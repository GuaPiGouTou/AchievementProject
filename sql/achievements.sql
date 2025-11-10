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

 Date: 05/11/2025 12:54:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for achievements
-- ----------------------------
DROP TABLE IF EXISTS `achievements`;
CREATE TABLE `achievements`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `achievements_id` bigint NOT NULL COMMENT '子表id',
  `user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID（关联sys_user）',
  `user_identity` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户身份(0学生 1教师)',
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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_user_identity`(`user_identity` ASC) USING BTREE,
  INDEX `idx_achievements_type`(`achievements_type` ASC, `status` ASC) USING BTREE,
  INDEX `fk_achievements_id`(`achievements_id` ASC) USING BTREE,
  CONSTRAINT `fk_achievements_type` FOREIGN KEY (`achievements_type`) REFERENCES `achievement_type` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_achievements_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_achievements_id` FOREIGN KEY (`achievements_id`) REFERENCES `achievements_paper` (`achievements_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
