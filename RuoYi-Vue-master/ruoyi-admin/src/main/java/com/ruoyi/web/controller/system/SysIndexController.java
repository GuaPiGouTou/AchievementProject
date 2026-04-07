package com.ruoyi.web.controller.system;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
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
            new AchievementTable("论文成果", "achievements_paper"),
            new AchievementTable("获奖成果", "achievements_award"),
            new AchievementTable("竞赛成果", "achievements_competition"),
            new AchievementTable("专利成果", "achievements_patent"),
            new AchievementTable("科研项目", "achievements_research"),
            new AchievementTable("软著成果", "achievements_software"),
            new AchievementTable("教材成果", "achievements_textbook"),
            new AchievementTable("专著成果", "achievements_monograph"),
            new AchievementTable("成果转化", "achievements_transfer")
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

        for (AchievementTable achievementTable : ACHIEVEMENT_TABLES)
        {
            long count = queryLong("select count(*) from " + achievementTable.tableName);
            total += count;
            typeData.add(chartItem(achievementTable.label, count));

            List<Map<String, Object>> statusRows = jdbcTemplate.queryForList(
                    "select ifnull(audit_status, '未填写') as audit_status, count(*) as total from "
                            + achievementTable.tableName + " group by audit_status");
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
                            + " group by date_format(created_at, '%Y-%m')");
            for (Map<String, Object> row : monthRows)
            {
                String month = String.valueOf(row.get("month"));
                if (monthCount.containsKey(month))
                {
                    monthCount.put(month, monthCount.get(month) + toLong(row.get("total")));
                }
            }
        }

        for (Map.Entry<String, Long> entry : statusCount.entrySet())
        {
            if (entry.getKey().contains("待") || entry.getKey().contains("未"))
            {
                pending += entry.getValue();
            }
            if (entry.getKey().contains("通过") || entry.getKey().contains("已"))
            {
                approved += entry.getValue();
            }
        }

        data.put("total", total);
        data.put("pending", pending);
        data.put("approved", approved);
        data.put("typeData", typeData);
        data.put("statusData", toChartData(statusCount));
        data.put("monthLabels", new ArrayList<>(monthCount.keySet()));
        data.put("monthData", new ArrayList<>(monthCount.values()));
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

    private long queryLong(String sql)
    {
        Long value = jdbcTemplate.queryForObject(sql, Long.class);
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

    private static class AchievementTable
    {
        private final String label;
        private final String tableName;

        private AchievementTable(String label, String tableName)
        {
            this.label = label;
            this.tableName = tableName;
        }
    }
}
