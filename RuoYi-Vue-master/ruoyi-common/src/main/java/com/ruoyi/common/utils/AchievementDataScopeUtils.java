package com.ruoyi.common.utils;

import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.spring.SpringUtils;
import org.apache.commons.lang3.StringUtils;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.sql.DataSource;

/**
 * 成果模块的数据范围辅助。
 */
public class AchievementDataScopeUtils
{
    public static final String SCOPED_DEPT_IDS_PARAM = "scopedDeptIds";

    private enum Scope
    {
        CURRENT_USER,
        CURRENT_DEPT,
        ROLE_DEPTS,
        ALL
    }

    public static void applyAchievementListScope(Object achievement)
    {
        applyAchievementListScope(achievement, null);
    }

    public static void applyAchievementListScope(Object achievement, String modulePerm)
    {
        clearScopedDeptIds(achievement);
        Scope scope = getAchievementDataScope(modulePerm);
        if (scope == Scope.ALL)
        {
            setLongValue(achievement, "setUserId", null);
            setLongValue(achievement, "setDeptId", null);
            return;
        }

        if (scope == Scope.CURRENT_DEPT)
        {
            setLongValue(achievement, "setUserId", null);
            setLongValue(achievement, "setDeptId", SecurityUtils.getDeptId());
            return;
        }

        if (scope == Scope.ROLE_DEPTS)
        {
            setLongValue(achievement, "setUserId", null);
            setLongValue(achievement, "setDeptId", null);
            List<Long> deptIds = getCurrentRoleDeptIds();
            setScopedDeptIds(achievement, deptIds.isEmpty() ? Collections.singletonList(-1L) : deptIds);
            return;
        }

        setLongValue(achievement, "setUserId", SecurityUtils.getUserId());
        setLongValue(achievement, "setDeptId", SecurityUtils.getDeptId());
    }

    public static Long getScopedUserId()
    {
        return getScopedUserId(null);
    }

    public static Long getScopedUserId(String modulePerm)
    {
        Scope scope = getAchievementDataScope(modulePerm);
        return scope == Scope.CURRENT_USER ? SecurityUtils.getUserId() : null;
    }

    public static Long getScopedDeptId()
    {
        return getScopedDeptId(null);
    }

    public static Long getScopedDeptId(String modulePerm)
    {
        Scope scope = getAchievementDataScope(modulePerm);
        return scope == Scope.CURRENT_DEPT || scope == Scope.CURRENT_USER ? SecurityUtils.getDeptId() : null;
    }

    public static boolean canAccessAchievementRecord(Object achievement)
    {
        return canAccessAchievementRecord(achievement, null);
    }

    public static boolean canAccessAchievementRecord(Object achievement, String modulePerm)
    {
        if (achievement == null)
        {
            return false;
        }

        Scope scope = getAchievementDataScope(modulePerm);
        if (scope == Scope.ALL)
        {
            return true;
        }

        Long recordDeptId = getLongValue(achievement, "getDeptId");
        if (scope == Scope.CURRENT_DEPT)
        {
            return recordDeptId != null && recordDeptId.equals(SecurityUtils.getDeptId());
        }
        if (scope == Scope.ROLE_DEPTS)
        {
            return recordDeptId != null && getCurrentRoleDeptIds().contains(recordDeptId);
        }

        Long recordUserId = getLongValue(achievement, "getUserId");
        return recordUserId != null && recordUserId.equals(SecurityUtils.getUserId());
    }

    public static <T> List<T> filterByIds(List<T> rows, Long[] ids, String idGetterName)
    {
        if (rows == null || rows.isEmpty() || ids == null || ids.length == 0)
        {
            return rows;
        }

        Set<Long> idSet = new HashSet<>();
        for (Long id : ids)
        {
            if (id != null)
            {
                idSet.add(id);
            }
        }
        if (idSet.isEmpty())
        {
            return rows;
        }

        List<T> filteredRows = new ArrayList<>();
        for (T row : rows)
        {
            Long id = getLongValue(row, idGetterName);
            if (id != null && idSet.contains(id))
            {
                filteredRows.add(row);
            }
        }
        return filteredRows;
    }

    private static Scope getAchievementDataScope(String modulePerm)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null || loginUser.getUser() == null)
        {
            return Scope.CURRENT_USER;
        }

        if (loginUser.getUser().isAdmin())
        {
            return Scope.ALL;
        }

        List<SysRole> roles = loginUser.getUser().getRoles();
        if (roles == null || roles.isEmpty())
        {
            return Scope.CURRENT_USER;
        }

        boolean deptScope = false;
        boolean roleDeptScope = false;
        for (SysRole role : roles)
        {
            if ((matches(role, 104L, "competition_leader", "学院学科竞赛负责人", "信息工程学院学科竞赛负责人")
                    && isAnyModule(modulePerm, "competition:competition", "attachment:attachment"))
                    || (matches(role, 106L, "teaching_improvement_leader", "教学能力提升负责人")
                    && isAnyModule(modulePerm, "paper:paper", "award:award", "competition:competition", "research:research", "textbook:textbook", "attachment:attachment"))
                    || (matches(role, 107L, "research_leader", "科研负责人")
                    && isAnyModule(modulePerm, "paper:paper", "award:award", "research:research", "monograph:monograph", "patent:patent", "software:software", "transfer:transfer", "attachment:attachment"))
                    || (matches(role, 108L, "teaching_research_leader", "教学科研负责人")
                    && isAnyModule(modulePerm, "paper:paper", "award:award", "patent:patent", "research:research", "software:software", "textbook:textbook", "monograph:monograph", "transfer:transfer", "attachment:attachment")))
            {
                return Scope.ALL;
            }

            if (matches(role, 103L, "class_teacher", "班主任")
                    || matches(role, 105L, "teaching_office_director", "教研室主任"))
            {
                roleDeptScope = true;
            }
        }

        if (roleDeptScope)
        {
            return Scope.ROLE_DEPTS;
        }
        return deptScope ? Scope.CURRENT_DEPT : Scope.CURRENT_USER;
    }

    private static List<Long> getCurrentRoleDeptIds()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null || loginUser.getUser() == null || loginUser.getUser().getRoles() == null)
        {
            return Collections.emptyList();
        }

        Set<Long> roleIds = new HashSet<>();
        for (SysRole role : loginUser.getUser().getRoles())
        {
            if (matches(role, 103L, "class_teacher", "班主任")
                    || matches(role, 105L, "teaching_office_director", "教研室主任"))
            {
                roleIds.add(role.getRoleId());
            }
        }
        if (roleIds.isEmpty())
        {
            return Collections.emptyList();
        }

        StringBuilder sql = new StringBuilder("select distinct dept_id from sys_role_dept where role_id in (");
        for (int i = 0; i < roleIds.size(); i++)
        {
            if (i > 0)
            {
                sql.append(",");
            }
            sql.append("?");
        }
        sql.append(")");

        List<Long> deptIds = new ArrayList<>();
        try
        {
            DataSource dataSource = SpringUtils.getBean(DataSource.class);
            try (Connection connection = dataSource.getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql.toString()))
            {
                int index = 1;
                for (Long roleId : roleIds)
                {
                    statement.setLong(index++, roleId);
                }
                try (ResultSet resultSet = statement.executeQuery())
                {
                    while (resultSet.next())
                    {
                        deptIds.add(resultSet.getLong("dept_id"));
                    }
                }
            }
        }
        catch (Exception ignored)
        {
        }
        return deptIds;
    }

    private static void clearScopedDeptIds(Object target)
    {
        if (target instanceof BaseEntity)
        {
            ((BaseEntity) target).getParams().remove(SCOPED_DEPT_IDS_PARAM);
        }
    }

    private static void setScopedDeptIds(Object target, List<Long> deptIds)
    {
        if (target instanceof BaseEntity)
        {
            ((BaseEntity) target).getParams().put(SCOPED_DEPT_IDS_PARAM, deptIds);
        }
    }

    private static boolean isAnyModule(String modulePerm, String... modulePerms)
    {
        if (StringUtils.isBlank(modulePerm))
        {
            return true;
        }
        for (String perm : modulePerms)
        {
            if (StringUtils.equals(modulePerm, perm))
            {
                return true;
            }
        }
        return false;
    }

    private static boolean matches(SysRole role, Long roleId, String roleKey, String... roleNames)
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

    private static void setLongValue(Object target, String methodName, Long value)
    {
        if (target == null)
        {
            return;
        }
        try
        {
            Method method = target.getClass().getMethod(methodName, Long.class);
            method.invoke(target, value);
        }
        catch (Exception ignored)
        {
        }
    }

    private static Long getLongValue(Object target, String methodName)
    {
        try
        {
            Method method = target.getClass().getMethod(methodName);
            Object value = method.invoke(target);
            return value instanceof Long ? (Long) value : null;
        }
        catch (Exception ignored)
        {
            return null;
        }
    }
}
