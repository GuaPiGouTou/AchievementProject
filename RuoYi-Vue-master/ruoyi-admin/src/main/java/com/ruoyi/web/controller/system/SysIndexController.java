package com.ruoyi.web.controller.system;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.AchievementDataScopeUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.service.ISysNoticeService;

/**
 * 首页
 *
 * @author ruoyi
 */
@RestController
public class SysIndexController
{
    private static final AchievementTable[] ACHIEVEMENT_TABLES = {
            new AchievementTable("论文成果", "achievements_paper", "paper_id", "paper_title", "/achievement/paper", "paper:paper"),
            new AchievementTable("获奖成果", "achievements_award", "award_id", "award_name", "/achievement/award", "award:award"),
            new AchievementTable("竞赛成果", "achievements_competition", "competition_id", "competition_name", "/achievement/competition", "competition:competition"),
            new AchievementTable("专利成果", "achievements_patent", "patent_id", "patent_name", "/achievement/patent", "patent:patent"),
            new AchievementTable("科研项目", "achievements_research", "research_id", "project_name", "/achievement/research", "research:research"),
            new AchievementTable("软著成果", "achievements_software", "software_id", "software_name", "/achievement/software", "software:software"),
            new AchievementTable("教材成果", "achievements_textbook", "textbook_id", "textbook_name", "/achievement/textbook", "textbook:textbook"),
            new AchievementTable("专著成果", "achievements_monograph", "monograph_id", "monograph_title", "/achievement/monograph", "monograph:monograph"),
            new AchievementTable("成果转化", "achievements_transfer", "transfer_id", "achievement_name", "/achievement/transfer", "transfer:transfer")
    };

    /** 系统基础配置 */
    @Autowired
    private RuoYiConfig ruoyiConfig;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private ISysNoticeService noticeService;

    /**
     * 访问首页，提示语
     */
    @RequestMapping("/")
    public String index()
    {
        return StringUtils.format("欢迎使用{}后台管理框架，当前版本：v{}，请通过前端地址访问。", ruoyiConfig.getName(), ruoyiConfig.getVersion());
    }

    /**
     * 首页成果可视化统计。
     */
    @GetMapping("/dashboard/achievement/overview")
    public AjaxResult achievementOverview()
    {
        Map<String, Object> data = new LinkedHashMap<>();
        List<Map<String, Object>> typeData = new ArrayList<>();
        Map<String, Long> statusCount = new LinkedHashMap<>();
        Map<String, Long> monthCount = initRecentMonthCount();

        long total = 0L;
        long pending = 0L;
        long approved = 0L;
        long mine = 0L;

        for (AchievementTable achievementTable : ACHIEVEMENT_TABLES)
        {
            ScopeCondition scopeCondition = buildScopeCondition(achievementTable.modulePerm);
            long count = queryLong("select count(*) from " + achievementTable.tableName
                    + " where 1 = 1" + scopeCondition.sql, scopeCondition.args);
            total += count;
            typeData.add(chartItem(achievementTable.label, count));

            List<Map<String, Object>> statusRows = jdbcTemplate.queryForList(
                    "select ifnull(audit_status, '未填写') as audit_status, count(*) as total from "
                            + achievementTable.tableName + " where 1 = 1" + scopeCondition.sql + " group by audit_status",
                    scopeCondition.args.toArray());
            for (Map<String, Object> row : statusRows)
            {
                String status = String.valueOf(row.get("audit_status"));
                long statusTotal = toLong(row.get("total"));
                statusCount.put(status, statusCount.getOrDefault(status, 0L) + statusTotal);
            }

            List<Map<String, Object>> monthRows = jdbcTemplate.queryForList(
                    "select date_format(created_at, '%Y-%m') as month, count(*) as total from "
                            + achievementTable.tableName
                            + " where created_at >= date_format(date_sub(curdate(), interval 5 month), '%Y-%m-01')"
                            + scopeCondition.sql
                            + " group by date_format(created_at, '%Y-%m')",
                    scopeCondition.args.toArray());
            for (Map<String, Object> row : monthRows)
            {
                String month = String.valueOf(row.get("month"));
                if (monthCount.containsKey(month))
                {
                    monthCount.put(month, monthCount.get(month) + toLong(row.get("total")));
                }
            }

            pending += queryPendingTaskCount(achievementTable);
            mine += queryOwnAchievementCount(achievementTable);
        }

        for (Map.Entry<String, Long> entry : statusCount.entrySet())
        {
            if (entry.getKey().contains("通过") || entry.getKey().contains("已"))
            {
                approved += entry.getValue();
            }
        }

        data.put("total", total);
        data.put("pending", pending);
        data.put("approved", approved);
        data.put("mine", mine);
        data.put("typeData", typeData);
        data.put("statusData", toChartData(statusCount));
        data.put("monthLabels", new ArrayList<>(monthCount.keySet()));
        data.put("monthData", new ArrayList<>(monthCount.values()));
        return AjaxResult.success(data);
    }

    /**
     * 首页我的成果状态明细列表。
     */
    @GetMapping("/dashboard/achievement/my")
    public AjaxResult myAchievementList(@RequestParam(defaultValue = "60") int limit)
    {
        int safeLimit = Math.max(1, Math.min(limit, 200));
        int perTableLimit = Math.max(6, (int) Math.ceil(safeLimit / (double) ACHIEVEMENT_TABLES.length));
        List<Map<String, Object>> rows = new ArrayList<>();

        for (AchievementTable achievementTable : ACHIEVEMENT_TABLES)
        {
            rows.addAll(queryOwnAchievementRows(achievementTable, perTableLimit));
        }

        rows.sort(Comparator.comparingLong((Map<String, Object> item) -> toLong(item.get("sortKey"))).reversed());
        List<Map<String, Object>> data = rows.size() > safeLimit ? rows.subList(0, safeLimit) : rows;
        data.forEach(item -> item.remove("sortKey"));
        return AjaxResult.success(data);
    }

    /**
     * 首页待处理明细列表。
     */
    @GetMapping("/dashboard/achievement/pending")
    public AjaxResult pendingAchievementList(@RequestParam(defaultValue = "60") int limit)
    {
        int safeLimit = Math.max(1, Math.min(limit, 200));
        int perTableLimit = Math.max(6, (int) Math.ceil(safeLimit / (double) ACHIEVEMENT_TABLES.length));
        List<Map<String, Object>> rows = new ArrayList<>();

        for (AchievementTable achievementTable : ACHIEVEMENT_TABLES)
        {
            rows.addAll(queryPendingRows(achievementTable, perTableLimit));
        }

        rows.sort(Comparator.comparingLong((Map<String, Object> item) -> toLong(item.get("sortKey"))).reversed());
        List<Map<String, Object>> data = rows.size() > safeLimit ? rows.subList(0, safeLimit) : rows;
        data.forEach(item -> item.remove("sortKey"));
        return AjaxResult.success(data);
    }

    /**
     * 首页公告列表，返回公告正文供首页直接展示。
     */
    @GetMapping("/dashboard/notices")
    public AjaxResult notices()
    {
        SysNotice query = new SysNotice();
        query.setStatus("0");
        List<SysNotice> notices = noticeService.selectNoticeList(query);
        if (notices.size() > 6)
        {
            notices = notices.subList(0, 6);
        }
        return AjaxResult.success(notices);
    }

    /**
     * 首页公告详情。
     */
    @GetMapping("/dashboard/notices/{noticeId}")
    public AjaxResult noticeDetail(@PathVariable Long noticeId)
    {
        return AjaxResult.success(noticeService.selectNoticeById(noticeId));
    }

    private long queryLong(String sql, List<Object> args)
    {
        Long value = jdbcTemplate.queryForObject(sql, Long.class, args.toArray());
        return value == null ? 0L : value;
    }

    private Map<String, Object> chartItem(String name, long value)
    {
        Map<String, Object> item = new LinkedHashMap<>();
        item.put("name", name);
        item.put("value", value);
        return item;
    }

    private List<Map<String, Object>> toChartData(Map<String, Long> source)
    {
        List<Map<String, Object>> data = new ArrayList<>();
        for (Map.Entry<String, Long> entry : source.entrySet())
        {
            data.add(chartItem(entry.getKey(), entry.getValue()));
        }
        return data;
    }

    private Map<String, Long> initRecentMonthCount()
    {
        Map<String, Long> monthCount = new LinkedHashMap<>();
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, -5);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
        for (int i = 0; i < 6; i++)
        {
            monthCount.put(formatter.format(calendar.getTime()), 0L);
            calendar.add(Calendar.MONTH, 1);
        }
        return monthCount;
    }

    private long toLong(Object value)
    {
        return value == null ? 0L : Long.parseLong(value.toString());
    }

    private List<Map<String, Object>> queryPendingRows(AchievementTable achievementTable, int limit)
    {
        List<Map<String, Object>> result = new ArrayList<>();
        if (hasReviewDuty(achievementTable.modulePerm))
        {
            result.addAll(queryReviewPendingRows(achievementTable, limit));
        }
        return result;
    }

    private long queryPendingTaskCount(AchievementTable achievementTable)
    {
        long count = 0L;
        if (hasReviewDuty(achievementTable.modulePerm))
        {
            ScopeCondition scopeCondition = buildScopeCondition(achievementTable.modulePerm);
            count += queryLong("select count(*) from " + achievementTable.tableName
                    + " where " + reviewPendingCondition() + scopeCondition.sql, scopeCondition.args);
        }
        return count;
    }

    private long queryOwnAchievementCount(AchievementTable achievementTable)
    {
        List<Object> args = new ArrayList<>();
        args.add(SecurityUtils.getUserId());
        return queryLong("select count(*) from " + achievementTable.tableName + " where user_id = ?", args);
    }

    private List<Map<String, Object>> queryReviewPendingRows(AchievementTable achievementTable, int limit)
    {
        ScopeCondition scopeCondition = buildScopeCondition(achievementTable.modulePerm);
        String sql = "select "
                + achievementTable.idColumn + " as record_id, "
                + "ifnull(" + achievementTable.titleColumn + ", '未命名记录') as record_title, "
                + "ifnull(audit_status, '未填写') as audit_status, "
                + "created_at, "
                + "ifnull(unix_timestamp(created_at), 0) as sort_key "
                + "from " + achievementTable.tableName + " "
                + "where " + reviewPendingCondition()
                + scopeCondition.sql
                + "order by created_at desc limit ?";
        List<Object> args = new ArrayList<>(scopeCondition.args);
        args.add(limit);
        return queryTaskRows(achievementTable, sql, args, "审核");
    }

    private List<Map<String, Object>> queryOwnAchievementRows(AchievementTable achievementTable, int limit)
    {
        String sql = "select "
                + achievementTable.idColumn + " as record_id, "
                + "ifnull(" + achievementTable.titleColumn + ", '未命名记录') as record_title, "
                + "ifnull(audit_status, '未填写') as audit_status, "
                + "created_at, "
                + "ifnull(unix_timestamp(created_at), 0) as sort_key "
                + "from " + achievementTable.tableName + " "
                + "where user_id = ? "
                + "order by created_at desc limit ?";
        List<Object> args = new ArrayList<>();
        args.add(SecurityUtils.getUserId());
        args.add(limit);
        return queryTaskRows(achievementTable, sql, args, "本人提交");
    }

    private List<Map<String, Object>> queryTaskRows(AchievementTable achievementTable, String sql, List<Object> args, String taskType)
    {
        List<Map<String, Object>> result = new ArrayList<>();
        try
        {
            List<Map<String, Object>> source = jdbcTemplate.queryForList(sql, args.toArray());
            for (Map<String, Object> row : source)
            {
                Map<String, Object> item = new LinkedHashMap<>();
                item.put("module", achievementTable.label);
                item.put("routePath", achievementTable.routePath);
                item.put("recordId", row.get("record_id"));
                item.put("recordIdField", achievementTable.recordIdField);
                item.put("title", row.get("record_title"));
                item.put("auditStatus", row.get("audit_status"));
                item.put("taskType", taskType);
                item.put("createdAt", row.get("created_at"));
                item.put("sortKey", row.get("sort_key"));
                result.add(item);
            }
        }
        catch (Exception ignored)
        {
            // 忽略单表异常，避免影响首页整体加载。
        }
        return result;
    }

    private String reviewPendingCondition()
    {
        return "(audit_status like '%待%' or audit_status like '%未%' or audit_status is null) ";
    }

    private boolean hasReviewDuty(String modulePerm)
    {
        LoginUser loginUser = getCurrentLoginUser();
        if (loginUser == null || loginUser.getUser() == null)
        {
            return false;
        }
        if (loginUser.getUser().isAdmin() || hasPerm("*:*:*"))
        {
            return true;
        }

        List<SysRole> roles = loginUser.getUser().getRoles();
        if (roles == null || roles.isEmpty())
        {
            return false;
        }

        for (SysRole role : roles)
        {
            if (roleMatches(role, 103L, "class_teacher", "班主任"))
            {
                return true;
            }
            if (roleMatches(role, 106L, "teaching_improvement_leader", "教学能力提升负责人")
                    && isAnyModule(modulePerm, "paper:paper", "award:award", "competition:competition", "research:research", "textbook:textbook"))
            {
                return true;
            }
            if (roleMatches(role, 107L, "research_leader", "科研负责人")
                    && isAnyModule(modulePerm, "paper:paper", "award:award", "research:research", "monograph:monograph", "patent:patent", "software:software", "transfer:transfer"))
            {
                return true;
            }
        }
        return false;
    }

    private LoginUser getCurrentLoginUser()
    {
        try
        {
            return SecurityUtils.getLoginUser();
        }
        catch (Exception e)
        {
            return null;
        }
    }

    private boolean hasPerm(String permission)
    {
        LoginUser loginUser = getCurrentLoginUser();
        Set<String> permissions = loginUser == null ? Collections.emptySet() : loginUser.getPermissions();
        return permissions != null && SecurityUtils.hasPermi(permissions, permission);
    }

    private boolean isAnyModule(String modulePerm, String... modulePerms)
    {
        for (String perm : modulePerms)
        {
            if (StringUtils.equals(modulePerm, perm))
            {
                return true;
            }
        }
        return false;
    }

    private boolean roleMatches(SysRole role, Long roleId, String roleKey, String... roleNames)
    {
        if (role == null)
        {
            return false;
        }
        if (roleId != null && roleId.equals(role.getRoleId()))
        {
            return true;
        }
        if (StringUtils.equals(roleKey, role.getRoleKey()))
        {
            return true;
        }
        for (String roleName : roleNames)
        {
            if (StringUtils.equals(roleName, role.getRoleName()))
            {
                return true;
            }
        }
        return false;
    }

    private ScopeCondition buildScopeCondition(String modulePerm)
    {
        DashboardScope scope = new DashboardScope();
        AchievementDataScopeUtils.applyAchievementListScope(scope, modulePerm);

        StringBuilder sql = new StringBuilder();
        List<Object> args = new ArrayList<>();
        if (scope.getUserId() != null)
        {
            sql.append(" and user_id = ?");
            args.add(scope.getUserId());
        }

        Object scopedDeptIdsValue = scope.getParams().get(AchievementDataScopeUtils.SCOPED_DEPT_IDS_PARAM);
        if (scopedDeptIdsValue instanceof List && !((List<?>) scopedDeptIdsValue).isEmpty())
        {
            List<?> scopedDeptIds = (List<?>) scopedDeptIdsValue;
            sql.append(" and dept_id in (");
            for (int i = 0; i < scopedDeptIds.size(); i++)
            {
                if (i > 0)
                {
                    sql.append(",");
                }
                sql.append("?");
                args.add(scopedDeptIds.get(i));
            }
            sql.append(")");
        }

        if (scope.getDeptId() != null)
        {
            sql.append(" and dept_id = ?");
            args.add(scope.getDeptId());
        }
        return new ScopeCondition(sql.toString(), args);
    }

    private static class DashboardScope extends BaseEntity
    {
        private Long userId;
        private Long deptId;

        public Long getUserId()
        {
            return userId;
        }

        public void setUserId(Long userId)
        {
            this.userId = userId;
        }

        public Long getDeptId()
        {
            return deptId;
        }

        public void setDeptId(Long deptId)
        {
            this.deptId = deptId;
        }
    }

    private static class ScopeCondition
    {
        private final String sql;
        private final List<Object> args;

        private ScopeCondition(String sql, List<Object> args)
        {
            this.sql = sql;
            this.args = args;
        }
    }

    private static class AchievementTable
    {
        private final String label;
        private final String tableName;
        private final String idColumn;
        private final String recordIdField;
        private final String titleColumn;
        private final String routePath;
        private final String modulePerm;

        private AchievementTable(String label, String tableName, String idColumn, String titleColumn, String routePath, String modulePerm)
        {
            this.label = label;
            this.tableName = tableName;
            this.idColumn = idColumn;
            this.recordIdField = toCamelCase(idColumn);
            this.titleColumn = titleColumn;
            this.routePath = routePath;
            this.modulePerm = modulePerm;
        }

        private static String toCamelCase(String value)
        {
            StringBuilder result = new StringBuilder();
            boolean upperNext = false;
            for (int i = 0; i < value.length(); i++)
            {
                char ch = value.charAt(i);
                if (ch == '_')
                {
                    upperNext = true;
                    continue;
                }
                if (upperNext)
                {
                    result.append(Character.toUpperCase(ch));
                    upperNext = false;
                }
                else
                {
                    result.append(ch);
                }
            }
            return result.toString();
        }
    }
}
