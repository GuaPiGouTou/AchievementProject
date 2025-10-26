/*
MySQL Data Transfer
Source Host: localhost
Source Database: students_teacher
Target Host: localhost
Target Database: students_teacher
Date: 2025/10/26 17:54:43
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for student_account
-- ----------------------------
DROP TABLE IF EXISTS `student_account`;
CREATE TABLE `student_account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL COMMENT '关联学生ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登录账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '密码',
  `account_status` tinyint DEFAULT '1' COMMENT '账号状态(1:正常,0:禁用)',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_username` (`username`),
  KEY `idx_status` (`account_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生账号表';

-- ----------------------------
-- Table structure for student_info
-- ----------------------------
DROP TABLE IF EXISTS `student_info`;
CREATE TABLE `student_info` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `student_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '学号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
  `gender` enum('男','女','其他') DEFAULT NULL COMMENT '性别',
  `grade` varchar(20) DEFAULT NULL COMMENT '年级',
  `department` varchar(50) DEFAULT NULL COMMENT '院系',
  `major` varchar(100) DEFAULT NULL COMMENT '专业',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `id_card` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像URL',
  `birth_date` date DEFAULT NULL COMMENT '出生日期',
  `enrollment_date` date DEFAULT NULL COMMENT '入学日期',
  `address` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `student_no` (`student_no`),
  KEY `idx_student_no` (`student_no`),
  KEY `idx_department_major` (`department`,`major`),
  KEY `idx_grade` (`grade`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生信息表';

-- ----------------------------
-- Table structure for teacher_account
-- ----------------------------
DROP TABLE IF EXISTS `teacher_account`;
CREATE TABLE `teacher_account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NOT NULL COMMENT '关联教师ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登录账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '密码',
  `account_status` tinyint DEFAULT '1' COMMENT '账号状态(1:正常,0:禁用)',
  `role_type` enum('普通教师','系主任','院长','管理员') DEFAULT '普通教师' COMMENT '角色类型',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `password_updated_at` timestamp NULL DEFAULT NULL COMMENT '密码最后修改时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_username` (`username`),
  KEY `idx_status_role` (`account_status`,`role_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教师账号表';

-- ----------------------------
-- Table structure for teacher_info
-- ----------------------------
DROP TABLE IF EXISTS `teacher_info`;
CREATE TABLE `teacher_info` (
  `teacher_id` int NOT NULL AUTO_INCREMENT,
  `teacher_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '教师工号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
  `gender` enum('男','女','其他') DEFAULT NULL COMMENT '性别',
  `title` varchar(50) DEFAULT NULL COMMENT '职称(教授/副教授/讲师等)',
  `department` varchar(50) DEFAULT NULL COMMENT '所属院系',
  `research_direction` varchar(255) DEFAULT NULL COMMENT '研究方向',
  `phone` varchar(20) DEFAULT NULL COMMENT '办公电话',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `office_location` varchar(100) DEFAULT NULL COMMENT '办公室位置',
  `id_card` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像URL',
  `birth_date` date DEFAULT NULL COMMENT '出生日期',
  `hire_date` date DEFAULT NULL COMMENT '入职日期',
  `education_background` text COMMENT '教育背景',
  `work_experience` text COMMENT '工作经历',
  `academic_achievements` text COMMENT '学术成果概述',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `teacher_no` (`teacher_no`),
  KEY `idx_teacher_no` (`teacher_no`),
  KEY `idx_department_title` (`department`,`title`),
  KEY `idx_name` (`name`),
  KEY `idx_research` (`research_direction`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教师信息表';

-- ----------------------------
-- Records 
-- ----------------------------
