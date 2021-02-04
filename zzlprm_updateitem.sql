/*
Navicat MySQL Data Transfer

Source Server         : replusDriver
Source Server Version : 50505
Source Host           : 192.168.127.2:3306
Source Database       : zzlprm

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2021-02-04 13:22:53
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
  `email` varchar(254) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-02-04 12:59:16.890656', '1', 'admin', '', '', 'zzl@qq.com', '1', '1', '2020-12-18 06:28:27.497579', '管理员', '123', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('26', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-02-04 13:13:58.786003', '0', 'ly', null, null, 'null', null, '1', null, '李杨', '15998539782', '2021-02-03 16:44:40', '2021-02-04 13:09:20', '1');
INSERT INTO `auth_user` VALUES ('27', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-02-04 09:04:29.455345', '0', 'lp', null, null, null, null, '1', null, '李鹏', '13998530749', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('28', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-02-03 16:41:33.672416', '0', 'zmg', null, null, null, null, '1', null, '张茂国', '18624378730', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('29', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'aq', null, null, null, null, '1', null, '敖强', '17709811260', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('30', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'wyx', null, null, null, null, '1', null, '王玉鑫', '15041140912', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('31', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'gxy', null, null, null, null, '1', null, '宫晓宇', '18741120474', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('32', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'wfk', null, null, null, null, '1', null, '汪丰凯', '13478699196', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('33', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'lx', null, null, null, null, '1', null, '刘鑫', '18742580982', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('34', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'xzr', null, null, null, null, '1', null, '徐卓然', '15004251988', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('35', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'zrr', null, null, null, null, '1', null, '张瑞蕊', '15524792519', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('36', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-02-04 09:12:01.574213', '0', 'lgh', null, null, null, null, '1', null, '卢国宏', '18604118283', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('37', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'kmy', null, null, null, null, '1', null, '康明雨', '15140691680', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('38', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'hdp', null, null, null, null, '1', null, '韩东鹏', '13942000263', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('39', 'pbkdf2_sha256$180000$8Tb6ut6VJ7HJ$RnWT0AqDoRl/nYnPL0+jmzHsuEpGJy9ki58gBMABXvA=', '2021-02-04 09:04:45.764934', '0', 'zzh', null, null, null, null, '1', null, '郑镇洪', '18640136340', '2021-02-03 16:44:40', '2021-02-03 16:46:37', '1');
INSERT INTO `auth_user` VALUES ('40', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'ljx', null, null, null, null, '1', null, '刘佳欣', '15164056843', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('41', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'yht', null, null, null, null, '1', null, '闫海涛', '13998481020', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('42', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-02-03 16:49:13.937311', '0', 'gq', null, null, null, null, '1', null, '郭庆', '13840802128', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('43', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'jwh', null, null, null, null, '1', null, '姜文宏', '15842412682', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '1');
INSERT INTO `auth_user` VALUES ('44', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', null, '0', 'fl', null, null, null, null, '1', null, '付林', '18041118926', '2021-02-03 16:44:40', '2021-02-03 16:44:40', '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_client
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_contact
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_user
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_businessrecord
-- ----------------------------

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
  `source` int(11) DEFAULT NULL,
  PRIMARY KEY (`clientid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_client
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaper
-- ----------------------------
INSERT INTO `tb_dailypaper` VALUES ('62', '39', '2021-02-02 00:00:00', '2021-02-04 09:05:22', '2021-02-04 09:05:22');

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
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaper_user
-- ----------------------------
INSERT INTO `tb_dailypaper_user` VALUES ('121', '62', '26', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('122', '62', '27', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('123', '62', '36', '0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaperdetail
-- ----------------------------
INSERT INTO `tb_dailypaperdetail` VALUES ('60', '62', '-1', '3', '学习python');

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
  `isimportant` int(11) DEFAULT NULL,
  PRIMARY KEY (`dailypaperdetail_saleid`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaperdetail_sale
-- ----------------------------

-- ----------------------------
-- Table structure for tb_dict
-- ----------------------------
DROP TABLE IF EXISTS `tb_dict`;
CREATE TABLE `tb_dict` (
  `dictid` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `typename` varchar(50) NOT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`dictid`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dict
-- ----------------------------
INSERT INTO `tb_dict` VALUES ('1', '1', '1', '自研项目', null);
INSERT INTO `tb_dict` VALUES ('2', '1', '2', '外包项目', null);
INSERT INTO `tb_dict` VALUES ('3', '2', '1', '开发岗', null);
INSERT INTO `tb_dict` VALUES ('4', '2', '2', '销售岗', null);
INSERT INTO `tb_dict` VALUES ('5', '2', '3', '管理岗', null);
INSERT INTO `tb_dict` VALUES ('6', '2', '0', '其他岗', null);
INSERT INTO `tb_dict` VALUES ('7', '3', '1', '提议', '2');
INSERT INTO `tb_dict` VALUES ('8', '3', '2', '需求分析', '3');
INSERT INTO `tb_dict` VALUES ('9', '3', '3', '谈判', '5');
INSERT INTO `tb_dict` VALUES ('10', '3', '4', '获取商机', '6');
INSERT INTO `tb_dict` VALUES ('11', '3', '5', '失去商机', '7');
INSERT INTO `tb_dict` VALUES ('12', '4', '1', '普通客户', null);
INSERT INTO `tb_dict` VALUES ('13', '4', '2', '潜在客户', null);
INSERT INTO `tb_dict` VALUES ('14', '5', '0', '日常工作', null);
INSERT INTO `tb_dict` VALUES ('15', '5', '1', '拜访', null);
INSERT INTO `tb_dict` VALUES ('16', '5', '2', '宴请', null);
INSERT INTO `tb_dict` VALUES ('17', '6', '1', '部门经理', null);
INSERT INTO `tb_dict` VALUES ('18', '6', '2', '总经理', null);
INSERT INTO `tb_dict` VALUES ('19', '6', '3', '人事', null);
INSERT INTO `tb_dict` VALUES ('20', '7', '1', '病假', null);
INSERT INTO `tb_dict` VALUES ('21', '7', '2', '事假', null);
INSERT INTO `tb_dict` VALUES ('22', '3', '6', '初步接洽', '1');
INSERT INTO `tb_dict` VALUES ('23', '3', '7', '方案/报价', '4');
INSERT INTO `tb_dict` VALUES ('24', '8', '1', '朋友介绍', null);
INSERT INTO `tb_dict` VALUES ('25', '8', '2', '活动', null);
INSERT INTO `tb_dict` VALUES ('26', '8', '3', '网站搜索', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('1', '0', '中智联', '2020-12-21 16:26:15.000000', '2020-12-22 10:01:58.965286');
INSERT INTO `tb_group` VALUES ('12', '1', '总经理室', '2021-01-12 07:48:18.858672', '2021-01-21 08:53:25.358505');
INSERT INTO `tb_group` VALUES ('15', '12', '人力资源文创', '2021-01-12 07:48:56.720445', '2021-02-03 16:29:54.920491');
INSERT INTO `tb_group` VALUES ('18', '15', '开发一部', '2021-02-03 16:28:52.777060', '2021-02-03 16:28:52.777021');
INSERT INTO `tb_group` VALUES ('19', '15', '开发二部', '2021-02-03 16:29:04.217541', '2021-02-03 16:29:04.217500');
INSERT INTO `tb_group` VALUES ('20', '15', '智慧教育', '2021-02-03 16:29:20.843294', '2021-02-03 16:29:20.843254');
INSERT INTO `tb_group` VALUES ('21', '15', '销售部', '2021-02-03 16:29:35.220154', '2021-02-03 16:29:35.220114');

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group_user
-- ----------------------------
INSERT INTO `tb_group_user` VALUES ('56', '26', '12', '1');
INSERT INTO `tb_group_user` VALUES ('57', '36', '15', '1');
INSERT INTO `tb_group_user` VALUES ('58', '40', '15', '0');
INSERT INTO `tb_group_user` VALUES ('59', '42', '15', '0');
INSERT INTO `tb_group_user` VALUES ('60', '28', '18', '1');
INSERT INTO `tb_group_user` VALUES ('61', '29', '18', '0');
INSERT INTO `tb_group_user` VALUES ('62', '30', '18', '0');
INSERT INTO `tb_group_user` VALUES ('63', '31', '18', '0');
INSERT INTO `tb_group_user` VALUES ('64', '32', '18', '0');
INSERT INTO `tb_group_user` VALUES ('65', '34', '18', '0');
INSERT INTO `tb_group_user` VALUES ('66', '35', '18', '0');
INSERT INTO `tb_group_user` VALUES ('67', '37', '18', '0');
INSERT INTO `tb_group_user` VALUES ('68', '27', '19', '1');
INSERT INTO `tb_group_user` VALUES ('69', '39', '19', '0');
INSERT INTO `tb_group_user` VALUES ('70', '38', '20', '1');
INSERT INTO `tb_group_user` VALUES ('71', '33', '20', '0');
INSERT INTO `tb_group_user` VALUES ('72', '41', '20', '0');
INSERT INTO `tb_group_user` VALUES ('73', '43', '20', '0');
INSERT INTO `tb_group_user` VALUES ('74', '44', '21', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_project
-- ----------------------------
INSERT INTO `tb_project` VALUES ('25', '大连礼物开业活动', '开业活动准备', '2', '2021-02-04 13:05:05', '2021-02-04 13:05:05', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_projectschedule
-- ----------------------------
INSERT INTO `tb_projectschedule` VALUES ('22', '25', '执行阶段', '', '20', '0', null, '2021-02-01 00:00:00', '2021-02-28 00:00:00', null, null, '0', '2021-02-04 13:07:54', '2021-02-04 13:07:54', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_projectschedule_user
-- ----------------------------
INSERT INTO `tb_projectschedule_user` VALUES ('150', '22', '38', '1');
INSERT INTO `tb_projectschedule_user` VALUES ('151', '22', '41', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('152', '22', '43', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('153', '22', '42', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('154', '22', '36', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('155', '22', '38', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('156', '22', '33', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('157', '22', '26', '0');
INSERT INTO `tb_projectschedule_user` VALUES ('158', '22', '27', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES ('1', '管理员', '2020-12-23 08:53:20', '2020-12-23 08:53:24');
INSERT INTO `tb_role` VALUES ('7', '项目经理', '2021-01-12 07:51:29', '2021-01-12 07:51:29');
INSERT INTO `tb_role` VALUES ('8', '销售主管', '2021-01-21 09:00:18', '2021-01-21 09:00:18');
INSERT INTO `tb_role` VALUES ('9', '总经理', '2021-02-03 16:36:47', '2021-02-03 16:36:47');
INSERT INTO `tb_role` VALUES ('10', '人力资源', '2021-02-03 16:42:33', '2021-02-03 16:42:33');

-- ----------------------------
-- Table structure for tb_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_permission`;
CREATE TABLE `tb_role_permission` (
  `role_permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL,
  PRIMARY KEY (`role_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=555 DEFAULT CHARSET=utf8;

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
INSERT INTO `tb_role_permission` VALUES ('526', '8', '37');
INSERT INTO `tb_role_permission` VALUES ('527', '8', '38');
INSERT INTO `tb_role_permission` VALUES ('528', '8', '39');
INSERT INTO `tb_role_permission` VALUES ('529', '8', '40');
INSERT INTO `tb_role_permission` VALUES ('530', '8', '41');
INSERT INTO `tb_role_permission` VALUES ('531', '8', '42');
INSERT INTO `tb_role_permission` VALUES ('532', '8', '43');
INSERT INTO `tb_role_permission` VALUES ('533', '8', '44');
INSERT INTO `tb_role_permission` VALUES ('534', '8', '45');
INSERT INTO `tb_role_permission` VALUES ('535', '8', '46');
INSERT INTO `tb_role_permission` VALUES ('536', '8', '47');
INSERT INTO `tb_role_permission` VALUES ('537', '8', '48');
INSERT INTO `tb_role_permission` VALUES ('538', '9', '47');
INSERT INTO `tb_role_permission` VALUES ('539', '9', '48');
INSERT INTO `tb_role_permission` VALUES ('540', '10', '2');
INSERT INTO `tb_role_permission` VALUES ('541', '10', '3');
INSERT INTO `tb_role_permission` VALUES ('542', '10', '4');
INSERT INTO `tb_role_permission` VALUES ('543', '10', '5');
INSERT INTO `tb_role_permission` VALUES ('544', '10', '6');
INSERT INTO `tb_role_permission` VALUES ('545', '10', '7');
INSERT INTO `tb_role_permission` VALUES ('546', '10', '8');
INSERT INTO `tb_role_permission` VALUES ('547', '10', '9');
INSERT INTO `tb_role_permission` VALUES ('548', '10', '16');
INSERT INTO `tb_role_permission` VALUES ('549', '10', '17');
INSERT INTO `tb_role_permission` VALUES ('550', '10', '26');
INSERT INTO `tb_role_permission` VALUES ('551', '10', '27');
INSERT INTO `tb_role_permission` VALUES ('552', '10', '29');
INSERT INTO `tb_role_permission` VALUES ('553', '10', '30');
INSERT INTO `tb_role_permission` VALUES ('554', '10', '31');

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES ('34', '1', '1');
INSERT INTO `tb_user_role` VALUES ('41', '44', '8');
INSERT INTO `tb_user_role` VALUES ('42', '28', '7');
INSERT INTO `tb_user_role` VALUES ('43', '27', '7');
INSERT INTO `tb_user_role` VALUES ('44', '36', '7');
INSERT INTO `tb_user_role` VALUES ('45', '38', '7');
INSERT INTO `tb_user_role` VALUES ('47', '36', '10');
INSERT INTO `tb_user_role` VALUES ('48', '26', '9');

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
