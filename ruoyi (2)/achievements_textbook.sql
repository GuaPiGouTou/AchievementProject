/*
 Navicat Premium Dump SQL

 Source Server         : bd
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 14/11/2025 16:41:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for achievements_textbook
-- ----------------------------
DROP TABLE IF EXISTS `achievements_textbook`;
CREATE TABLE `achievements_textbook`  (
  `textbook_id` bigint(20) NOT NULL COMMENT '教材id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `textbook_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '教材名称',
  `author_role` enum('主编','副主编','参编','独著') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作者角色',
  `press_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出版社',
  `isbn_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ISBN号',
  `publish_date` date NOT NULL COMMENT '出版时间',
  `textbook_type` enum('规划教材','校本教材','国家级规划','省部级规划','行业规划') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '教材类型',
  `edition` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版次',
  `word_count` int(11) NULL DEFAULT NULL COMMENT '字数（万字）',
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
  INDEX `idx_publish_date`(`publish_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教材著作表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of achievements_textbook
-- ----------------------------
INSERT INTO `achievements_textbook` VALUES (1001, 24306010534, NULL, '人工智能导论', '主编', '高等教育出版社', '978-7-04-060000-1', '2024-05-20', '规划教材', '第一版', NULL, NULL, NULL, '本科', NULL, '待审核', '2025-11-07 10:53:26', '2025-11-07 10:53:26');

SET FOREIGN_KEY_CHECKS = 1;
