-- 权限分配（依据 /Users/frog/Desktop/权限分配文件.xls）
-- 执行时间：2026-04-17
-- 注意：该脚本已被 2026-05-08-role-permission-allocation.sql 取代；新部署请执行 2026-05-08 版本。
-- 说明：
-- 1) 仅调整“成果管理”相关菜单/按钮权限
-- 2) 不改动角色数据范围（data_scope）和角色-部门关系（sys_role_dept）
-- 3) 角色ID基于当前库：103班主任、104竞赛负责人、105教研室主任、106教学能力提升负责人、107科研负责人、108教学科研负责人

START TRANSACTION;

-- 先清理这三个角色在“成果管理”下的既有授权（避免残留 add/edit/remove）
DELETE rm
FROM sys_role_menu rm
JOIN sys_menu m ON m.menu_id = rm.menu_id
WHERE rm.role_id IN (104, 105, 108)
  AND (
    m.menu_id = 2000
    OR m.perms LIKE 'paper:paper:%'
    OR m.perms LIKE 'award:award:%'
    OR m.perms LIKE 'competition:competition:%'
    OR m.perms LIKE 'patent:patent:%'
    OR m.perms LIKE 'research:research:%'
    OR m.perms LIKE 'software:software:%'
    OR m.perms LIKE 'textbook:textbook:%'
    OR m.perms LIKE 'monograph:monograph:%'
    OR m.perms LIKE 'transfer:transfer:%'
  );

-- 104 信息工程学院学科竞赛负责人：
-- 仅保留竞赛成果的“查看/导出”（对应 list/query/export）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 104, m.menu_id
FROM sys_menu m
WHERE m.menu_id = 2000
   OR m.perms IN (
     'competition:competition:list',
     'competition:competition:query',
     'competition:competition:export'
   );

-- 105 教研室主任：
-- 保留全成果模块“查看/导出”（对应 list/query/export）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 105, m.menu_id
FROM sys_menu m
WHERE m.menu_id = 2000
   OR m.perms IN (
     'paper:paper:list','paper:paper:query','paper:paper:export',
     'award:award:list','award:award:query','award:award:export',
     'competition:competition:list','competition:competition:query','competition:competition:export',
     'patent:patent:list','patent:patent:query','patent:patent:export',
     'research:research:list','research:research:query','research:research:export',
     'software:software:list','software:software:query','software:software:export',
     'textbook:textbook:list','textbook:textbook:query','textbook:textbook:export',
     'monograph:monograph:list','monograph:monograph:query','monograph:monograph:export',
     'transfer:transfer:list','transfer:transfer:query','transfer:transfer:export'
   );

-- 108 教学科研负责人：
-- 保留教学/科研成果模块“查看/导出”（对应 list/query/export），不授予学生竞赛权限。
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT 108, m.menu_id
FROM sys_menu m
WHERE m.menu_id = 2000
   OR m.perms IN (
     'paper:paper:list','paper:paper:query','paper:paper:export',
     'award:award:list','award:award:query','award:award:export',
     'patent:patent:list','patent:patent:query','patent:patent:export',
     'research:research:list','research:research:query','research:research:export',
     'software:software:list','software:software:query','software:software:export',
     'textbook:textbook:list','textbook:textbook:query','textbook:textbook:export',
     'monograph:monograph:list','monograph:monograph:query','monograph:monograph:export',
     'transfer:transfer:list','transfer:transfer:query','transfer:transfer:export'
   );

COMMIT;
