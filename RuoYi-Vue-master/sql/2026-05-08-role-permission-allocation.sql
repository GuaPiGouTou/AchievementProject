-- 权限分配（依据 /Users/frog/Desktop/权限分配文件.xls）
-- 执行目标库：ry-vue
-- 说明：
-- 1) 仅重配 103-108 六个业务角色的“成果管理/附件”菜单与按钮权限。
-- 2) 不改动 sys_role.data_scope、sys_role_dept；班级/专业/全院的数据范围过滤需要后端列表查询配合。
-- 3) “审核”当前由各成果模块 edit 权限承载，因此有审核职责的角色会授予 edit。

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS tmp_achievement_roles;
CREATE TEMPORARY TABLE tmp_achievement_roles (
  role_marker varchar(40) NOT NULL,
  role_id bigint(20) NOT NULL,
  PRIMARY KEY (role_marker, role_id)
);

INSERT IGNORE INTO tmp_achievement_roles (role_marker, role_id)
SELECT 'class_teacher', role_id
FROM sys_role
WHERE del_flag = '0' AND (role_id = 103 OR role_key = 'class_teacher' OR role_name = '班主任');

INSERT IGNORE INTO tmp_achievement_roles (role_marker, role_id)
SELECT 'competition_leader', role_id
FROM sys_role
WHERE del_flag = '0' AND (role_id = 104 OR role_key = 'competition_leader' OR role_name IN ('学院学科竞赛负责人', '信息工程学院学科竞赛负责人'));

INSERT IGNORE INTO tmp_achievement_roles (role_marker, role_id)
SELECT 'teaching_office_director', role_id
FROM sys_role
WHERE del_flag = '0' AND (role_id = 105 OR role_key = 'teaching_office_director' OR role_name = '教研室主任');

INSERT IGNORE INTO tmp_achievement_roles (role_marker, role_id)
SELECT 'teaching_improvement_leader', role_id
FROM sys_role
WHERE del_flag = '0' AND (role_id = 106 OR role_key = 'teaching_improvement_leader' OR role_name = '教学能力提升负责人');

INSERT IGNORE INTO tmp_achievement_roles (role_marker, role_id)
SELECT 'research_leader', role_id
FROM sys_role
WHERE del_flag = '0' AND (role_id = 107 OR role_key = 'research_leader' OR role_name = '科研负责人');

INSERT IGNORE INTO tmp_achievement_roles (role_marker, role_id)
SELECT 'teaching_research_leader', role_id
FROM sys_role
WHERE del_flag = '0' AND (role_id = 108 OR role_key = 'teaching_research_leader' OR role_name = '教学科研负责人');

DROP TEMPORARY TABLE IF EXISTS tmp_achievement_menus;
CREATE TEMPORARY TABLE tmp_achievement_menus (
  menu_id bigint(20) NOT NULL PRIMARY KEY
);

-- 成果管理父级菜单。
INSERT IGNORE INTO tmp_achievement_menus (menu_id)
SELECT menu_id
FROM sys_menu
WHERE menu_id = 2000 OR menu_name = '成果管理';

-- 成果管理下的直接子菜单。
INSERT IGNORE INTO tmp_achievement_menus (menu_id)
SELECT m.menu_id
FROM sys_menu m
WHERE m.parent_id IN (
  SELECT parent_menu_id
  FROM (
    SELECT menu_id AS parent_menu_id
    FROM sys_menu
    WHERE menu_id = 2000 OR menu_name = '成果管理'
  ) parent_menus
);

-- 各成果模块与附件模块的按钮权限。
INSERT IGNORE INTO tmp_achievement_menus (menu_id)
SELECT menu_id
FROM sys_menu
WHERE perms LIKE 'paper:paper:%'
   OR perms LIKE 'award:award:%'
   OR perms LIKE 'competition:competition:%'
   OR perms LIKE 'patent:patent:%'
   OR perms LIKE 'research:research:%'
   OR perms LIKE 'software:software:%'
   OR perms LIKE 'textbook:textbook:%'
   OR perms LIKE 'monograph:monograph:%'
   OR perms LIKE 'transfer:transfer:%'
   OR perms LIKE 'attachment:attachment:%';

DELETE rm
FROM sys_role_menu rm
JOIN tmp_achievement_roles r ON r.role_id = rm.role_id
JOIN tmp_achievement_menus m ON m.menu_id = rm.menu_id;

DROP TEMPORARY TABLE IF EXISTS tmp_full_actions;
CREATE TEMPORARY TABLE tmp_full_actions (
  action_name varchar(20) NOT NULL PRIMARY KEY
);

INSERT INTO tmp_full_actions VALUES ('list'), ('query'), ('add'), ('edit'), ('remove'), ('export');

DROP TEMPORARY TABLE IF EXISTS tmp_read_actions;
CREATE TEMPORARY TABLE tmp_read_actions (
  action_name varchar(20) NOT NULL PRIMARY KEY
);

INSERT INTO tmp_read_actions VALUES ('list'), ('query'), ('export');

DROP TEMPORARY TABLE IF EXISTS tmp_role_modules;
CREATE TEMPORARY TABLE tmp_role_modules (
  role_marker varchar(40) NOT NULL,
  module_perm varchar(80) NOT NULL,
  access_level varchar(10) NOT NULL,
  PRIMARY KEY (role_marker, module_perm)
);

-- 103 班主任：所管理班级学生所有成果，审批、增删改查、导出。
INSERT INTO tmp_role_modules VALUES
('class_teacher', 'paper:paper', 'full'),
('class_teacher', 'award:award', 'full'),
('class_teacher', 'competition:competition', 'full'),
('class_teacher', 'patent:patent', 'full'),
('class_teacher', 'research:research', 'full'),
('class_teacher', 'software:software', 'full'),
('class_teacher', 'textbook:textbook', 'full'),
('class_teacher', 'monograph:monograph', 'full'),
('class_teacher', 'transfer:transfer', 'full'),
('class_teacher', 'attachment:attachment', 'full');

-- 104 学院学科竞赛负责人：全员学生学科竞赛成果，查看、导出。
INSERT INTO tmp_role_modules VALUES
('competition_leader', 'competition:competition', 'read'),
('competition_leader', 'attachment:attachment', 'read');

-- 105 教研室主任：所管理专业学生所有成果，查看、导出。
INSERT INTO tmp_role_modules VALUES
('teaching_office_director', 'paper:paper', 'read'),
('teaching_office_director', 'award:award', 'read'),
('teaching_office_director', 'competition:competition', 'read'),
('teaching_office_director', 'patent:patent', 'read'),
('teaching_office_director', 'research:research', 'read'),
('teaching_office_director', 'software:software', 'read'),
('teaching_office_director', 'textbook:textbook', 'read'),
('teaching_office_director', 'monograph:monograph', 'read'),
('teaching_office_director', 'transfer:transfer', 'read'),
('teaching_office_director', 'attachment:attachment', 'read');

-- 106 教学能力提升负责人：全院教师教学类成果，审核、增删改查、导出。
INSERT INTO tmp_role_modules VALUES
('teaching_improvement_leader', 'paper:paper', 'full'),
('teaching_improvement_leader', 'award:award', 'full'),
('teaching_improvement_leader', 'competition:competition', 'full'),
('teaching_improvement_leader', 'research:research', 'full'),
('teaching_improvement_leader', 'textbook:textbook', 'full'),
('teaching_improvement_leader', 'attachment:attachment', 'full');

-- 107 科研负责人：全院教师科研类成果，审核、增删改查、导出。
INSERT INTO tmp_role_modules VALUES
('research_leader', 'paper:paper', 'full'),
('research_leader', 'award:award', 'full'),
('research_leader', 'research:research', 'full'),
('research_leader', 'monograph:monograph', 'full'),
('research_leader', 'patent:patent', 'full'),
('research_leader', 'software:software', 'full'),
('research_leader', 'transfer:transfer', 'full'),
('research_leader', 'attachment:attachment', 'full');

-- 108 教学科研负责人：全院教学/科研成果查看、导出；不管理学生竞赛。
INSERT INTO tmp_role_modules VALUES
('teaching_research_leader', 'paper:paper', 'read'),
('teaching_research_leader', 'award:award', 'read'),
('teaching_research_leader', 'patent:patent', 'read'),
('teaching_research_leader', 'research:research', 'read'),
('teaching_research_leader', 'software:software', 'read'),
('teaching_research_leader', 'textbook:textbook', 'read'),
('teaching_research_leader', 'monograph:monograph', 'read'),
('teaching_research_leader', 'transfer:transfer', 'read'),
('teaching_research_leader', 'attachment:attachment', 'read');

DROP TEMPORARY TABLE IF EXISTS tmp_role_perms;
CREATE TEMPORARY TABLE tmp_role_perms (
  role_marker varchar(40) NOT NULL,
  perms varchar(100) NOT NULL,
  PRIMARY KEY (role_marker, perms)
);

INSERT IGNORE INTO tmp_role_perms (role_marker, perms)
SELECT rm.role_marker, CONCAT(rm.module_perm, ':', a.action_name)
FROM tmp_role_modules rm
JOIN tmp_full_actions a ON rm.access_level = 'full';

INSERT IGNORE INTO tmp_role_perms (role_marker, perms)
SELECT rm.role_marker, CONCAT(rm.module_perm, ':', a.action_name)
FROM tmp_role_modules rm
JOIN tmp_read_actions a ON rm.access_level = 'read';

-- 所有业务角色都需要进入“成果管理”父级菜单。
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT DISTINCT r.role_id, m.menu_id
FROM tmp_achievement_roles r
JOIN sys_menu m ON m.menu_id = 2000 OR m.menu_name = '成果管理';

-- 按权限字符授予具体菜单/按钮。
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT DISTINCT r.role_id, m.menu_id
FROM tmp_achievement_roles r
JOIN tmp_role_perms p ON p.role_marker = r.role_marker
JOIN sys_menu m ON m.perms = p.perms;

COMMIT;
