/*
Navicat MySQL Data Transfer

Source Server         : 3.49
Source Server Version : 50528
Source Host           : 192.168.3.49:3306
Source Database       : updatedb

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2016-09-13 13:13:17
*/

DROP DATABASE IF EXISTS updatedb;
CREATE DATABASE updatedb DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE updatedb;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `local_ver`
-- ----------------------------
DROP TABLE IF EXISTS `local_ver`;
CREATE TABLE `local_ver` (
  `name` varchar(255) NOT NULL COMMENT '程序名',
  `ver` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of local_ver
-- ----------------------------
INSERT INTO `local_ver` VALUES ('autoupdate', '20160913');
INSERT INTO `local_ver` VALUES ('disrec', '20160812');
INSERT INTO `local_ver` VALUES ('filetrans', '20160726');
INSERT INTO `local_ver` VALUES ('ftpserver', '20160625');
INSERT INTO `local_ver` VALUES ('ftp_download', '20160830');
INSERT INTO `local_ver` VALUES ('js', '20160824');
INSERT INTO `local_ver` VALUES ('pullstreams', '20160822');
INSERT INTO `local_ver` VALUES ('study', '20160824');
INSERT INTO `local_ver` VALUES ('videoprocess', '20160729');
INSERT INTO `local_ver` VALUES ('zkdm', '20160817');

-- ----------------------------
-- Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `download_time` datetime DEFAULT NULL COMMENT '升级包下载成功时间',
  `update_time` datetime DEFAULT NULL COMMENT '升级时间',
  `location_log` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for `server_ver`
-- ----------------------------
DROP TABLE IF EXISTS `server_ver`;
CREATE TABLE `server_ver` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '程序名',
  `ver` varchar(255) NOT NULL,
  `package` varchar(255) DEFAULT NULL,
  `base` int(10) NOT NULL DEFAULT '3' COMMENT '1-CentOS6.3;  2-CentOS6.7;  3-both',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of server_ver
-- ----------------------------
INSERT INTO `server_ver` VALUES ('autoupdate', '20160913', null, '3');
INSERT INTO `server_ver` VALUES ('disrec', '20160812', null, '3');
INSERT INTO `server_ver` VALUES ('filetrans', '20160908', 'update_filetrans_for_area_platform_1.2.6_base_on_CentOS6.7.zip', '3');
INSERT INTO `server_ver` VALUES ('ftpserver', '20160625', '', '3');
INSERT INTO `server_ver` VALUES ('ftp_download', '20160902', 'update_ftp-downloda_for_area_platform-1.2.6_base_on_CentOS6.7.zip', '3');
INSERT INTO `server_ver` VALUES ('js', '20160902', 'update_study-js_for_area_platform_1.2.6_base_on_CentOS6.3&CentOS6.7.zip', '3');
INSERT INTO `server_ver` VALUES ('pullstreams', '20160822', '', '3');
INSERT INTO `server_ver` VALUES ('study', '20160824', null, '3');
INSERT INTO `server_ver` VALUES ('videoprocess', '20160729', '', '3');
INSERT INTO `server_ver` VALUES ('zkdm', '20160817', '', '3');
