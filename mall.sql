/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:32:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_address
-- ----------------------------
DROP TABLE IF EXISTS `tbl_address`;
CREATE TABLE `tbl_address`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tel` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addressDetail` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `areaCode` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `country` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `county` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isDefault` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `postalCode` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_address
-- ----------------------------
INSERT INTO `tbl_address` VALUES ('1584957662669', 'cc', '1584957622018', '18786085146', 'cc', '110102', '北京市', '', '西城区', '0', '', '北京市');

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:32:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_goodlist
-- ----------------------------
DROP TABLE IF EXISTS `tbl_goodlist`;
CREATE TABLE `tbl_goodlist`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `listName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goodId` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_goodlist
-- ----------------------------
INSERT INTO `tbl_goodlist` VALUES ('15849568382640', '大', '3', '100', '1584956838175', '1584956838196');
INSERT INTO `tbl_goodlist` VALUES ('15849568839330', '大', '1', '15', '1584956883828', '1584956883891');
INSERT INTO `tbl_goodlist` VALUES ('15849568839331', '小', '1.04', '10', '1584956883871', '1584956883891');
INSERT INTO `tbl_goodlist` VALUES ('15849574780350', 'dd', '11', '100', '1584957477904', '1584957477993');
INSERT INTO `tbl_goodlist` VALUES ('15849574780351', 'ww', '1.04', '15', '1584957477946', '1584957477993');

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:32:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_goods
-- ----------------------------
DROP TABLE IF EXISTS `tbl_goods`;
CREATE TABLE `tbl_goods`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `names` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sortId` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hot` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_goods
-- ----------------------------
INSERT INTO `tbl_goods` VALUES ('1584956838196', '可乐', '3', '1584956781562', '显示');
INSERT INTO `tbl_goods` VALUES ('1584956883891', '辣条', '1', '1584956791256', '显示');
INSERT INTO `tbl_goods` VALUES ('1584957477993', '存储ccc', '11', '1584957424325', '显示');

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:32:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_image
-- ----------------------------
DROP TABLE IF EXISTS `tbl_image`;
CREATE TABLE `tbl_image`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_image
-- ----------------------------
INSERT INTO `tbl_image` VALUES ('1584956732842', '1584956732806');
INSERT INTO `tbl_image` VALUES ('1584956740381', '1584956740339');
INSERT INTO `tbl_image` VALUES ('1584957386900', '1584957386842');
INSERT INTO `tbl_image` VALUES ('1584957397288', '1584957397252');

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:32:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_joinwe
-- ----------------------------
DROP TABLE IF EXISTS `tbl_joinwe`;
CREATE TABLE `tbl_joinwe`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_joinwe
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:32:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_pay
-- ----------------------------
DROP TABLE IF EXISTS `tbl_pay`;
CREATE TABLE `tbl_pay`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `listId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goodId` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_pay
-- ----------------------------
INSERT INTO `tbl_pay` VALUES ('1584957678746', '15849568839330', 'ccc', '1', 'http://localhost:3000/getImg?imagePath=1584956883828', '1584956883891', '大', '1', '1584957622018', '2', 'cc18786085146北京市北京市西城区cc');
INSERT INTO `tbl_pay` VALUES ('1584957874111', '15849574780350', 'c', '3', 'http://localhost:3000/getImg?imagePath=1584957477904', '1584957477993', 'dd', '11', '1584957622018', '3', 'cc18786085146北京市北京市西城区cc');

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:33:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_shopcar
-- ----------------------------
DROP TABLE IF EXISTS `tbl_shopcar`;
CREATE TABLE `tbl_shopcar`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `listId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goodId` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_shopcar
-- ----------------------------
INSERT INTO `tbl_shopcar` VALUES ('1584957874111', '15849574780350', 'c', '2', 'http://localhost:3000/getImg?imagePath=1584957477904', '1584957477993', 'dd', '11', '1584957622018', '0', 'cc18786085146北京市北京市西城区cc');

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:33:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_sort
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sort`;
CREATE TABLE `tbl_sort`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `names` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_sort
-- ----------------------------
INSERT INTO `tbl_sort` VALUES ('1584956781562', '饮料', '1584956780334');
INSERT INTO `tbl_sort` VALUES ('1584956791256', '零食', '1584956790861');
INSERT INTO `tbl_sort` VALUES ('1584957424325', '顶顶顶', '1584957423531');

SET FOREIGN_KEY_CHECKS = 1;
/*
 Navicat Premium Data Transfer

 Source Server         : video
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost:3306
 Source Schema         : supermarket

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : 65001

 Date: 23/03/2020 18:33:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user`  (
  `ids` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `names` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userImg` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ids`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('1584957622018', 'wwwcc', 'www', 'www', '1584958130584', '15515133358');
INSERT INTO `tbl_user` VALUES ('1584958227670', 'eeeccc', 'eee', 'eee', '1584958546413', '18786085146');

SET FOREIGN_KEY_CHECKS = 1;
