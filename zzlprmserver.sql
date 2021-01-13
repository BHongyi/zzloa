/*
Navicat MySQL Data Transfer

Source Server         : zzldb
Source Server Version : 80021
Source Host           : localhost:3306
Source Database       : zzlprmserver

Target Server Type    : MYSQL
Target Server Version : 80021
File Encoding         : 65001

Date: 2021-01-13 13:34:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for authtoken_token
-- ----------------------------
DROP TABLE IF EXISTS `authtoken_token`;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of authtoken_token
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `positiontype` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-01-12 05:00:02.571006', '1', 'admin', '', '', 'zzl@qq.com', '1', '1', '2020-12-18 06:28:27.497579', '管理员', '123', '0000-00-00 00:00:00', '2020-12-31 13:57:57', '1');
INSERT INTO `auth_user` VALUES ('13', 'pbkdf2_sha256$180000$vHoU1GZsCAFe$5fCzaZykUipQ1eGDYlP8s3CkjKKr57foVXtFI/UMPQc=', null, '0', 'lp', null, null, 'lp@qq.com', null, '1', null, '李鹏', '13900001234', '2021-01-12 07:42:39', '2021-01-12 07:42:39', '3');
INSERT INTO `auth_user` VALUES ('14', 'pbkdf2_sha256$180000$BeC9JQs044uk$AhqRfYJGSl3n5+JfrOCH5AmSxu84T/pD5LW3NqnE0t4=', null, '0', 'ly', null, null, 'ly@qq.com', null, '1', null, '李杨', '13500000000', '2021-01-12 07:43:19', '2021-01-12 07:43:19', '3');
INSERT INTO `auth_user` VALUES ('15', 'pbkdf2_sha256$180000$9t3qGkrux4Sd$LXAsIVly+OFQP6r897RbOzJ/Zdu7OkXRgFX7DQxwmG0=', null, '0', 'zzh', null, null, 'zzh@qq.com', null, '1', null, '郑镇洪', '15800000000', '2021-01-12 07:44:00', '2021-01-12 07:44:00', '1');
INSERT INTO `auth_user` VALUES ('16', 'pbkdf2_sha256$180000$jdRZHyhldQPd$i3dETVZMN58Si/rYjTApxXUZiWWGYObgLxV4xnIOZVc=', null, '0', 'zrr', null, null, 'zrr@qq.com', null, '1', null, '张蕊蕊', '15600000000', '2021-01-12 07:44:33', '2021-01-12 07:44:33', '1');
INSERT INTO `auth_user` VALUES ('18', 'pbkdf2_sha256$180000$9oWyF3ClnXwR$CMHoEC2jGX/AlK6Yj9j3Do0+fp09ODFaDmpnirhYzQk=', null, '0', 'zgm', null, null, 'zgm@qq.com', null, '1', null, '张国茂', '13600000000', '2021-01-12 07:46:05', '2021-01-12 07:46:05', '3');
INSERT INTO `auth_user` VALUES ('19', 'pbkdf2_sha256$180000$pAjJ8dt1APNu$ZrpsfurpmRy1ZbsyUt09tBgLJ/wGtzQ4hz9tUEWsL/s=', null, '0', 'wyx', null, null, 'wyx@qq.com', null, '1', null, '王玉新', '15600000000', '2021-01-12 07:46:38', '2021-01-12 07:46:38', '1');
INSERT INTO `auth_user` VALUES ('20', 'pbkdf2_sha256$180000$pOyjX1wtZqMf$BiAOj6K0+23xWfkU6icZS+JJuQZZOSsMGHWwSGD/QmQ=', null, '0', 'lgh', null, null, 'lgh@qq.com', null, '1', null, '卢国宏', '13560000000', '2021-01-12 07:47:21', '2021-01-12 07:47:21', '3');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for tb_dailypaper
-- ----------------------------
DROP TABLE IF EXISTS `tb_dailypaper`;
CREATE TABLE `tb_dailypaper` (
  `dailypaperid` int NOT NULL AUTO_INCREMENT,
  `userid` int NOT NULL,
  `dailypaperdate` datetime NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`dailypaperid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_dailypaper
-- ----------------------------
INSERT INTO `tb_dailypaper` VALUES ('36', '15', '2021-01-12 00:00:00', '2021-01-12 07:59:24', '2021-01-12 07:59:24');
INSERT INTO `tb_dailypaper` VALUES ('37', '15', '2021-01-11 00:00:00', '2021-01-12 08:00:05', '2021-01-12 08:00:05');

-- ----------------------------
-- Table structure for tb_dailypaperdetail
-- ----------------------------
DROP TABLE IF EXISTS `tb_dailypaperdetail`;
CREATE TABLE `tb_dailypaperdetail` (
  `dailypaperdetailid` int NOT NULL AUTO_INCREMENT,
  `dailypaperid` int NOT NULL,
  `projectscheduleid` int DEFAULT NULL,
  `worktime` float NOT NULL,
  `workcontent` varchar(1000) NOT NULL,
  PRIMARY KEY (`dailypaperdetailid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_dailypaperdetail
-- ----------------------------
INSERT INTO `tb_dailypaperdetail` VALUES ('36', '36', '18', '8', '系统部署及初始化');
INSERT INTO `tb_dailypaperdetail` VALUES ('37', '37', '18', '8', '表单基础验证');

-- ----------------------------
-- Table structure for tb_dailypaper_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_dailypaper_user`;
CREATE TABLE `tb_dailypaper_user` (
  `dailypaper_user_id` int NOT NULL AUTO_INCREMENT,
  `dailypaperid` int NOT NULL,
  `userid` int NOT NULL,
  `isread` int NOT NULL,
  `readtime` datetime DEFAULT NULL,
  PRIMARY KEY (`dailypaper_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_dailypaper_user
-- ----------------------------
INSERT INTO `tb_dailypaper_user` VALUES ('44', '36', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('45', '36', '13', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('46', '37', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('47', '37', '13', '1', '2021-01-13 02:11:56');

-- ----------------------------
-- Table structure for tb_dict
-- ----------------------------
DROP TABLE IF EXISTS `tb_dict`;
CREATE TABLE `tb_dict` (
  `dictid` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL,
  `typeid` int NOT NULL,
  `typename` varchar(50) NOT NULL,
  PRIMARY KEY (`dictid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_dict
-- ----------------------------
INSERT INTO `tb_dict` VALUES ('1', '1', '1', '自研项目');
INSERT INTO `tb_dict` VALUES ('2', '1', '2', '外包项目');
INSERT INTO `tb_dict` VALUES ('3', '2', '1', '开发岗');
INSERT INTO `tb_dict` VALUES ('4', '2', '2', '销售岗');
INSERT INTO `tb_dict` VALUES ('5', '2', '3', '管理岗');
INSERT INTO `tb_dict` VALUES ('6', '2', '0', '其他岗');

-- ----------------------------
-- Table structure for tb_group
-- ----------------------------
DROP TABLE IF EXISTS `tb_group`;
CREATE TABLE `tb_group` (
  `groupid` int NOT NULL AUTO_INCREMENT,
  `parentid` int DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  PRIMARY KEY (`groupid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('1', '0', '中智联', '2020-12-21 16:26:15.000000', '2020-12-22 10:01:58.965286');
INSERT INTO `tb_group` VALUES ('12', '1', '总经理室', '2021-01-12 07:48:18.858672', '2021-01-12 07:48:18.858666');
INSERT INTO `tb_group` VALUES ('13', '12', '研发一部', '2021-01-12 07:48:37.736017', '2021-01-12 07:48:37.736010');
INSERT INTO `tb_group` VALUES ('14', '12', '研发二部', '2021-01-12 07:48:46.270383', '2021-01-12 07:48:46.270376');
INSERT INTO `tb_group` VALUES ('15', '12', '行政部门', '2021-01-12 07:48:56.720445', '2021-01-12 07:48:56.720439');

-- ----------------------------
-- Table structure for tb_group_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_group_user`;
CREATE TABLE `tb_group_user` (
  `group_user_id` int NOT NULL AUTO_INCREMENT,
  `userid` int NOT NULL,
  `groupid` int NOT NULL,
  `ismanager` int NOT NULL,
  PRIMARY KEY (`group_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_group_user
-- ----------------------------
INSERT INTO `tb_group_user` VALUES ('40', '14', '12', '1');
INSERT INTO `tb_group_user` VALUES ('41', '13', '13', '1');
INSERT INTO `tb_group_user` VALUES ('42', '15', '13', '0');
INSERT INTO `tb_group_user` VALUES ('43', '16', '13', '0');
INSERT INTO `tb_group_user` VALUES ('44', '18', '14', '1');
INSERT INTO `tb_group_user` VALUES ('45', '19', '14', '0');
INSERT INTO `tb_group_user` VALUES ('46', '20', '15', '1');

-- ----------------------------
-- Table structure for tb_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_permission`;
CREATE TABLE `tb_permission` (
  `permissionid` int NOT NULL AUTO_INCREMENT,
  `parentid` int DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  PRIMARY KEY (`permissionid`),
  UNIQUE KEY `uniq_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_permission
-- ----------------------------
INSERT INTO `tb_permission` VALUES ('1', '0', '根', '000000');
INSERT INTO `tb_permission` VALUES ('2', '1', '用户管理', '000001');
INSERT INTO `tb_permission` VALUES ('3', '2', '新建用户', '000002');
INSERT INTO `tb_permission` VALUES ('4', '2', '删除用户', '000003');
INSERT INTO `tb_permission` VALUES ('5', '2', '修改用户', '000004');
INSERT INTO `tb_permission` VALUES ('6', '2', '查看用户', '000005');
INSERT INTO `tb_permission` VALUES ('7', '1', '部门管理', '000006');
INSERT INTO `tb_permission` VALUES ('8', '7', '新建部门', '000007');
INSERT INTO `tb_permission` VALUES ('9', '7', '删除部门', '000008');
INSERT INTO `tb_permission` VALUES ('16', '7', '修改部门', '000009');
INSERT INTO `tb_permission` VALUES ('17', '7', '查看部门', '000010');
INSERT INTO `tb_permission` VALUES ('18', '1', '权限管理', '000011');
INSERT INTO `tb_permission` VALUES ('19', '18', '新建权限', '000012');
INSERT INTO `tb_permission` VALUES ('20', '18', '删除权限', '000013');
INSERT INTO `tb_permission` VALUES ('21', '18', '修改权限', '000014');
INSERT INTO `tb_permission` VALUES ('22', '18', '查看权限', '000015');
INSERT INTO `tb_permission` VALUES ('26', '1', '角色管理', '000016');
INSERT INTO `tb_permission` VALUES ('27', '26', '新建角色', '000017');
INSERT INTO `tb_permission` VALUES ('29', '26', '删除角色', '000018');
INSERT INTO `tb_permission` VALUES ('30', '26', '修改角色', '000019');
INSERT INTO `tb_permission` VALUES ('31', '26', '查看角色', '000020');
INSERT INTO `tb_permission` VALUES ('32', '1', '项目管理', '000021');
INSERT INTO `tb_permission` VALUES ('33', '32', '新建项目', '000022');
INSERT INTO `tb_permission` VALUES ('34', '32', '删除项目', '000023');
INSERT INTO `tb_permission` VALUES ('35', '32', '修改项目', '000024');
INSERT INTO `tb_permission` VALUES ('36', '32', '查看项目', '000025');

-- ----------------------------
-- Table structure for tb_project
-- ----------------------------
DROP TABLE IF EXISTS `tb_project`;
CREATE TABLE `tb_project` (
  `projectid` int NOT NULL AUTO_INCREMENT,
  `projectname` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `typeid` int NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`projectid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_project
-- ----------------------------
INSERT INTO `tb_project` VALUES ('19', '对日docker项目', '.netcore+vue+docker', '2', '2021-01-12 07:53:17', '2021-01-12 07:53:17');
INSERT INTO `tb_project` VALUES ('20', '项目管理系统', 'crm+prm', '1', '2021-01-12 07:56:52', '2021-01-12 07:56:52');

-- ----------------------------
-- Table structure for tb_projectschedule
-- ----------------------------
DROP TABLE IF EXISTS `tb_projectschedule`;
CREATE TABLE `tb_projectschedule` (
  `projectscheduleid` int NOT NULL AUTO_INCREMENT,
  `projectid` int NOT NULL,
  `schedulename` varchar(50) NOT NULL,
  `scheduledescription` varchar(255) DEFAULT NULL,
  `groupid` int NOT NULL,
  `preworkload` int NOT NULL,
  `realworkload` int DEFAULT NULL,
  `schedulestartdate` datetime NOT NULL,
  `schedulefinishdate` datetime NOT NULL,
  `schedulerealstartdate` datetime DEFAULT NULL,
  `schedulerealfinishdate` datetime DEFAULT NULL,
  `isfinished` int NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`projectscheduleid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_projectschedule
-- ----------------------------
INSERT INTO `tb_projectschedule` VALUES ('17', '19', '开发阶段', '开发及部署', '13', '30', '60', '2020-09-07 00:00:00', '2020-12-15 00:00:00', '2020-09-07 00:00:00', '2020-12-15 00:00:00', '1', '2021-01-12 07:54:39', '2021-01-12 07:55:40');
INSERT INTO `tb_projectschedule` VALUES ('18', '20', '设计-开发', '基础后台管理+日报填写+项目管理', '13', '30', null, '2020-12-22 00:00:00', '2021-02-15 00:00:00', null, null, '0', '2021-01-12 07:58:19', '2021-01-12 07:58:19');

-- ----------------------------
-- Table structure for tb_projectschedule_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_projectschedule_user`;
CREATE TABLE `tb_projectschedule_user` (
  `projectschedule_user_id` int NOT NULL AUTO_INCREMENT,
  `projectscheduleid` int NOT NULL,
  `userid` int NOT NULL,
  `ismanager` int NOT NULL,
  PRIMARY KEY (`projectschedule_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_projectschedule_user
-- ----------------------------
INSERT INTO `tb_projectschedule_user` VALUES ('84', '17', '13', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('85', '17', '15', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('86', '17', '16', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('87', '18', '13', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('88', '18', '15', '0');

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role` (
  `roleid` int NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES ('1', '管理员', '2020-12-23 08:53:20', '2020-12-23 08:53:24');
INSERT INTO `tb_role` VALUES ('7', '项目经理', '2021-01-12 07:51:29', '2021-01-12 07:51:29');

-- ----------------------------
-- Table structure for tb_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_permission`;
CREATE TABLE `tb_role_permission` (
  `role_permission_id` int NOT NULL AUTO_INCREMENT,
  `roleid` int NOT NULL,
  `permissionid` int NOT NULL,
  PRIMARY KEY (`role_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_role_permission
-- ----------------------------
INSERT INTO `tb_role_permission` VALUES ('1', '1', '1');
INSERT INTO `tb_role_permission` VALUES ('2', '1', '2');
INSERT INTO `tb_role_permission` VALUES ('3', '1', '3');
INSERT INTO `tb_role_permission` VALUES ('4', '1', '4');
INSERT INTO `tb_role_permission` VALUES ('5', '1', '5');
INSERT INTO `tb_role_permission` VALUES ('6', '1', '6');
INSERT INTO `tb_role_permission` VALUES ('7', '1', '7');
INSERT INTO `tb_role_permission` VALUES ('8', '1', '8');
INSERT INTO `tb_role_permission` VALUES ('9', '1', '9');
INSERT INTO `tb_role_permission` VALUES ('10', '1', '16');
INSERT INTO `tb_role_permission` VALUES ('11', '1', '17');
INSERT INTO `tb_role_permission` VALUES ('12', '1', '18');
INSERT INTO `tb_role_permission` VALUES ('13', '1', '19');
INSERT INTO `tb_role_permission` VALUES ('14', '1', '20');
INSERT INTO `tb_role_permission` VALUES ('15', '1', '21');
INSERT INTO `tb_role_permission` VALUES ('16', '1', '22');
INSERT INTO `tb_role_permission` VALUES ('17', '1', '26');
INSERT INTO `tb_role_permission` VALUES ('18', '1', '27');
INSERT INTO `tb_role_permission` VALUES ('19', '1', '29');
INSERT INTO `tb_role_permission` VALUES ('20', '1', '30');
INSERT INTO `tb_role_permission` VALUES ('21', '1', '31');
INSERT INTO `tb_role_permission` VALUES ('22', '1', '32');
INSERT INTO `tb_role_permission` VALUES ('23', '1', '33');
INSERT INTO `tb_role_permission` VALUES ('24', '1', '34');
INSERT INTO `tb_role_permission` VALUES ('25', '1', '35');
INSERT INTO `tb_role_permission` VALUES ('26', '1', '36');
INSERT INTO `tb_role_permission` VALUES ('452', '7', '32');
INSERT INTO `tb_role_permission` VALUES ('453', '7', '33');
INSERT INTO `tb_role_permission` VALUES ('454', '7', '34');
INSERT INTO `tb_role_permission` VALUES ('455', '7', '35');
INSERT INTO `tb_role_permission` VALUES ('456', '7', '36');

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role` (
  `user_role_id` int NOT NULL AUTO_INCREMENT,
  `userid` int NOT NULL,
  `roleid` int NOT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES ('9', '1', '1');
INSERT INTO `tb_user_role` VALUES ('11', '20', '7');
INSERT INTO `tb_user_role` VALUES ('12', '18', '7');
INSERT INTO `tb_user_role` VALUES ('13', '14', '7');
INSERT INTO `tb_user_role` VALUES ('14', '13', '7');

-- ----------------------------
-- Procedure structure for getManagerList
-- ----------------------------
DROP PROCEDURE IF EXISTS `getManagerList`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getManagerList`(uid int)
begin
DECLARE tmp_groupid INT DEFAULT 0;
DECLARE _done INT DEFAULT FALSE;
DECLARE fid INT;  
DECLARE t_index CURSOR FOR SELECT groupid from tb_group_user where userid = uid;
DECLARE CONTINUE HANDLER for not FOUND set _done=true;

drop temporary table if exists ss;
create temporary table groupids(groupid INT);

OPEN t_index;
REPEAT
FETCH t_index INTO tmp_groupid;
 if not _done then 

WHILE tmp_groupid is not null  do   
		insert into groupids value(tmp_groupid);
    SET fid =(SELECT parentid FROM tb_group WHERE groupid = tmp_groupid);   
    IF fid is not null THEN   
        insert into groupids value(fid);
        SET tmp_groupid = fid;   
    ELSE   
        SET tmp_groupid = fid;   
    END IF;   
END WHILE; 

 end if;

UNTIL _done END REPEAT;
CLOSE t_index;

select tb_group_user.userid from (
select DISTINCT(groupid) from groupids) a
LEFT JOIN tb_group_user
on a.groupid = tb_group_user.groupid
where ismanager = 1;
end
;;
DELIMITER ;
