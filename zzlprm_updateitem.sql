/*
Navicat MySQL Data Transfer

Source Server         : replusDriver
Source Server Version : 50505
Source Host           : 192.168.127.2:3306
Source Database       : zzlprm

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2021-01-27 17:27:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `positiontype` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-01-27 17:05:12.299921', '1', 'admin', '', '', 'zzl@qq.com', '1', '1', '2020-12-18 06:28:27.497579', '管理员', '123', '0000-00-00 00:00:00', '2021-01-27 15:45:02', '1');
INSERT INTO `auth_user` VALUES ('13', 'pbkdf2_sha256$180000$vHoU1GZsCAFe$5fCzaZykUipQ1eGDYlP8s3CkjKKr57foVXtFI/UMPQc=', '2021-01-27 17:02:34.575708', '0', 'lp', null, null, 'lp@qq.com', null, '1', null, '李鹏', '13900001234', '2021-01-12 07:42:39', '2021-01-27 15:45:40', '1');
INSERT INTO `auth_user` VALUES ('14', 'pbkdf2_sha256$180000$BeC9JQs044uk$AhqRfYJGSl3n5+JfrOCH5AmSxu84T/pD5LW3NqnE0t4=', '2021-01-27 15:47:12.135434', '0', 'ly', null, null, 'ly@qq.com', null, '1', null, '李杨', '13500000000', '2021-01-12 07:43:19', '2021-01-27 15:45:31', '1');
INSERT INTO `auth_user` VALUES ('15', 'pbkdf2_sha256$180000$9t3qGkrux4Sd$LXAsIVly+OFQP6r897RbOzJ/Zdu7OkXRgFX7DQxwmG0=', '2021-01-27 16:59:17.505968', '0', 'zzh', null, null, 'zzh@qq.com', null, '1', null, '郑镇洪', '15800000000', '2021-01-12 07:44:00', '2021-01-12 07:44:00', '1');
INSERT INTO `auth_user` VALUES ('18', 'pbkdf2_sha256$180000$9oWyF3ClnXwR$CMHoEC2jGX/AlK6Yj9j3Do0+fp09ODFaDmpnirhYzQk=', null, '0', 'zgm', null, null, 'zgm@qq.com', null, '1', null, '张国茂', '13600000000', '2021-01-12 07:46:05', '2021-01-27 15:45:25', '1');
INSERT INTO `auth_user` VALUES ('19', 'pbkdf2_sha256$180000$pAjJ8dt1APNu$ZrpsfurpmRy1ZbsyUt09tBgLJ/wGtzQ4hz9tUEWsL/s=', null, '0', 'wyx', null, null, 'wyx@qq.com', null, '1', null, '王玉鑫', '15600000000', '2021-01-12 07:46:38', '2021-01-13 15:14:09', '1');
INSERT INTO `auth_user` VALUES ('20', 'pbkdf2_sha256$180000$pOyjX1wtZqMf$BiAOj6K0+23xWfkU6icZS+JJuQZZOSsMGHWwSGD/QmQ=', '2021-01-27 15:00:52.833445', '0', 'lgh', null, null, 'lgh@qq.com', null, '1', null, '卢国宏', '13560000000', '2021-01-12 07:47:21', '2021-01-27 15:45:17', '1');
INSERT INTO `auth_user` VALUES ('21', 'pbkdf2_sha256$180000$ERZ3LS7BmZI3$GbVIX7YidVRyVsR5iaH55FCqJqBQBERPY1VZC5ZusPI=', '2021-01-27 14:52:05.081855', '0', 'xszg', null, null, 'qq@qq.com', null, '1', null, '销售主管', '18612341234', '2021-01-21 08:58:50', '2021-01-27 15:45:09', '2');
INSERT INTO `auth_user` VALUES ('22', 'pbkdf2_sha256$180000$ZXkypopHpZnN$dM4Veqvo4Xp71uZSJVtqfsPWVhffUaVzsjIcwu9FyVg=', '2021-01-27 17:00:05.149514', '0', 'xsyg', null, null, 'qq@qq.com', null, '1', null, '销售员工', '18612341861234', '2021-01-21 08:59:18', '2021-01-21 08:59:18', '2');
INSERT INTO `auth_user` VALUES ('23', 'pbkdf2_sha256$180000$i4fFVUY0mpbS$BuuZW1bJTdBZ2ndT7AyO76ecX+wg42C4hpsA7eu2uEk=', null, '0', 'zrr', null, null, '66333', null, '1', null, '张瑞蕊', '135', '2021-01-25 10:24:41', '2021-01-25 10:24:41', '1');
INSERT INTO `auth_user` VALUES ('24', 'pbkdf2_sha256$180000$bq6TP3blcz9C$m//3phDz6xP99182EaPtCUoD8dvinEifclU4n9N3d0Q=', '2021-01-27 14:51:04.376761', '0', 'lzcs', null, null, '123123', null, '1', null, '离职测试员工', '123123', '2021-01-27 14:46:21', '2021-01-27 14:46:31', '1');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for authtoken_token
-- ----------------------------
DROP TABLE IF EXISTS `authtoken_token`;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authtoken_token
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for tb_business
-- ----------------------------
DROP TABLE IF EXISTS `tb_business`;
CREATE TABLE `tb_business` (
  `businessid` int(11) NOT NULL AUTO_INCREMENT,
  `businessname` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `possibility` float DEFAULT NULL,
  `budget` decimal(10,2) DEFAULT NULL,
  `lossreason` varchar(200) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `writer` int(11) NOT NULL,
  `finishtime` datetime DEFAULT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `isdeleted` int(11) NOT NULL,
  PRIMARY KEY (`businessid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business
-- ----------------------------
INSERT INTO `tb_business` VALUES ('12', '搭建平台', '1', '', '50', '500.00', null, '21', '21', null, '2021-01-21 09:09:03', '2021-01-21 09:09:42', '0');
INSERT INTO `tb_business` VALUES ('13', '测试商机', '2', '', null, null, '111', null, '21', '2021-01-22 16:08:42', '2021-01-22 13:18:31', '2021-01-22 16:08:53', '0');
INSERT INTO `tb_business` VALUES ('14', '测试商机记录', '1', '', null, null, null, '21', '21', null, '2021-01-22 16:09:25', '2021-01-22 16:09:36', '0');
INSERT INTO `tb_business` VALUES ('15', '1111', '5', '123', '1', '55.00', '333', '21', '21', '2021-01-25 12:41:25', '2021-01-25 12:39:44', '2021-01-25 12:41:25', '0');
INSERT INTO `tb_business` VALUES ('16', '软删除测试', '1', '', null, null, null, '1', '1', null, '2021-01-27 14:58:02', '2021-01-27 14:59:35', '1');

-- ----------------------------
-- Table structure for tb_business_client
-- ----------------------------
DROP TABLE IF EXISTS `tb_business_client`;
CREATE TABLE `tb_business_client` (
  `business_client_id` int(11) NOT NULL AUTO_INCREMENT,
  `businessid` int(11) NOT NULL,
  `clientid` int(11) NOT NULL,
  `ismanager` int(11) NOT NULL,
  PRIMARY KEY (`business_client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_client
-- ----------------------------
INSERT INTO `tb_business_client` VALUES ('28', '12', '8', '0');
INSERT INTO `tb_business_client` VALUES ('32', '13', '9', '0');
INSERT INTO `tb_business_client` VALUES ('33', '14', '9', '0');
INSERT INTO `tb_business_client` VALUES ('35', '16', '10', '0');

-- ----------------------------
-- Table structure for tb_business_contact
-- ----------------------------
DROP TABLE IF EXISTS `tb_business_contact`;
CREATE TABLE `tb_business_contact` (
  `business_contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `businessid` int(11) NOT NULL,
  `contactid` int(11) NOT NULL,
  `ismanager` int(11) NOT NULL,
  PRIMARY KEY (`business_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_contact
-- ----------------------------
INSERT INTO `tb_business_contact` VALUES ('30', '12', '6', '0');
INSERT INTO `tb_business_contact` VALUES ('34', '13', '7', '0');
INSERT INTO `tb_business_contact` VALUES ('35', '14', '7', '0');
INSERT INTO `tb_business_contact` VALUES ('37', '16', '9', '0');

-- ----------------------------
-- Table structure for tb_business_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_business_user`;
CREATE TABLE `tb_business_user` (
  `business_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `businessid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `ismanager` int(11) NOT NULL,
  PRIMARY KEY (`business_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_user
-- ----------------------------
INSERT INTO `tb_business_user` VALUES ('32', '12', '21', '1');
INSERT INTO `tb_business_user` VALUES ('33', '12', '22', '0');
INSERT INTO `tb_business_user` VALUES ('34', '15', '20', '1');
INSERT INTO `tb_business_user` VALUES ('35', '15', '18', '0');
INSERT INTO `tb_business_user` VALUES ('36', '15', '19', '0');
INSERT INTO `tb_business_user` VALUES ('39', '16', '20', '1');
INSERT INTO `tb_business_user` VALUES ('40', '16', '24', '0');
INSERT INTO `tb_business_user` VALUES ('41', '16', '22', '0');

-- ----------------------------
-- Table structure for tb_businessrecord
-- ----------------------------
DROP TABLE IF EXISTS `tb_businessrecord`;
CREATE TABLE `tb_businessrecord` (
  `businessrecordid` int(11) NOT NULL AUTO_INCREMENT,
  `businessid` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `createtime` datetime NOT NULL,
  PRIMARY KEY (`businessrecordid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_businessrecord
-- ----------------------------
INSERT INTO `tb_businessrecord` VALUES ('10', '13', '2', '21', '2021-01-22 16:08:19');
INSERT INTO `tb_businessrecord` VALUES ('11', '13', '3', '21', '2021-01-22 16:08:31');
INSERT INTO `tb_businessrecord` VALUES ('12', '13', '5', '21', '2021-01-22 16:08:42');
INSERT INTO `tb_businessrecord` VALUES ('13', '13', '2', '21', '2021-01-22 16:08:53');
INSERT INTO `tb_businessrecord` VALUES ('14', '14', '1', '21', '2021-01-22 16:09:25');
INSERT INTO `tb_businessrecord` VALUES ('15', '15', '2', '21', '2021-01-25 12:39:44');
INSERT INTO `tb_businessrecord` VALUES ('16', '15', '3', '21', '2021-01-25 12:39:57');
INSERT INTO `tb_businessrecord` VALUES ('17', '15', '4', '21', '2021-01-25 12:40:26');
INSERT INTO `tb_businessrecord` VALUES ('18', '15', '4', '21', '2021-01-25 12:40:37');
INSERT INTO `tb_businessrecord` VALUES ('19', '15', '5', '21', '2021-01-25 12:41:25');
INSERT INTO `tb_businessrecord` VALUES ('20', '16', '1', '1', '2021-01-27 14:58:02');

-- ----------------------------
-- Table structure for tb_client
-- ----------------------------
DROP TABLE IF EXISTS `tb_client`;
CREATE TABLE `tb_client` (
  `clientid` int(11) NOT NULL AUTO_INCREMENT,
  `companyname` varchar(100) NOT NULL,
  `clienttype` int(11) NOT NULL,
  `staff` int(11) NOT NULL COMMENT '我方代表',
  `owner` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `scale` int(11) DEFAULT NULL,
  `profession` varchar(50) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `isdeleted` int(11) NOT NULL,
  PRIMARY KEY (`clientid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_client
-- ----------------------------
INSERT INTO `tb_client` VALUES ('8', '世界500强', '1', '19', '张三', '', '50000', '各行各业', 'www.baidu.com', '', '', '大连高新区', '0411-12341234', '2021-01-21 09:06:41', '2021-01-25 13:00:14', '0');
INSERT INTO `tb_client` VALUES ('9', '大连XX公司', '1', '21', '', '', null, '', '', '', '', '', '', '2021-01-22 13:17:28', '2021-01-22 13:17:28', '0');
INSERT INTO `tb_client` VALUES ('10', '软删除测试客户', '1', '24', '', '', null, '', '', '', '', '', '', '2021-01-27 14:58:29', '2021-01-27 14:58:29', '0');

-- ----------------------------
-- Table structure for tb_contact
-- ----------------------------
DROP TABLE IF EXISTS `tb_contact`;
CREATE TABLE `tb_contact` (
  `contactid` int(11) NOT NULL AUTO_INCREMENT,
  `contactname` varchar(50) NOT NULL,
  `position` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `clientid` int(11) NOT NULL,
  `ismanager` int(11) NOT NULL,
  `phone` varchar(50) DEFAULT NULL COMMENT '手机',
  `telephone` varchar(50) DEFAULT NULL COMMENT '座机',
  `email` varchar(50) DEFAULT NULL,
  `wx` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `isdeleted` int(11) NOT NULL,
  PRIMARY KEY (`contactid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_contact
-- ----------------------------
INSERT INTO `tb_contact` VALUES ('6', '李四', '处长', '', '8', '1', '18612341234', '', '', '', '', '女', '35', '2021-01-21 09:08:05', '2021-01-21 09:08:05', '0');
INSERT INTO `tb_contact` VALUES ('7', '大鹏', '', '', '9', '0', '13998530749', '', '', '', '', '', null, '2021-01-22 13:17:48', '2021-01-22 13:17:48', '0');
INSERT INTO `tb_contact` VALUES ('8', 'tgb', '经理', '1233', '9', '1', '1358', '1358', '46442771@qq.com', '1358', '', '女', null, '2021-01-25 13:01:13', '2021-01-25 13:01:39', '0');
INSERT INTO `tb_contact` VALUES ('9', '软删除测试客', '', '', '10', '0', '186000000', '', '', '', '', '', null, '2021-01-27 14:58:54', '2021-01-27 14:58:54', '0');

-- ----------------------------
-- Table structure for tb_dailypaper
-- ----------------------------
DROP TABLE IF EXISTS `tb_dailypaper`;
CREATE TABLE `tb_dailypaper` (
  `dailypaperid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `dailypaperdate` datetime NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`dailypaperid`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaper
-- ----------------------------
INSERT INTO `tb_dailypaper` VALUES ('36', '15', '2021-01-12 00:00:00', '2021-01-12 07:59:24', '2021-01-12 07:59:24');
INSERT INTO `tb_dailypaper` VALUES ('37', '15', '2021-01-11 00:00:00', '2021-01-12 08:00:05', '2021-01-12 08:00:05');
INSERT INTO `tb_dailypaper` VALUES ('38', '13', '2021-01-14 00:00:00', '2021-01-14 09:58:08', '2021-01-14 09:58:08');
INSERT INTO `tb_dailypaper` VALUES ('39', '13', '2021-01-14 00:00:00', '2021-01-14 09:58:42', '2021-01-14 09:58:42');
INSERT INTO `tb_dailypaper` VALUES ('40', '13', '2021-01-14 00:00:00', '2021-01-14 09:59:05', '2021-01-14 09:59:05');
INSERT INTO `tb_dailypaper` VALUES ('41', '13', '2021-01-14 00:00:00', '2021-01-14 09:59:46', '2021-01-14 09:59:46');
INSERT INTO `tb_dailypaper` VALUES ('42', '15', '2021-01-13 00:00:00', '2021-01-14 14:53:33', '2021-01-14 14:55:42');
INSERT INTO `tb_dailypaper` VALUES ('43', '16', '2021-01-14 00:00:00', '2021-01-14 14:57:34', '2021-01-14 14:57:34');
INSERT INTO `tb_dailypaper` VALUES ('44', '22', '2021-01-19 00:00:00', '2021-01-21 09:10:53', '2021-01-21 09:40:50');
INSERT INTO `tb_dailypaper` VALUES ('47', '22', '2021-01-20 00:00:00', '2021-01-21 09:16:23', '2021-01-21 09:40:22');
INSERT INTO `tb_dailypaper` VALUES ('48', '15', '2021-01-21 00:00:00', '2021-01-21 16:47:16', '2021-01-21 16:47:16');
INSERT INTO `tb_dailypaper` VALUES ('49', '15', '2021-01-23 00:00:00', '2021-01-25 09:15:27', '2021-01-25 09:41:19');
INSERT INTO `tb_dailypaper` VALUES ('50', '15', '2021-01-25 00:00:00', '2021-01-25 09:51:32', '2021-01-25 09:51:32');
INSERT INTO `tb_dailypaper` VALUES ('51', '15', '2021-01-24 00:00:00', '2021-01-25 09:52:33', '2021-01-25 09:52:33');
INSERT INTO `tb_dailypaper` VALUES ('52', '23', '2021-01-25 00:00:00', '2021-01-25 10:47:57', '2021-01-25 10:47:57');
INSERT INTO `tb_dailypaper` VALUES ('54', '24', '2021-01-26 00:00:00', '2021-01-27 14:48:21', '2021-01-27 14:48:21');
INSERT INTO `tb_dailypaper` VALUES ('55', '22', '2021-01-26 00:00:00', '2021-01-27 15:00:03', '2021-01-27 15:00:10');

-- ----------------------------
-- Table structure for tb_dailypaper_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_dailypaper_user`;
CREATE TABLE `tb_dailypaper_user` (
  `dailypaper_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `dailypaperid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `isread` int(11) NOT NULL,
  `readtime` datetime DEFAULT NULL,
  PRIMARY KEY (`dailypaper_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaper_user
-- ----------------------------
INSERT INTO `tb_dailypaper_user` VALUES ('44', '36', '14', '1', '2021-01-27 15:49:00');
INSERT INTO `tb_dailypaper_user` VALUES ('45', '36', '13', '1', '2021-01-21 08:57:10');
INSERT INTO `tb_dailypaper_user` VALUES ('46', '37', '14', '1', '2021-01-27 15:06:40');
INSERT INTO `tb_dailypaper_user` VALUES ('47', '37', '13', '1', '2021-01-14 14:55:08');
INSERT INTO `tb_dailypaper_user` VALUES ('48', '38', '14', '1', '2021-01-27 15:46:33');
INSERT INTO `tb_dailypaper_user` VALUES ('49', '38', '13', '1', '2021-01-27 15:46:16');
INSERT INTO `tb_dailypaper_user` VALUES ('50', '39', '14', '1', '2021-01-27 15:46:33');
INSERT INTO `tb_dailypaper_user` VALUES ('51', '39', '13', '1', '2021-01-27 15:46:16');
INSERT INTO `tb_dailypaper_user` VALUES ('52', '40', '14', '1', '2021-01-27 15:46:33');
INSERT INTO `tb_dailypaper_user` VALUES ('53', '40', '13', '1', '2021-01-27 15:46:16');
INSERT INTO `tb_dailypaper_user` VALUES ('54', '41', '14', '1', '2021-01-27 15:46:33');
INSERT INTO `tb_dailypaper_user` VALUES ('55', '41', '13', '1', '2021-01-27 15:46:15');
INSERT INTO `tb_dailypaper_user` VALUES ('60', '42', '14', '1', '2021-01-27 15:49:00');
INSERT INTO `tb_dailypaper_user` VALUES ('61', '42', '13', '1', '2021-01-25 09:42:07');
INSERT INTO `tb_dailypaper_user` VALUES ('62', '43', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('63', '43', '13', '1', '2021-01-25 09:43:26');
INSERT INTO `tb_dailypaper_user` VALUES ('76', '47', '14', '1', '2021-01-27 15:05:44');
INSERT INTO `tb_dailypaper_user` VALUES ('77', '47', '21', '1', '2021-01-22 14:17:18');
INSERT INTO `tb_dailypaper_user` VALUES ('78', '44', '14', '1', '2021-01-27 15:05:44');
INSERT INTO `tb_dailypaper_user` VALUES ('79', '44', '21', '1', '2021-01-22 14:17:11');
INSERT INTO `tb_dailypaper_user` VALUES ('80', '48', '14', '1', '2021-01-27 15:49:00');
INSERT INTO `tb_dailypaper_user` VALUES ('81', '48', '13', '1', '2021-01-25 09:50:53');
INSERT INTO `tb_dailypaper_user` VALUES ('82', '48', '20', '1', '2021-01-25 10:31:40');
INSERT INTO `tb_dailypaper_user` VALUES ('85', '49', '13', '1', '2021-01-25 10:07:32');
INSERT INTO `tb_dailypaper_user` VALUES ('86', '50', '14', '1', '2021-01-27 15:49:00');
INSERT INTO `tb_dailypaper_user` VALUES ('87', '50', '13', '1', '2021-01-25 12:26:48');
INSERT INTO `tb_dailypaper_user` VALUES ('88', '50', '20', '1', '2021-01-25 10:31:44');
INSERT INTO `tb_dailypaper_user` VALUES ('89', '51', '14', '1', '2021-01-27 15:49:00');
INSERT INTO `tb_dailypaper_user` VALUES ('90', '51', '13', '1', '2021-01-25 10:07:12');
INSERT INTO `tb_dailypaper_user` VALUES ('91', '52', '14', '1', '2021-01-27 15:43:45');
INSERT INTO `tb_dailypaper_user` VALUES ('92', '52', '13', '1', '2021-01-25 12:27:57');
INSERT INTO `tb_dailypaper_user` VALUES ('93', '52', '20', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('96', '54', '21', '1', '2021-01-27 14:48:56');
INSERT INTO `tb_dailypaper_user` VALUES ('100', '55', '14', '1', '2021-01-27 15:05:44');
INSERT INTO `tb_dailypaper_user` VALUES ('101', '55', '20', '1', '2021-01-27 15:01:49');
INSERT INTO `tb_dailypaper_user` VALUES ('102', '55', '21', '0', null);

-- ----------------------------
-- Table structure for tb_dailypaperdetail
-- ----------------------------
DROP TABLE IF EXISTS `tb_dailypaperdetail`;
CREATE TABLE `tb_dailypaperdetail` (
  `dailypaperdetailid` int(11) NOT NULL AUTO_INCREMENT,
  `dailypaperid` int(11) NOT NULL,
  `projectscheduleid` int(11) DEFAULT NULL,
  `worktime` float NOT NULL,
  `workcontent` varchar(1000) NOT NULL,
  PRIMARY KEY (`dailypaperdetailid`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaperdetail
-- ----------------------------
INSERT INTO `tb_dailypaperdetail` VALUES ('36', '36', '18', '8', '系统部署及初始化');
INSERT INTO `tb_dailypaperdetail` VALUES ('37', '37', '18', '8', '表单基础验证');
INSERT INTO `tb_dailypaperdetail` VALUES ('38', '38', '18', '0.5', 'test');
INSERT INTO `tb_dailypaperdetail` VALUES ('39', '39', '18', '3', '222');
INSERT INTO `tb_dailypaperdetail` VALUES ('40', '40', '18', '2', '2322');
INSERT INTO `tb_dailypaperdetail` VALUES ('41', '41', '-1', '1', 'test');
INSERT INTO `tb_dailypaperdetail` VALUES ('45', '42', '18', '3', '部署');
INSERT INTO `tb_dailypaperdetail` VALUES ('46', '43', '-1', '1', '11');
INSERT INTO `tb_dailypaperdetail` VALUES ('47', '48', '18', '2', '自己填');
INSERT INTO `tb_dailypaperdetail` VALUES ('48', '48', '-1', '3', '学习内容');
INSERT INTO `tb_dailypaperdetail` VALUES ('51', '49', '18', '2', '自己填');
INSERT INTO `tb_dailypaperdetail` VALUES ('52', '49', '-1', '0.5', '学习内容');
INSERT INTO `tb_dailypaperdetail` VALUES ('53', '50', '19', '0.5', '帮忙');
INSERT INTO `tb_dailypaperdetail` VALUES ('54', '51', '19', '1', '不错');
INSERT INTO `tb_dailypaperdetail` VALUES ('55', '52', '20', '0.5', '111');
INSERT INTO `tb_dailypaperdetail` VALUES ('56', '52', '-1', '1', '111');
INSERT INTO `tb_dailypaperdetail` VALUES ('57', '54', '21', '2', 'ccc');

-- ----------------------------
-- Table structure for tb_dailypaperdetail_sale
-- ----------------------------
DROP TABLE IF EXISTS `tb_dailypaperdetail_sale`;
CREATE TABLE `tb_dailypaperdetail_sale` (
  `dailypaperdetail_saleid` int(11) NOT NULL AUTO_INCREMENT,
  `dailypaperid` int(11) NOT NULL,
  `businessid` int(11) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `worktime` float NOT NULL,
  `workcontent` varchar(1000) DEFAULT NULL,
  `contactid` int(11) DEFAULT NULL,
  PRIMARY KEY (`dailypaperdetail_saleid`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaperdetail_sale
-- ----------------------------
INSERT INTO `tb_dailypaperdetail_sale` VALUES ('38', '47', '12', '22.00', '5', '日常工作', null);
INSERT INTO `tb_dailypaperdetail_sale` VALUES ('39', '44', '12', null, '5', '宴请：肯德基', '6');
INSERT INTO `tb_dailypaperdetail_sale` VALUES ('40', '44', '-1', null, '3', '学习相关法规', null);
INSERT INTO `tb_dailypaperdetail_sale` VALUES ('44', '55', '16', '11.00', '1.5', 'cccc', '9');

-- ----------------------------
-- Table structure for tb_dict
-- ----------------------------
DROP TABLE IF EXISTS `tb_dict`;
CREATE TABLE `tb_dict` (
  `dictid` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `typename` varchar(50) NOT NULL,
  PRIMARY KEY (`dictid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dict
-- ----------------------------
INSERT INTO `tb_dict` VALUES ('1', '1', '1', '自研项目');
INSERT INTO `tb_dict` VALUES ('2', '1', '2', '外包项目');
INSERT INTO `tb_dict` VALUES ('3', '2', '1', '开发岗');
INSERT INTO `tb_dict` VALUES ('4', '2', '2', '销售岗');
INSERT INTO `tb_dict` VALUES ('5', '2', '3', '管理岗');
INSERT INTO `tb_dict` VALUES ('6', '2', '0', '其他岗');
INSERT INTO `tb_dict` VALUES ('7', '3', '1', '提议');
INSERT INTO `tb_dict` VALUES ('8', '3', '2', '需求分析');
INSERT INTO `tb_dict` VALUES ('9', '3', '3', '谈判');
INSERT INTO `tb_dict` VALUES ('10', '3', '4', '获取商机');
INSERT INTO `tb_dict` VALUES ('11', '3', '5', '失去商机');
INSERT INTO `tb_dict` VALUES ('12', '4', '1', '普通客户');
INSERT INTO `tb_dict` VALUES ('13', '4', '2', '潜在客户');
INSERT INTO `tb_dict` VALUES ('14', '5', '0', '日常工作');
INSERT INTO `tb_dict` VALUES ('15', '5', '1', '拜访');
INSERT INTO `tb_dict` VALUES ('16', '5', '2', '宴请');

-- ----------------------------
-- Table structure for tb_group
-- ----------------------------
DROP TABLE IF EXISTS `tb_group`;
CREATE TABLE `tb_group` (
  `groupid` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` int(11) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  PRIMARY KEY (`groupid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('1', '0', '中智联', '2020-12-21 16:26:15.000000', '2020-12-22 10:01:58.965286');
INSERT INTO `tb_group` VALUES ('12', '1', '总经理室', '2021-01-12 07:48:18.858672', '2021-01-21 08:53:25.358505');
INSERT INTO `tb_group` VALUES ('13', '12', '研发一部', '2021-01-12 07:48:37.736017', '2021-01-12 07:48:37.736010');
INSERT INTO `tb_group` VALUES ('15', '12', '行政部门', '2021-01-12 07:48:56.720445', '2021-01-12 07:48:56.720439');
INSERT INTO `tb_group` VALUES ('16', '12', '销售部门', '2021-01-21 08:58:11.132956', '2021-01-21 08:58:11.132919');
INSERT INTO `tb_group` VALUES ('17', '12', '研发二部', '2021-01-25 10:15:12.041828', '2021-01-25 10:15:38.145423');

-- ----------------------------
-- Table structure for tb_group_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_group_user`;
CREATE TABLE `tb_group_user` (
  `group_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `ismanager` int(11) NOT NULL,
  PRIMARY KEY (`group_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group_user
-- ----------------------------
INSERT INTO `tb_group_user` VALUES ('40', '14', '12', '1');
INSERT INTO `tb_group_user` VALUES ('41', '13', '13', '0');
INSERT INTO `tb_group_user` VALUES ('42', '15', '13', '1');
INSERT INTO `tb_group_user` VALUES ('43', '16', '13', '0');
INSERT INTO `tb_group_user` VALUES ('45', '19', '14', '0');
INSERT INTO `tb_group_user` VALUES ('46', '20', '15', '1');
INSERT INTO `tb_group_user` VALUES ('47', '21', '16', '1');
INSERT INTO `tb_group_user` VALUES ('48', '22', '16', '0');
INSERT INTO `tb_group_user` VALUES ('49', '19', '15', '0');
INSERT INTO `tb_group_user` VALUES ('50', '18', '14', '1');
INSERT INTO `tb_group_user` VALUES ('52', '19', '17', '0');
INSERT INTO `tb_group_user` VALUES ('55', '23', '13', '0');

-- ----------------------------
-- Table structure for tb_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_permission`;
CREATE TABLE `tb_permission` (
  `permissionid` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  PRIMARY KEY (`permissionid`),
  UNIQUE KEY `uniq_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

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
INSERT INTO `tb_permission` VALUES ('37', '1', '客户管理', '000026');
INSERT INTO `tb_permission` VALUES ('38', '37', '新建客户', '000027');
INSERT INTO `tb_permission` VALUES ('39', '37', '删除客户', '000028');
INSERT INTO `tb_permission` VALUES ('40', '37', '修改客户', '000029');
INSERT INTO `tb_permission` VALUES ('41', '37', '查看客户', '000030');
INSERT INTO `tb_permission` VALUES ('42', '1', '商机管理', '000031');
INSERT INTO `tb_permission` VALUES ('43', '42', '新建商机', '000032');
INSERT INTO `tb_permission` VALUES ('44', '42', '删除商机', '000033');
INSERT INTO `tb_permission` VALUES ('45', '42', '修改商机', '000034');
INSERT INTO `tb_permission` VALUES ('46', '42', '查看商机', '000035');
INSERT INTO `tb_permission` VALUES ('47', '1', '日报管理', '000036');
INSERT INTO `tb_permission` VALUES ('48', '47', '查看日报', '000037');

-- ----------------------------
-- Table structure for tb_project
-- ----------------------------
DROP TABLE IF EXISTS `tb_project`;
CREATE TABLE `tb_project` (
  `projectid` int(11) NOT NULL AUTO_INCREMENT,
  `projectname` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `typeid` int(11) NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `isdeleted` int(11) NOT NULL,
  PRIMARY KEY (`projectid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_project
-- ----------------------------
INSERT INTO `tb_project` VALUES ('19', '对日docker项目', '.netcore+vue+docker', '2', '2021-01-12 07:53:17', '2021-01-12 07:53:17', '0');
INSERT INTO `tb_project` VALUES ('20', '项目管理系统', 'crm+prm', '1', '2021-01-12 07:56:52', '2021-01-12 07:56:52', '0');
INSERT INTO `tb_project` VALUES ('22', 'hr', 'lj', '1', '2021-01-25 10:04:59', '2021-01-25 10:04:59', '0');
INSERT INTO `tb_project` VALUES ('23', '1111', '123', '1', '2021-01-25 12:40:37', '2021-01-25 12:40:37', '0');
INSERT INTO `tb_project` VALUES ('24', '软删除测试', '软删除测试', '1', '2021-01-27 14:47:10', '2021-01-27 14:47:10', '0');

-- ----------------------------
-- Table structure for tb_projectschedule
-- ----------------------------
DROP TABLE IF EXISTS `tb_projectschedule`;
CREATE TABLE `tb_projectschedule` (
  `projectscheduleid` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `schedulename` varchar(50) NOT NULL,
  `scheduledescription` varchar(255) DEFAULT NULL,
  `groupid` int(11) NOT NULL,
  `preworkload` int(11) NOT NULL,
  `realworkload` int(11) DEFAULT NULL,
  `schedulestartdate` datetime NOT NULL,
  `schedulefinishdate` datetime NOT NULL,
  `schedulerealstartdate` datetime DEFAULT NULL,
  `schedulerealfinishdate` datetime DEFAULT NULL,
  `isfinished` int(11) NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `isdeleted` int(11) NOT NULL,
  PRIMARY KEY (`projectscheduleid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_projectschedule
-- ----------------------------
INSERT INTO `tb_projectschedule` VALUES ('17', '19', '开发阶段', '开发及部署', '13', '30', '60', '2020-09-07 00:00:00', '2020-12-15 00:00:00', '2020-09-07 00:00:00', '2020-12-15 00:00:00', '1', '2021-01-12 07:54:39', '2021-01-12 07:55:40', '0');
INSERT INTO `tb_projectschedule` VALUES ('18', '20', '设计-开发', '基础后台管理+日报填写+项目管理', '13', '30', null, '2020-12-22 00:00:00', '2021-02-25 00:00:00', null, null, '0', '2021-01-12 07:58:19', '2021-01-25 09:56:58', '0');
INSERT INTO `tb_projectschedule` VALUES ('20', '22', 'hr-1', '', '13', '2', null, '2021-01-01 00:00:00', '2021-01-25 00:00:00', null, null, '0', '2021-01-25 10:05:34', '2021-01-25 10:45:56', '0');
INSERT INTO `tb_projectschedule` VALUES ('21', '24', '软删除测试阶段', '123', '13', '12', null, '2021-01-26 00:00:00', '2021-01-29 00:00:00', null, null, '0', '2021-01-27 14:47:53', '2021-01-27 14:47:53', '0');

-- ----------------------------
-- Table structure for tb_projectschedule_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_projectschedule_user`;
CREATE TABLE `tb_projectschedule_user` (
  `projectschedule_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `projectscheduleid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `ismanager` int(11) NOT NULL,
  PRIMARY KEY (`projectschedule_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_projectschedule_user
-- ----------------------------
INSERT INTO `tb_projectschedule_user` VALUES ('84', '17', '13', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('85', '17', '15', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('86', '17', '16', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('129', '18', '13', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('130', '18', '15', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('136', '19', '13', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('137', '19', '16', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('138', '19', '19', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('139', '19', '20', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('140', '19', '15', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('144', '20', '20', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('145', '20', '16', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('146', '20', '15', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('147', '20', '23', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('148', '21', '21', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('149', '21', '24', '0');

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role` (
  `roleid` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES ('1', '管理员', '2020-12-23 08:53:20', '2020-12-23 08:53:24');
INSERT INTO `tb_role` VALUES ('7', '项目经理', '2021-01-12 07:51:29', '2021-01-12 07:51:29');
INSERT INTO `tb_role` VALUES ('8', '销售主管', '2021-01-21 09:00:18', '2021-01-21 09:00:18');

-- ----------------------------
-- Table structure for tb_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_permission`;
CREATE TABLE `tb_role_permission` (
  `role_permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL,
  PRIMARY KEY (`role_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_role_permission
-- ----------------------------
INSERT INTO `tb_role_permission` VALUES ('457', '1', '1');
INSERT INTO `tb_role_permission` VALUES ('458', '1', '2');
INSERT INTO `tb_role_permission` VALUES ('459', '1', '3');
INSERT INTO `tb_role_permission` VALUES ('460', '1', '4');
INSERT INTO `tb_role_permission` VALUES ('461', '1', '5');
INSERT INTO `tb_role_permission` VALUES ('462', '1', '6');
INSERT INTO `tb_role_permission` VALUES ('463', '1', '7');
INSERT INTO `tb_role_permission` VALUES ('464', '1', '8');
INSERT INTO `tb_role_permission` VALUES ('465', '1', '9');
INSERT INTO `tb_role_permission` VALUES ('466', '1', '16');
INSERT INTO `tb_role_permission` VALUES ('467', '1', '17');
INSERT INTO `tb_role_permission` VALUES ('468', '1', '18');
INSERT INTO `tb_role_permission` VALUES ('469', '1', '19');
INSERT INTO `tb_role_permission` VALUES ('470', '1', '20');
INSERT INTO `tb_role_permission` VALUES ('471', '1', '21');
INSERT INTO `tb_role_permission` VALUES ('472', '1', '22');
INSERT INTO `tb_role_permission` VALUES ('473', '1', '26');
INSERT INTO `tb_role_permission` VALUES ('474', '1', '27');
INSERT INTO `tb_role_permission` VALUES ('475', '1', '29');
INSERT INTO `tb_role_permission` VALUES ('476', '1', '30');
INSERT INTO `tb_role_permission` VALUES ('477', '1', '31');
INSERT INTO `tb_role_permission` VALUES ('478', '1', '32');
INSERT INTO `tb_role_permission` VALUES ('479', '1', '33');
INSERT INTO `tb_role_permission` VALUES ('480', '1', '34');
INSERT INTO `tb_role_permission` VALUES ('481', '1', '35');
INSERT INTO `tb_role_permission` VALUES ('482', '1', '36');
INSERT INTO `tb_role_permission` VALUES ('483', '1', '37');
INSERT INTO `tb_role_permission` VALUES ('484', '1', '38');
INSERT INTO `tb_role_permission` VALUES ('485', '1', '39');
INSERT INTO `tb_role_permission` VALUES ('486', '1', '40');
INSERT INTO `tb_role_permission` VALUES ('487', '1', '41');
INSERT INTO `tb_role_permission` VALUES ('488', '1', '42');
INSERT INTO `tb_role_permission` VALUES ('489', '1', '43');
INSERT INTO `tb_role_permission` VALUES ('490', '1', '44');
INSERT INTO `tb_role_permission` VALUES ('491', '1', '45');
INSERT INTO `tb_role_permission` VALUES ('492', '1', '46');
INSERT INTO `tb_role_permission` VALUES ('493', '1', '47');
INSERT INTO `tb_role_permission` VALUES ('494', '1', '48');
INSERT INTO `tb_role_permission` VALUES ('495', '7', '32');
INSERT INTO `tb_role_permission` VALUES ('496', '7', '33');
INSERT INTO `tb_role_permission` VALUES ('497', '7', '34');
INSERT INTO `tb_role_permission` VALUES ('498', '7', '35');
INSERT INTO `tb_role_permission` VALUES ('499', '7', '36');
INSERT INTO `tb_role_permission` VALUES ('500', '7', '47');
INSERT INTO `tb_role_permission` VALUES ('501', '7', '48');
INSERT INTO `tb_role_permission` VALUES ('514', '8', '37');
INSERT INTO `tb_role_permission` VALUES ('515', '8', '38');
INSERT INTO `tb_role_permission` VALUES ('516', '8', '39');
INSERT INTO `tb_role_permission` VALUES ('517', '8', '40');
INSERT INTO `tb_role_permission` VALUES ('518', '8', '41');
INSERT INTO `tb_role_permission` VALUES ('519', '8', '42');
INSERT INTO `tb_role_permission` VALUES ('520', '8', '43');
INSERT INTO `tb_role_permission` VALUES ('521', '8', '44');
INSERT INTO `tb_role_permission` VALUES ('522', '8', '45');
INSERT INTO `tb_role_permission` VALUES ('523', '8', '46');
INSERT INTO `tb_role_permission` VALUES ('524', '8', '47');
INSERT INTO `tb_role_permission` VALUES ('525', '8', '48');

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES ('34', '1', '1');
INSERT INTO `tb_user_role` VALUES ('35', '21', '8');
INSERT INTO `tb_user_role` VALUES ('36', '20', '7');
INSERT INTO `tb_user_role` VALUES ('37', '20', '8');
INSERT INTO `tb_user_role` VALUES ('38', '18', '7');
INSERT INTO `tb_user_role` VALUES ('39', '14', '7');
INSERT INTO `tb_user_role` VALUES ('40', '13', '7');

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
