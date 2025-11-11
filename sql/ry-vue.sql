/*
 Navicat Premium Dump SQL

 Source Server         : bb
 Source Server Type    : MySQL
 Source Server Version : 80405 (8.4.5)
 Source Host           : 172.16.46.202:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80405 (8.4.5)
 File Encoding         : 65001

 Date: 07/11/2025 14:01:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for achievement_type
-- ----------------------------
DROP TABLE IF EXISTS `achievement_type`;
CREATE TABLE `achievement_type`  (
  `type_id` bigint NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父类型ID',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型名称',
  `type_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型编码',
  `type_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '学术成果' COMMENT '类型分类',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `type_icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型图标',
  `type_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#1890ff' COMMENT '类型颜色',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`type_id`) USING BTREE,
  UNIQUE INDEX `uk_type_code`(`type_code` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_type_name`(`type_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成果类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievement_type
-- ----------------------------
INSERT INTO `achievement_type` VALUES (1, 0, '', '学术成果', 'academic', '学术成果', 1, 'academic-icon', '#1890ff', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (2, 1, '1', '论文成果', 'paper', '学术成果', 1, 'paper-icon', '#52c41a', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (3, 1, '1', '专利成果', 'patent', '学术成果', 2, 'patent-icon', '#faad14', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (5, 2, '1,2', 'SCI论文', 'sci_paper', '学术成果', 1, 'sci-icon', '#f5222d', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (6, 2, '1,2', 'EI论文', 'ei_paper', '学术成果', 2, 'ei-icon', '#fa541c', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (7, 2, '1,2', '核心期刊', 'core_journal', '学术成果', 3, 'journal-icon', '#13c2c2', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (8, 2, '1,2', '会议论文', 'conference_paper', '学术成果', 4, 'conference-icon', '#eb2f96', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (9, 3, '1,3', '发明专利', 'invention_patent', '学术成果', 1, 'invention-icon', '#1890ff', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (10, 3, '1,3', '实用新型', 'utility_model', '学术成果', 2, 'utility-icon', '#52c41a', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (11, 3, '1,3', '外观设计', 'design_patent', '学术成果', 3, 'design-icon', '#faad14', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (12, 4, '1,4', '国家级项目', 'national_project', '学术成果', 1, 'national-icon', '#722ed1', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (13, 4, '1,4', '省部级项目', 'provincial_project', '学术成果', 2, 'provincial-icon', '#eb2f96', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (14, 4, '1,4', '校企合作', 'industry_project', '学术成果', 3, 'industry-icon', '#13c2c2', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (15, 5, '1,2,5', 'SCI一区', 'sci_zone1', '学术成果', 1, 'zone1-icon', '#f5222d', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (16, 5, '1,2,5', 'SCI二区', 'sci_zone2', '学术成果', 2, 'zone2-icon', '#fa541c', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (17, 5, '1,2,5', 'SCI三区', 'sci_zone3', '学术成果', 3, 'zone3-icon', '#fa8c16', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (18, 5, '1,2,5', 'SCI四区', 'sci_zone4', '学术成果', 4, 'zone4-icon', '#faad14', '0', '0', 'admin', '2025-11-04 17:46:30', '', NULL);
INSERT INTO `achievement_type` VALUES (19, 0, '', '竞赛成果', 'competition', '学术成果', 3, NULL, '#1890ff', '0', '0', '', '2025-11-07 10:14:39', '', NULL);
INSERT INTO `achievement_type` VALUES (100, 0, '', '项目成果', 'research', '学术成果', 4, NULL, '#1890ff', '0', '0', '', '2025-11-07 10:24:12', '', NULL);
INSERT INTO `achievement_type` VALUES (101, 0, '', '软件著作权', 'software', '学术成果', 5, NULL, '#1890ff', '0', '0', '', '2025-11-07 10:24:12', '', NULL);
INSERT INTO `achievement_type` VALUES (103, 0, '', '专著成果', 'monograph', '学术成果', 6, NULL, '#1890ff', '0', '0', '', '2025-11-07 10:37:31', '', NULL);
INSERT INTO `achievement_type` VALUES (104, 0, '', '教材成果', 'textbook', '学术成果', 7, NULL, '#1890ff', '0', '0', '', '2025-11-07 10:37:31', '', NULL);
INSERT INTO `achievement_type` VALUES (105, 0, '', '获奖成果', 'award', '学术成果', 8, NULL, '#1890ff', '0', '0', '', '2025-11-07 10:37:31', '', NULL);
INSERT INTO `achievement_type` VALUES (106, 0, '', '转化成果', 'transfer', '学术成果', 9, NULL, '#1890ff', '0', '0', '', '2025-11-07 10:37:31', '', NULL);

-- ----------------------------
-- Table structure for achievements
-- ----------------------------
DROP TABLE IF EXISTS `achievements`;
CREATE TABLE `achievements`  (
  `achievements_id` bigint NOT NULL AUTO_INCREMENT COMMENT '成果id',
  `id` bigint NULL DEFAULT NULL COMMENT '关联的子表ID，逻辑外键',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户ID，逻辑外键',
  `user_identity` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户身份(0学生 1教师)',
  `achievements_type` bigint NOT NULL COMMENT '成果类型ID（关联achievement_type）',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '成果名称',
  `status` enum('通过','待审核','驳回') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `submit_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_user_id` bigint NULL DEFAULT NULL COMMENT '审核人ID',
  `audit_opinion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '审核意见',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`achievements_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_user_identity`(`user_identity` ASC) USING BTREE,
  INDEX `idx_achievements_type`(`achievements_type` ASC, `status` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE,
  CONSTRAINT `fk_achievements_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements
-- ----------------------------
INSERT INTO `achievements` VALUES (1, 3, '24306010534', '0', 2, '人工智能在教育领域的应用研究与实践探索', '待审核', '2025-11-06 12:37:45', NULL, NULL, NULL, '24306010534', '2025-11-06 12:37:45', '', NULL);
INSERT INTO `achievements` VALUES (8, 1001, '24306010534', '1', 19, '全国大学生程序设计大赛', '待审核', '2025-11-07 10:25:10', NULL, NULL, NULL, '24306010534', '2025-11-07 10:25:10', '', NULL);
INSERT INTO `achievements` VALUES (9, 1001, '24306010534', '0', 105, '优秀教学成果奖', '待审核', '2025-11-07 10:53:26', NULL, NULL, NULL, '24306010534', '2025-11-07 10:53:26', '', NULL);
INSERT INTO `achievements` VALUES (10, 1001, '24306010534', '1', 3, '一种人工智能教学系统', '待审核', '2025-11-07 10:53:26', NULL, NULL, NULL, '24306010534', '2025-11-07 10:53:26', '', NULL);
INSERT INTO `achievements` VALUES (11, 1001, '24306010534', '0', 100, '人工智能在教育领域的应用研究', '待审核', '2025-11-07 10:53:26', NULL, NULL, NULL, '24306010534', '2025-11-07 10:53:26', '', NULL);
INSERT INTO `achievements` VALUES (12, 1001, '24306010534', '0', 104, '人工智能导论', '待审核', '2025-11-07 10:53:26', NULL, NULL, NULL, '24306010534', '2025-11-07 10:53:26', '', NULL);
INSERT INTO `achievements` VALUES (13, 1001, '24306010534', '1', 101, '智能教学管理系统', '待审核', '2025-11-07 10:53:26', NULL, NULL, NULL, '24306010534', '2025-11-07 10:53:26', '', NULL);
INSERT INTO `achievements` VALUES (14, 1001, '24306010534', '0', 106, '智能教学专利技术', '待审核', '2025-11-07 10:57:04', NULL, NULL, NULL, '24306010534', '2025-11-07 10:57:04', '', NULL);
INSERT INTO `achievements` VALUES (15, 1001, '24306010534', '0', 103, '深度学习理论与实践', '待审核', '2025-11-07 10:57:56', NULL, NULL, NULL, '24306010534', '2025-11-07 10:57:56', '', NULL);
INSERT INTO `achievements` VALUES (16, 4, 'admin', '0', 2, '测试1', '待审核', '2025-11-19 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-19 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (17, 5, 'admin', '00', 2, '测试', '待审核', '2025-11-04 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-04 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (18, 6, 'admin', '00', 2, 'rows', '待审核', '2025-11-05 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-05 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (19, 7, 'admin', '00', 2, 'response', '待审核', '2025-11-25 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-25 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (20, 8, 'admin', '00', 2, '231', '待审核', '2025-11-07 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-07 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (21, 9, 'admin', '00', 2, '1231', '待审核', '2025-11-14 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-14 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (22, 10, 'admin', '00', 2, '1231', '待审核', '2025-11-12 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-12 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (23, 11, 'admin', '00', 2, '123', '待审核', '2025-11-20 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-20 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (24, 12, 'admin', '00', 2, '213', '待审核', '2025-11-06 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-06 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (25, 13, 'admin', '00', 2, '123', '待审核', '2025-11-19 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-19 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (26, 14, 'admin', '00', 2, '123', '待审核', '2025-11-05 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-05 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (27, 15, 'admin', '00', 2, '123', '待审核', '2025-11-21 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-21 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (28, 16, 'admin', '00', 2, '123', '待审核', '2025-11-18 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-18 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (29, 17, 'admin', '00', 2, '123', '待审核', '2025-11-18 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-18 00:00:00', '', NULL);
INSERT INTO `achievements` VALUES (30, 18, 'admin', '00', 2, '123', '待审核', '2025-11-18 00:00:00', NULL, NULL, NULL, 'admin', '2025-11-18 00:00:00', '', NULL);

-- ----------------------------
-- Table structure for achievements_attachment
-- ----------------------------
DROP TABLE IF EXISTS `achievements_attachment`;
CREATE TABLE `achievements_attachment`  (
  `attachment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件ID',
  `user_id` bigint NOT NULL COMMENT '关联子表ID',
  `attachment_type` enum('paper','award','competition','monograph','patent','research','software','textbook','transfer') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '附件类型',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `file_size` bigint NOT NULL COMMENT '文件大小（字节）',
  `file_extension` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件扩展名',
  `file_category` enum('certificate','document','image','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'document' COMMENT '文件分类',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件描述',
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `upload_user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '上传用户ID',
  `download_count` int NOT NULL DEFAULT 0 COMMENT '下载次数',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`attachment_id`) USING BTREE,
  INDEX `idx_achievements_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_attachment_type`(`attachment_type` ASC) USING BTREE,
  INDEX `fk_attachment_id`(`upload_user_id` ASC) USING BTREE,
  CONSTRAINT `fk_attachment_id` FOREIGN KEY (`upload_user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_paper_id` FOREIGN KEY (`user_id`) REFERENCES `achievements_paper` (`paper_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成果附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for achievements_award
-- ----------------------------
DROP TABLE IF EXISTS `achievements_award`;
CREATE TABLE `achievements_award`  (
  `award_id` bigint NOT NULL COMMENT '获奖',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `award_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖项名称id',
  `award_winner` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '获奖人',
  `award_unit` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '颁奖单位',
  `award_date` date NOT NULL COMMENT '获奖时间',
  `award_level` enum('国家级','省级','市级','校级','行业级','国际级','其他') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖项级别',
  `award_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖项类别',
  `award_ranking` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '获奖等次',
  `award_ceremony_date` date NULL DEFAULT NULL COMMENT '颁奖典礼日期',
  `award_ceremony_place` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颁奖地点',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`award_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_award_date`(`award_date` ASC) USING BTREE,
  INDEX `idx_award_level`(`award_level` ASC) USING BTREE,
  CONSTRAINT `fk_award_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '获奖成果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_award
-- ----------------------------
INSERT INTO `achievements_award` VALUES (1001, '24306010534', '优秀教学成果奖', '张老师', '教育部', '2024-06-15', '国家级', '教学成果', '一等奖', NULL, NULL, '待审核', '2025-11-07 10:53:26', '2025-11-07 10:53:26');

-- ----------------------------
-- Table structure for achievements_competition
-- ----------------------------
DROP TABLE IF EXISTS `achievements_competition`;
CREATE TABLE `achievements_competition`  (
  `competition_id` bigint NOT NULL AUTO_INCREMENT COMMENT '竞赛id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `competition_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '竞赛名称',
  `competition_level` enum('国际级','国家级','省级','校级','院级','市级') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '竞赛级别',
  `competition_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '竞赛类型',
  `competition_time` datetime NOT NULL COMMENT '竞赛时间',
  `role_type` enum('参赛者','队长','队员','指导老师','评委','组织者') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色类型',
  `award_level` enum('特等奖','一等奖','二等奖','三等奖','优秀奖','参与奖','组织奖','指导奖','金奖','银奖','铜奖') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '获奖等级',
  `award_date` date NULL DEFAULT NULL COMMENT '获奖日期',
  `organizer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主办单位',
  `competition_category` enum('学科竞赛','科技创新','教学竞赛','科研竞赛','技能竞赛','综合类竞赛','创业竞赛') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '竞赛类别',
  `team_size` int NULL DEFAULT 1 COMMENT '团队人数',
  `team_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '团队名称',
  `student_participants` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '指导的学生参赛（仅指导老师角色使用）',
  `award_certificate_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '获奖证书编号',
  `competition_website` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '竞赛官网',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`competition_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_competition_time`(`competition_time` ASC) USING BTREE,
  INDEX `idx_competition_level`(`competition_level` ASC) USING BTREE,
  CONSTRAINT `fk_competition_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '竞赛成果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_competition
-- ----------------------------
INSERT INTO `achievements_competition` VALUES (1001, '24306010534', '全国大学生程序设计大赛', '国家级', '算法编程类', '2024-10-15 09:00:00', '指导老师', '一等奖', '2024-10-20', '教育部高等教育司', '学科竞赛', 3, '创新之星团队', '[\"张三\", \"李四\", \"王五\"]', 'CERT20241020001', 'https://acm.contest.edu.cn', '待审核', '2025-11-07 10:25:10', '2025-11-07 10:25:10');

-- ----------------------------
-- Table structure for achievements_monograph
-- ----------------------------
DROP TABLE IF EXISTS `achievements_monograph`;
CREATE TABLE `achievements_monograph`  (
  `monograph_id` int NOT NULL COMMENT '专著id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `monograph_title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专著名称',
  `author_role` enum('独著','主编','副主编','参编','译者','编者') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作者角色',
  `press_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出版社',
  `isbn_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ISBN号',
  `publish_date` date NOT NULL COMMENT '出版时间',
  `monograph_type` enum('学术专著','教材','译著','编著','科普著作','工具书','论文集') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专著类型',
  `edition` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版次（如：第一版、第二版等）',
  `word_count` int NULL DEFAULT NULL COMMENT '字数（万字）',
  `page_count` int NULL DEFAULT NULL COMMENT '页数',
  `language` enum('中文','英文','其他') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '中文' COMMENT '著作语言',
  `subject_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学科分类',
  `is_included` tinyint(1) NULL DEFAULT 0 COMMENT '是否被收录（1:是,0:否）',
  `included_database` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收录数据库（如：CSSCI、CSCD等）',
  `award_situation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '获奖情况',
  `co_authors` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '合著者信息（JSON格式存储）',
  `international_standard_book_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '国际标准书号',
  `china_classification_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '中国分类号',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`monograph_id`) USING BTREE,
  UNIQUE INDEX `uk_isbn`(`isbn_number` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_monograph_title`(`monograph_title`(100) ASC) USING BTREE,
  INDEX `idx_publish_date`(`publish_date` ASC) USING BTREE,
  INDEX `idx_press_name`(`press_name` ASC) USING BTREE,
  INDEX `idx_monograph_type`(`monograph_type` ASC) USING BTREE,
  INDEX `idx_user_publish`(`user_id` ASC, `publish_date` ASC) USING BTREE,
  CONSTRAINT `fk_monograph_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成果专著表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_monograph
-- ----------------------------
INSERT INTO `achievements_monograph` VALUES (1001, '24306010534', '深度学习理论与实践', '独著', '科学出版社', '978-7-03-070000-1', '2024-07-10', '学术专著', NULL, NULL, NULL, '中文', NULL, 1, 'CSSCI,CSCD', NULL, NULL, NULL, NULL, '待审核', '2025-11-07 10:57:56', '2025-11-07 10:57:56');

-- ----------------------------
-- Table structure for achievements_paper
-- ----------------------------
DROP TABLE IF EXISTS `achievements_paper`;
CREATE TABLE `achievements_paper`  (
  `paper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '论文id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `paper_title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '论文标题',
  `paper_category` enum('A1','A2','B1','B2','C','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '论文类别',
  `research_direction` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '研究方向',
  `author_information` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作者信息（1:第一作者,2:第二作者等）',
  `journal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '期刊名称',
  `publish_date` date NOT NULL COMMENT '发表时间',
  `volume` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卷号',
  `issue` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '期号',
  `page_range` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页码范围',
  `doi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'DOI号',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`paper_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_publish_date`(`publish_date` ASC) USING BTREE,
  INDEX `idx_journal`(`journal` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '论文成果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_paper
-- ----------------------------
INSERT INTO `achievements_paper` VALUES (3, '24306010534', '人工智能在教育领域的应用研究与实践探索', 'B1', '人工智能与教育技术', '1', '计算机科学与技术学报', '2024-06-15', '45', '3', '12-25', '10.1234/j.cnki.1000-1234.2024.03.002', '待审核', '2025-11-06 00:00:00', '2025-11-06 00:00:00');
INSERT INTO `achievements_paper` VALUES (13, 'admin', '123', 'A1', '123', '123', '123', '2025-11-05', '123', '123', '123', '123', '待审核', '2025-11-19 00:00:00', '2025-11-20 00:00:00');
INSERT INTO `achievements_paper` VALUES (14, 'admin', '123', 'A1', '123', '123', '123', '2025-11-19', '123', '123', '123', '123', '待审核', '2025-11-05 00:00:00', '2025-11-15 00:00:00');
INSERT INTO `achievements_paper` VALUES (15, 'admin', '123', 'A1', '123', '213', '123', '2025-11-20', '123', '213', '123', '123', '待审核', '2025-11-21 00:00:00', '2025-11-21 00:00:00');
INSERT INTO `achievements_paper` VALUES (16, 'admin', '123', 'A2', '213', '123', '123', '2025-11-19', '123', '123', '123', '123', '待审核', '2025-11-18 00:00:00', '2025-11-28 00:00:00');
INSERT INTO `achievements_paper` VALUES (17, 'admin', '123', 'A2', '213', '123', '123', '2025-11-19', '123', '123', '123', '123', '待审核', '2025-11-18 00:00:00', '2025-11-28 00:00:00');
INSERT INTO `achievements_paper` VALUES (18, 'admin', '123', 'A2', '213', '123', '123', '2025-11-19', '123', '123', '123', '123', '待审核', '2025-11-18 00:00:00', '2025-11-28 00:00:00');

-- ----------------------------
-- Table structure for achievements_patent
-- ----------------------------
DROP TABLE IF EXISTS `achievements_patent`;
CREATE TABLE `achievements_patent`  (
  `patent_id` bigint NOT NULL COMMENT '专利id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `patent_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专利名称',
  `patent_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专利号',
  `patent_type` enum('发明专利','实用新型','外观设计') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专利类型',
  `author_order` int NOT NULL COMMENT '发明人顺序',
  `application_date` date NOT NULL COMMENT '申请日期',
  `authorization_date` date NULL DEFAULT NULL COMMENT '授权日期',
  `publication_date` date NULL DEFAULT NULL COMMENT '公布日期',
  `publication_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公布号',
  `patent_validity` date NULL DEFAULT NULL COMMENT '专利有效期',
  `patent_subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专利所属学科',
  `patent_status` enum('申请中','已授权','已转让','已失效','实质审查') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '申请中' COMMENT '专利状态',
  `patent_office` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专利局',
  `technical_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '技术领域',
  `legal_status` enum('申请中','已授权','有效','失效','终止') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '申请中' COMMENT '专利法律状态',
  `certificate_type` enum('application_notice','authorization_certificate') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'application_notice' COMMENT '证书类型',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`patent_id`) USING BTREE,
  UNIQUE INDEX `uk_patent_no`(`patent_no` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_application_date`(`application_date` ASC) USING BTREE,
  INDEX `idx_patent_type`(`patent_type` ASC) USING BTREE,
  CONSTRAINT `fk_patent_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '专利成果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_patent
-- ----------------------------
INSERT INTO `achievements_patent` VALUES (1001, '24306010534', '一种人工智能教学系统', 'ZL202410000001.1', '发明专利', 1, '2024-01-10', '2024-06-20', NULL, NULL, NULL, NULL, '已授权', '国家知识产权局', NULL, '申请中', 'application_notice', '待审核', '2025-11-07 10:53:26', '2025-11-07 10:53:26');

-- ----------------------------
-- Table structure for achievements_research
-- ----------------------------
DROP TABLE IF EXISTS `achievements_research`;
CREATE TABLE `achievements_research`  (
  `research_id` bigint NOT NULL COMMENT '项目id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `project_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编号',
  `project_category` enum('纵向项目','横向项目') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目类别',
  `project_level` enum('国家级','省部级','市厅级','校级','企业级','国际合作') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目级别',
  `project_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目类型',
  `project_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目名称',
  `principal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '负责人',
  `participants` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参与人（JSON格式存储）',
  `organizing_unit` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '立项单位',
  `total_funding` decimal(12, 2) NOT NULL COMMENT '总经费（万元）',
  `received_funding` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '已到账经费',
  `funding_unit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经费拨款单位',
  `start_date` date NOT NULL COMMENT '开始时间',
  `end_date` date NOT NULL COMMENT '结束时间',
  `actual_end_date` date NULL DEFAULT NULL COMMENT '实际结题时间',
  `project_status` enum('在研','已结题','延期','终止','验收中','申报中') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '在研' COMMENT '项目状态',
  `completion_status` enum('未结题','已结题','结题优秀','结题合格','结题不合格') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '未结题' COMMENT '结题状态',
  `research_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '研究领域',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`research_id`) USING BTREE,
  UNIQUE INDEX `uk_project_number`(`project_number` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_start_date`(`start_date` ASC) USING BTREE,
  INDEX `idx_project_level`(`project_level` ASC) USING BTREE,
  CONSTRAINT `fk_research_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `chk_research_dates` CHECK (`start_date` <= `end_date`),
  CONSTRAINT `chk_research_funding` CHECK ((`total_funding` >= `received_funding`) and (`total_funding` >= 0))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目成果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_research
-- ----------------------------
INSERT INTO `achievements_research` VALUES (1001, '24306010534', 'NSFC2024001', '纵向项目', '国家级', '自然科学基金', '人工智能在教育领域的应用研究', '张老师', NULL, '国家自然科学基金委', 50.00, 0.00, NULL, '2024-03-01', '2026-02-28', NULL, '在研', '未结题', NULL, '待审核', '2025-11-07 10:53:26', '2025-11-07 10:53:26');

-- ----------------------------
-- Table structure for achievements_software
-- ----------------------------
DROP TABLE IF EXISTS `achievements_software`;
CREATE TABLE `achievements_software`  (
  `software_id` bigint NOT NULL COMMENT '软著id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `software_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '软件名称',
  `software_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '软件版本',
  `certificate_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登记号',
  `publish_date` date NULL DEFAULT NULL COMMENT '发表日期',
  `register_date` date NOT NULL COMMENT '登记日期',
  `development_date` date NOT NULL COMMENT '开发完成日期',
  `programming_language` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '编程语言',
  `software_type` enum('系统软件','应用软件','嵌入式软件','其他') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '软件类型',
  `software_copyright_certificate_level` enum('一级','二级','三级','其他') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '软著等级',
  `certificate_type` enum('申请证书','授权证书') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证书类型',
  `main_function` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '主要功能',
  `application_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用领域',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`software_id`) USING BTREE,
  UNIQUE INDEX `uk_certificate_no`(`certificate_no` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_register_date`(`register_date` ASC) USING BTREE,
  CONSTRAINT `fk_software_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '软件著作权成果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_software
-- ----------------------------
INSERT INTO `achievements_software` VALUES (1001, '24306010534', '智能教学管理系统', 'V1.0', '2024SR000001', NULL, '2024-04-15', '2024-03-01', NULL, '应用软件', '一级', '申请证书', NULL, NULL, '待审核', '2025-11-07 10:53:26', '2025-11-07 10:53:26');

-- ----------------------------
-- Table structure for achievements_textbook
-- ----------------------------
DROP TABLE IF EXISTS `achievements_textbook`;
CREATE TABLE `achievements_textbook`  (
  `textbook_id` bigint NOT NULL COMMENT '教材id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `textbook_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '教材名称',
  `author_role` enum('主编','副主编','参编','独著') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作者角色',
  `press_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出版社',
  `isbn_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ISBN号',
  `publish_date` date NOT NULL COMMENT '出版时间',
  `textbook_type` enum('规划教材','校本教材','国家级规划','省部级规划','行业规划') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '教材类型',
  `edition` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版次',
  `word_count` int NULL DEFAULT NULL COMMENT '字数（万字）',
  `using_institutions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '使用院校（JSON格式）',
  `applicable_major` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '适用专业',
  `textbook_level` enum('本科','专科','研究生','职业教育') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '本科' COMMENT '教材层次',
  `approval_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批准文号',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`textbook_id`) USING BTREE,
  UNIQUE INDEX `uk_isbn`(`isbn_number` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_publish_date`(`publish_date` ASC) USING BTREE,
  CONSTRAINT `fk_textbook_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教材著作表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_textbook
-- ----------------------------
INSERT INTO `achievements_textbook` VALUES (1001, '24306010534', '人工智能导论', '主编', '高等教育出版社', '978-7-04-060000-1', '2024-05-20', '规划教材', '第一版', NULL, NULL, NULL, '本科', NULL, '待审核', '2025-11-07 10:53:26', '2025-11-07 10:53:26');

-- ----------------------------
-- Table structure for achievements_transfer
-- ----------------------------
DROP TABLE IF EXISTS `achievements_transfer`;
CREATE TABLE `achievements_transfer`  (
  `transfer_id` bigint NOT NULL COMMENT '转化id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `achievement_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '成果名称',
  `achievement_type` enum('论文','专利','软件著作权','技术秘密','其他') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '成果类型',
  `achievement_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '成果编号',
  `transfer_method` enum('转让','许可','作价入股','合作开发','技术服务','技术咨询') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '转化方式',
  `partner_enterprise` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '合作企业',
  `transfer_amount` decimal(12, 2) NOT NULL COMMENT '转化金额（万元）',
  `transfer_date` date NOT NULL COMMENT '转化时间',
  `transfer_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '转化内容描述',
  `validity_period` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '有效期限',
  `territory_range` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地域范围',
  `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `transfer_status` enum('洽谈中','已签约','执行中','已完成','终止','违约') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '洽谈中' COMMENT '转化状态',
  `is_exclusive` tinyint(1) NULL DEFAULT 0 COMMENT '是否独占许可',
  `economic_benefits` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '经济效益',
  `social_benefits` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '社会效益',
  `contact_person` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`transfer_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_transfer_date`(`transfer_date` ASC) USING BTREE,
  INDEX `idx_partner_enterprise`(`partner_enterprise` ASC) USING BTREE,
  CONSTRAINT `fk_transfer_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成果转化表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of achievements_transfer
-- ----------------------------
INSERT INTO `achievements_transfer` VALUES (1001, '24306010534', '智能教学专利技术', '专利', NULL, '许可', '某某科技公司', 20.00, '2024-08-01', NULL, NULL, NULL, NULL, '已签约', 0, NULL, NULL, NULL, NULL, '待审核', '2025-11-07 10:57:04', '2025-11-07 10:57:04');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (7, 'achievements_paper', '论文成果表', NULL, NULL, 'AchievementsPaper', 'crud', 'element-ui', 'com.ruoyi.paper', 'paper', 'paper', '论文成果', 'xixia', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59', NULL);
INSERT INTO `gen_table` VALUES (8, 'achievements_attachment', '成果附件表', NULL, NULL, 'AchievementsAttachment', 'crud', '', 'com.ruoyi.system', 'system', 'attachment', '成果附件', 'ruoyi', '0', '/', NULL, 'admin', '2025-11-06 23:33:25', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 137 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (106, 7, 'paper_id', '论文id', 'bigint', 'Long', 'paperId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (107, 7, 'user_id', '用户ID', 'varchar(30)', 'String', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (108, 7, 'paper_title', '论文标题', 'varchar(500)', 'String', 'paperTitle', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (109, 7, 'paper_category', '论文类别', 'enum(\'A1\',\'A2\',\'B1\',\'B2\',\'C\',\'D\')', 'String', 'paperCategory', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (110, 7, 'research_direction', '研究方向', 'varchar(200)', 'String', 'researchDirection', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (111, 7, 'author_information', '作者信息（1:第一作者,2:第二作者等）', 'varchar(100)', 'String', 'authorInformation', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (112, 7, 'journal', '期刊名称', 'varchar(255)', 'String', 'journal', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (113, 7, 'publish_date', '发表时间', 'date', 'Date', 'publishDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 8, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (114, 7, 'volume', '卷号', 'varchar(50)', 'String', 'volume', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (115, 7, 'issue', '期号', 'varchar(50)', 'String', 'issue', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (116, 7, 'page_range', '页码范围', 'varchar(50)', 'String', 'pageRange', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (117, 7, 'doi', 'DOI号', 'varchar(100)', 'String', 'doi', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (118, 7, 'audit_status', '审核状态', 'enum(\'通过\',\'驳回\',\'待审核\')', 'String', 'auditStatus', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'select', '', 13, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (119, 7, 'created_at', '创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (120, 7, 'updated_at', '更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 15, 'admin', '2025-11-05 23:49:02', '', '2025-11-05 23:58:59');
INSERT INTO `gen_table_column` VALUES (121, 8, 'attachment_id', '附件ID', 'bigint', 'Long', 'attachmentId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (122, 8, 'user_id', '关联子表ID', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (123, 8, 'attachment_type', '附件类型', 'enum(\'paper\',\'award\',\'competition\',\'monograph\',\'patent\',\'research\',\'software\',\'textbook\',\'transfer\')', 'String', 'attachmentType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (124, 8, 'file_name', '文件名称', 'varchar(255)', 'String', 'fileName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (125, 8, 'file_path', '文件路径', 'varchar(500)', 'String', 'filePath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (126, 8, 'file_size', '文件大小（字节）', 'bigint', 'Long', 'fileSize', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (127, 8, 'file_extension', '文件扩展名', 'varchar(20)', 'String', 'fileExtension', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (128, 8, 'file_category', '文件分类', 'enum(\'certificate\',\'document\',\'image\',\'other\')', 'String', 'fileCategory', '0', '0', '1', '1', '1', '1', '1', 'EQ', NULL, '', 8, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (129, 8, 'description', '文件描述', 'varchar(500)', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (130, 8, 'upload_time', '上传时间', 'timestamp', 'Date', 'uploadTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 10, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (131, 8, 'upload_user_id', '上传用户ID', 'varchar(30)', 'String', 'uploadUserId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (132, 8, 'download_count', '下载次数', 'int', 'Long', 'downloadCount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (133, 8, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (134, 8, 'create_time', '创建时间', 'timestamp', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (135, 8, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 15, 'admin', '2025-11-06 23:33:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (136, 8, 'update_time', '更新时间', 'timestamp', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 16, 'admin', '2025-11-06 23:33:25', '', NULL);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-11-03 11:30:08', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 214 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '山西工学院', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-03 15:06:31');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '信息工程学院', 1, '韩鹤', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-03 15:07:05');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '陶瓷学院', 2, '', '', '', '1', '0', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-06 19:32:41');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '计算机科学与技术', 1, '姚慧婷', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-06 19:39:01');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '物联网工程', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-06 19:39:18');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '通信工程', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-06 19:39:24');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-11-03 11:30:07', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-11-03 11:30:07', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '2024级', 1, 'xx', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-03 15:10:07');
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '2025级', 2, 'x x', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-03 15:10:16');
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '电力工程学院', 3, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:32:10', '', NULL);
INSERT INTO `sys_dept` VALUES (201, 100, '0,100', '能源工程学院', 4, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:32:53', '', NULL);
INSERT INTO `sys_dept` VALUES (202, 100, '0,100', '材料工程学院', 5, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:33:06', '', NULL);
INSERT INTO `sys_dept` VALUES (203, 100, '0,100', '智能制造工程学院', 6, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:33:15', '', NULL);
INSERT INTO `sys_dept` VALUES (204, 100, '0,100', '文旅学院', 7, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:33:33', '', NULL);
INSERT INTO `sys_dept` VALUES (205, 100, '0,100', '经济与管理学院', 8, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:33:51', '', NULL);
INSERT INTO `sys_dept` VALUES (206, 100, '0,100', '建筑工程学院', 10, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:34:11', '', NULL);
INSERT INTO `sys_dept` VALUES (207, 100, '0,100', '通识教育学院', 9, NULL, NULL, NULL, '1', '0', 'admin', '2025-11-06 19:34:26', '', NULL);
INSERT INTO `sys_dept` VALUES (208, 101, '0,100,101', '电子信息工程', 4, NULL, NULL, NULL, '0', '0', 'admin', '2025-11-06 19:39:43', '', NULL);
INSERT INTO `sys_dept` VALUES (209, 101, '0,100,101', '人工智能', 5, NULL, NULL, NULL, '0', '0', 'admin', '2025-11-06 19:39:51', '', NULL);
INSERT INTO `sys_dept` VALUES (210, 101, '0,100,101', '轨道交通信号与控制', 6, NULL, NULL, NULL, '0', '0', 'admin', '2025-11-06 19:40:00', '', NULL);
INSERT INTO `sys_dept` VALUES (211, 101, '0,100,101', '网络安全', 7, NULL, NULL, NULL, '0', '0', 'admin', '2025-11-06 19:40:07', '', NULL);
INSERT INTO `sys_dept` VALUES (212, 101, '0,100,101', '软件工程', 8, NULL, NULL, NULL, '0', '0', 'admin', '2025-11-06 19:40:13', '', NULL);
INSERT INTO `sys_dept` VALUES (213, 103, '0,100,101,103', '2024级', 1, NULL, NULL, NULL, '0', '0', 'admin', '2025-11-06 19:40:38', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-11-03 11:30:08', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-11-03 11:30:08', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-11-03 11:30:08', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-11-03 11:30:08', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-03 13:28:00');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '172.16.197.158', '内网IP', 'Chrome Mobile', 'Android 1.x', '1', '验证码错误', '2025-11-03 13:28:41');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '172.16.197.158', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-11-03 13:28:47');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '172.16.196.168', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-11-03 13:46:06');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '172.16.196.168', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-11-03 15:05:13');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2025-11-03 15:12:35');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-03 15:12:36');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '172.16.76.229', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-03 15:26:11');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '172.18.131.58', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-11-03 17:02:00');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '172.16.77.180', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-03 19:16:42');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '172.16.77.180', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-03 19:18:22');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '172.16.77.180', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-03 19:18:29');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '172.16.77.150', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-03 20:56:42');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-03 22:35:20');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-05 10:37:20');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-11-05 10:38:15');
INSERT INTO `sys_logininfor` VALUES (116, '24306010535', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-05 10:38:26');
INSERT INTO `sys_logininfor` VALUES (117, '24306010535', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-11-05 10:39:07');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-05 10:39:12');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Firefox 14', 'Windows 10', '0', '登录成功', '2025-11-05 16:47:24');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '172.16.150.127', '内网IP', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '登录成功', '2025-11-05 18:49:48');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '172.16.93.32', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-11-05 18:53:08');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '172.16.77.153', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-11-05 20:55:50');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '172.16.77.171', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-05 21:07:02');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '172.16.77.150', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-11-05 21:23:50');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '172.16.77.150', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-05 21:52:12');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-05 23:48:35');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-06 12:20:19');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '172.16.193.197', '内网IP', 'Chrome 12', 'Linux', '0', '登录成功', '2025-11-06 15:19:27');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '172.18.176.131', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-06 16:19:55');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-06 19:22:34');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2025-11-06 19:28:38');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-06 19:28:44');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-06 23:30:10');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-06 23:30:21');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '172.16.193.221', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-07 10:46:45');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Firefox 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-07 10:55:03');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Firefox 14', 'Windows 10', '0', '登录成功', '2025-11-07 10:55:11');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2009 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-11-03 11:30:07', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-11-03 11:30:07', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-11-03 11:30:07', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '1', '', 'guide', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-05 17:04:30', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-11-03 11:30:07', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-11-03 11:30:07', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-11-03 11:30:07', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-11-03 11:30:07', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-11-03 11:30:07', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-11-03 11:30:07', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-11-03 11:30:07', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-11-03 11:30:07', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-11-03 11:30:07', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-11-03 11:30:07', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-11-03 11:30:07', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-11-03 11:30:07', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-11-03 11:30:07', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-11-03 11:30:07', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-11-03 11:30:07', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-11-03 11:30:07', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-11-03 11:30:07', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-11-03 11:30:07', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-11-03 11:30:07', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-11-03 11:30:07', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-11-03 11:30:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '成果管理', 0, 0, 'achievement', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'excel', 'admin', '2025-11-05 11:11:23', 'admin', '2025-11-05 11:11:46', '');
INSERT INTO `sys_menu` VALUES (2003, '论文成果', 2000, 1, 'paper', 'paper/paper/index', NULL, '', 1, 0, 'C', '0', '0', 'paper:paper:list', 'education', 'admin', '2025-11-06 19:24:17', 'admin', '2025-11-06 19:31:38', '论文成果菜单');
INSERT INTO `sys_menu` VALUES (2004, '论文成果查询', 2003, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'paper:paper:query', '#', 'admin', '2025-11-06 19:24:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '论文成果新增', 2003, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'paper:paper:add', '#', 'admin', '2025-11-06 19:24:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '论文成果修改', 2003, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'paper:paper:edit', '#', 'admin', '2025-11-06 19:24:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '论文成果删除', 2003, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'paper:paper:remove', '#', 'admin', '2025-11-06 19:24:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '论文成果导出', 2003, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'paper:paper:export', '#', 'admin', '2025-11-06 19:24:17', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-11-03 11:30:08', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-11-03 11:30:08', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 221 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"山西工学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:06:31', 21);
INSERT INTO `sys_oper_log` VALUES (101, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"信息工程学院\",\"email\":\"ry@qq.com\",\"leader\":\"韩鹤\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"山西工学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:07:05', 31);
INSERT INTO `sys_oper_log` VALUES (102, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"姚慧婷\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:08:02', 26);
INSERT INTO `sys_oper_log` VALUES (103, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"信息工程学院\",\"email\":\"ry@qq.com\",\"leader\":\"姚慧婷\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:08:17', 27);
INSERT INTO `sys_oper_log` VALUES (104, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/107', '172.16.196.168', '内网IP', '107', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:08:22', 14);
INSERT INTO `sys_oper_log` VALUES (105, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/106', '172.16.196.168', '内网IP', '106', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:08:29', 13);
INSERT INTO `sys_oper_log` VALUES (106, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/105', '172.16.196.168', '内网IP', '105', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-11-03 15:08:31', 4);
INSERT INTO `sys_oper_log` VALUES (107, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/105', '172.16.196.168', '内网IP', '105', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-11-03 15:08:35', 5);
INSERT INTO `sys_oper_log` VALUES (108, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"2024级\",\"email\":\"ry@qq.com\",\"leader\":\"姚慧婷\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:09:01', 20);
INSERT INTO `sys_oper_log` VALUES (109, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"2023级\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:09:12', 19);
INSERT INTO `sys_oper_log` VALUES (110, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"2025级\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:09:24', 24);
INSERT INTO `sys_oper_log` VALUES (111, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '172.16.196.168', '内网IP', '102', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-11-03 15:09:26', 3);
INSERT INTO `sys_oper_log` VALUES (112, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"陶瓷学院\",\"email\":\"ry@qq.com\",\"leader\":\"xx\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"山西工学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:09:52', 31);
INSERT INTO `sys_oper_log` VALUES (113, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"2024级\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"parentName\":\"陶瓷学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:10:03', 19);
INSERT INTO `sys_oper_log` VALUES (114, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"2024级\",\"email\":\"ry@qq.com\",\"leader\":\"xx\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"parentName\":\"陶瓷学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:10:07', 22);
INSERT INTO `sys_oper_log` VALUES (115, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '172.16.196.168', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":109,\"deptName\":\"2025级\",\"email\":\"ry@qq.com\",\"leader\":\"x x\",\"orderNum\":2,\"params\":{},\"parentId\":102,\"parentName\":\"陶瓷学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 15:10:16', 21);
INSERT INTO `sys_oper_log` VALUES (116, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '2024级', '/system/user/profile', '172.16.77.150', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"123\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 21:00:01', 14);
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/importTable', '172.16.193.221', '内网IP', '{\"tables\":\"sys_user\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 22:37:39', 72);
INSERT INTO `sys_oper_log` VALUES (118, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '2024级', '/tool/gen/1', '172.16.193.221', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-03 22:38:06', 62);
INSERT INTO `sys_oper_log` VALUES (119, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, '24306010535', NULL, '/system/user/profile', '172.16.193.221', '内网IP', '{\"admin\":false,\"email\":\"13934910703@qq.com\",\"nickName\":\"薛红菲\",\"params\":{},\"phonenumber\":\"13934910703\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 10:38:50', 13);
INSERT INTO `sys_oper_log` VALUES (120, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '2024级', '/system/role', '172.16.193.221', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[4],\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"普通学生\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 10:50:19', 33);
INSERT INTO `sys_oper_log` VALUES (121, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '2024级', '/system/role', '172.16.193.221', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[4],\"params\":{},\"roleId\":101,\"roleKey\":\"StudentAdministrator\",\"roleName\":\"学生管理员\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 10:51:24', 40);
INSERT INTO `sys_oper_log` VALUES (122, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '2024级', '/system/role', '172.16.193.221', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-05 10:50:19\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[4],\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"普通学生\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 10:51:30', 18);
INSERT INTO `sys_oper_log` VALUES (123, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '2024级', '/system/role', '172.16.193.221', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"普通老师\",\"roleSort\":5,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 10:51:59', 34);
INSERT INTO `sys_oper_log` VALUES (124, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '2024级', '/system/role', '172.16.193.221', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-05 10:51:24\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[4],\"params\":{},\"roleId\":101,\"roleKey\":\"studentAdministrator\",\"roleName\":\"学生管理员\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 10:52:12', 17);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '2024级', '/system/menu', '172.16.193.221', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"成果管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"achievement\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 11:11:23', 26);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.193.221', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-05 11:11:23\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"成果管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"achievement\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 11:11:46', 16);
INSERT INTO `sys_oper_log` VALUES (127, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/importTable', '172.16.193.221', '内网IP', '{\"tables\":\"achievements_paper\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 11:25:57', 40);
INSERT INTO `sys_oper_log` VALUES (128, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '2024级', '/tool/gen/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 16:47:58', 62);
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"achievements_paper\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 16:48:09', 273);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"achievements\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 16:49:42', 197);
INSERT INTO `sys_oper_log` VALUES (131, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '2024级', '/tool/gen/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 16:57:02', 92);
INSERT INTO `sys_oper_log` VALUES (132, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '2024级', '/tool/gen/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 16:57:03', 128);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-03 11:30:07\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:04:30', 26);
INSERT INTO `sys_oper_log` VALUES (134, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '2024级', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-11-03 11:30:07\",\"flag\":false,\"params\":{},\"postCode\":\"headteacher\",\"postId\":1,\"postName\":\"班主任\",\"postSort\":1,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:05:19', 44);
INSERT INTO `sys_oper_log` VALUES (135, '岗位管理', 3, 'com.ruoyi.web.controller.system.SysPostController.remove()', 'DELETE', 1, 'admin', '2024级', '/system/post/2', '127.0.0.1', '内网IP', '[2]', NULL, 1, '项目经理已分配,不能删除', '2025-11-05 17:05:29', 16);
INSERT INTO `sys_oper_log` VALUES (136, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '2024级', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 11:30:07\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"2025级\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-11-03 11:30:07\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"管理\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[1],\"pwdUpdateDate\":\"2025-11-03 11:30:07\",\"remark\":\"测试员\",\"roleIds\":[2,101,100],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:06:01', 76);
INSERT INTO `sys_oper_log` VALUES (137, '岗位管理', 3, 'com.ruoyi.web.controller.system.SysPostController.remove()', 'DELETE', 1, 'admin', '2024级', '/system/post/2,3,4', '127.0.0.1', '内网IP', '[2,3,4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:06:18', 56);
INSERT INTO `sys_oper_log` VALUES (138, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"achievements_attachment\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:08:30', 184);
INSERT INTO `sys_oper_log` VALUES (139, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '2024级', '/tool/gen/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:08:53', 41);
INSERT INTO `sys_oper_log` VALUES (140, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"achievements_paper\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:09:06', 209);
INSERT INTO `sys_oper_log` VALUES (141, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '2024级', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"paper\",\"className\":\"AchievementsPaper\",\"columns\":[{\"capJavaField\":\"PaperId\",\"columnComment\":\"论文id\",\"columnId\":90,\"columnName\":\"paper_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"paperId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AchievementsId\",\"columnComment\":\"关联成果基础表ID\",\"columnId\":91,\"columnName\":\"achievements_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"achievementsId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":92,\"columnName\":\"user_id\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PaperTitle\",\"columnComment\":\"论文标题\",\"columnId\":93,\"columnName\":\"paper_title\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 17:09:36', 188);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '2024级', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"achievements_paper\"}', NULL, 0, NULL, '2025-11-05 17:09:39', 216);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"论文管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"/thesis\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:36:39', 9);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"/thesis\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:37:50', 11);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"/thesis\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:38:09', 12);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"thesis\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:39:54', 11);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"component\":\"system/thesis/index\",\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"thesis\",\"perms\":\"syetem:thesis:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:40:54', 9);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"component\":\"system/thesis/index\",\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"thesis\",\"perms\":\"syetem:thesis:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:41:54', 8);
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"component\":\"system/thesis/index\",\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"thesis\",\"perms\":\"system:thesis:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:44:21', 9);
INSERT INTO `sys_oper_log` VALUES (150, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/createTable', '172.16.77.150', '内网IP', '{\"sql\":\"表描述：论文管理\\n实体类名称：Thesis\\n模块名：system\\n业务名：thesis\\n生成模板：Vue3+Element Plus（或对应前端版本）\\n勾选查询条件、表单字段、表格字段（如标题、作者、发表时间等）；\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-11-05 21:44:51', 6);
INSERT INTO `sys_oper_log` VALUES (151, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/createTable', '172.16.77.150', '内网IP', '{\"sql\":\"表描述：论文管理\\n\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-11-05 21:45:10', 2);
INSERT INTO `sys_oper_log` VALUES (152, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/createTable', '172.16.77.150', '内网IP', '{\"sql\":\"\\n论文成果\\n\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-11-05 21:45:27', 1);
INSERT INTO `sys_oper_log` VALUES (153, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '2024级', '/tool/gen', '172.16.77.150', '内网IP', '{\"businessName\":\"paper\",\"className\":\"AchievementsPaper\",\"columns\":[{\"capJavaField\":\"PaperId\",\"columnComment\":\"论文id\",\"columnId\":90,\"columnName\":\"paper_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"paperId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 17:09:35\",\"usableColumn\":false},{\"capJavaField\":\"AchievementsId\",\"columnComment\":\"关联成果基础表ID\",\"columnId\":91,\"columnName\":\"achievements_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"achievementsId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 17:09:36\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":92,\"columnName\":\"user_id\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 17:09:36\",\"usableColumn\":false},{\"capJavaField\":\"PaperTitle\",\"columnComment\":\"论文标题\",\"columnId\":93,\"columnName\":\"paper_title\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 17:09:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"texta', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:46:03', 44);
INSERT INTO `sys_oper_log` VALUES (154, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '2024级', '/tool/gen/batchGenCode', '172.16.77.150', '内网IP', '{\"tables\":\"achievements_paper\"}', NULL, 0, NULL, '2025-11-05 21:46:23', 33);
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"component\":\"system/thesis/index\",\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"/thesis\",\"perms\":\"system:thesis:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:52:43', 9);
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-11-05 21:36:39\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"论文管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"/thesis\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:53:10', 12);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '2024级', '/system/menu', '172.16.77.150', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"123\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"/123\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 21:59:41', 9);
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '2024级', '/system/menu/2002', '172.16.77.150', '内网IP', '2002', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 22:01:43', 10);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '2024级', '/system/menu/2001', '172.16.193.221', '内网IP', '2001', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 23:48:48', 12);
INSERT INTO `sys_oper_log` VALUES (160, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '2024级', '/tool/gen/6', '172.16.193.221', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 23:48:54', 10);
INSERT INTO `sys_oper_log` VALUES (161, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '2024级', '/tool/gen/importTable', '172.16.193.221', '内网IP', '{\"tables\":\"achievements_paper\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 23:49:02', 40);
INSERT INTO `sys_oper_log` VALUES (162, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '2024级', '/tool/gen', '172.16.193.221', '内网IP', '{\"businessName\":\"paper\",\"className\":\"AchievementsPaper\",\"columns\":[{\"capJavaField\":\"PaperId\",\"columnComment\":\"论文id\",\"columnId\":106,\"columnName\":\"paper_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"paperId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":107,\"columnName\":\"user_id\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PaperTitle\",\"columnComment\":\"论文标题\",\"columnId\":108,\"columnName\":\"paper_title\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"paperTitle\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PaperCategory\",\"columnComment\":\"论文类别\",\"columnId\":109,\"columnName\":\"paper_category\",\"columnType\":\"enum(\'A1\',\'A2\',\'B1\',\'B2\',\'C\',\'D\')\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 23:50:36', 28);
INSERT INTO `sys_oper_log` VALUES (163, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '2024级', '/tool/gen', '172.16.193.221', '内网IP', '{\"businessName\":\"paper\",\"className\":\"AchievementsPaper\",\"columns\":[{\"capJavaField\":\"PaperId\",\"columnComment\":\"论文id\",\"columnId\":106,\"columnName\":\"paper_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"paperId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 23:50:36\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":107,\"columnName\":\"user_id\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 23:50:36\",\"usableColumn\":false},{\"capJavaField\":\"PaperTitle\",\"columnComment\":\"论文标题\",\"columnId\":108,\"columnName\":\"paper_title\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"paperTitle\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 23:50:36\",\"usableColumn\":false},{\"capJavaField\":\"PaperCategory\",\"columnComment\":\"论文类别\",\"columnId\":109,\"columnName\":\"paper_category\",\"columnType\":\"enum(\'A1\',\'A2\',\'B1\',\'B2\',\'C\',\'D\')\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edi', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 23:50:47', 30);
INSERT INTO `sys_oper_log` VALUES (164, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '2024级', '/tool/gen/batchGenCode', '172.16.193.221', '内网IP', '{\"tables\":\"achievements_paper\"}', NULL, 0, NULL, '2025-11-05 23:50:49', 25);
INSERT INTO `sys_oper_log` VALUES (165, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '2024级', '/tool/gen', '172.16.193.221', '内网IP', '{\"businessName\":\"paper\",\"className\":\"AchievementsPaper\",\"columns\":[{\"capJavaField\":\"PaperId\",\"columnComment\":\"论文id\",\"columnId\":106,\"columnName\":\"paper_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"paperId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 23:50:47\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":107,\"columnName\":\"user_id\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 23:50:47\",\"usableColumn\":false},{\"capJavaField\":\"PaperTitle\",\"columnComment\":\"论文标题\",\"columnId\":108,\"columnName\":\"paper_title\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"paperTitle\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-11-05 23:50:47\",\"usableColumn\":false},{\"capJavaField\":\"PaperCategory\",\"columnComment\":\"论文类别\",\"columnId\":109,\"columnName\":\"paper_category\",\"columnType\":\"enum(\'A1\',\'A2\',\'B1\',\'B2\',\'C\',\'D\')\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 23:49:02\",\"dictType\":\"\",\"edi', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 23:58:59', 26);
INSERT INTO `sys_oper_log` VALUES (166, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '2024级', '/tool/gen/batchGenCode', '172.16.193.221', '内网IP', '{\"tables\":\"achievements_paper\"}', NULL, 0, NULL, '2025-11-05 23:59:01', 20);
INSERT INTO `sys_oper_log` VALUES (167, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '2024级', '/system/role/dataScope', '172.16.193.197', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-05 10:50:19\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"普通学生\",\"roleSort\":4,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 15:23:10', 9);
INSERT INTO `sys_oper_log` VALUES (168, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '2024级', '/system/user/profile/updatePwd', '172.16.193.221', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:29:32', 216);
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '2024级', '/system/menu', '172.16.193.221', '内网IP', '{\"children\":[],\"component\":\"paper/paper/index\",\"createTime\":\"2025-11-06 19:24:17\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"论文成果\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"paper\",\"perms\":\"paper:paper:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:31:38', 21);
INSERT INTO `sys_oper_log` VALUES (170, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"电力工程学院\",\"orderNum\":3,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:32:10', 29);
INSERT INTO `sys_oper_log` VALUES (171, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"陶瓷学院\",\"email\":\"\",\"leader\":\"\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"山西工学院\",\"phone\":\"\",\"status\":\"1\"}', '{\"msg\":\"该部门包含未停用的子部门！\",\"code\":500}', 0, NULL, '2025-11-06 19:32:28', 7);
INSERT INTO `sys_oper_log` VALUES (172, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '2024级', '/system/dept/108', '172.16.193.221', '内网IP', '108', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:32:33', 24);
INSERT INTO `sys_oper_log` VALUES (173, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '2024级', '/system/dept/109', '172.16.193.221', '内网IP', '109', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:32:36', 27);
INSERT INTO `sys_oper_log` VALUES (174, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"陶瓷学院\",\"email\":\"\",\"leader\":\"\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"山西工学院\",\"phone\":\"\",\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:32:41', 28);
INSERT INTO `sys_oper_log` VALUES (175, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"能源工程学院\",\"orderNum\":4,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:32:53', 13);
INSERT INTO `sys_oper_log` VALUES (176, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"材料工程学院\",\"orderNum\":5,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:33:06', 31);
INSERT INTO `sys_oper_log` VALUES (177, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"智能制造工程学院\",\"orderNum\":6,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:33:15', 22);
INSERT INTO `sys_oper_log` VALUES (178, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"children\":[],\"deptName\":\"信息工程学院\",\"orderNum\":7,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"新增部门\'信息工程学院\'失败，部门名称已存在\",\"code\":500}', 0, NULL, '2025-11-06 19:33:26', 6);
INSERT INTO `sys_oper_log` VALUES (179, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"文旅学院\",\"orderNum\":7,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:33:33', 13);
INSERT INTO `sys_oper_log` VALUES (180, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"经济与管理学院\",\"orderNum\":8,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:33:51', 12);
INSERT INTO `sys_oper_log` VALUES (181, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"建筑工程学院\",\"orderNum\":10,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:34:11', 16);
INSERT INTO `sys_oper_log` VALUES (182, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"通识教育学院\",\"orderNum\":9,\"params\":{},\"parentId\":100,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:34:26', 18);
INSERT INTO `sys_oper_log` VALUES (183, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '2024级', '/system/role/dataScope', '172.16.193.221', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-05 10:50:19\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"普通学生\",\"roleSort\":4,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:37:07', 19);
INSERT INTO `sys_oper_log` VALUES (184, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '2024级', '/system/role/dataScope', '172.16.193.221', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-05 10:51:59\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"普通老师\",\"roleSort\":5,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:37:12', 13);
INSERT INTO `sys_oper_log` VALUES (185, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '2024级', '/system/dept/103', '172.16.193.221', '内网IP', '103', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-11-06 19:38:28', 5);
INSERT INTO `sys_oper_log` VALUES (186, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '2024级', '/system/user', '172.16.193.221', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-03 11:30:07\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"2025级\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":100,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-11-03 11:30:07\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"管理\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[1],\"pwdUpdateDate\":\"2025-11-03 11:30:07\",\"remark\":\"测试员\",\"roleIds\":[2,100,101],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"},{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"普通学生\",\"roleSort\":4,\"status\":\"0\"},{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":101,\"roleKey\":\"studentAdministrator\",\"roleName\":\"学生管理员\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:38:46', 22);
INSERT INTO `sys_oper_log` VALUES (187, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"计算机科学与技术\",\"email\":\"ry@qq.com\",\"leader\":\"姚慧婷\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:39:01', 21);
INSERT INTO `sys_oper_log` VALUES (188, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"物联网工程\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:39:18', 25);
INSERT INTO `sys_oper_log` VALUES (189, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"通信工程\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:39:24', 18);
INSERT INTO `sys_oper_log` VALUES (190, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"电子信息工程\",\"orderNum\":4,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:39:43', 15);
INSERT INTO `sys_oper_log` VALUES (191, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"人工智能\",\"orderNum\":5,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:39:51', 13);
INSERT INTO `sys_oper_log` VALUES (192, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"轨道交通信号与控制\",\"orderNum\":6,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:40:00', 11);
INSERT INTO `sys_oper_log` VALUES (193, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"网络安全\",\"orderNum\":7,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:40:07', 15);
INSERT INTO `sys_oper_log` VALUES (194, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"软件工程\",\"orderNum\":8,\"params\":{},\"parentId\":101,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:40:13', 11);
INSERT INTO `sys_oper_log` VALUES (195, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '2024级', '/system/dept', '172.16.193.221', '内网IP', '{\"ancestors\":\"0,100,101,103\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"2024级\",\"orderNum\":1,\"params\":{},\"parentId\":103,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:40:38', 17);
INSERT INTO `sys_oper_log` VALUES (196, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '2024级', '/system/role', '172.16.193.221', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-05 10:50:19\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2003,2004,2005,2006,2007,2008],\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"普通学生\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:45:02', 18);
INSERT INTO `sys_oper_log` VALUES (197, '论文成果', 2, 'com.ruoyi.paper.controller.AchievementsPaperController.edit()', 'PUT', 1, 'admin', '2024级', '/paper/paper', '172.16.193.221', '内网IP', '{\"auditStatus\":\"待审核\",\"authorInformation\":\"1\",\"createdAt\":\"2025-11-06\",\"doi\":\"10.1234/j.cnki.1000-1234.2024.03.002\",\"issue\":\"3\",\"journal\":\"计算机科学与技术学报\",\"pageRange\":\"12-25\",\"paperCategory\":\"B1\",\"paperId\":3,\"paperTitle\":\"人工智能在教育领域的应用研究与实践探索\",\"params\":{},\"publishDate\":\"2024-06-15\",\"researchDirection\":\"人工智能与教育技术\",\"updatedAt\":\"2025-11-06\",\"userId\":\"24306010534\",\"volume\":\"45\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 19:45:24', 16);
INSERT INTO `sys_oper_log` VALUES (198, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '计算机科学与技术', '/tool/gen/importTable', '172.16.193.221', '内网IP', '{\"tables\":\"achievements_attachment\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 23:33:25', 56);
INSERT INTO `sys_oper_log` VALUES (199, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-19\",\"doi\":\"测试\",\"issue\":\"测试\",\"journal\":\"测试\",\"pageRange\":\"测试\",\"paperCategory\":\"A2\",\"paperTitle\":\"测试1\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"测试\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Administrator\\Downloads\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-admin\\target\\classes\\mapper\\paper\\AchievementsPaperMapper.xml]\r\n### The error may involve com.ruoyi.paper.mapper.AchievementsPaperMapper.insertAchievementsPaper-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into achievements_paper          ( user_id,             paper_title,             paper_category,             research_direction,             author_information,             journal,             publish_date,             volume,             issue,             page_range,             doi,                          created_at,             updated_at )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value\n; Field \'user_identity\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value', '2025-11-07 10:55:35', 87);
INSERT INTO `sys_oper_log` VALUES (200, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-19\",\"doi\":\"测试\",\"issue\":\"123\",\"journal\":\"测试\",\"pageRange\":\"1231\",\"paperCategory\":\"A2\",\"paperTitle\":\"测试1\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"123\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Administrator\\Downloads\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-admin\\target\\classes\\mapper\\paper\\AchievementsPaperMapper.xml]\r\n### The error may involve com.ruoyi.paper.mapper.AchievementsPaperMapper.insertAchievementsPaper-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into achievements_paper          ( user_id,             paper_title,             paper_category,             research_direction,             author_information,             journal,             publish_date,             volume,             issue,             page_range,             doi,                          created_at,             updated_at )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value\n; Field \'user_identity\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value', '2025-11-07 10:55:50', 13);
INSERT INTO `sys_oper_log` VALUES (201, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-19\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"测试\",\"pageRange\":\"1231\",\"paperCategory\":\"A2\",\"paperTitle\":\"测试1\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"123\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Administrator\\Downloads\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-admin\\target\\classes\\mapper\\paper\\AchievementsPaperMapper.xml]\r\n### The error may involve com.ruoyi.paper.mapper.AchievementsPaperMapper.insertAchievementsPaper-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into achievements_paper          ( user_id,             paper_title,             paper_category,             research_direction,             author_information,             journal,             publish_date,             volume,             issue,             page_range,             doi,                          created_at,             updated_at )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value\n; Field \'user_identity\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_identity\' doesn\'t have a default value', '2025-11-07 10:56:06', 12);
INSERT INTO `sys_oper_log` VALUES (202, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-19\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"测试\",\"pageRange\":\"1231\",\"paperCategory\":\"A2\",\"paperId\":4,\"paperTitle\":\"测试1\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 10:59:35', 23);
INSERT INTO `sys_oper_log` VALUES (203, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-04\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"13\",\"pageRange\":\"123\",\"paperCategory\":\"A1\",\"paperId\":5,\"paperTitle\":\"测试\",\"params\":{},\"publishDate\":\"2025-11-11\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-06\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 11:01:35', 27);
INSERT INTO `sys_oper_log` VALUES (204, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"rows\",\"createdAt\":\"2025-11-05\",\"doi\":\"123\",\"issue\":\"1231\",\"journal\":\"rows\",\"pageRange\":\"1231\",\"paperCategory\":\"A1\",\"paperId\":6,\"paperTitle\":\"rows\",\"params\":{},\"publishDate\":\"2025-11-11\",\"researchDirection\":\"rows\",\"updatedAt\":\"2025-11-08\",\"userId\":\"admin\",\"volume\":\"2131\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":6}', 0, NULL, '2025-11-07 11:09:04', 72);
INSERT INTO `sys_oper_log` VALUES (205, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-25\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A2\",\"paperId\":7,\"paperTitle\":\"response\",\"params\":{},\"publishDate\":\"2025-11-14\",\"researchDirection\":\"213\",\"updatedAt\":\"2025-11-19\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":7}', 0, NULL, '2025-11-07 11:10:20', 22);
INSERT INTO `sys_oper_log` VALUES (206, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-07\",\"doi\":\"1231\",\"issue\":\"1123\",\"journal\":\"123\",\"pageRange\":\"213\",\"paperCategory\":\"A2\",\"paperId\":8,\"paperTitle\":\"231\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-11-08\",\"userId\":\"admin\",\"volume\":\"1123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":8}', 0, NULL, '2025-11-07 11:11:04', 16);
INSERT INTO `sys_oper_log` VALUES (207, '论文成果', 2, 'com.ruoyi.paper.controller.AchievementsPaperController.edit()', 'PUT', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"auditStatus\":\"待审核\",\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-19\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"测试\",\"pageRange\":\"1231\",\"paperCategory\":\"A2\",\"paperId\":4,\"paperTitle\":\"测试122\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 11:13:32', 20);
INSERT INTO `sys_oper_log` VALUES (208, '论文成果', 2, 'com.ruoyi.paper.controller.AchievementsPaperController.edit()', 'PUT', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"auditStatus\":\"待审核\",\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-19\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"测试\",\"pageRange\":\"1231\",\"paperCategory\":\"A2\",\"paperId\":4,\"paperTitle\":\"测试12222\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 11:13:51', 20);
INSERT INTO `sys_oper_log` VALUES (209, '论文成果', 2, 'com.ruoyi.paper.controller.AchievementsPaperController.edit()', 'PUT', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"auditStatus\":\"待审核\",\"authorInformation\":\"测试\",\"createdAt\":\"2025-11-19\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"测试\",\"pageRange\":\"1231\",\"paperCategory\":\"A2\",\"paperId\":4,\"paperTitle\":\"测试1\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"测试\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 11:16:55', 55);
INSERT INTO `sys_oper_log` VALUES (210, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"1231\",\"createdAt\":\"2025-11-14\",\"doi\":\"1231\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A1\",\"paperId\":9,\"paperTitle\":\"1231\",\"params\":{},\"publishDate\":\"2025-11-13\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-11-14\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":9}', 0, NULL, '2025-11-07 11:17:33', 15);
INSERT INTO `sys_oper_log` VALUES (211, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-12\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A1\",\"paperId\":10,\"paperTitle\":\"1231\",\"params\":{},\"publishDate\":\"2025-11-12\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-10-30\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":10}', 0, NULL, '2025-11-07 11:21:54', 24);
INSERT INTO `sys_oper_log` VALUES (212, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-20\",\"doi\":\"213\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A1\",\"paperId\":11,\"paperTitle\":\"123\",\"params\":{},\"publishDate\":\"2025-11-13\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-11-12\",\"userId\":\"admin\",\"volume\":\"2131\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":11}', 0, NULL, '2025-11-07 11:22:42', 25);
INSERT INTO `sys_oper_log` VALUES (213, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-06\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"231\",\"pageRange\":\"123\",\"paperCategory\":\"A2\",\"paperId\":12,\"paperTitle\":\"213\",\"params\":{},\"publishDate\":\"2025-11-13\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-10-30\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":12}', 0, NULL, '2025-11-07 11:24:16', 20);
INSERT INTO `sys_oper_log` VALUES (214, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-19\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A1\",\"paperId\":13,\"paperTitle\":\"123\",\"params\":{},\"publishDate\":\"2025-11-05\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-11-20\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":13}', 0, NULL, '2025-11-07 11:30:44', 10);
INSERT INTO `sys_oper_log` VALUES (215, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-05\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A1\",\"paperId\":14,\"paperTitle\":\"123\",\"params\":{},\"publishDate\":\"2025-11-19\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-11-15\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":14}', 0, NULL, '2025-11-07 11:34:03', 22);
INSERT INTO `sys_oper_log` VALUES (216, '论文成果', 3, 'com.ruoyi.paper.controller.AchievementsPaperController.remove()', 'DELETE', 1, 'admin', '计算机科学与技术', '/paper/paper/4,5,6,7,8,9,10,11,12', '127.0.0.1', '内网IP', '[4,5,6,7,8,9,10,11,12]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 11:36:39', 38);
INSERT INTO `sys_oper_log` VALUES (217, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"213\",\"createdAt\":\"2025-11-21\",\"doi\":\"123\",\"issue\":\"213\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A1\",\"paperId\":15,\"paperTitle\":\"123\",\"params\":{},\"publishDate\":\"2025-11-20\",\"researchDirection\":\"123\",\"updatedAt\":\"2025-11-21\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":15}', 0, NULL, '2025-11-07 11:36:56', 9);
INSERT INTO `sys_oper_log` VALUES (218, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-18\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A2\",\"paperId\":16,\"paperTitle\":\"123\",\"params\":{},\"publishDate\":\"2025-11-19\",\"researchDirection\":\"213\",\"updatedAt\":\"2025-11-28\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":16}', 0, NULL, '2025-11-07 11:43:03', 23);
INSERT INTO `sys_oper_log` VALUES (219, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-18\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A2\",\"paperId\":17,\"paperTitle\":\"123\",\"params\":{},\"publishDate\":\"2025-11-19\",\"researchDirection\":\"213\",\"updatedAt\":\"2025-11-28\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":17}', 0, NULL, '2025-11-07 11:43:10', 20);
INSERT INTO `sys_oper_log` VALUES (220, '论文成果', 1, 'com.ruoyi.paper.controller.AchievementsPaperController.add()', 'POST', 1, 'admin', '计算机科学与技术', '/paper/paper', '127.0.0.1', '内网IP', '{\"authorInformation\":\"123\",\"createdAt\":\"2025-11-18\",\"doi\":\"123\",\"issue\":\"123\",\"journal\":\"123\",\"pageRange\":\"123\",\"paperCategory\":\"A2\",\"paperId\":18,\"paperTitle\":\"123\",\"params\":{},\"publishDate\":\"2025-11-19\",\"researchDirection\":\"213\",\"updatedAt\":\"2025-11-28\",\"userId\":\"admin\",\"volume\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200,\"paperId\":18}', 0, NULL, '2025-11-07 11:43:38', 29);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'headteacher', '班主任', 1, '0', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-05 17:05:19', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-11-03 11:30:07', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-11-03 11:30:07', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '普通学生', 'student', 4, '5', 1, 1, '0', '0', 'admin', '2025-11-05 10:50:19', 'admin', '2025-11-06 19:45:02', NULL);
INSERT INTO `sys_role` VALUES (101, '学生管理员', 'studentAdministrator', 3, '1', 1, 1, '0', '0', 'admin', '2025-11-05 10:51:24', 'admin', '2025-11-05 10:52:12', NULL);
INSERT INTO `sys_role` VALUES (102, '普通老师', 'teacher', 5, '5', 1, 1, '0', '0', 'admin', '2025-11-05 10:51:59', '', '2025-11-06 19:37:12', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2003);
INSERT INTO `sys_role_menu` VALUES (100, 2004);
INSERT INTO `sys_role_menu` VALUES (100, 2005);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (101, 4);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户身份(0:学生，1:老师)',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `initial` int NOT NULL DEFAULT 1 COMMENT '1：为True第一次登录需修改密码，0：为false第二次登录不修改密码',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `user_name_2`(`user_name` ASC) USING BTREE,
  INDEX `user_name`(`user_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3280 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '123', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$VmzbPOdcsnyIWxCBJHSoIeb.N/XochpzyQUAiE4USjI0NLPOWfPRK', '0', '0', '127.0.0.1', '2025-11-07 10:55:10', '2025-11-06 19:29:32', 'admin', '2025-11-03 11:30:07', '', '2025-11-06 19:29:32', '管理员', 1);
INSERT INTO `sys_user` VALUES (2, 100, 'ry', '管理', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-11-03 11:30:07', '2025-11-03 11:30:07', 'admin', '2025-11-03 11:30:07', 'admin', '2025-11-06 19:38:46', '测试员', 1);
INSERT INTO `sys_user` VALUES (100, NULL, '20210027', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (101, NULL, '20210042', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (102, NULL, '20210062', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (103, NULL, '20210101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (104, NULL, '20220116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (105, NULL, '20220133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (106, NULL, '20220134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (107, NULL, '20220135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (108, NULL, '20220136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (109, NULL, '20220137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (110, NULL, '20220184', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (111, NULL, '20220189', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (112, NULL, '20220197', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (113, NULL, '20220198', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (114, NULL, '20220201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (115, NULL, '2022197', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (116, NULL, '20230209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (117, NULL, '20230233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (118, NULL, '20230234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (119, NULL, '20230235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (120, NULL, '20230236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (121, NULL, '20230237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (122, NULL, '20230238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (123, NULL, '20230239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (124, NULL, '20230240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (125, NULL, '20230241', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (126, NULL, '20230257', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (127, NULL, '20230289', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (128, NULL, '20230296', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (129, NULL, '20230297', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (130, NULL, '20240317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (131, NULL, '20240323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (132, NULL, '20240324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (133, NULL, '20240325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (134, NULL, '20240327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (135, NULL, '20240328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (136, NULL, '20240329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (137, NULL, '20240330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (138, NULL, '20240331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (139, NULL, '20240332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (140, NULL, '20240333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (141, NULL, '20240334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (142, NULL, '20240337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (143, NULL, '20240345', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (144, NULL, '20240395', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (145, NULL, '20240398', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (146, NULL, 'L2022092', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (147, NULL, 'L2022099', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (148, NULL, 'L2022157', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (149, NULL, 'L2024236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (150, NULL, '21102020125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (151, NULL, '21106050118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (152, NULL, '21106050225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (153, NULL, '21106060201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (154, NULL, '21106060324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (155, NULL, '21106060520', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (156, NULL, '21106080336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (157, NULL, '21109030221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (158, NULL, '21109030225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (159, NULL, '21206010614', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (160, NULL, '22101010101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (161, NULL, '22101030217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (162, NULL, '22102020105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (163, NULL, '22102020108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (164, NULL, '22105040108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (165, NULL, '22105040516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (166, NULL, '22106010101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (167, NULL, '22106010102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (168, NULL, '22106010103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (169, NULL, '22106010104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (170, NULL, '22106010105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (171, NULL, '22106010106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (172, NULL, '22106010108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (173, NULL, '22106010109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (174, NULL, '22106010110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (175, NULL, '22106010111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (176, NULL, '22106010113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (177, NULL, '22106010114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (178, NULL, '22106010115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (179, NULL, '22106010116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (180, NULL, '22106010117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (181, NULL, '22106010118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (182, NULL, '22106010119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (183, NULL, '22106010120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (184, NULL, '22106010121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (185, NULL, '22106010122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (186, NULL, '22106010123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (187, NULL, '22106010124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (188, NULL, '22106010125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (189, NULL, '22106010126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (190, NULL, '22106010127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (191, NULL, '22106010128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (192, NULL, '22106010129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (193, NULL, '22106010130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (194, NULL, '22106010131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (195, NULL, '22106010132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (196, NULL, '22106010133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (197, NULL, '22106010134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (198, NULL, '22106010135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (199, NULL, '22106010137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (200, NULL, '22106010201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (201, NULL, '22106010202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (202, NULL, '22106010203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (203, NULL, '22106010204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (204, NULL, '22106010205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (205, NULL, '22106010206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (206, NULL, '22106010207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (207, NULL, '22106010208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (208, NULL, '22106010209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (209, NULL, '22106010210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (210, NULL, '22106010211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (211, NULL, '22106010212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (212, NULL, '22106010213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (213, NULL, '22106010214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (214, NULL, '22106010215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (215, NULL, '22106010217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (216, NULL, '22106010218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (217, NULL, '22106010219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (218, NULL, '22106010220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (219, NULL, '22106010221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (220, NULL, '22106010222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (221, NULL, '22106010223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (222, NULL, '22106010224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (223, NULL, '22106010225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (224, NULL, '22106010226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (225, NULL, '22106010227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (226, NULL, '22106010228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (227, NULL, '22106010229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (228, NULL, '22106010230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (229, NULL, '22106010231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (230, NULL, '22106010232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (231, NULL, '22106010233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (232, NULL, '22106010234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (233, NULL, '22106010235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (234, NULL, '22106010236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (235, NULL, '22106010237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (236, NULL, '22106010301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (237, NULL, '22106010302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (238, NULL, '22106010303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (239, NULL, '22106010304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (240, NULL, '22106010305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (241, NULL, '22106010306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (242, NULL, '22106010307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (243, NULL, '22106010308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (244, NULL, '22106010309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (245, NULL, '22106010310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (246, NULL, '22106010311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (247, NULL, '22106010312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (248, NULL, '22106010313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (249, NULL, '22106010314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (250, NULL, '22106010315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (251, NULL, '22106010316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (252, NULL, '22106010317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (253, NULL, '22106010318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (254, NULL, '22106010319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (255, NULL, '22106010320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (256, NULL, '22106010321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (257, NULL, '22106010322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (258, NULL, '22106010323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (259, NULL, '22106010324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (260, NULL, '22106010325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (261, NULL, '22106010326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (262, NULL, '22106010327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (263, NULL, '22106010328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (264, NULL, '22106010329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (265, NULL, '22106010330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (266, NULL, '22106010331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (267, NULL, '22106010332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (268, NULL, '22106010334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (269, NULL, '22106010335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (270, NULL, '22106010336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (271, NULL, '22106040101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (272, NULL, '22106040102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (273, NULL, '22106040103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (274, NULL, '22106040104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (275, NULL, '22106040105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (276, NULL, '22106040106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (277, NULL, '22106040107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (278, NULL, '22106040108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (279, NULL, '22106040109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (280, NULL, '22106040110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (281, NULL, '22106040111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (282, NULL, '22106040112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (283, NULL, '22106040113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (284, NULL, '22106040114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (285, NULL, '22106040115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (286, NULL, '22106040116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (287, NULL, '22106040117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (288, NULL, '22106040118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (289, NULL, '22106040119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (290, NULL, '22106040120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (291, NULL, '22106040121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (292, NULL, '22106040122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (293, NULL, '22106040123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (294, NULL, '22106040124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (295, NULL, '22106040125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (296, NULL, '22106040126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (297, NULL, '22106040127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (298, NULL, '22106040128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (299, NULL, '22106040129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (300, NULL, '22106040130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (301, NULL, '22106040131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (302, NULL, '22106040132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (303, NULL, '22106040133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (304, NULL, '22106040134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (305, NULL, '22106040135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (306, NULL, '22106040201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (307, NULL, '22106040202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (308, NULL, '22106040203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (309, NULL, '22106040204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (310, NULL, '22106040205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (311, NULL, '22106040206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (312, NULL, '22106040207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (313, NULL, '22106040208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (314, NULL, '22106040209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (315, NULL, '22106040210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (316, NULL, '22106040212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (317, NULL, '22106040213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (318, NULL, '22106040214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (319, NULL, '22106040215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (320, NULL, '22106040217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (321, NULL, '22106040218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (322, NULL, '22106040219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (323, NULL, '22106040220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (324, NULL, '22106040221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (325, NULL, '22106040222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (326, NULL, '22106040223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (327, NULL, '22106040224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (328, NULL, '22106040225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (329, NULL, '22106040226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (330, NULL, '22106040227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (331, NULL, '22106040228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (332, NULL, '22106040229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (333, NULL, '22106040230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (334, NULL, '22106040231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (335, NULL, '22106040232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (336, NULL, '22106040233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (337, NULL, '22106040234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (338, NULL, '22106040235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (339, NULL, '22106050101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (340, NULL, '22106050102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (341, NULL, '22106050103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (342, NULL, '22106050104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (343, NULL, '22106050105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (344, NULL, '22106050106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (345, NULL, '22106050107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (346, NULL, '22106050108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (347, NULL, '22106050109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (348, NULL, '22106050110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (349, NULL, '22106050111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (350, NULL, '22106050112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (351, NULL, '22106050113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (352, NULL, '22106050114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (353, NULL, '22106050115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (354, NULL, '22106050116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (355, NULL, '22106050117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (356, NULL, '22106050118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (357, NULL, '22106050119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (358, NULL, '22106050120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (359, NULL, '22106050121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (360, NULL, '22106050122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (361, NULL, '22106050123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (362, NULL, '22106050124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (363, NULL, '22106050125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (364, NULL, '22106050126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (365, NULL, '22106050127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (366, NULL, '22106050128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (367, NULL, '22106050129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (368, NULL, '22106050130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (369, NULL, '22106050131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (370, NULL, '22106050132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (371, NULL, '22106050133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (372, NULL, '22106050134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (373, NULL, '22106050201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (374, NULL, '22106050202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (375, NULL, '22106050203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (376, NULL, '22106050204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (377, NULL, '22106050205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (378, NULL, '22106050206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (379, NULL, '22106050207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (380, NULL, '22106050208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (381, NULL, '22106050209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (382, NULL, '22106050210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (383, NULL, '22106050211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (384, NULL, '22106050212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (385, NULL, '22106050213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (386, NULL, '22106050214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (387, NULL, '22106050215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (388, NULL, '22106050216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (389, NULL, '22106050217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (390, NULL, '22106050218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (391, NULL, '22106050219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (392, NULL, '22106050220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (393, NULL, '22106050221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (394, NULL, '22106050222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (395, NULL, '22106050223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (396, NULL, '22106050224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (397, NULL, '22106050225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (398, NULL, '22106050226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (399, NULL, '22106050227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (400, NULL, '22106050228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (401, NULL, '22106050229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (402, NULL, '22106050230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (403, NULL, '22106050231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (404, NULL, '22106050232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (405, NULL, '22106050233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (406, NULL, '22106050234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (407, NULL, '22106050235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (408, NULL, '22106050301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (409, NULL, '22106050302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (410, NULL, '22106050303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (411, NULL, '22106050304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (412, NULL, '22106050305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (413, NULL, '22106050306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (414, NULL, '22106050307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (415, NULL, '22106050308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (416, NULL, '22106050309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (417, NULL, '22106050310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (418, NULL, '22106050311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (419, NULL, '22106050312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (420, NULL, '22106050313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (421, NULL, '22106050314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (422, NULL, '22106050315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (423, NULL, '22106050316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (424, NULL, '22106050317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (425, NULL, '22106050318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (426, NULL, '22106050319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (427, NULL, '22106050320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (428, NULL, '22106050321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (429, NULL, '22106050322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (430, NULL, '22106050323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (431, NULL, '22106050324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (432, NULL, '22106050325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (433, NULL, '22106050326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (434, NULL, '22106050327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (435, NULL, '22106050328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (436, NULL, '22106050329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (437, NULL, '22106050330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (438, NULL, '22106050331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (439, NULL, '22106050332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (440, NULL, '22106050333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (441, NULL, '22106050334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (442, NULL, '22106050335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (443, NULL, '22106050401', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (444, NULL, '22106050403', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (445, NULL, '22106050404', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (446, NULL, '22106050405', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (447, NULL, '22106050406', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (448, NULL, '22106050407', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (449, NULL, '22106050408', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (450, NULL, '22106050409', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (451, NULL, '22106050410', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (452, NULL, '22106050411', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (453, NULL, '22106050412', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (454, NULL, '22106050413', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (455, NULL, '22106050414', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (456, NULL, '22106050415', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (457, NULL, '22106050416', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (458, NULL, '22106050417', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (459, NULL, '22106050418', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (460, NULL, '22106050419', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (461, NULL, '22106050420', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (462, NULL, '22106050421', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (463, NULL, '22106050422', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (464, NULL, '22106050423', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (465, NULL, '22106050424', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (466, NULL, '22106050425', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (467, NULL, '22106050426', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (468, NULL, '22106050427', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (469, NULL, '22106050428', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (470, NULL, '22106050429', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (471, NULL, '22106050430', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (472, NULL, '22106050431', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (473, NULL, '22106050432', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (474, NULL, '22106050433', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (475, NULL, '22106050434', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (476, NULL, '22106050435', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (477, NULL, '22106050501', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (478, NULL, '22106050503', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (479, NULL, '22106050504', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (480, NULL, '22106050505', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (481, NULL, '22106050506', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (482, NULL, '22106050508', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (483, NULL, '22106050509', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (484, NULL, '22106050510', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (485, NULL, '22106050511', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (486, NULL, '22106050512', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (487, NULL, '22106050513', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (488, NULL, '22106050514', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (489, NULL, '22106050516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (490, NULL, '22106050517', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (491, NULL, '22106050518', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (492, NULL, '22106050519', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (493, NULL, '22106050520', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (494, NULL, '22106050521', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (495, NULL, '22106050522', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (496, NULL, '22106050523', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (497, NULL, '22106050524', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (498, NULL, '22106050526', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (499, NULL, '22106050529', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (500, NULL, '22106050530', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (501, NULL, '22106050531', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (502, NULL, '22106050532', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (503, NULL, '22106050533', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (504, NULL, '22106050534', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (505, NULL, '22106050535', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (506, NULL, '22106060101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (507, NULL, '22106060102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (508, NULL, '22106060103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (509, NULL, '22106060104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (510, NULL, '22106060105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (511, NULL, '22106060106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (512, NULL, '22106060107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (513, NULL, '22106060108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (514, NULL, '22106060109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (515, NULL, '22106060110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (516, NULL, '22106060111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (517, NULL, '22106060112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (518, NULL, '22106060113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (519, NULL, '22106060114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (520, NULL, '22106060116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (521, NULL, '22106060117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (522, NULL, '22106060118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (523, NULL, '22106060119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (524, NULL, '22106060120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (525, NULL, '22106060121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (526, NULL, '22106060122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (527, NULL, '22106060123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (528, NULL, '22106060124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (529, NULL, '22106060125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (530, NULL, '22106060126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (531, NULL, '22106060127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (532, NULL, '22106060128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (533, NULL, '22106060129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (534, NULL, '22106060130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (535, NULL, '22106060131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (536, NULL, '22106060132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (537, NULL, '22106060133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (538, NULL, '22106060134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (539, NULL, '22106060135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (540, NULL, '22106060201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (541, NULL, '22106060202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (542, NULL, '22106060203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (543, NULL, '22106060204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (544, NULL, '22106060205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (545, NULL, '22106060206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (546, NULL, '22106060207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (547, NULL, '22106060208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (548, NULL, '22106060209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (549, NULL, '22106060210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (550, NULL, '22106060211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (551, NULL, '22106060212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (552, NULL, '22106060213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (553, NULL, '22106060214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (554, NULL, '22106060215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (555, NULL, '22106060216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (556, NULL, '22106060217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (557, NULL, '22106060218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (558, NULL, '22106060219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (559, NULL, '22106060220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (560, NULL, '22106060221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (561, NULL, '22106060222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (562, NULL, '22106060223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (563, NULL, '22106060224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (564, NULL, '22106060225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (565, NULL, '22106060226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (566, NULL, '22106060227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (567, NULL, '22106060228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (568, NULL, '22106060229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (569, NULL, '22106060230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (570, NULL, '22106060232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (571, NULL, '22106060233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (572, NULL, '22106060234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (573, NULL, '22106060235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (574, NULL, '22106060302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (575, NULL, '22106060303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (576, NULL, '22106060304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (577, NULL, '22106060305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (578, NULL, '22106060306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (579, NULL, '22106060307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (580, NULL, '22106060308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (581, NULL, '22106060309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (582, NULL, '22106060310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (583, NULL, '22106060311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (584, NULL, '22106060312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (585, NULL, '22106060313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (586, NULL, '22106060314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (587, NULL, '22106060315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (588, NULL, '22106060316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (589, NULL, '22106060317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (590, NULL, '22106060318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (591, NULL, '22106060319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (592, NULL, '22106060320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (593, NULL, '22106060321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (594, NULL, '22106060322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (595, NULL, '22106060324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (596, NULL, '22106060325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (597, NULL, '22106060326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (598, NULL, '22106060327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (599, NULL, '22106060328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (600, NULL, '22106060329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (601, NULL, '22106060330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (602, NULL, '22106060331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (603, NULL, '22106060332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (604, NULL, '22106060333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (605, NULL, '22106060334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (606, NULL, '22106060335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (607, NULL, '22106060401', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (608, NULL, '22106060402', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (609, NULL, '22106060403', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (610, NULL, '22106060404', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (611, NULL, '22106060405', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (612, NULL, '22106060406', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (613, NULL, '22106060407', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (614, NULL, '22106060408', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (615, NULL, '22106060409', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (616, NULL, '22106060410', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (617, NULL, '22106060411', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (618, NULL, '22106060412', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (619, NULL, '22106060413', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (620, NULL, '22106060414', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (621, NULL, '22106060415', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (622, NULL, '22106060416', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (623, NULL, '22106060417', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (624, NULL, '22106060418', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (625, NULL, '22106060419', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (626, NULL, '22106060420', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (627, NULL, '22106060421', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (628, NULL, '22106060422', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (629, NULL, '22106060423', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (630, NULL, '22106060424', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (631, NULL, '22106060425', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (632, NULL, '22106060426', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (633, NULL, '22106060427', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (634, NULL, '22106060428', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (635, NULL, '22106060429', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (636, NULL, '22106060430', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (637, NULL, '22106060432', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (638, NULL, '22106060433', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (639, NULL, '22106060434', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (640, NULL, '22106060435', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (641, NULL, '22106060501', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (642, NULL, '22106060502', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (643, NULL, '22106060503', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (644, NULL, '22106060504', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (645, NULL, '22106060505', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (646, NULL, '22106060506', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (647, NULL, '22106060507', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (648, NULL, '22106060508', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (649, NULL, '22106060509', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (650, NULL, '22106060510', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (651, NULL, '22106060511', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (652, NULL, '22106060512', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (653, NULL, '22106060513', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (654, NULL, '22106060514', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (655, NULL, '22106060515', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (656, NULL, '22106060516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (657, NULL, '22106060517', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (658, NULL, '22106060518', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (659, NULL, '22106060519', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (660, NULL, '22106060520', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (661, NULL, '22106060521', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (662, NULL, '22106060522', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (663, NULL, '22106060523', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (664, NULL, '22106060524', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (665, NULL, '22106060525', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (666, NULL, '22106060526', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (667, NULL, '22106060527', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (668, NULL, '22106060528', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (669, NULL, '22106060530', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (670, NULL, '22106060531', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (671, NULL, '22106060532', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (672, NULL, '22106060533', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (673, NULL, '22106060534', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (674, NULL, '22106060535', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (675, NULL, '22106070101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (676, NULL, '22106070102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (677, NULL, '22106070103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (678, NULL, '22106070104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (679, NULL, '22106070105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (680, NULL, '22106070106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (681, NULL, '22106070107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (682, NULL, '22106070108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (683, NULL, '22106070109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (684, NULL, '22106070110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (685, NULL, '22106070111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (686, NULL, '22106070112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (687, NULL, '22106070113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (688, NULL, '22106070116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (689, NULL, '22106070118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (690, NULL, '22106070119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (691, NULL, '22106070120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (692, NULL, '22106070121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (693, NULL, '22106070122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (694, NULL, '22106070123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (695, NULL, '22106070124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (696, NULL, '22106070125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (697, NULL, '22106070126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (698, NULL, '22106070127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (699, NULL, '22106070128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (700, NULL, '22106070129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (701, NULL, '22106070130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (702, NULL, '22106070131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (703, NULL, '22106070132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (704, NULL, '22106070133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (705, NULL, '22106070134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (706, NULL, '22106070135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (707, NULL, '22106070136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (708, NULL, '22106070137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (709, NULL, '22106070138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (710, NULL, '22106070201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (711, NULL, '22106070202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (712, NULL, '22106070203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (713, NULL, '22106070204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (714, NULL, '22106070205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (715, NULL, '22106070206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (716, NULL, '22106070207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (717, NULL, '22106070208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (718, NULL, '22106070209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (719, NULL, '22106070210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (720, NULL, '22106070211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (721, NULL, '22106070212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (722, NULL, '22106070213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (723, NULL, '22106070214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (724, NULL, '22106070215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (725, NULL, '22106070216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (726, NULL, '22106070217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (727, NULL, '22106070218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (728, NULL, '22106070219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (729, NULL, '22106070220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (730, NULL, '22106070221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (731, NULL, '22106070222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (732, NULL, '22106070223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (733, NULL, '22106070224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (734, NULL, '22106070225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (735, NULL, '22106070226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (736, NULL, '22106070227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (737, NULL, '22106070228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (738, NULL, '22106070229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (739, NULL, '22106070230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (740, NULL, '22106070231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (741, NULL, '22106070232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (742, NULL, '22106070233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (743, NULL, '22106070234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (744, NULL, '22106070235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (745, NULL, '22106070236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (746, NULL, '22106070237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (747, NULL, '22106070238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (748, NULL, '22106070301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (749, NULL, '22106070302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (750, NULL, '22106070303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (751, NULL, '22106070304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (752, NULL, '22106070305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (753, NULL, '22106070307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (754, NULL, '22106070308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (755, NULL, '22106070309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (756, NULL, '22106070310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (757, NULL, '22106070311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (758, NULL, '22106070312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (759, NULL, '22106070313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (760, NULL, '22106070314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (761, NULL, '22106070315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (762, NULL, '22106070316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (763, NULL, '22106070317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (764, NULL, '22106070318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (765, NULL, '22106070319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (766, NULL, '22106070320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (767, NULL, '22106070321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (768, NULL, '22106070322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (769, NULL, '22106070323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (770, NULL, '22106070324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (771, NULL, '22106070325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (772, NULL, '22106070326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (773, NULL, '22106070328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (774, NULL, '22106070329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (775, NULL, '22106070330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (776, NULL, '22106070331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (777, NULL, '22106070332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (778, NULL, '22106070333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (779, NULL, '22106070334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (780, NULL, '22106070335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (781, NULL, '22106070336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (782, NULL, '22106070337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (783, NULL, '22106070401', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (784, NULL, '22106070402', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (785, NULL, '22106070403', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (786, NULL, '22106070404', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (787, NULL, '22106070405', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (788, NULL, '22106070406', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (789, NULL, '22106070407', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (790, NULL, '22106070409', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (791, NULL, '22106070410', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (792, NULL, '22106070411', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (793, NULL, '22106070412', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (794, NULL, '22106070413', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (795, NULL, '22106070414', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (796, NULL, '22106070415', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (797, NULL, '22106070416', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (798, NULL, '22106070417', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (799, NULL, '22106070419', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (800, NULL, '22106070420', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (801, NULL, '22106070421', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (802, NULL, '22106070422', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (803, NULL, '22106070423', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (804, NULL, '22106070424', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (805, NULL, '22106070425', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (806, NULL, '22106070426', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (807, NULL, '22106070427', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (808, NULL, '22106070428', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (809, NULL, '22106070429', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (810, NULL, '22106070430', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (811, NULL, '22106070431', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (812, NULL, '22106070432', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (813, NULL, '22106070433', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (814, NULL, '22106070434', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (815, NULL, '22106070435', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (816, NULL, '22106070436', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (817, NULL, '22106070437', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (818, NULL, '22106070503', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (819, NULL, '22106070504', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (820, NULL, '22106070505', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (821, NULL, '22106070506', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (822, NULL, '22106070507', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (823, NULL, '22106070508', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (824, NULL, '22106070509', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (825, NULL, '22106070510', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (826, NULL, '22106070511', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (827, NULL, '22106070512', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (828, NULL, '22106070513', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (829, NULL, '22106070514', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (830, NULL, '22106070515', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (831, NULL, '22106070516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (832, NULL, '22106070517', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (833, NULL, '22106070518', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (834, NULL, '22106070519', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (835, NULL, '22106070521', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (836, NULL, '22106070522', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (837, NULL, '22106070523', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (838, NULL, '22106070524', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (839, NULL, '22106070525', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (840, NULL, '22106070526', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (841, NULL, '22106070527', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (842, NULL, '22106070528', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (843, NULL, '22106070529', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (844, NULL, '22106070530', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (845, NULL, '22106070531', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (846, NULL, '22106070532', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (847, NULL, '22106070533', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (848, NULL, '22106070534', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (849, NULL, '22106070535', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (850, NULL, '22106070536', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (851, NULL, '22106070537', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (852, NULL, '22106070601', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (853, NULL, '22106070602', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (854, NULL, '22106070603', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (855, NULL, '22106070604', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (856, NULL, '22106070605', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (857, NULL, '22106070606', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (858, NULL, '22106070607', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (859, NULL, '22106070608', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (860, NULL, '22106070609', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (861, NULL, '22106070610', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (862, NULL, '22106070611', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (863, NULL, '22106070612', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (864, NULL, '22106070613', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (865, NULL, '22106070614', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (866, NULL, '22106070615', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (867, NULL, '22106070616', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (868, NULL, '22106070618', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (869, NULL, '22106070619', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (870, NULL, '22106070620', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (871, NULL, '22106070621', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (872, NULL, '22106070622', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (873, NULL, '22106070623', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (874, NULL, '22106070624', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (875, NULL, '22106070625', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (876, NULL, '22106070626', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (877, NULL, '22106070627', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (878, NULL, '22106070628', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (879, NULL, '22106070629', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (880, NULL, '22106070630', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (881, NULL, '22106070631', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (882, NULL, '22106070632', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (883, NULL, '22106070633', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (884, NULL, '22106070634', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (885, NULL, '22106070635', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (886, NULL, '22106070636', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (887, NULL, '22106070637', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (888, NULL, '22106070701', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (889, NULL, '22106070702', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (890, NULL, '22106070703', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (891, NULL, '22106070704', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (892, NULL, '22106070705', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (893, NULL, '22106070706', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (894, NULL, '22106070707', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (895, NULL, '22106070708', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (896, NULL, '22106070709', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (897, NULL, '22106070710', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (898, NULL, '22106070711', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (899, NULL, '22106070712', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (900, NULL, '22106070713', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (901, NULL, '22106070715', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (902, NULL, '22106070716', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (903, NULL, '22106070717', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (904, NULL, '22106070718', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (905, NULL, '22106070719', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (906, NULL, '22106070720', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (907, NULL, '22106070721', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (908, NULL, '22106070722', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (909, NULL, '22106070723', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (910, NULL, '22106070724', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (911, NULL, '22106070725', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (912, NULL, '22106070726', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (913, NULL, '22106070727', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (914, NULL, '22106070728', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (915, NULL, '22106070729', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (916, NULL, '22106070730', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (917, NULL, '22106070731', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (918, NULL, '22106070732', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (919, NULL, '22106070733', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (920, NULL, '22106070734', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (921, NULL, '22106070735', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (922, NULL, '22106070736', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (923, NULL, '22106070737', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (924, NULL, '22106080101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (925, NULL, '22106080102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (926, NULL, '22106080103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (927, NULL, '22106080104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (928, NULL, '22106080105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (929, NULL, '22106080106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (930, NULL, '22106080107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (931, NULL, '22106080108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (932, NULL, '22106080109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (933, NULL, '22106080110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (934, NULL, '22106080111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (935, NULL, '22106080112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (936, NULL, '22106080113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (937, NULL, '22106080114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (938, NULL, '22106080115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (939, NULL, '22106080117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (940, NULL, '22106080118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (941, NULL, '22106080119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (942, NULL, '22106080120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (943, NULL, '22106080121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (944, NULL, '22106080122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (945, NULL, '22106080123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (946, NULL, '22106080124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (947, NULL, '22106080125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (948, NULL, '22106080126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (949, NULL, '22106080127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (950, NULL, '22106080128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (951, NULL, '22106080129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (952, NULL, '22106080130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (953, NULL, '22106080131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (954, NULL, '22106080132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (955, NULL, '22106080133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (956, NULL, '22106080134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (957, NULL, '22106080135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (958, NULL, '22106080201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (959, NULL, '22106080202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (960, NULL, '22106080203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (961, NULL, '22106080204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (962, NULL, '22106080205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (963, NULL, '22106080206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (964, NULL, '22106080207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (965, NULL, '22106080208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (966, NULL, '22106080209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (967, NULL, '22106080210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (968, NULL, '22106080211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (969, NULL, '22106080212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (970, NULL, '22106080213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (971, NULL, '22106080214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (972, NULL, '22106080215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (973, NULL, '22106080216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (974, NULL, '22106080217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (975, NULL, '22106080218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (976, NULL, '22106080219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (977, NULL, '22106080220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (978, NULL, '22106080221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (979, NULL, '22106080222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (980, NULL, '22106080223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (981, NULL, '22106080224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (982, NULL, '22106080225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (983, NULL, '22106080226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (984, NULL, '22106080227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (985, NULL, '22106080228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (986, NULL, '22106080229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (987, NULL, '22106080230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (988, NULL, '22106080231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (989, NULL, '22106080232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (990, NULL, '22106080233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (991, NULL, '22106080234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (992, NULL, '22106080235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (993, NULL, '22109010115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (994, NULL, '23106010101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (995, NULL, '23106010102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (996, NULL, '23106010103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (997, NULL, '23106010104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (998, NULL, '23106010105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (999, NULL, '23106010106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1000, NULL, '23106010107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1001, NULL, '23106010108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1002, NULL, '23106010109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1003, NULL, '23106010110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1004, NULL, '23106010111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1005, NULL, '23106010112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1006, NULL, '23106010113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1007, NULL, '23106010114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1008, NULL, '23106010115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1009, NULL, '23106010116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1010, NULL, '23106010117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1011, NULL, '23106010118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1012, NULL, '23106010119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1013, NULL, '23106010120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1014, NULL, '23106010121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1015, NULL, '23106010122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1016, NULL, '23106010123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1017, NULL, '23106010125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1018, NULL, '23106010126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1019, NULL, '23106010127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1020, NULL, '23106010128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1021, NULL, '23106010129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1022, NULL, '23106010131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1023, NULL, '23106010132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1024, NULL, '23106010133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1025, NULL, '23106010134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1026, NULL, '23106010135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1027, NULL, '23106040101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1028, NULL, '23106040102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1029, NULL, '23106040103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1030, NULL, '23106040104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1031, NULL, '23106040105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1032, NULL, '23106040106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1033, NULL, '23106040107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1034, NULL, '23106040108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1035, NULL, '23106040109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1036, NULL, '23106040110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1037, NULL, '23106040111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1038, NULL, '23106040112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1039, NULL, '23106040113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1040, NULL, '23106040114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1041, NULL, '23106040115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1042, NULL, '23106040116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1043, NULL, '23106040117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1044, NULL, '23106040118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1045, NULL, '23106040119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1046, NULL, '23106040121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1047, NULL, '23106040122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1048, NULL, '23106040123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1049, NULL, '23106040124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1050, NULL, '23106040125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1051, NULL, '23106040126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1052, NULL, '23106040127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1053, NULL, '23106040128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1054, NULL, '23106040129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1055, NULL, '23106040130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1056, NULL, '23106040131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1057, NULL, '23106040132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1058, NULL, '23106040133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1059, NULL, '23106040134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1060, NULL, '23106040135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1061, NULL, '23106050101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1062, NULL, '23106050102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1063, NULL, '23106050104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1064, NULL, '23106050105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1065, NULL, '23106050106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1066, NULL, '23106050107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1067, NULL, '23106050108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1068, NULL, '23106050109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1069, NULL, '23106050110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1070, NULL, '23106050111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1071, NULL, '23106050112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1072, NULL, '23106050114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1073, NULL, '23106050115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1074, NULL, '23106050116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1075, NULL, '23106050117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1076, NULL, '23106050119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1077, NULL, '23106050120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1078, NULL, '23106050121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1079, NULL, '23106050122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1080, NULL, '23106050123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1081, NULL, '23106050124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1082, NULL, '23106050125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1083, NULL, '23106050126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1084, NULL, '23106050127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1085, NULL, '23106050128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1086, NULL, '23106050129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1087, NULL, '23106050130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1088, NULL, '23106050131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1089, NULL, '23106050132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1090, NULL, '23106050133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1091, NULL, '23106050134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1092, NULL, '23106050135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1093, NULL, '23106060101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1094, NULL, '23106060103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1095, NULL, '23106060104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1096, NULL, '23106060105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1097, NULL, '23106060106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1098, NULL, '23106060107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1099, NULL, '23106060108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1100, NULL, '23106060109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1101, NULL, '23106060110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1102, NULL, '23106060111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1103, NULL, '23106060112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1104, NULL, '23106060113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1105, NULL, '23106060114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1106, NULL, '23106060115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1107, NULL, '23106060116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1108, NULL, '23106060117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1109, NULL, '23106060118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1110, NULL, '23106060119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1111, NULL, '23106060120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1112, NULL, '23106060121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1113, NULL, '23106060122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1114, NULL, '23106060123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1115, NULL, '23106060124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1116, NULL, '23106060125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1117, NULL, '23106060126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1118, NULL, '23106060127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1119, NULL, '23106060128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1120, NULL, '23106060129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1121, NULL, '23106060130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1122, NULL, '23106060131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1123, NULL, '23106060132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1124, NULL, '23106060133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1125, NULL, '23106060134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1126, NULL, '23106060135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1127, NULL, '23106070101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1128, NULL, '23106070102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1129, NULL, '23106070103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1130, NULL, '23106070104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1131, NULL, '23106070105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1132, NULL, '23106070106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1133, NULL, '23106070107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1134, NULL, '23106070108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1135, NULL, '23106070109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1136, NULL, '23106070111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1137, NULL, '23106070112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1138, NULL, '23106070113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1139, NULL, '23106070114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1140, NULL, '23106070115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1141, NULL, '23106070117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1142, NULL, '23106070118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1143, NULL, '23106070119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1144, NULL, '23106070120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1145, NULL, '23106070121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1146, NULL, '23106070122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1147, NULL, '23106070123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1148, NULL, '23106070124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1149, NULL, '23106070125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1150, NULL, '23106070126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1151, NULL, '23106070127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1152, NULL, '23106070128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1153, NULL, '23106070129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1154, NULL, '23106070130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1155, NULL, '23106070131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1156, NULL, '23106070132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1157, NULL, '23106070133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1158, NULL, '23106070134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1159, NULL, '23106070135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1160, NULL, '23106070136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1161, NULL, '23106070137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1162, NULL, '23106070138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1163, NULL, '23106070139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1164, NULL, '23106070140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1165, NULL, '23106070201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1166, NULL, '23106070202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1167, NULL, '23106070203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1168, NULL, '23106070204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1169, NULL, '23106070205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1170, NULL, '23106070206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1171, NULL, '23106070207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1172, NULL, '23106070208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1173, NULL, '23106070209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1174, NULL, '23106070210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1175, NULL, '23106070211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1176, NULL, '23106070212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1177, NULL, '23106070213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1178, NULL, '23106070214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1179, NULL, '23106070215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1180, NULL, '23106070216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1181, NULL, '23106070217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1182, NULL, '23106070218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1183, NULL, '23106070219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1184, NULL, '23106070220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1185, NULL, '23106070221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1186, NULL, '23106070222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1187, NULL, '23106070223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1188, NULL, '23106070224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1189, NULL, '23106070226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1190, NULL, '23106070227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1191, NULL, '23106070228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1192, NULL, '23106070229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1193, NULL, '23106070230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1194, NULL, '23106070231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1195, NULL, '23106070233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1196, NULL, '23106070234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1197, NULL, '23106070235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1198, NULL, '23106070236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1199, NULL, '23106070238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1200, NULL, '23106070239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1201, NULL, '23106070240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1202, NULL, '23106070301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1203, NULL, '23106070302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1204, NULL, '23106070303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1205, NULL, '23106070304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1206, NULL, '23106070305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1207, NULL, '23106070306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1208, NULL, '23106070307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1209, NULL, '23106070308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1210, NULL, '23106070309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1211, NULL, '23106070310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1212, NULL, '23106070311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1213, NULL, '23106070312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1214, NULL, '23106070313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1215, NULL, '23106070314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1216, NULL, '23106070315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1217, NULL, '23106070316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1218, NULL, '23106070317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1219, NULL, '23106070318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1220, NULL, '23106070319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1221, NULL, '23106070321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1222, NULL, '23106070323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1223, NULL, '23106070324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1224, NULL, '23106070325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1225, NULL, '23106070326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1226, NULL, '23106070327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1227, NULL, '23106070329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1228, NULL, '23106070330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1229, NULL, '23106070331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1230, NULL, '23106070332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1231, NULL, '23106070333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1232, NULL, '23106070334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1233, NULL, '23106070335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1234, NULL, '23106070336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1235, NULL, '23106070337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1236, NULL, '23106070338', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1237, NULL, '23106070339', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1238, NULL, '23106070340', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1239, NULL, '23109020118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1240, NULL, '23306010249', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1241, NULL, '24101070126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1242, NULL, '24103030107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1243, NULL, '24105010105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1244, NULL, '24106010101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1245, NULL, '24106010102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1246, NULL, '24106010103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1247, NULL, '24106010104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1248, NULL, '24106010105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1249, NULL, '24106010106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1250, NULL, '24106010107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1251, NULL, '24106010108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1252, NULL, '24106010109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1253, NULL, '24106010110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1254, NULL, '24106010111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1255, NULL, '24106010112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1256, NULL, '24106010113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1257, NULL, '24106010114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1258, NULL, '24106010115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1259, NULL, '24106010116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1260, NULL, '24106010117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1261, NULL, '24106010118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1262, NULL, '24106010119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1263, NULL, '24106010120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1264, NULL, '24106010121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1265, NULL, '24106010122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1266, NULL, '24106010123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1267, NULL, '24106010124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1268, NULL, '24106010125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1269, NULL, '24106010126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1270, NULL, '24106010127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1271, NULL, '24106010128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1272, NULL, '24106010129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1273, NULL, '24106010130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1274, NULL, '24106010131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1275, NULL, '24106010132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1276, NULL, '24106010133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1277, NULL, '24106010134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1278, NULL, '24106010135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1279, NULL, '24106010136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1280, NULL, '24106010137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1281, NULL, '24106010138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1282, NULL, '24106010139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1283, NULL, '24106010140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1284, NULL, '24106010141', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1285, NULL, '24106010201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1286, NULL, '24106010202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1287, NULL, '24106010203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1288, NULL, '24106010204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1289, NULL, '24106010205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1290, NULL, '24106010206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1291, NULL, '24106010207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1292, NULL, '24106010208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1293, NULL, '24106010209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1294, NULL, '24106010210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1295, NULL, '24106010211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1296, NULL, '24106010212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1297, NULL, '24106010213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1298, NULL, '24106010214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1299, NULL, '24106010215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1300, NULL, '24106010216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1301, NULL, '24106010217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1302, NULL, '24106010218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1303, NULL, '24106010219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1304, NULL, '24106010220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1305, NULL, '24106010221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1306, NULL, '24106010222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1307, NULL, '24106010223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1308, NULL, '24106010224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1309, NULL, '24106010225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1310, NULL, '24106010226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1311, NULL, '24106010227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1312, NULL, '24106010228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1313, NULL, '24106010229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1314, NULL, '24106010230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1315, NULL, '24106010231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1316, NULL, '24106010232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1317, NULL, '24106010233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1318, NULL, '24106010234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1319, NULL, '24106010235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1320, NULL, '24106010236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1321, NULL, '24106010237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1322, NULL, '24106010238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1323, NULL, '24106010239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1324, NULL, '24106010240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1325, NULL, '24106010241', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1326, NULL, '24106010301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1327, NULL, '24106010302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1328, NULL, '24106010303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1329, NULL, '24106010304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1330, NULL, '24106010305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1331, NULL, '24106010306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1332, NULL, '24106010307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1333, NULL, '24106010308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1334, NULL, '24106010309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1335, NULL, '24106010310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1336, NULL, '24106010311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1337, NULL, '24106010312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1338, NULL, '24106010313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1339, NULL, '24106010314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1340, NULL, '24106010315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1341, NULL, '24106010316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1342, NULL, '24106010317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1343, NULL, '24106010318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1344, NULL, '24106010319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1345, NULL, '24106010320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1346, NULL, '24106010321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1347, NULL, '24106010322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1348, NULL, '24106010323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1349, NULL, '24106010324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1350, NULL, '24106010325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1351, NULL, '24106010326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1352, NULL, '24106010327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1353, NULL, '24106010328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1354, NULL, '24106010329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1355, NULL, '24106010330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1356, NULL, '24106010331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1357, NULL, '24106010332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1358, NULL, '24106010333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1359, NULL, '24106010334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1360, NULL, '24106010335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1361, NULL, '24106010336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1362, NULL, '24106010337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1363, NULL, '24106010338', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1364, NULL, '24106010339', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1365, NULL, '24106010340', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1366, NULL, '24106030101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1367, NULL, '24106030102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1368, NULL, '24106030103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1369, NULL, '24106030104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1370, NULL, '24106030105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1371, NULL, '24106030106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1372, NULL, '24106030107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1373, NULL, '24106030109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1374, NULL, '24106030110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1375, NULL, '24106030111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1376, NULL, '24106030112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1377, NULL, '24106030113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1378, NULL, '24106030114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1379, NULL, '24106030115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1380, NULL, '24106030116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1381, NULL, '24106030117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1382, NULL, '24106030118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1383, NULL, '24106030119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1384, NULL, '24106030120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1385, NULL, '24106030121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1386, NULL, '24106030122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1387, NULL, '24106030123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1388, NULL, '24106030124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1389, NULL, '24106030125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1390, NULL, '24106030126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1391, NULL, '24106030127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1392, NULL, '24106030128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1393, NULL, '24106030129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1394, NULL, '24106030130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1395, NULL, '24106030131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1396, NULL, '24106030132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1397, NULL, '24106030133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1398, NULL, '24106030134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1399, NULL, '24106030135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1400, NULL, '24106030136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1401, NULL, '24106030137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1402, NULL, '24106030138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1403, NULL, '24106030139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1404, NULL, '24106030140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1405, NULL, '24106030201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1406, NULL, '24106030202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1407, NULL, '24106030203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1408, NULL, '24106030204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1409, NULL, '24106030205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1410, NULL, '24106030206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1411, NULL, '24106030207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1412, NULL, '24106030208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1413, NULL, '24106030209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1414, NULL, '24106030210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1415, NULL, '24106030211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1416, NULL, '24106030212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1417, NULL, '24106030213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1418, NULL, '24106030214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1419, NULL, '24106030215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1420, NULL, '24106030216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1421, NULL, '24106030217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1422, NULL, '24106030218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1423, NULL, '24106030219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1424, NULL, '24106030220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1425, NULL, '24106030221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1426, NULL, '24106030222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1427, NULL, '24106030223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1428, NULL, '24106030224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1429, NULL, '24106030225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1430, NULL, '24106030226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1431, NULL, '24106030227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1432, NULL, '24106030229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1433, NULL, '24106030230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1434, NULL, '24106030231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1435, NULL, '24106030232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1436, NULL, '24106030233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1437, NULL, '24106030234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1438, NULL, '24106030235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1439, NULL, '24106030236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1440, NULL, '24106030238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1441, NULL, '24106030239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1442, NULL, '24106030240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1443, NULL, '24106040101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1444, NULL, '24106040102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1445, NULL, '24106040103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1446, NULL, '24106040104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1447, NULL, '24106040105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1448, NULL, '24106040106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1449, NULL, '24106040107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1450, NULL, '24106040108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1451, NULL, '24106040109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1452, NULL, '24106040110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1453, NULL, '24106040111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1454, NULL, '24106040112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1455, NULL, '24106040113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1456, NULL, '24106040114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1457, NULL, '24106040115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1458, NULL, '24106040116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1459, NULL, '24106040118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1460, NULL, '24106040119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1461, NULL, '24106040120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1462, NULL, '24106040121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1463, NULL, '24106040122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1464, NULL, '24106040123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1465, NULL, '24106040124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1466, NULL, '24106040125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1467, NULL, '24106040126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1468, NULL, '24106040127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1469, NULL, '24106040128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1470, NULL, '24106040129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1471, NULL, '24106040130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1472, NULL, '24106040131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1473, NULL, '24106040132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1474, NULL, '24106040133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1475, NULL, '24106040134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1476, NULL, '24106040136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1477, NULL, '24106040137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1478, NULL, '24106040138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1479, NULL, '24106040139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1480, NULL, '24106040140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1481, NULL, '24106040141', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1482, NULL, '24106040201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1483, NULL, '24106040202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1484, NULL, '24106040203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1485, NULL, '24106040204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1486, NULL, '24106040205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1487, NULL, '24106040206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1488, NULL, '24106040207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1489, NULL, '24106040208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1490, NULL, '24106040209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1491, NULL, '24106040210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1492, NULL, '24106040211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1493, NULL, '24106040212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1494, NULL, '24106040213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1495, NULL, '24106040214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1496, NULL, '24106040215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1497, NULL, '24106040216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1498, NULL, '24106040217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1499, NULL, '24106040218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1500, NULL, '24106040219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1501, NULL, '24106040220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1502, NULL, '24106040221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1503, NULL, '24106040222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1504, NULL, '24106040223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1505, NULL, '24106040224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1506, NULL, '24106040225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1507, NULL, '24106040226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1508, NULL, '24106040227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1509, NULL, '24106040229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1510, NULL, '24106040230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1511, NULL, '24106040231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1512, NULL, '24106040232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1513, NULL, '24106040233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1514, NULL, '24106040234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1515, NULL, '24106040235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1516, NULL, '24106040236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1517, NULL, '24106040237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1518, NULL, '24106040238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1519, NULL, '24106040239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1520, NULL, '24106040240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1521, NULL, '24106040241', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1522, NULL, '24106040301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1523, NULL, '24106040302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1524, NULL, '24106040303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1525, NULL, '24106040304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1526, NULL, '24106040306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1527, NULL, '24106040307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1528, NULL, '24106040308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1529, NULL, '24106040309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1530, NULL, '24106040310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1531, NULL, '24106040311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1532, NULL, '24106040312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1533, NULL, '24106040313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1534, NULL, '24106040314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1535, NULL, '24106040315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1536, NULL, '24106040316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1537, NULL, '24106040317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1538, NULL, '24106040318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1539, NULL, '24106040319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1540, NULL, '24106040320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1541, NULL, '24106040321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1542, NULL, '24106040322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1543, NULL, '24106040323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1544, NULL, '24106040324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1545, NULL, '24106040325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1546, NULL, '24106040326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1547, NULL, '24106040327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1548, NULL, '24106040328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1549, NULL, '24106040329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1550, NULL, '24106040330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1551, NULL, '24106040331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1552, NULL, '24106040332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1553, NULL, '24106040333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1554, NULL, '24106040334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1555, NULL, '24106040335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1556, NULL, '24106040336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1557, NULL, '24106040337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1558, NULL, '24106040338', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1559, NULL, '24106040339', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1560, NULL, '24106040340', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1561, NULL, '24106060101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1562, NULL, '24106060102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1563, NULL, '24106060104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1564, NULL, '24106060105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1565, NULL, '24106060107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1566, NULL, '24106060108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1567, NULL, '24106060109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1568, NULL, '24106060110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1569, NULL, '24106060111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1570, NULL, '24106060112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1571, NULL, '24106060113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1572, NULL, '24106060114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1573, NULL, '24106060115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1574, NULL, '24106060116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1575, NULL, '24106060117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1576, NULL, '24106060118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1577, NULL, '24106060119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1578, NULL, '24106060120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1579, NULL, '24106060121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1580, NULL, '24106060122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1581, NULL, '24106060123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1582, NULL, '24106060124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1583, NULL, '24106060125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1584, NULL, '24106060126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1585, NULL, '24106060127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1586, NULL, '24106060128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1587, NULL, '24106060129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1588, NULL, '24106060130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1589, NULL, '24106060131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1590, NULL, '24106060132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1591, NULL, '24106060133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1592, NULL, '24106060134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1593, NULL, '24106060135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1594, NULL, '24106060136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1595, NULL, '24106060137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1596, NULL, '24106060138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1597, NULL, '24106060139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1598, NULL, '24106060140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1599, NULL, '24106060141', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1600, NULL, '24106060201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1601, NULL, '24106060202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1602, NULL, '24106060203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1603, NULL, '24106060204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1604, NULL, '24106060205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1605, NULL, '24106060206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1606, NULL, '24106060207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1607, NULL, '24106060208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1608, NULL, '24106060209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1609, NULL, '24106060210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1610, NULL, '24106060211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1611, NULL, '24106060212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1612, NULL, '24106060214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1613, NULL, '24106060215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1614, NULL, '24106060216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1615, NULL, '24106060217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1616, NULL, '24106060218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1617, NULL, '24106060220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1618, NULL, '24106060221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1619, NULL, '24106060222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1620, NULL, '24106060223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1621, NULL, '24106060224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1622, NULL, '24106060225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1623, NULL, '24106060226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1624, NULL, '24106060227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1625, NULL, '24106060228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1626, NULL, '24106060229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1627, NULL, '24106060230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1628, NULL, '24106060231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1629, NULL, '24106060232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1630, NULL, '24106060233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1631, NULL, '24106060234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1632, NULL, '24106060235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1633, NULL, '24106060236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1634, NULL, '24106060237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1635, NULL, '24106060238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1636, NULL, '24106060239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1637, NULL, '24106060240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1638, NULL, '24106070102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1639, NULL, '24106070103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1640, NULL, '24106070104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1641, NULL, '24106070105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1642, NULL, '24106070106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1643, NULL, '24106070107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1644, NULL, '24106070108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1645, NULL, '24106070109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1646, NULL, '24106070110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1647, NULL, '24106070111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1648, NULL, '24106070112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1649, NULL, '24106070113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1650, NULL, '24106070114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1651, NULL, '24106070115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1652, NULL, '24106070116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1653, NULL, '24106070117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1654, NULL, '24106070118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1655, NULL, '24106070119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1656, NULL, '24106070120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1657, NULL, '24106070121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1658, NULL, '24106070122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1659, NULL, '24106070123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1660, NULL, '24106070124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1661, NULL, '24106070125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1662, NULL, '24106070126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1663, NULL, '24106070127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1664, NULL, '24106070128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1665, NULL, '24106070129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1666, NULL, '24106070130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1667, NULL, '24106070131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1668, NULL, '24106070132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1669, NULL, '24106070133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1670, NULL, '24106070134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1671, NULL, '24106070135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1672, NULL, '24106070137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1673, NULL, '24106070138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1674, NULL, '24106070201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1675, NULL, '24106070202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1676, NULL, '24106070203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1677, NULL, '24106070204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1678, NULL, '24106070205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1679, NULL, '24106070206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1680, NULL, '24106070207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1681, NULL, '24106070208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1682, NULL, '24106070209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1683, NULL, '24106070210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1684, NULL, '24106070211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1685, NULL, '24106070212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1686, NULL, '24106070213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1687, NULL, '24106070214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1688, NULL, '24106070215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1689, NULL, '24106070217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1690, NULL, '24106070218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1691, NULL, '24106070219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1692, NULL, '24106070220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1693, NULL, '24106070221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1694, NULL, '24106070222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1695, NULL, '24106070223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1696, NULL, '24106070224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1697, NULL, '24106070225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1698, NULL, '24106070226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1699, NULL, '24106070227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1700, NULL, '24106070228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1701, NULL, '24106070229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1702, NULL, '24106070230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1703, NULL, '24106070231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1704, NULL, '24106070232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1705, NULL, '24106070233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1706, NULL, '24106070234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1707, NULL, '24106070235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1708, NULL, '24106070236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1709, NULL, '24106070237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1710, NULL, '24106070238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1711, NULL, '24106070301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1712, NULL, '24106070302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1713, NULL, '24106070303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1714, NULL, '24106070304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1715, NULL, '24106070305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1716, NULL, '24106070306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1717, NULL, '24106070307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1718, NULL, '24106070308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1719, NULL, '24106070309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1720, NULL, '24106070310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1721, NULL, '24106070311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1722, NULL, '24106070312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1723, NULL, '24106070313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1724, NULL, '24106070314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1725, NULL, '24106070315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1726, NULL, '24106070316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1727, NULL, '24106070317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1728, NULL, '24106070318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1729, NULL, '24106070319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1730, NULL, '24106070320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1731, NULL, '24106070321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1732, NULL, '24106070322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1733, NULL, '24106070323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1734, NULL, '24106070324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1735, NULL, '24106070325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1736, NULL, '24106070326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1737, NULL, '24106070327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1738, NULL, '24106070328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1739, NULL, '24106070329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1740, NULL, '24106070330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1741, NULL, '24106070331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1742, NULL, '24106070332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1743, NULL, '24106070334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1744, NULL, '24106070335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1745, NULL, '24106070336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1746, NULL, '24106070337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1747, NULL, '24106070401', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1748, NULL, '24106070403', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1749, NULL, '24106070404', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1750, NULL, '24106070405', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1751, NULL, '24106070406', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1752, NULL, '24106070407', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1753, NULL, '24106070408', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1754, NULL, '24106070409', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1755, NULL, '24106070410', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1756, NULL, '24106070411', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1757, NULL, '24106070412', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1758, NULL, '24106070414', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1759, NULL, '24106070415', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1760, NULL, '24106070416', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1761, NULL, '24106070417', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1762, NULL, '24106070418', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1763, NULL, '24106070419', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1764, NULL, '24106070420', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1765, NULL, '24106070421', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1766, NULL, '24106070422', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1767, NULL, '24106070424', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1768, NULL, '24106070425', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1769, NULL, '24106070426', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1770, NULL, '24106070427', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1771, NULL, '24106070428', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1772, NULL, '24106070429', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1773, NULL, '24106070430', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1774, NULL, '24106070431', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1775, NULL, '24106070432', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1776, NULL, '24106070433', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1777, NULL, '24106070434', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1778, NULL, '24106070435', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1779, NULL, '24106070436', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1780, NULL, '24106070437', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1781, NULL, '24106070501', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1782, NULL, '24106070502', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1783, NULL, '24106070503', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1784, NULL, '24106070504', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1785, NULL, '24106070505', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1786, NULL, '24106070506', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1787, NULL, '24106070508', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1788, NULL, '24106070509', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1789, NULL, '24106070510', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1790, NULL, '24106070511', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1791, NULL, '24106070513', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1792, NULL, '24106070514', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1793, NULL, '24106070515', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1794, NULL, '24106070516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1795, NULL, '24106070517', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1796, NULL, '24106070518', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1797, NULL, '24106070519', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1798, NULL, '24106070520', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1799, NULL, '24106070521', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1800, NULL, '24106070522', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1801, NULL, '24106070523', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1802, NULL, '24106070524', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1803, NULL, '24106070525', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1804, NULL, '24106070526', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1805, NULL, '24106070527', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1806, NULL, '24106070528', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1807, NULL, '24106070529', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1808, NULL, '24106070530', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1809, NULL, '24106070531', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1810, NULL, '24106070532', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1811, NULL, '24106070533', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1812, NULL, '24106070534', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1813, NULL, '24106070535', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1814, NULL, '24106070536', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1815, NULL, '24106070537', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1816, NULL, '24106070601', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1817, NULL, '24106070602', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1818, NULL, '24106070603', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1819, NULL, '24106070604', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1820, NULL, '24106070605', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1821, NULL, '24106070606', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1822, NULL, '24106070607', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1823, NULL, '24106070608', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1824, NULL, '24106070610', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1825, NULL, '24106070611', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1826, NULL, '24106070612', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1827, NULL, '24106070613', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1828, NULL, '24106070614', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1829, NULL, '24106070615', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1830, NULL, '24106070616', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1831, NULL, '24106070617', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1832, NULL, '24106070618', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1833, NULL, '24106070619', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1834, NULL, '24106070620', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1835, NULL, '24106070621', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1836, NULL, '24106070622', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1837, NULL, '24106070623', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1838, NULL, '24106070624', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1839, NULL, '24106070625', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1840, NULL, '24106070626', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1841, NULL, '24106070627', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1842, NULL, '24106070628', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1843, NULL, '24106070630', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1844, NULL, '24106070631', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1845, NULL, '24106070632', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1846, NULL, '24106070633', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1847, NULL, '24106070634', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1848, NULL, '24106070635', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1849, NULL, '24106070636', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1850, NULL, '24106070637', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1851, NULL, '24106070701', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1852, NULL, '24106070702', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1853, NULL, '24106070703', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1854, NULL, '24106070704', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1855, NULL, '24106070705', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1856, NULL, '24106070706', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1857, NULL, '24106070707', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1858, NULL, '24106070708', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1859, NULL, '24106070709', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1860, NULL, '24106070710', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1861, NULL, '24106070711', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1862, NULL, '24106070712', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1863, NULL, '24106070713', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1864, NULL, '24106070714', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1865, NULL, '24106070715', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1866, NULL, '24106070716', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1867, NULL, '24106070717', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1868, NULL, '24106070718', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1869, NULL, '24106070719', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1870, NULL, '24106070720', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1871, NULL, '24106070721', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1872, NULL, '24106070722', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1873, NULL, '24106070723', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1874, NULL, '24106070724', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1875, NULL, '24106070725', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1876, NULL, '24106070726', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1877, NULL, '24106070727', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1878, NULL, '24106070728', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1879, NULL, '24106070729', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1880, NULL, '24106070730', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1881, NULL, '24106070731', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1882, NULL, '24106070732', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1883, NULL, '24106070733', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1884, NULL, '24106070734', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1885, NULL, '24106070735', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1886, NULL, '24106070736', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1887, NULL, '24106070737', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1888, NULL, '24106070801', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1889, NULL, '24106070802', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1890, NULL, '24106070803', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1891, NULL, '24106070804', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1892, NULL, '24106070805', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1893, NULL, '24106070806', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1894, NULL, '24106070807', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1895, NULL, '24106070808', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1896, NULL, '24106070809', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1897, NULL, '24106070810', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1898, NULL, '24106070811', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1899, NULL, '24106070812', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1900, NULL, '24106070813', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1901, NULL, '24106070814', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1902, NULL, '24106070815', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1903, NULL, '24106070816', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1904, NULL, '24106070817', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1905, NULL, '24106070818', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1906, NULL, '24106070819', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1907, NULL, '24106070820', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1908, NULL, '24106070821', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1909, NULL, '24106070822', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1910, NULL, '24106070823', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1911, NULL, '24106070824', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1912, NULL, '24106070826', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1913, NULL, '24106070827', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1914, NULL, '24106070828', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1915, NULL, '24106070829', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1916, NULL, '24106070830', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1917, NULL, '24106070831', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1918, NULL, '24106070832', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1919, NULL, '24106070833', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1920, NULL, '24106070834', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1921, NULL, '24106070835', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1922, NULL, '24106070836', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1923, NULL, '24106070837', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1924, NULL, '24106070901', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1925, NULL, '24106070902', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1926, NULL, '24106070903', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1927, NULL, '24106070904', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1928, NULL, '24106070905', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1929, NULL, '24106070906', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1930, NULL, '24106070907', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1931, NULL, '24106070908', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1932, NULL, '24106070909', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1933, NULL, '24106070910', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1934, NULL, '24106070911', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1935, NULL, '24106070912', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1936, NULL, '24106070913', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1937, NULL, '24106070914', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1938, NULL, '24106070915', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1939, NULL, '24106070916', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1940, NULL, '24106070917', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1941, NULL, '24106070918', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1942, NULL, '24106070919', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1943, NULL, '24106070920', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1944, NULL, '24106070921', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1945, NULL, '24106070922', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1946, NULL, '24106070923', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1947, NULL, '24106070924', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1948, NULL, '24106070925', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1949, NULL, '24106070927', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1950, NULL, '24106070928', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1951, NULL, '24106070929', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1952, NULL, '24106070930', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1953, NULL, '24106070931', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1954, NULL, '24106070932', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1955, NULL, '24106070933', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1956, NULL, '24106070935', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1957, NULL, '24106070936', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1958, NULL, '24106070937', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1959, NULL, '24306010101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1960, NULL, '24306010102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1961, NULL, '24306010103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1962, NULL, '24306010104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1963, NULL, '24306010105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1964, NULL, '24306010106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1965, NULL, '24306010107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1966, NULL, '24306010108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1967, NULL, '24306010109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1968, NULL, '24306010110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1969, NULL, '24306010112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1970, NULL, '24306010113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1971, NULL, '24306010114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1972, NULL, '24306010115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1973, NULL, '24306010116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1974, NULL, '24306010117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1975, NULL, '24306010118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1976, NULL, '24306010119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1977, NULL, '24306010120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1978, NULL, '24306010121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1979, NULL, '24306010122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1980, NULL, '24306010123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1981, NULL, '24306010124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1982, NULL, '24306010125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1983, NULL, '24306010126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1984, NULL, '24306010127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1985, NULL, '24306010128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1986, NULL, '24306010129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1987, NULL, '24306010130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1988, NULL, '24306010131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1989, NULL, '24306010132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1990, NULL, '24306010133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1991, NULL, '24306010134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1992, NULL, '24306010135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1993, NULL, '24306010136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1994, NULL, '24306010137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1995, NULL, '24306010138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1996, NULL, '24306010139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1997, NULL, '24306010201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1998, NULL, '24306010202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (1999, NULL, '24306010203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2000, NULL, '24306010204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2001, NULL, '24306010205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2002, NULL, '24306010206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2003, NULL, '24306010207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2004, NULL, '24306010208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2005, NULL, '24306010209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2006, NULL, '24306010210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2007, NULL, '24306010211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2008, NULL, '24306010212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2009, NULL, '24306010213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2010, NULL, '24306010214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2011, NULL, '24306010215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2012, NULL, '24306010216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2013, NULL, '24306010217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2014, NULL, '24306010218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2015, NULL, '24306010219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2016, NULL, '24306010220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2017, NULL, '24306010221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2018, NULL, '24306010222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2019, NULL, '24306010223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2020, NULL, '24306010224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2021, NULL, '24306010225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2022, NULL, '24306010226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2023, NULL, '24306010227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2024, NULL, '24306010228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2025, NULL, '24306010229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2026, NULL, '24306010230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2027, NULL, '24306010231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2028, NULL, '24306010232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2029, NULL, '24306010233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2030, NULL, '24306010234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2031, NULL, '24306010235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2032, NULL, '24306010236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2033, NULL, '24306010237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2034, NULL, '24306010238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2035, NULL, '24306010239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2036, NULL, '24306010301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2037, NULL, '24306010302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2038, NULL, '24306010303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2039, NULL, '24306010304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2040, NULL, '24306010305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2041, NULL, '24306010306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2042, NULL, '24306010307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2043, NULL, '24306010308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2044, NULL, '24306010309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2045, NULL, '24306010310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2046, NULL, '24306010311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2047, NULL, '24306010312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2048, NULL, '24306010313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2049, NULL, '24306010314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2050, NULL, '24306010315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2051, NULL, '24306010316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2052, NULL, '24306010317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2053, NULL, '24306010318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2054, NULL, '24306010319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2055, NULL, '24306010320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2056, NULL, '24306010321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2057, NULL, '24306010322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2058, NULL, '24306010323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2059, NULL, '24306010324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2060, NULL, '24306010325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2061, NULL, '24306010327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2062, NULL, '24306010328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2063, NULL, '24306010329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2064, NULL, '24306010330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2065, NULL, '24306010331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2066, NULL, '24306010332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2067, NULL, '24306010333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2068, NULL, '24306010334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2069, NULL, '24306010335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2070, NULL, '24306010336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2071, NULL, '24306010337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2072, NULL, '24306010338', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2073, NULL, '24306010401', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2074, NULL, '24306010402', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2075, NULL, '24306010403', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2076, NULL, '24306010404', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2077, NULL, '24306010405', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2078, NULL, '24306010406', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2079, NULL, '24306010407', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2080, NULL, '24306010408', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2081, NULL, '24306010409', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2082, NULL, '24306010410', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2083, NULL, '24306010411', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2084, NULL, '24306010412', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2085, NULL, '24306010413', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2086, NULL, '24306010414', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2087, NULL, '24306010415', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2088, NULL, '24306010416', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2089, NULL, '24306010417', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2090, NULL, '24306010418', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2091, NULL, '24306010419', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2092, NULL, '24306010420', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2093, NULL, '24306010421', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2094, NULL, '24306010422', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2095, NULL, '24306010423', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2096, NULL, '24306010424', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2097, NULL, '24306010425', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2098, NULL, '24306010426', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2099, NULL, '24306010427', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2100, NULL, '24306010428', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2101, NULL, '24306010429', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2102, NULL, '24306010430', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2103, NULL, '24306010431', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2104, NULL, '24306010432', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2105, NULL, '24306010433', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2106, NULL, '24306010434', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2107, NULL, '24306010435', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2108, NULL, '24306010436', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2109, NULL, '24306010437', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2110, NULL, '24306010438', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2111, NULL, '24306010501', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2112, NULL, '24306010502', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2113, NULL, '24306010503', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2114, NULL, '24306010504', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2115, NULL, '24306010505', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2116, NULL, '24306010506', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2117, NULL, '24306010507', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2118, NULL, '24306010508', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2119, NULL, '24306010509', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2120, NULL, '24306010510', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2121, NULL, '24306010511', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2122, NULL, '24306010513', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2123, NULL, '24306010514', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2124, NULL, '24306010515', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2125, NULL, '24306010516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2126, NULL, '24306010517', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2127, NULL, '24306010518', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2128, NULL, '24306010519', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2129, NULL, '24306010520', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2130, NULL, '24306010521', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2131, NULL, '24306010522', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2132, NULL, '24306010523', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2133, NULL, '24306010524', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2134, NULL, '24306010525', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2135, NULL, '24306010526', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2136, NULL, '24306010527', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2137, NULL, '24306010528', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2138, NULL, '24306010529', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2139, NULL, '24306010530', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2140, NULL, '24306010531', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2141, NULL, '24306010532', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2142, NULL, '24306010533', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2143, NULL, '24306010534', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2144, NULL, '24306010535', '薛红菲', '00', '13934910703@qq.com', '13934910703', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '172.16.193.221', '2025-11-05 10:38:26', NULL, '', NULL, '', '2025-11-05 10:38:50', NULL, 1);
INSERT INTO `sys_user` VALUES (2145, NULL, '24306010536', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2146, NULL, '24306010537', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2147, NULL, '24306010539', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2148, NULL, '24306010601', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2149, NULL, '24306010602', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2150, NULL, '24306010603', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2151, NULL, '24306010604', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2152, NULL, '24306010605', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2153, NULL, '24306010606', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2154, NULL, '24306010607', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2155, NULL, '24306010608', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2156, NULL, '24306010609', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2157, NULL, '24306010610', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2158, NULL, '24306010611', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2159, NULL, '24306010612', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2160, NULL, '24306010613', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2161, NULL, '24306010614', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2162, NULL, '24306010615', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2163, NULL, '24306010616', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2164, NULL, '24306010617', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2165, NULL, '24306010618', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2166, NULL, '24306010619', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2167, NULL, '24306010620', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2168, NULL, '24306010621', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2169, NULL, '24306010622', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2170, NULL, '24306010623', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2171, NULL, '24306010624', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2172, NULL, '24306010625', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2173, NULL, '24306010626', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2174, NULL, '24306010627', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2175, NULL, '24306010628', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2176, NULL, '24306010629', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2177, NULL, '24306010630', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2178, NULL, '24306010631', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2179, NULL, '24306010632', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2180, NULL, '24306010633', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2181, NULL, '24306010634', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2182, NULL, '24306010635', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2183, NULL, '24306010636', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2184, NULL, '24306010637', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2185, NULL, '24306010639', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2186, NULL, '24306010701', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2187, NULL, '24306010702', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2188, NULL, '24306010703', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2189, NULL, '24306010704', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2190, NULL, '24306010705', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2191, NULL, '24306010706', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2192, NULL, '24306010707', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2193, NULL, '24306010708', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2194, NULL, '24306010709', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2195, NULL, '24306010710', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2196, NULL, '24306010711', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2197, NULL, '24306010712', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2198, NULL, '24306010713', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2199, NULL, '24306010714', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2200, NULL, '24306010715', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2201, NULL, '24306010716', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2202, NULL, '24306010717', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2203, NULL, '24306010718', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2204, NULL, '24306010719', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2205, NULL, '24306010720', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2206, NULL, '24306010721', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2207, NULL, '24306010722', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2208, NULL, '24306010723', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2209, NULL, '24306010724', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2210, NULL, '24306010725', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2211, NULL, '24306010726', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2212, NULL, '24306010727', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2213, NULL, '24306010728', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2214, NULL, '24306010729', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2215, NULL, '24306010730', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2216, NULL, '24306010731', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2217, NULL, '24306010732', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2218, NULL, '24306010733', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2219, NULL, '24306010734', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2220, NULL, '24306010735', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2221, NULL, '24306010736', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2222, NULL, '24306010737', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2223, NULL, '24306010738', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2224, NULL, '24306010801', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2225, NULL, '24306010802', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2226, NULL, '24306010803', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2227, NULL, '24306010804', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2228, NULL, '24306010805', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2229, NULL, '24306010806', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2230, NULL, '24306010807', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2231, NULL, '24306010808', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2232, NULL, '24306010809', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2233, NULL, '24306010810', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2234, NULL, '24306010811', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2235, NULL, '24306010812', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2236, NULL, '24306010813', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2237, NULL, '24306010814', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2238, NULL, '24306010815', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2239, NULL, '24306010816', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2240, NULL, '24306010817', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2241, NULL, '24306010819', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2242, NULL, '24306010820', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2243, NULL, '24306010821', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2244, NULL, '24306010822', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2245, NULL, '24306010823', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2246, NULL, '24306010824', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2247, NULL, '24306010825', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2248, NULL, '24306010826', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2249, NULL, '24306010827', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2250, NULL, '24306010828', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2251, NULL, '24306010829', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2252, NULL, '24306010830', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2253, NULL, '24306010831', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2254, NULL, '24306010832', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2255, NULL, '24306010833', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2256, NULL, '24306010834', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2257, NULL, '24306010835', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2258, NULL, '24306010836', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2259, NULL, '24306010837', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2260, NULL, '24306010838', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2261, NULL, '24306010901', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2262, NULL, '24306010902', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2263, NULL, '24306010903', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2264, NULL, '24306010904', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2265, NULL, '24306010905', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2266, NULL, '24306010906', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2267, NULL, '24306010907', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2268, NULL, '24306010908', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2269, NULL, '24306010909', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2270, NULL, '24306010910', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2271, NULL, '24306010911', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2272, NULL, '24306010912', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2273, NULL, '24306010913', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2274, NULL, '24306010914', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2275, NULL, '24306010915', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2276, NULL, '24306010916', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2277, NULL, '24306010917', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2278, NULL, '24306010918', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2279, NULL, '24306010919', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2280, NULL, '24306010920', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2281, NULL, '24306010921', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2282, NULL, '24306010922', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2283, NULL, '24306010923', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2284, NULL, '24306010924', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2285, NULL, '24306010925', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2286, NULL, '24306010926', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2287, NULL, '24306010927', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2288, NULL, '24306010928', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2289, NULL, '24306010929', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2290, NULL, '24306010930', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2291, NULL, '24306010931', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2292, NULL, '24306010932', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2293, NULL, '24306010933', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2294, NULL, '24306010934', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2295, NULL, '24306010935', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2296, NULL, '24306010936', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2297, NULL, '24306010937', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2298, NULL, '24306010938', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2299, NULL, '25106010101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2300, NULL, '25106010102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2301, NULL, '25106010103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2302, NULL, '25106010104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2303, NULL, '25106010105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2304, NULL, '25106010106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2305, NULL, '25106010107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2306, NULL, '25106010108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2307, NULL, '25106010109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2308, NULL, '25106010110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2309, NULL, '25106010111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2310, NULL, '25106010112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2311, NULL, '25106010113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2312, NULL, '25106010114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2313, NULL, '25106010115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2314, NULL, '25106010116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2315, NULL, '25106010117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2316, NULL, '25106010118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2317, NULL, '25106010119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2318, NULL, '25106010120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2319, NULL, '25106010121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2320, NULL, '25106010122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2321, NULL, '25106010123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2322, NULL, '25106010124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2323, NULL, '25106010125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2324, NULL, '25106010126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2325, NULL, '25106010127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2326, NULL, '25106010128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2327, NULL, '25106010129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2328, NULL, '25106010130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2329, NULL, '25106010131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2330, NULL, '25106010132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2331, NULL, '25106010133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2332, NULL, '25106010134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2333, NULL, '25106010135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2334, NULL, '25106010136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2335, NULL, '25106010137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2336, NULL, '25106010138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2337, NULL, '25106010139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2338, NULL, '25106010140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2339, NULL, '25106010201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2340, NULL, '25106010202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2341, NULL, '25106010203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2342, NULL, '25106010204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2343, NULL, '25106010205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2344, NULL, '25106010206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2345, NULL, '25106010207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2346, NULL, '25106010208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2347, NULL, '25106010209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2348, NULL, '25106010210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2349, NULL, '25106010211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2350, NULL, '25106010212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2351, NULL, '25106010213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2352, NULL, '25106010214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2353, NULL, '25106010215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2354, NULL, '25106010216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2355, NULL, '25106010219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2356, NULL, '25106010220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2357, NULL, '25106010222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2358, NULL, '25106010223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2359, NULL, '25106010224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2360, NULL, '25106010225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2361, NULL, '25106010226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2362, NULL, '25106010227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2363, NULL, '25106010228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2364, NULL, '25106010229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2365, NULL, '25106010230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2366, NULL, '25106010231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2367, NULL, '25106010232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2368, NULL, '25106010233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2369, NULL, '25106010234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2370, NULL, '25106010235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2371, NULL, '25106010236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2372, NULL, '25106010237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2373, NULL, '25106010238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2374, NULL, '25106010239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2375, NULL, '25106010240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2376, NULL, '25106030101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2377, NULL, '25106030102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2378, NULL, '25106030103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2379, NULL, '25106030104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2380, NULL, '25106030105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2381, NULL, '25106030106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2382, NULL, '25106030107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2383, NULL, '25106030108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2384, NULL, '25106030109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2385, NULL, '25106030110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2386, NULL, '25106030111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2387, NULL, '25106030112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2388, NULL, '25106030113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2389, NULL, '25106030114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2390, NULL, '25106030115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2391, NULL, '25106030116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2392, NULL, '25106030117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2393, NULL, '25106030118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2394, NULL, '25106030119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2395, NULL, '25106030120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2396, NULL, '25106030121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2397, NULL, '25106030122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2398, NULL, '25106030123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2399, NULL, '25106030124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2400, NULL, '25106030125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2401, NULL, '25106030126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2402, NULL, '25106030127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2403, NULL, '25106030128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2404, NULL, '25106030129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2405, NULL, '25106030130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2406, NULL, '25106030131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2407, NULL, '25106030132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2408, NULL, '25106030133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2409, NULL, '25106030134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2410, NULL, '25106030135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2411, NULL, '25106030136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2412, NULL, '25106030137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2413, NULL, '25106030138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2414, NULL, '25106030139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2415, NULL, '25106030140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2416, NULL, '25106030201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2417, NULL, '25106030202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2418, NULL, '25106030203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2419, NULL, '25106030204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2420, NULL, '25106030205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2421, NULL, '25106030207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2422, NULL, '25106030208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2423, NULL, '25106030209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2424, NULL, '25106030210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2425, NULL, '25106030211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2426, NULL, '25106030212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2427, NULL, '25106030213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2428, NULL, '25106030214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2429, NULL, '25106030215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2430, NULL, '25106030216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2431, NULL, '25106030217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2432, NULL, '25106030218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2433, NULL, '25106030219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2434, NULL, '25106030220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2435, NULL, '25106030221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2436, NULL, '25106030222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2437, NULL, '25106030223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2438, NULL, '25106030224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2439, NULL, '25106030225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2440, NULL, '25106030226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2441, NULL, '25106030227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2442, NULL, '25106030228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2443, NULL, '25106030229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2444, NULL, '25106030230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2445, NULL, '25106030231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2446, NULL, '25106030232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2447, NULL, '25106030233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2448, NULL, '25106030234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2449, NULL, '25106030235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2450, NULL, '25106030236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2451, NULL, '25106030237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2452, NULL, '25106030238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2453, NULL, '25106030239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2454, NULL, '25106030240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2455, NULL, '25106040101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2456, NULL, '25106040102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2457, NULL, '25106040103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2458, NULL, '25106040104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2459, NULL, '25106040105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2460, NULL, '25106040106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2461, NULL, '25106040107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2462, NULL, '25106040108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2463, NULL, '25106040109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2464, NULL, '25106040110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2465, NULL, '25106040111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2466, NULL, '25106040112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2467, NULL, '25106040113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2468, NULL, '25106040114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2469, NULL, '25106040115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2470, NULL, '25106040116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2471, NULL, '25106040117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2472, NULL, '25106040118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2473, NULL, '25106040119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2474, NULL, '25106040120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2475, NULL, '25106040121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2476, NULL, '25106040122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2477, NULL, '25106040123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2478, NULL, '25106040124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2479, NULL, '25106040125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2480, NULL, '25106040126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2481, NULL, '25106040127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2482, NULL, '25106040128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2483, NULL, '25106040129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2484, NULL, '25106040130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2485, NULL, '25106040131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2486, NULL, '25106040132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2487, NULL, '25106040133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2488, NULL, '25106040134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2489, NULL, '25106040135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2490, NULL, '25106040136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2491, NULL, '25106040137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2492, NULL, '25106040138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2493, NULL, '25106040139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2494, NULL, '25106040140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2495, NULL, '25106040202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2496, NULL, '25106040203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2497, NULL, '25106040204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2498, NULL, '25106040205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2499, NULL, '25106040206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2500, NULL, '25106040207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2501, NULL, '25106040208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2502, NULL, '25106040209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2503, NULL, '25106040210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2504, NULL, '25106040211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2505, NULL, '25106040212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2506, NULL, '25106040213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2507, NULL, '25106040214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2508, NULL, '25106040215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2509, NULL, '25106040216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2510, NULL, '25106040217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2511, NULL, '25106040218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2512, NULL, '25106040219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2513, NULL, '25106040220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2514, NULL, '25106040222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2515, NULL, '25106040223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2516, NULL, '25106040224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2517, NULL, '25106040225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2518, NULL, '25106040226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2519, NULL, '25106040227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2520, NULL, '25106040228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2521, NULL, '25106040229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2522, NULL, '25106040230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2523, NULL, '25106040231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2524, NULL, '25106040232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2525, NULL, '25106040233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2526, NULL, '25106040234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2527, NULL, '25106040235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2528, NULL, '25106040236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2529, NULL, '25106040237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2530, NULL, '25106040238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2531, NULL, '25106040239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2532, NULL, '25106040240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2533, NULL, '25106060101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2534, NULL, '25106060102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2535, NULL, '25106060103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2536, NULL, '25106060104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2537, NULL, '25106060105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2538, NULL, '25106060106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2539, NULL, '25106060107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2540, NULL, '25106060108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2541, NULL, '25106060109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2542, NULL, '25106060110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2543, NULL, '25106060111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2544, NULL, '25106060112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2545, NULL, '25106060113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2546, NULL, '25106060114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2547, NULL, '25106060115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2548, NULL, '25106060116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2549, NULL, '25106060117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2550, NULL, '25106060118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2551, NULL, '25106060119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2552, NULL, '25106060120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2553, NULL, '25106060121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2554, NULL, '25106060122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2555, NULL, '25106060123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2556, NULL, '25106060124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2557, NULL, '25106060125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2558, NULL, '25106060126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2559, NULL, '25106060127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2560, NULL, '25106060128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2561, NULL, '25106060129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2562, NULL, '25106060130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2563, NULL, '25106060131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2564, NULL, '25106060132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2565, NULL, '25106060133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2566, NULL, '25106060134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2567, NULL, '25106060135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2568, NULL, '25106060136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2569, NULL, '25106060137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2570, NULL, '25106060138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2571, NULL, '25106060139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2572, NULL, '25106060140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2573, NULL, '25106060201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2574, NULL, '25106060202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2575, NULL, '25106060203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2576, NULL, '25106060204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2577, NULL, '25106060205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2578, NULL, '25106060206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2579, NULL, '25106060207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2580, NULL, '25106060208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2581, NULL, '25106060209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2582, NULL, '25106060210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2583, NULL, '25106060211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2584, NULL, '25106060212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2585, NULL, '25106060213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2586, NULL, '25106060214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2587, NULL, '25106060215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2588, NULL, '25106060216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2589, NULL, '25106060217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2590, NULL, '25106060218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2591, NULL, '25106060219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2592, NULL, '25106060220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2593, NULL, '25106060221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2594, NULL, '25106060222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2595, NULL, '25106060223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2596, NULL, '25106060224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2597, NULL, '25106060225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2598, NULL, '25106060226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2599, NULL, '25106060227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2600, NULL, '25106060228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2601, NULL, '25106060229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2602, NULL, '25106060230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2603, NULL, '25106060231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2604, NULL, '25106060232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2605, NULL, '25106060233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2606, NULL, '25106060234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2607, NULL, '25106060235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2608, NULL, '25106060236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2609, NULL, '25106060237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2610, NULL, '25106060238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2611, NULL, '25106060239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2612, NULL, '25106060240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2613, NULL, '25106070101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2614, NULL, '25106070102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2615, NULL, '25106070103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2616, NULL, '25106070104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2617, NULL, '25106070105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2618, NULL, '25106070106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2619, NULL, '25106070107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2620, NULL, '25106070108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2621, NULL, '25106070109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2622, NULL, '25106070110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2623, NULL, '25106070111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2624, NULL, '25106070112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2625, NULL, '25106070113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2626, NULL, '25106070114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2627, NULL, '25106070115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2628, NULL, '25106070116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2629, NULL, '25106070117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2630, NULL, '25106070118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2631, NULL, '25106070119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2632, NULL, '25106070120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2633, NULL, '25106070121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2634, NULL, '25106070122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2635, NULL, '25106070123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2636, NULL, '25106070124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2637, NULL, '25106070126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2638, NULL, '25106070127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2639, NULL, '25106070129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2640, NULL, '25106070130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2641, NULL, '25106070131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2642, NULL, '25106070132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2643, NULL, '25106070133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2644, NULL, '25106070134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2645, NULL, '25106070135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2646, NULL, '25106070136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2647, NULL, '25106070137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2648, NULL, '25106070138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2649, NULL, '25106070139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2650, NULL, '25106070140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2651, NULL, '25106070141', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2652, NULL, '25106070142', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2653, NULL, '25106070201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2654, NULL, '25106070202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2655, NULL, '25106070203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2656, NULL, '25106070204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2657, NULL, '25106070205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2658, NULL, '25106070206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2659, NULL, '25106070207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2660, NULL, '25106070208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2661, NULL, '25106070209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2662, NULL, '25106070210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2663, NULL, '25106070211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2664, NULL, '25106070212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2665, NULL, '25106070213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2666, NULL, '25106070214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2667, NULL, '25106070215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2668, NULL, '25106070216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2669, NULL, '25106070218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2670, NULL, '25106070219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2671, NULL, '25106070220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2672, NULL, '25106070221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2673, NULL, '25106070222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2674, NULL, '25106070223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2675, NULL, '25106070224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2676, NULL, '25106070225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2677, NULL, '25106070226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2678, NULL, '25106070227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2679, NULL, '25106070228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2680, NULL, '25106070229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2681, NULL, '25106070230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2682, NULL, '25106070231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2683, NULL, '25106070232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2684, NULL, '25106070233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2685, NULL, '25106070234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2686, NULL, '25106070235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2687, NULL, '25106070236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2688, NULL, '25106070237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2689, NULL, '25106070238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2690, NULL, '25106070239', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2691, NULL, '25106070240', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2692, NULL, '25106070241', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2693, NULL, '25106070242', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2694, NULL, '25106070302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2695, NULL, '25106070303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2696, NULL, '25106070304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2697, NULL, '25106070305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2698, NULL, '25106070306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2699, NULL, '25106070307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2700, NULL, '25106070308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2701, NULL, '25106070309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2702, NULL, '25106070310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2703, NULL, '25106070311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2704, NULL, '25106070312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2705, NULL, '25106070313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2706, NULL, '25106070314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2707, NULL, '25106070315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2708, NULL, '25106070316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2709, NULL, '25106070317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2710, NULL, '25106070318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2711, NULL, '25106070319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2712, NULL, '25106070320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2713, NULL, '25106070321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2714, NULL, '25106070322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2715, NULL, '25106070323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2716, NULL, '25106070324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2717, NULL, '25106070325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2718, NULL, '25106070326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2719, NULL, '25106070327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2720, NULL, '25106070328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2721, NULL, '25106070329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2722, NULL, '25106070330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2723, NULL, '25106070331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2724, NULL, '25106070332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2725, NULL, '25106070333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2726, NULL, '25106070334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2727, NULL, '25106070335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2728, NULL, '25106070337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2729, NULL, '25106070338', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2730, NULL, '25106070339', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2731, NULL, '25106070340', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2732, NULL, '25106070341', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2733, NULL, '25106070402', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2734, NULL, '25106070403', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2735, NULL, '25106070404', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2736, NULL, '25106070405', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2737, NULL, '25106070406', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2738, NULL, '25106070407', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2739, NULL, '25106070408', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2740, NULL, '25106070409', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2741, NULL, '25106070410', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2742, NULL, '25106070411', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2743, NULL, '25106070412', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2744, NULL, '25106070413', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2745, NULL, '25106070414', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2746, NULL, '25106070415', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2747, NULL, '25106070416', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2748, NULL, '25106070417', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2749, NULL, '25106070418', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2750, NULL, '25106070419', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2751, NULL, '25106070420', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2752, NULL, '25106070421', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2753, NULL, '25106070422', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2754, NULL, '25106070423', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2755, NULL, '25106070424', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2756, NULL, '25106070425', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2757, NULL, '25106070426', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2758, NULL, '25106070427', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2759, NULL, '25106070428', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2760, NULL, '25106070429', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2761, NULL, '25106070430', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2762, NULL, '25106070431', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2763, NULL, '25106070432', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2764, NULL, '25106070433', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2765, NULL, '25106070434', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2766, NULL, '25106070435', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2767, NULL, '25106070436', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2768, NULL, '25106070437', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2769, NULL, '25106070438', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2770, NULL, '25106070439', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2771, NULL, '25106070440', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2772, NULL, '25106070441', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2773, NULL, '25106070501', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2774, NULL, '25106070503', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2775, NULL, '25106070504', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2776, NULL, '25106070505', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2777, NULL, '25106070506', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2778, NULL, '25106070507', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2779, NULL, '25106070508', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2780, NULL, '25106070509', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2781, NULL, '25106070510', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2782, NULL, '25106070511', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2783, NULL, '25106070512', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2784, NULL, '25106070513', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2785, NULL, '25106070514', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2786, NULL, '25106070515', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2787, NULL, '25106070516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2788, NULL, '25106070517', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2789, NULL, '25106070519', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2790, NULL, '25106070520', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2791, NULL, '25106070521', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2792, NULL, '25106070522', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2793, NULL, '25106070523', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2794, NULL, '25106070524', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2795, NULL, '25106070525', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2796, NULL, '25106070526', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2797, NULL, '25106070527', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2798, NULL, '25106070528', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2799, NULL, '25106070529', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2800, NULL, '25106070530', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2801, NULL, '25106070531', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2802, NULL, '25106070532', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2803, NULL, '25106070533', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2804, NULL, '25106070534', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2805, NULL, '25106070535', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2806, NULL, '25106070536', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2807, NULL, '25106070537', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2808, NULL, '25106070538', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2809, NULL, '25106070539', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2810, NULL, '25106070540', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2811, NULL, '25106070541', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2812, NULL, '25106070601', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2813, NULL, '25106070602', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2814, NULL, '25106070603', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2815, NULL, '25106070604', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2816, NULL, '25106070605', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2817, NULL, '25106070606', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2818, NULL, '25106070607', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2819, NULL, '25106070608', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2820, NULL, '25106070609', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2821, NULL, '25106070610', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2822, NULL, '25106070611', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2823, NULL, '25106070612', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2824, NULL, '25106070613', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2825, NULL, '25106070614', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2826, NULL, '25106070615', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2827, NULL, '25106070616', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2828, NULL, '25106070617', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2829, NULL, '25106070618', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2830, NULL, '25106070619', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2831, NULL, '25106070620', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2832, NULL, '25106070621', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2833, NULL, '25106070622', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2834, NULL, '25106070623', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2835, NULL, '25106070624', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2836, NULL, '25106070625', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2837, NULL, '25106070626', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2838, NULL, '25106070627', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2839, NULL, '25106070628', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2840, NULL, '25106070629', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2841, NULL, '25106070630', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2842, NULL, '25106070631', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2843, NULL, '25106070632', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2844, NULL, '25106070633', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2845, NULL, '25106070634', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2846, NULL, '25106070635', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2847, NULL, '25106070636', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2848, NULL, '25106070637', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2849, NULL, '25106070638', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2850, NULL, '25106070639', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2851, NULL, '25106070640', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2852, NULL, '25106070641', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2853, NULL, '25106070701', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2854, NULL, '25106070702', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2855, NULL, '25106070703', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2856, NULL, '25106070704', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2857, NULL, '25106070705', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2858, NULL, '25106070706', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2859, NULL, '25106070707', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2860, NULL, '25106070708', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2861, NULL, '25106070709', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2862, NULL, '25106070710', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2863, NULL, '25106070711', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2864, NULL, '25106070712', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2865, NULL, '25106070713', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2866, NULL, '25106070714', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2867, NULL, '25106070715', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2868, NULL, '25106070716', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2869, NULL, '25106070717', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2870, NULL, '25106070718', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2871, NULL, '25106070720', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2872, NULL, '25106070721', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2873, NULL, '25106070722', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2874, NULL, '25106070723', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2875, NULL, '25106070724', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2876, NULL, '25106070725', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2877, NULL, '25106070726', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2878, NULL, '25106070727', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2879, NULL, '25106070728', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2880, NULL, '25106070729', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2881, NULL, '25106070730', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2882, NULL, '25106070731', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2883, NULL, '25106070732', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2884, NULL, '25106070733', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2885, NULL, '25106070734', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2886, NULL, '25106070735', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2887, NULL, '25106070736', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2888, NULL, '25106070737', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2889, NULL, '25106070738', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2890, NULL, '25106070739', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2891, NULL, '25106070740', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2892, NULL, '25106070741', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2893, NULL, '25106070801', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2894, NULL, '25106070802', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2895, NULL, '25106070803', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2896, NULL, '25106070804', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2897, NULL, '25106070805', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2898, NULL, '25106070806', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2899, NULL, '25106070807', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2900, NULL, '25106070808', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2901, NULL, '25106070809', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2902, NULL, '25106070810', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2903, NULL, '25106070811', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2904, NULL, '25106070812', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2905, NULL, '25106070813', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2906, NULL, '25106070814', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2907, NULL, '25106070815', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2908, NULL, '25106070816', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2909, NULL, '25106070817', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2910, NULL, '25106070818', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2911, NULL, '25106070819', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2912, NULL, '25106070820', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2913, NULL, '25106070821', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2914, NULL, '25106070822', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2915, NULL, '25106070823', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2916, NULL, '25106070824', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2917, NULL, '25106070825', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2918, NULL, '25106070826', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2919, NULL, '25106070827', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2920, NULL, '25106070828', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2921, NULL, '25106070829', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2922, NULL, '25106070830', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2923, NULL, '25106070831', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2924, NULL, '25106070832', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2925, NULL, '25106070833', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2926, NULL, '25106070834', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2927, NULL, '25106070835', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2928, NULL, '25106070836', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2929, NULL, '25106070837', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2930, NULL, '25106070838', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2931, NULL, '25106070839', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2932, NULL, '25106070840', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2933, NULL, '25106070841', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2934, NULL, '25306010101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2935, NULL, '25306010102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2936, NULL, '25306010103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2937, NULL, '25306010104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2938, NULL, '25306010105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2939, NULL, '25306010106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2940, NULL, '25306010107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2941, NULL, '25306010108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2942, NULL, '25306010109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2943, NULL, '25306010110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2944, NULL, '25306010111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2945, NULL, '25306010112', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2946, NULL, '25306010113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2947, NULL, '25306010114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2948, NULL, '25306010115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2949, NULL, '25306010116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2950, NULL, '25306010117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2951, NULL, '25306010118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2952, NULL, '25306010119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2953, NULL, '25306010120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2954, NULL, '25306010121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2955, NULL, '25306010122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2956, NULL, '25306010123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2957, NULL, '25306010124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2958, NULL, '25306010125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2959, NULL, '25306010126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2960, NULL, '25306010127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2961, NULL, '25306010128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2962, NULL, '25306010129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2963, NULL, '25306010130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2964, NULL, '25306010131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2965, NULL, '25306010132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2966, NULL, '25306010133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2967, NULL, '25306010134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2968, NULL, '25306010135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2969, NULL, '25306010136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2970, NULL, '25306010137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2971, NULL, '25306010138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2972, NULL, '25306010201', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2973, NULL, '25306010202', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2974, NULL, '25306010203', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2975, NULL, '25306010204', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2976, NULL, '25306010205', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2977, NULL, '25306010206', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2978, NULL, '25306010207', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2979, NULL, '25306010208', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2980, NULL, '25306010209', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2981, NULL, '25306010210', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2982, NULL, '25306010211', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2983, NULL, '25306010212', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2984, NULL, '25306010213', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2985, NULL, '25306010214', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2986, NULL, '25306010215', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2987, NULL, '25306010216', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2988, NULL, '25306010217', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2989, NULL, '25306010218', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2990, NULL, '25306010219', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2991, NULL, '25306010220', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2992, NULL, '25306010221', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2993, NULL, '25306010222', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2994, NULL, '25306010223', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2995, NULL, '25306010224', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2996, NULL, '25306010225', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2997, NULL, '25306010226', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2998, NULL, '25306010227', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (2999, NULL, '25306010228', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3000, NULL, '25306010229', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3001, NULL, '25306010230', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3002, NULL, '25306010231', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3003, NULL, '25306010232', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3004, NULL, '25306010233', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3005, NULL, '25306010234', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3006, NULL, '25306010235', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3007, NULL, '25306010236', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3008, NULL, '25306010237', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3009, NULL, '25306010238', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3010, NULL, '25306010301', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3011, NULL, '25306010302', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3012, NULL, '25306010303', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3013, NULL, '25306010304', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3014, NULL, '25306010305', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3015, NULL, '25306010306', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3016, NULL, '25306010307', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3017, NULL, '25306010308', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3018, NULL, '25306010309', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3019, NULL, '25306010310', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3020, NULL, '25306010311', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3021, NULL, '25306010312', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3022, NULL, '25306010313', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3023, NULL, '25306010314', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3024, NULL, '25306010315', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3025, NULL, '25306010316', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3026, NULL, '25306010317', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3027, NULL, '25306010318', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3028, NULL, '25306010319', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3029, NULL, '25306010320', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3030, NULL, '25306010321', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3031, NULL, '25306010322', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3032, NULL, '25306010323', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3033, NULL, '25306010324', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3034, NULL, '25306010325', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3035, NULL, '25306010326', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3036, NULL, '25306010327', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3037, NULL, '25306010328', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3038, NULL, '25306010329', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3039, NULL, '25306010330', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3040, NULL, '25306010331', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3041, NULL, '25306010332', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3042, NULL, '25306010333', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3043, NULL, '25306010334', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3044, NULL, '25306010335', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3045, NULL, '25306010336', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3046, NULL, '25306010337', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3047, NULL, '25306010338', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3048, NULL, '25306010401', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3049, NULL, '25306010402', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3050, NULL, '25306010403', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3051, NULL, '25306010404', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3052, NULL, '25306010405', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3053, NULL, '25306010406', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3054, NULL, '25306010407', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3055, NULL, '25306010408', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3056, NULL, '25306010409', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3057, NULL, '25306010410', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3058, NULL, '25306010411', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3059, NULL, '25306010412', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3060, NULL, '25306010413', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3061, NULL, '25306010414', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3062, NULL, '25306010415', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3063, NULL, '25306010416', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3064, NULL, '25306010417', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3065, NULL, '25306010418', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3066, NULL, '25306010419', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3067, NULL, '25306010420', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3068, NULL, '25306010422', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3069, NULL, '25306010423', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3070, NULL, '25306010424', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3071, NULL, '25306010425', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3072, NULL, '25306010426', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3073, NULL, '25306010427', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3074, NULL, '25306010428', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3075, NULL, '25306010429', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3076, NULL, '25306010430', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3077, NULL, '25306010431', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3078, NULL, '25306010432', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3079, NULL, '25306010433', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3080, NULL, '25306010434', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3081, NULL, '25306010435', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3082, NULL, '25306010436', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3083, NULL, '25306010437', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3084, NULL, '25306010438', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3085, NULL, '25306010501', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3086, NULL, '25306010502', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3087, NULL, '25306010503', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3088, NULL, '25306010504', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3089, NULL, '25306010505', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3090, NULL, '25306010506', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3091, NULL, '25306010507', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3092, NULL, '25306010508', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3093, NULL, '25306010509', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3094, NULL, '25306010510', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3095, NULL, '25306010511', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3096, NULL, '25306010512', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3097, NULL, '25306010513', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3098, NULL, '25306010514', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3099, NULL, '25306010515', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3100, NULL, '25306010516', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3101, NULL, '25306010517', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3102, NULL, '25306010518', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3103, NULL, '25306010519', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3104, NULL, '25306010520', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3105, NULL, '25306010521', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3106, NULL, '25306010522', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3107, NULL, '25306010523', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3108, NULL, '25306010524', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3109, NULL, '25306010525', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3110, NULL, '25306010526', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3111, NULL, '25306010527', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3112, NULL, '25306010528', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3113, NULL, '25306010529', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3114, NULL, '25306010530', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3115, NULL, '25306010531', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3116, NULL, '25306010532', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3117, NULL, '25306010533', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3118, NULL, '25306010534', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3119, NULL, '25306010535', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3120, NULL, '25306010536', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3121, NULL, '25306010537', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3122, NULL, '25306010601', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3123, NULL, '25306010602', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3124, NULL, '25306010603', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3125, NULL, '25306010604', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3126, NULL, '25306010605', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3127, NULL, '25306010606', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3128, NULL, '25306010607', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3129, NULL, '25306010608', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3130, NULL, '25306010609', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3131, NULL, '25306010610', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3132, NULL, '25306010611', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3133, NULL, '25306010612', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3134, NULL, '25306010613', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3135, NULL, '25306010614', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3136, NULL, '25306010615', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3137, NULL, '25306010616', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3138, NULL, '25306010617', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3139, NULL, '25306010618', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3140, NULL, '25306010619', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3141, NULL, '25306010620', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3142, NULL, '25306010621', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3143, NULL, '25306010622', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3144, NULL, '25306010623', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3145, NULL, '25306010624', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3146, NULL, '25306010625', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3147, NULL, '25306010626', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3148, NULL, '25306010627', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3149, NULL, '25306010628', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3150, NULL, '25306010629', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3151, NULL, '25306010630', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3152, NULL, '25306010631', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3153, NULL, '25306010632', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3154, NULL, '25306010633', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3155, NULL, '25306010634', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3156, NULL, '25306010635', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3157, NULL, '25306010636', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3158, NULL, '25306010637', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3159, NULL, '25306010701', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3160, NULL, '25306010702', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3161, NULL, '25306010703', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3162, NULL, '25306010704', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3163, NULL, '25306010705', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3164, NULL, '25306010706', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3165, NULL, '25306010707', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3166, NULL, '25306010708', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3167, NULL, '25306010709', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3168, NULL, '25306010710', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3169, NULL, '25306010711', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3170, NULL, '25306010712', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3171, NULL, '25306010713', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3172, NULL, '25306010714', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3173, NULL, '25306010715', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3174, NULL, '25306010716', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3175, NULL, '25306010717', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3176, NULL, '25306010718', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3177, NULL, '25306010719', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3178, NULL, '25306010720', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3179, NULL, '25306010721', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3180, NULL, '25306010722', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3181, NULL, '25306010723', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3182, NULL, '25306010724', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3183, NULL, '25306010725', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3184, NULL, '25306010726', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3185, NULL, '25306010727', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3186, NULL, '25306010728', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3187, NULL, '25306010729', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3188, NULL, '25306010730', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3189, NULL, '25306010731', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3190, NULL, '25306010732', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3191, NULL, '25306010733', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3192, NULL, '25306010734', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3193, NULL, '25306010735', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3194, NULL, '25306010736', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3195, NULL, '25306010737', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3196, NULL, '25306010801', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3197, NULL, '25306010802', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3198, NULL, '25306010803', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3199, NULL, '25306010804', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3200, NULL, '25306010805', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3201, NULL, '25306010806', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3202, NULL, '25306010807', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3203, NULL, '25306010808', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3204, NULL, '25306010809', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3205, NULL, '25306010810', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3206, NULL, '25306010811', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3207, NULL, '25306010812', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3208, NULL, '25306010813', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3209, NULL, '25306010814', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3210, NULL, '25306010815', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3211, NULL, '25306010816', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3212, NULL, '25306010817', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3213, NULL, '25306010818', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3214, NULL, '25306010819', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3215, NULL, '25306010820', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3216, NULL, '25306010821', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3217, NULL, '25306010822', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3218, NULL, '25306010823', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3219, NULL, '25306010824', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3220, NULL, '25306010825', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3221, NULL, '25306010826', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3222, NULL, '25306010827', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3223, NULL, '25306010828', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3224, NULL, '25306010829', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3225, NULL, '25306010830', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3226, NULL, '25306010832', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3227, NULL, '25306010833', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3228, NULL, '25306010834', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3229, NULL, '25306010835', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3230, NULL, '25306010836', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3231, NULL, '25306010837', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3232, NULL, '25306060101', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3233, NULL, '25306060102', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3234, NULL, '25306060103', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3235, NULL, '25306060104', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3236, NULL, '25306060105', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3237, NULL, '25306060106', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3238, NULL, '25306060107', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3239, NULL, '25306060108', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3240, NULL, '25306060109', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3241, NULL, '25306060110', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3242, NULL, '25306060111', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3243, NULL, '25306060113', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3244, NULL, '25306060114', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3245, NULL, '25306060115', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3246, NULL, '25306060116', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3247, NULL, '25306060117', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3248, NULL, '25306060118', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3249, NULL, '25306060119', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3250, NULL, '25306060120', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3251, NULL, '25306060121', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3252, NULL, '25306060122', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3253, NULL, '25306060123', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3254, NULL, '25306060124', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3255, NULL, '25306060125', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3256, NULL, '25306060126', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3257, NULL, '25306060127', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3258, NULL, '25306060128', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3259, NULL, '25306060129', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3260, NULL, '25306060130', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3261, NULL, '25306060131', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3262, NULL, '25306060132', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3263, NULL, '25306060133', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3264, NULL, '25306060134', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3265, NULL, '25306060135', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3266, NULL, '25306060136', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3267, NULL, '25306060137', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3268, NULL, '25306060138', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3269, NULL, '25306060139', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3270, NULL, '25306060140', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3271, NULL, '25306060141', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3272, NULL, '25306060143', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3273, NULL, '25306060144', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3274, NULL, '25306060145', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3275, NULL, '25306060146', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3276, NULL, '25306060147', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3277, NULL, '25306060148', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3278, NULL, '25306060149', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (3279, NULL, '25306060150', '未命名', '00', '', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, NULL, '', NULL, '', NULL, NULL, 1);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (2, 100);
INSERT INTO `sys_user_role` VALUES (2, 101);

-- ----------------------------
-- Triggers structure for table achievements_award
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_award`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_award` AFTER INSERT ON `achievements_award` FOR EACH ROW BEGIN
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.award_id,
        NEW.user_id,
        (SELECT user_type FROM sys_user WHERE user_name = NEW.user_id),
        (SELECT type_id FROM achievement_type WHERE type_code = 'award'),
        NEW.award_name,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_competition
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_competition`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_competition` AFTER INSERT ON `achievements_competition` FOR EACH ROW BEGIN
    -- 插入成果基础表
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.competition_id,
        NEW.user_id,
        NEW.user_identity,
        (SELECT type_id FROM achievement_type WHERE type_code = 'competition'),
        NEW.competition_name,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_competition
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_update_achievements_competition`;
delimiter ;;
CREATE TRIGGER `trg_after_update_achievements_competition` AFTER UPDATE ON `achievements_competition` FOR EACH ROW BEGIN
    -- 更新成果基础表
    UPDATE achievements 
    SET 
        title = NEW.competition_name,
        status = NEW.audit_status,
        update_time = NOW(),
        update_by = NEW.user_id
    WHERE id = NEW.competition_id 
      AND achievements_type = (SELECT type_id FROM achievement_type WHERE type_code = 'competition');
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_competition
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_delete_achievements_competition`;
delimiter ;;
CREATE TRIGGER `trg_after_delete_achievements_competition` AFTER DELETE ON `achievements_competition` FOR EACH ROW BEGIN
    -- 删除成果基础表对应记录
    DELETE FROM achievements 
    WHERE id = OLD.competition_id 
      AND achievements_type = (SELECT type_id FROM achievement_type WHERE type_code = 'competition');
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_monograph
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_monograph`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_monograph` AFTER INSERT ON `achievements_monograph` FOR EACH ROW BEGIN
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.monograph_id,
        NEW.user_id,
        (SELECT user_type FROM sys_user WHERE user_name = NEW.user_id),
        (SELECT type_id FROM achievement_type WHERE type_code = 'monograph'),
        NEW.monograph_title,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_paper
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_paper`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_paper` AFTER INSERT ON `achievements_paper` FOR EACH ROW BEGIN
    -- 插入成果基础表
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.paper_id,
        NEW.user_id,
        (SELECT user_type FROM sys_user WHERE user_name = NEW.user_id),
        (SELECT type_id FROM achievement_type WHERE type_code = 'paper'),
        NEW.paper_title,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_patent
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_patent`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_patent` AFTER INSERT ON `achievements_patent` FOR EACH ROW BEGIN
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.patent_id,
        NEW.user_id,
        NEW.user_identity,
        (SELECT type_id FROM achievement_type WHERE type_code = 'patent'),
        NEW.patent_name,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_research
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_research`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_research` AFTER INSERT ON `achievements_research` FOR EACH ROW BEGIN
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.research_id,
        NEW.user_id,
        (SELECT user_type FROM sys_user WHERE user_name = NEW.user_id),
        (SELECT type_id FROM achievement_type WHERE type_code = 'research'),
        NEW.project_name,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_software
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_software`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_software` AFTER INSERT ON `achievements_software` FOR EACH ROW BEGIN
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.software_id,
        NEW.user_id,
        NEW.user_identity,
        (SELECT type_id FROM achievement_type WHERE type_code = 'software'),
        NEW.software_name,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_textbook
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_textbook`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_textbook` AFTER INSERT ON `achievements_textbook` FOR EACH ROW BEGIN
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.textbook_id,
        NEW.user_id,
        (SELECT user_type FROM sys_user WHERE user_name = NEW.user_id),
        (SELECT type_id FROM achievement_type WHERE type_code = 'textbook'),
        NEW.textbook_name,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table achievements_transfer
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_after_insert_achievements_transfer`;
delimiter ;;
CREATE TRIGGER `trg_after_insert_achievements_transfer` AFTER INSERT ON `achievements_transfer` FOR EACH ROW BEGIN
    INSERT INTO achievements (
        id,
        user_id,
        user_identity,
        achievements_type,
        title,
        status,
        submit_time,
        create_by,
        create_time
    )
    VALUES (
        NEW.transfer_id,
        NEW.user_id,
        (SELECT user_type FROM sys_user WHERE user_name = NEW.user_id),
        (SELECT type_id FROM achievement_type WHERE type_code = 'transfer'),
        NEW.achievement_name,
        NEW.audit_status,
        NEW.created_at,
        NEW.user_id,
        NEW.created_at
    );
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
