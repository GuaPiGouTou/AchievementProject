-- 项目完成情况报告问题修复补丁
-- 执行目标库：ry-vue
-- 说明：
-- 1) 兼容论文表错拼列 achievemrnts_type，新增正确列 achievements_type 并回填。
-- 2) 论文增加“论文状态/录用时间”，支持“已录用/已发表”的业务流。
-- 3) 专利状态补充“公开状态”，证书类型补充“发明专利申请公布通知书”。
-- 4) 竞赛角色类型与 C++ 接口文档保持一致，避免“指导教师”写入 enum 字段导致截断。

SET @schema_name = DATABASE();

SET @sql = (
  SELECT IF(COUNT(*) = 0,
    'ALTER TABLE achievements_paper ADD COLUMN achievements_type enum(''教改项目'',''科研项目'') NULL COMMENT ''成果项目类型'' AFTER archival_type',
    'SELECT ''achievements_paper.achievements_type already exists'''
  )
  FROM information_schema.columns
  WHERE table_schema = @schema_name
    AND table_name = 'achievements_paper'
    AND column_name = 'achievements_type'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE achievements_paper
SET achievements_type = achievemrnts_type
WHERE achievements_type IS NULL
  AND achievemrnts_type IS NOT NULL;

SET @sql = (
  SELECT IF(COUNT(*) = 0,
    'ALTER TABLE achievements_paper ADD COLUMN paper_status enum(''已录用'',''已发表'') NULL COMMENT ''论文状态'' AFTER paper_category',
    'SELECT ''achievements_paper.paper_status already exists'''
  )
  FROM information_schema.columns
  WHERE table_schema = @schema_name
    AND table_name = 'achievements_paper'
    AND column_name = 'paper_status'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (
  SELECT IF(COUNT(*) = 0,
    'ALTER TABLE achievements_paper ADD COLUMN acceptance_date date NULL COMMENT ''录用时间'' AFTER paper_status',
    'SELECT ''achievements_paper.acceptance_date already exists'''
  )
  FROM information_schema.columns
  WHERE table_schema = @schema_name
    AND table_name = 'achievements_paper'
    AND column_name = 'acceptance_date'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE achievements_paper
SET paper_status = '已发表'
WHERE paper_status IS NULL
  AND publish_date IS NOT NULL;

ALTER TABLE achievements_paper
  MODIFY publish_date date NULL COMMENT '发表时间';

ALTER TABLE achievements_paper
  MODIFY archival_type enum('teachingCategory','researchOriented') NULL COMMENT '归档类别';

ALTER TABLE achievements_award
  MODIFY archival_type enum('teachingCategory','researchOriented') NULL COMMENT '归档类别';

ALTER TABLE achievements_research
  MODIFY archival_type enum('teachingCategory','researchOriented') NULL COMMENT '归档类别';

ALTER TABLE achievements_monograph
  MODIFY archival_type enum('researchOriented') NULL COMMENT '归档类别';

ALTER TABLE achievements_patent
  MODIFY archival_type enum('researchOriented') NULL COMMENT '归档类别';

ALTER TABLE achievements_software
  MODIFY archival_type enum('researchOriented') NULL COMMENT '归档类别';

ALTER TABLE achievements_textbook
  MODIFY archival_type enum('teachingCategory') NULL COMMENT '归档类别';

ALTER TABLE achievements_transfer
  MODIFY archival_type enum('researchOriented') NULL COMMENT '归档类别';

ALTER TABLE achievements_competition
  MODIFY role_type enum('参赛者','队长','队员','指导老师','评委','组织者') NULL COMMENT '角色类型';

ALTER TABLE achievements_patent
  MODIFY patent_status enum('申请中','公开状态','实质审查','已授权','已转让','已失效') NULL COMMENT '专利状态';

UPDATE achievements_patent
SET patent_status = '申请中'
WHERE patent_status IS NULL
   OR patent_status = '';

ALTER TABLE achievements_patent
  MODIFY patent_status enum('申请中','公开状态','实质审查','已授权','已转让','已失效') NOT NULL COMMENT '专利状态';

ALTER TABLE achievements_patent
  MODIFY certificate_type enum('application_notice','publication_notice','authorization_certificate') NOT NULL COMMENT '证书类型';
