/*
Navicat MySQL Data Transfer

Source Server         : replusDriver
Source Server Version : 50505
Source Host           : 192.168.127.2:3306
Source Database       : zzlprm

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2021-01-21 09:46:18
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$216000$AqNOxAN9iwyE$K0ZE3aVPNFk1/Rg2hdJRbnW1JT8mcKXba96f+aMQGPM=', '2021-01-12 05:00:02.571006', '1', 'admin', '', '', 'zzl@qq.com', '1', '1', '2020-12-18 06:28:27.497579', '管理员', '123', '0000-00-00 00:00:00', '2020-12-31 13:57:57', '1');
INSERT INTO `auth_user` VALUES ('13', 'pbkdf2_sha256$180000$vHoU1GZsCAFe$5fCzaZykUipQ1eGDYlP8s3CkjKKr57foVXtFI/UMPQc=', null, '0', 'lp', null, null, 'lp@qq.com', null, '1', null, '李鹏', '13900001234', '2021-01-12 07:42:39', '2021-01-12 07:42:39', '3');
INSERT INTO `auth_user` VALUES ('14', 'pbkdf2_sha256$180000$BeC9JQs044uk$AhqRfYJGSl3n5+JfrOCH5AmSxu84T/pD5LW3NqnE0t4=', null, '0', 'ly', null, null, 'ly@qq.com', null, '1', null, '李杨', '13500000000', '2021-01-12 07:43:19', '2021-01-12 07:43:19', '3');
INSERT INTO `auth_user` VALUES ('15', 'pbkdf2_sha256$180000$9t3qGkrux4Sd$LXAsIVly+OFQP6r897RbOzJ/Zdu7OkXRgFX7DQxwmG0=', null, '0', 'zzh', null, null, 'zzh@qq.com', null, '1', null, '郑镇洪', '15800000000', '2021-01-12 07:44:00', '2021-01-12 07:44:00', '1');
INSERT INTO `auth_user` VALUES ('16', 'pbkdf2_sha256$180000$jdRZHyhldQPd$i3dETVZMN58Si/rYjTApxXUZiWWGYObgLxV4xnIOZVc=', null, '0', 'zrr', null, null, 'zrr@qq.com', null, '1', null, '张瑞蕊', '15600000000', '2021-01-12 07:44:33', '2021-01-13 15:14:19', '1');
INSERT INTO `auth_user` VALUES ('18', 'pbkdf2_sha256$180000$9oWyF3ClnXwR$CMHoEC2jGX/AlK6Yj9j3Do0+fp09ODFaDmpnirhYzQk=', null, '0', 'zgm', null, null, 'zgm@qq.com', null, '1', null, '张国茂', '13600000000', '2021-01-12 07:46:05', '2021-01-12 07:46:05', '3');
INSERT INTO `auth_user` VALUES ('19', 'pbkdf2_sha256$180000$pAjJ8dt1APNu$ZrpsfurpmRy1ZbsyUt09tBgLJ/wGtzQ4hz9tUEWsL/s=', null, '0', 'wyx', null, null, 'wyx@qq.com', null, '1', null, '王玉鑫', '15600000000', '2021-01-12 07:46:38', '2021-01-13 15:14:09', '1');
INSERT INTO `auth_user` VALUES ('20', 'pbkdf2_sha256$180000$pOyjX1wtZqMf$BiAOj6K0+23xWfkU6icZS+JJuQZZOSsMGHWwSGD/QmQ=', null, '0', 'lgh', null, null, 'lgh@qq.com', null, '1', null, '卢国宏', '13560000000', '2021-01-12 07:47:21', '2021-01-12 07:47:21', '3');
INSERT INTO `auth_user` VALUES ('21', 'pbkdf2_sha256$180000$ERZ3LS7BmZI3$GbVIX7YidVRyVsR5iaH55FCqJqBQBERPY1VZC5ZusPI=', null, '0', 'xszg', null, null, 'qq@qq.com', null, '1', null, '销售主管', '18612341234', '2021-01-21 08:58:50', '2021-01-21 08:58:50', '3');
INSERT INTO `auth_user` VALUES ('22', 'pbkdf2_sha256$180000$ZXkypopHpZnN$dM4Veqvo4Xp71uZSJVtqfsPWVhffUaVzsjIcwu9FyVg=', null, '0', 'xsyg', null, null, 'qq@qq.com', null, '1', null, '销售员工', '18612341861234', '2021-01-21 08:59:18', '2021-01-21 08:59:18', '2');

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
  PRIMARY KEY (`businessid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business
-- ----------------------------
INSERT INTO `tb_business` VALUES ('12', '搭建平台', '1', '', '50', '500.00', null, '21', '21', null, '2021-01-21 09:09:03', '2021-01-21 09:09:42');

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_client
-- ----------------------------
INSERT INTO `tb_business_client` VALUES ('28', '12', '8', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_contact
-- ----------------------------
INSERT INTO `tb_business_contact` VALUES ('30', '12', '6', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_business_user
-- ----------------------------
INSERT INTO `tb_business_user` VALUES ('32', '12', '21', '1');
INSERT INTO `tb_business_user` VALUES ('33', '12', '22', '0');

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
  PRIMARY KEY (`clientid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_client
-- ----------------------------
INSERT INTO `tb_client` VALUES ('8', '世界500强', '1', '22', '张三', '', '50000', '各行各业', 'www.baidu.com', '', '', '大连高新区', '0411-12341234', '2021-01-21 09:06:41', '2021-01-21 09:06:41');

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
  PRIMARY KEY (`contactid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_contact
-- ----------------------------
INSERT INTO `tb_contact` VALUES ('6', '李四', '处长', '', '8', '1', '18612341234', '', '', '', '', '女', '35', '2021-01-21 09:08:05', '2021-01-21 09:08:05');

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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaper_user
-- ----------------------------
INSERT INTO `tb_dailypaper_user` VALUES ('44', '36', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('45', '36', '13', '1', '2021-01-21 08:57:10');
INSERT INTO `tb_dailypaper_user` VALUES ('46', '37', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('47', '37', '13', '1', '2021-01-14 14:55:08');
INSERT INTO `tb_dailypaper_user` VALUES ('48', '38', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('49', '38', '13', '1', '2021-01-14 10:07:09');
INSERT INTO `tb_dailypaper_user` VALUES ('50', '39', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('51', '39', '13', '1', '2021-01-14 14:56:12');
INSERT INTO `tb_dailypaper_user` VALUES ('52', '40', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('53', '40', '13', '1', '2021-01-14 14:56:09');
INSERT INTO `tb_dailypaper_user` VALUES ('54', '41', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('55', '41', '13', '1', '2021-01-14 14:56:22');
INSERT INTO `tb_dailypaper_user` VALUES ('60', '42', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('61', '42', '13', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('62', '43', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('63', '43', '13', '1', '2021-01-21 08:57:05');
INSERT INTO `tb_dailypaper_user` VALUES ('76', '47', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('77', '47', '21', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('78', '44', '14', '0', null);
INSERT INTO `tb_dailypaper_user` VALUES ('79', '44', '21', '0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dailypaperdetail_sale
-- ----------------------------
INSERT INTO `tb_dailypaperdetail_sale` VALUES ('38', '47', '12', '22.00', '5', '日常工作', null);
INSERT INTO `tb_dailypaperdetail_sale` VALUES ('39', '44', '12', null, '5', '宴请：肯德基', '6');
INSERT INTO `tb_dailypaperdetail_sale` VALUES ('40', '44', '-1', null, '3', '学习相关法规', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('1', '0', '中智联', '2020-12-21 16:26:15.000000', '2020-12-22 10:01:58.965286');
INSERT INTO `tb_group` VALUES ('12', '1', '总经理室', '2021-01-12 07:48:18.858672', '2021-01-21 08:53:25.358505');
INSERT INTO `tb_group` VALUES ('13', '12', '研发一部', '2021-01-12 07:48:37.736017', '2021-01-12 07:48:37.736010');
INSERT INTO `tb_group` VALUES ('14', '12', '研发二部', '2021-01-12 07:48:46.270383', '2021-01-12 07:48:46.270376');
INSERT INTO `tb_group` VALUES ('15', '12', '行政部门', '2021-01-12 07:48:56.720445', '2021-01-12 07:48:56.720439');
INSERT INTO `tb_group` VALUES ('16', '12', '销售部门', '2021-01-21 08:58:11.132956', '2021-01-21 08:58:11.132919');

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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

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
INSERT INTO `tb_group_user` VALUES ('47', '21', '16', '1');
INSERT INTO `tb_group_user` VALUES ('48', '22', '16', '0');

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
  PRIMARY KEY (`projectid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`projectscheduleid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
  `projectschedule_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `projectscheduleid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `ismanager` int(11) NOT NULL,
  PRIMARY KEY (`projectschedule_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=514 DEFAULT CHARSET=utf8;

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
INSERT INTO `tb_role_permission` VALUES ('502', '8', '37');
INSERT INTO `tb_role_permission` VALUES ('503', '8', '38');
INSERT INTO `tb_role_permission` VALUES ('504', '8', '39');
INSERT INTO `tb_role_permission` VALUES ('505', '8', '40');
INSERT INTO `tb_role_permission` VALUES ('506', '8', '41');
INSERT INTO `tb_role_permission` VALUES ('507', '8', '42');
INSERT INTO `tb_role_permission` VALUES ('508', '8', '43');
INSERT INTO `tb_role_permission` VALUES ('509', '8', '44');
INSERT INTO `tb_role_permission` VALUES ('510', '8', '45');
INSERT INTO `tb_role_permission` VALUES ('511', '8', '46');
INSERT INTO `tb_role_permission` VALUES ('512', '8', '47');
INSERT INTO `tb_role_permission` VALUES ('513', '8', '48');

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES ('9', '1', '1');
INSERT INTO `tb_user_role` VALUES ('11', '20', '7');
INSERT INTO `tb_user_role` VALUES ('12', '18', '7');
INSERT INTO `tb_user_role` VALUES ('13', '14', '7');
INSERT INTO `tb_user_role` VALUES ('14', '13', '7');
INSERT INTO `tb_user_role` VALUES ('15', '21', '8');

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
