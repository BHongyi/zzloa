/*
Navicat MySQL Data Transfer

Source Server         : zzldb
Source Server Version : 80021
Source Host           : localhost:3306
Source Database       : zzlprm

Target Server Type    : MYSQL
Target Server Version : 80021
File Encoding         : 65001

Date: 2020-12-31 16:07:27
*/

SET FOREIGN_KEY_CHECKS=0;

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
