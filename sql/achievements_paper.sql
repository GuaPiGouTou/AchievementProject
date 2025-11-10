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

 Date: 05/11/2025 12:54:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for achievements_paper
-- ----------------------------
DROP TABLE IF EXISTS `achievements_paper`;
CREATE TABLE `achievements_paper`  (
  `achievements_id` bigint NOT NULL COMMENT '关联成果基础表ID',
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
  `paper_file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '论文文件路径',
  `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `file_size` bigint NULL DEFAULT NULL COMMENT '文件大小',
  `audit_status` enum('通过','驳回','待审核') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`achievements_id`) USING BTREE,
  INDEX `idx_achievements_id`(`achievements_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_publish_date`(`publish_date` ASC) USING BTREE,
  INDEX `idx_journal`(`journal` ASC) USING BTREE,
  CONSTRAINT `fk_paper_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '论文成果表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
