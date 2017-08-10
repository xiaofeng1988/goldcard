/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : demo

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2017-03-23 11:13:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sequence
-- ----------------------------
DROP TABLE IF EXISTS `sequence`;
CREATE TABLE `sequence` (
  `name` varchar(50) NOT NULL,
  `current_value` int(11) NOT NULL,
  `increment` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sequence
-- ----------------------------
INSERT INTO `sequence` VALUES ('TestSeq', '1', '1');
INSERT INTO `sequence` VALUES ('sys_dept_type_seq', '19', '1');
INSERT INTO `sequence` VALUES ('sys_dept_seq', '10', '1');
INSERT INTO `sequence` VALUES ('sys_right_seq', '22', '1');
INSERT INTO `sequence` VALUES ('sys_dept_and_type_seq', '17', '1');
INSERT INTO `sequence` VALUES ('sys_user_seq', '36', '1');
INSERT INTO `sequence` VALUES ('sys_role_and_user_seq', '316', '1');
INSERT INTO `sequence` VALUES ('sys_user_and_right_seq', '732', '1');
INSERT INTO `sequence` VALUES ('sys_role_and_right_seq', '137', '1');
INSERT INTO `sequence` VALUES ('student_seq', '5', '1');
INSERT INTO `sequence` VALUES ('sys_role_seq', '5', '1');
INSERT INTO `sequence` VALUES ('sys_user_type_seq', '8', '1');
INSERT INTO `sequence` VALUES ('sys_user_online_seq', '9', '1');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `sid` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `inserttime` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2', '张三', '0', '阿斯顿挥洒更多撒', null, '阿斯顿');
INSERT INTO `student` VALUES ('4', '王五', '0', '儿童热太热', null, '儿童热太热太热太热太热太热太热太热太热');
INSERT INTO `student` VALUES ('5', '酱油哥', '0', '玉泉路按时打算188', '2017-03-20 09:52:51', '最强大脑酱油哥，最强大脑酱油哥，最强大脑酱油哥，最强大脑酱油哥，最强大脑酱油哥，哈哈');

-- ----------------------------
-- Table structure for sys_auth
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth`;
CREATE TABLE `sys_auth` (
  `id` smallint(6) NOT NULL COMMENT '主键id',
  `auth_val` varchar(10) DEFAULT NULL COMMENT '位移公式',
  `auth_binary` varchar(50) DEFAULT NULL COMMENT '二进制(长度50=最大可有50种权限)',
  `auth_decimal` int(5) DEFAULT NULL COMMENT '十进制',
  `auth_en` varchar(25) DEFAULT NULL COMMENT '英文标识',
  `auth_zh` varchar(25) DEFAULT NULL COMMENT '中文标识',
  `auth_des` varchar(25) DEFAULT NULL COMMENT '权限说明',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_auth
-- ----------------------------
INSERT INTO `sys_auth` VALUES ('1', '1 << 0', '1', '1', 'CANSHOW', '浏览', '');
INSERT INTO `sys_auth` VALUES ('2', '1 << 1', '10', '2', 'CANADD', '添加', '');
INSERT INTO `sys_auth` VALUES ('3', '1 << 2', '100', '4', 'CANUPDATE', '修改', null);
INSERT INTO `sys_auth` VALUES ('4', '1 << 3', '1000', '8', 'CANDELETE', '删除', null);
INSERT INTO `sys_auth` VALUES ('5', '1 << 4', '10000', '16', 'CANMANAGER', '设置', null);
INSERT INTO `sys_auth` VALUES ('6', '1 << 5', '100000', '32', 'CANUP', '上传', null);
INSERT INTO `sys_auth` VALUES ('7', '1 << 6', '1000000', '64', 'CANDOWN', '下载', null);

-- ----------------------------
-- Table structure for sys_code_table
-- ----------------------------
DROP TABLE IF EXISTS `sys_code_table`;
CREATE TABLE `sys_code_table` (
  `id` bigint(20) NOT NULL,
  `sys_id` varchar(10) DEFAULT NULL,
  `module_id` varchar(10) DEFAULT NULL,
  `table_name` varchar(25) NOT NULL,
  `field_name` varchar(25) NOT NULL,
  `key` varchar(10) NOT NULL,
  `value` varchar(25) DEFAULT NULL,
  `des` varchar(45) DEFAULT NULL,
  `orderid` int(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `TABLE_FIELD_UNIQUE` (`table_name`,`field_name`,`key`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_code_table
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL COMMENT '自增ID',
  `father_id` int(11) DEFAULT NULL COMMENT '父id（组织机构树使用）',
  `no` varchar(50) DEFAULT NULL COMMENT '编码',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `shortname` varchar(100) DEFAULT NULL COMMENT '简称',
  `type` varchar(200) DEFAULT NULL COMMENT '类型',
  `longitude` varchar(50) DEFAULT NULL COMMENT 'x坐标',
  `latitude` varchar(50) DEFAULT NULL COMMENT 'y坐标',
  `img_url` varchar(200) DEFAULT NULL COMMENT '部门图片',
  `orderid` int(5) DEFAULT NULL COMMENT '排序',
  `isdel` int(1) DEFAULT NULL COMMENT '是否删除（0-否，1-是）',
  `coordinates` varchar(255) DEFAULT NULL COMMENT '地理位置边界集合',
  `remark` text COMMENT '简介',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '0', null, '品融集团公司', '集团公司', null, '1', '1', null, '0', '0', null, '1');
INSERT INTO `sys_dept` VALUES ('2', '1', null, '门店', '门店', null, null, null, null, '2', '0', null, null);
INSERT INTO `sys_dept` VALUES ('4', '2', null, '望江门店', '望江门店', null, '112.2323', '23.324', null, '2', '0', null, '<p>234324</p>');
INSERT INTO `sys_dept` VALUES ('5', '2', null, '西湖店', '西湖店', null, '', '123.2312', null, '3', '0', null, '');
INSERT INTO `sys_dept` VALUES ('9', '1', null, ' 信息部门', ' 信息部门', null, '12', '12', null, '1', '0', null, '<p>&nbsp;信息部门&nbsp;信息部门&nbsp;信息部门&nbsp;信息部门</p>');
INSERT INTO `sys_dept` VALUES ('7', '2', null, '天目山店', '天目山店', null, '45', '', null, '1', '0', null, '');
INSERT INTO `sys_dept` VALUES ('10', '9', null, ' 云计算小分队', ' 云计算小分队', null, '112.232', '', null, '0', '0', null, '<p>&nbsp;云计算小分队&nbsp;云计算小分队&nbsp;云计算小分队&nbsp;云计算小分队&nbsp;云计算小分队</p>');

-- ----------------------------
-- Table structure for sys_dept_and_right
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_and_right`;
CREATE TABLE `sys_dept_and_right` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `deptid` int(11) DEFAULT NULL COMMENT '部门id',
  `sysrightid` int(11) DEFAULT NULL COMMENT '菜单id',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `userdeptid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deptid` (`deptid`),
  KEY `sysrightid` (`sysrightid`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dept_and_right
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept_and_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_and_type`;
CREATE TABLE `sys_dept_and_type` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `deptid` int(11) NOT NULL COMMENT '部门id',
  `typeid` int(11) NOT NULL COMMENT '类型id',
  PRIMARY KEY (`id`),
  KEY `deptid` (`deptid`),
  KEY `typeid` (`typeid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='部门和类型关系表';

-- ----------------------------
-- Records of sys_dept_and_type
-- ----------------------------
INSERT INTO `sys_dept_and_type` VALUES ('1', '4', '10');
INSERT INTO `sys_dept_and_type` VALUES ('2', '5', '10');
INSERT INTO `sys_dept_and_type` VALUES ('14', '9', '11');
INSERT INTO `sys_dept_and_type` VALUES ('11', '7', '11');
INSERT INTO `sys_dept_and_type` VALUES ('16', '1', '10');
INSERT INTO `sys_dept_and_type` VALUES ('15', '9', '10');
INSERT INTO `sys_dept_and_type` VALUES ('17', '10', '19');

-- ----------------------------
-- Table structure for sys_dept_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_type`;
CREATE TABLE `sys_dept_type` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `no` varchar(50) DEFAULT NULL COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '类型名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dept_type
-- ----------------------------
INSERT INTO `sys_dept_type` VALUES ('19', '19', '技术研发', null);
INSERT INTO `sys_dept_type` VALUES ('18', '18', '秘书团', null);
INSERT INTO `sys_dept_type` VALUES ('12', '12', '总裁办', null);
INSERT INTO `sys_dept_type` VALUES ('11', '11', '信息部', null);
INSERT INTO `sys_dept_type` VALUES ('10', '10', '集团公司', null);

-- ----------------------------
-- Table structure for sys_right
-- ----------------------------
DROP TABLE IF EXISTS `sys_right`;
CREATE TABLE `sys_right` (
  `id` int(11) NOT NULL COMMENT '菜单自增id',
  `father_id` int(11) DEFAULT NULL COMMENT '菜单父ID',
  `level` int(1) DEFAULT NULL COMMENT '菜单级别（1-第一层别，2-第二层菜单，3-第三层菜单）',
  `icon` varchar(100) DEFAULT NULL COMMENT '菜单图标',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单请求路径',
  `name` varchar(200) DEFAULT NULL COMMENT '菜单名称',
  `childrights` int(11) DEFAULT NULL COMMENT '所包含的子权限集合',
  `orderid` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `url` (`url`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of sys_right
-- ----------------------------
INSERT INTO `sys_right` VALUES ('1', '0', '1', 'icon-xtwh', 'sysRightController/findSysRightByFatherId', '系统管理', '125', '1');
INSERT INTO `sys_right` VALUES ('3', '1', '2', 'icon-xtwh', 'systemController/sysUser/load', '用户管理', '127', '3');
INSERT INTO `sys_right` VALUES ('5', '1', '2', 'icon-xtwh', 'systemController/sysDept/load', '部门管理', '15', '4');
INSERT INTO `sys_right` VALUES ('6', '1', '2', 'icon-xtwh', 'systemController/sysRole/list', '角色管理', '127', '6');
INSERT INTO `sys_right` VALUES ('7', '1', '2', 'icon-xtwh', 'systemController/sysRight/load', '注册功能', '15', '8');
INSERT INTO `sys_right` VALUES ('8', '1', '2', 'icon-xtwh', 'systemController/sysDeptType/load', '部门类型管理', '31', '1');
INSERT INTO `sys_right` VALUES ('21', '20', '2', null, 'admin/student/list/load', 'Demo-CURD', '1', '7');
INSERT INTO `sys_right` VALUES ('20', '0', '1', null, 'sysRightController/findSysRightByFatherId', 'Demo展示', '1', '2');
INSERT INTO `sys_right` VALUES ('22', '1', '2', null, 'systemController/sysUserType/load', '用户类型管理', '127', '5');

-- ----------------------------
-- Table structure for sys_right_and_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_right_and_dept`;
CREATE TABLE `sys_right_and_dept` (
  `rdid` int(11) NOT NULL COMMENT '自增id',
  `rid` int(11) NOT NULL COMMENT '菜单id',
  `did` int(11) NOT NULL COMMENT '部门id',
  KEY `rid` (`rid`),
  KEY `did` (`did`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='菜单和部门关系表';

-- ----------------------------
-- Records of sys_right_and_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_right_bak
-- ----------------------------
DROP TABLE IF EXISTS `sys_right_bak`;
CREATE TABLE `sys_right_bak` (
  `id` int(11) NOT NULL COMMENT '菜单自增id',
  `father_id` int(11) DEFAULT NULL COMMENT '菜单父ID',
  `level` int(1) DEFAULT NULL COMMENT '菜单级别（1-第一层别，2-第二层菜单，3-第三层菜单）',
  `icon` varchar(100) DEFAULT NULL COMMENT '菜单图标',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单请求路径',
  `name` varchar(200) DEFAULT NULL COMMENT '菜单名称',
  `childrights` int(11) DEFAULT NULL COMMENT '所包含的子权限集合',
  `orderid` int(11) DEFAULT NULL COMMENT '排序'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_right_bak
-- ----------------------------
INSERT INTO `sys_right_bak` VALUES ('1', '0', '1', 'icon-xtwh', 'sysRightController/findSysRightByFatherId', '系统管理', '125', '1');
INSERT INTO `sys_right_bak` VALUES ('2', '0', '1', 'icon-xtwh', 'sysRightController/findSysRightByFatherId', 'Demo展示', '1', '2');
INSERT INTO `sys_right_bak` VALUES ('3', '1', '2', 'icon-xtwh', 'systemController/sysUser/load', '用户管理', '127', '1');
INSERT INTO `sys_right_bak` VALUES ('4', '1', '2', 'icon-xtwh', 'sysRightController/findSysRightByFatherId', '二级菜单', '1', '2');
INSERT INTO `sys_right_bak` VALUES ('5', '1', '2', 'icon-xtwh', 'systemController/sysDept/load', '部门管理', '435', '3');
INSERT INTO `sys_right_bak` VALUES ('6', '1', '2', 'icon-xtwh', 'systemController/sysRole/list', '角色管理', '1', '4');
INSERT INTO `sys_right_bak` VALUES ('7', '1', '2', 'icon-xtwh', 'systemController/sysRight/load', '注册功能', '15', '5');
INSERT INTO `sys_right_bak` VALUES ('8', '1', '2', 'icon-xtwh', 'systemController/sysDeptType/load', '部门类型管理', '54', '6');
INSERT INTO `sys_right_bak` VALUES ('16', '2', '2', null, 'admin/student/list/load', 'Demo展示-1', '1', '7');
INSERT INTO `sys_right_bak` VALUES ('18', '16', '3', null, 'systemController/sysDept/333', '三级菜单', '97', '1');
INSERT INTO `sys_right_bak` VALUES ('19', '18', '4', null, '44444444', '4444', '1', '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL COMMENT '角色表',
  `creator` int(11) NOT NULL COMMENT '创建者',
  `no` varchar(2) NOT NULL COMMENT '角色No',
  `name` varchar(50) NOT NULL COMMENT '角色名',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '1', '12', '1-1信息部角色', '11-1信息部角色');
INSERT INTO `sys_role` VALUES ('2', '1', '13', '1-2系统管理员角色', '系统管理员角色');
INSERT INTO `sys_role` VALUES ('3', '1', '14', '1-3集团审核人员', '1-4集团审核人员');
INSERT INTO `sys_role` VALUES ('5', '1', '', '门店管理员', '管理门店的所有权限');

-- ----------------------------
-- Table structure for sys_role_and_right
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_and_right`;
CREATE TABLE `sys_role_and_right` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `sysright` int(11) NOT NULL COMMENT '菜单id',
  `role` int(11) NOT NULL COMMENT '角色id',
  `childrights` int(11) NOT NULL COMMENT '子权限集合',
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  KEY `sysright` (`sysright`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='角色和菜单关系表';

-- ----------------------------
-- Records of sys_role_and_right
-- ----------------------------
INSERT INTO `sys_role_and_right` VALUES ('133', '3', '5', '97');
INSERT INTO `sys_role_and_right` VALUES ('132', '21', '5', '1');
INSERT INTO `sys_role_and_right` VALUES ('131', '1', '4', '1');
INSERT INTO `sys_role_and_right` VALUES ('130', '3', '4', '97');
INSERT INTO `sys_role_and_right` VALUES ('129', '8', '3', '53');
INSERT INTO `sys_role_and_right` VALUES ('128', '4', '3', '1');
INSERT INTO `sys_role_and_right` VALUES ('127', '5', '3', '49');
INSERT INTO `sys_role_and_right` VALUES ('126', '6', '3', '1');
INSERT INTO `sys_role_and_right` VALUES ('125', '7', '3', '9');
INSERT INTO `sys_role_and_right` VALUES ('124', '1', '3', '1');
INSERT INTO `sys_role_and_right` VALUES ('123', '3', '3', '23');
INSERT INTO `sys_role_and_right` VALUES ('107', '3', '2', '97');
INSERT INTO `sys_role_and_right` VALUES ('108', '1', '2', '1');
INSERT INTO `sys_role_and_right` VALUES ('134', '20', '5', '1');
INSERT INTO `sys_role_and_right` VALUES ('135', '1', '5', '1');
INSERT INTO `sys_role_and_right` VALUES ('136', '6', '5', '1');
INSERT INTO `sys_role_and_right` VALUES ('137', '5', '5', '1');

-- ----------------------------
-- Table structure for sys_role_and_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_and_user`;
CREATE TABLE `sys_role_and_user` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `sysuser` int(11) NOT NULL COMMENT '用户id',
  `role` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  KEY `sysuser` (`sysuser`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='角色和用户关系表';

-- ----------------------------
-- Records of sys_role_and_user
-- ----------------------------
INSERT INTO `sys_role_and_user` VALUES ('14', '32', '1');
INSERT INTO `sys_role_and_user` VALUES ('8', '31', '3');
INSERT INTO `sys_role_and_user` VALUES ('7', '31', '2');
INSERT INTO `sys_role_and_user` VALUES ('13', '32', '3');
INSERT INTO `sys_role_and_user` VALUES ('15', '32', '2');
INSERT INTO `sys_role_and_user` VALUES ('16', '33', '2');
INSERT INTO `sys_role_and_user` VALUES ('17', '33', '1');
INSERT INTO `sys_role_and_user` VALUES ('21', '34', '2');
INSERT INTO `sys_role_and_user` VALUES ('20', '34', '1');
INSERT INTO `sys_role_and_user` VALUES ('25', '29', '2');
INSERT INTO `sys_role_and_user` VALUES ('24', '29', '1');
INSERT INTO `sys_role_and_user` VALUES ('300', '2', '2');
INSERT INTO `sys_role_and_user` VALUES ('299', '2', '1');
INSERT INTO `sys_role_and_user` VALUES ('231', '35', '3');
INSERT INTO `sys_role_and_user` VALUES ('230', '35', '2');
INSERT INTO `sys_role_and_user` VALUES ('229', '35', '1');
INSERT INTO `sys_role_and_user` VALUES ('177', '24', '2');
INSERT INTO `sys_role_and_user` VALUES ('176', '24', '1');
INSERT INTO `sys_role_and_user` VALUES ('99', '25', '3');
INSERT INTO `sys_role_and_user` VALUES ('316', '1', '5');
INSERT INTO `sys_role_and_user` VALUES ('315', '1', '3');
INSERT INTO `sys_role_and_user` VALUES ('314', '1', '2');
INSERT INTO `sys_role_and_user` VALUES ('233', '36', '2');
INSERT INTO `sys_role_and_user` VALUES ('313', '1', '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `no` varchar(100) DEFAULT NULL COMMENT '编码',
  `deptid` int(11) NOT NULL COMMENT '部门ID',
  `name` varchar(100) NOT NULL COMMENT '用户姓名',
  `loginname` varchar(100) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `sex` char(1) NOT NULL COMMENT '性别',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `typeofwork` varchar(50) DEFAULT NULL COMMENT '职务',
  `typeofperson` int(11) DEFAULT NULL COMMENT '用户类型',
  `islock` char(1) DEFAULT '0' COMMENT '是否锁定（0-否，1-是）',
  `isdel` char(1) DEFAULT '0' COMMENT '是否删除（0-否，1-是）',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机',
  `mobile` varchar(20) DEFAULT NULL COMMENT '电话',
  PRIMARY KEY (`id`),
  KEY `deptid` (`deptid`),
  KEY `loginname` (`loginname`,`password`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', '1', '张三', 'admin', '21232F297A57A5A743894A0E4A801FC3', 'Y', '1321970594@qq.com', '管理员', '1', '1', '0', '1', '15001015666');
INSERT INTO `sys_user` VALUES ('2', '001', '1', '李四', 'lisi', 'DC3A8F1670D65BEA69B7B65048A0AC40', 'N', 'xiao3242@qq.com', '管理员1', '1', '1', '0', '1123213', '15002567896');
INSERT INTO `sys_user` VALUES ('21', null, '9', '丁刚', 'dinggang', 'dinggang', 'Y', 'dinggang@qq.com', '主管', '3', '0', '0', '8766567', null);
INSERT INTO `sys_user` VALUES ('32', null, '9', '卡卡', 'kaka', 'kaka', 'Y', '12432@qq.com', '总监', '3', '0', '0', '010-8688456', '15001015349');
INSERT INTO `sys_user` VALUES ('22', null, '9', '周润发', 'zhourunfa', 'zhourunfa', 'Y', '12432@qq.com', '影星', '3', '0', '0', '8788988', null);
INSERT INTO `sys_user` VALUES ('31', null, '9', '刘德华', 'liudehua', 'liudehua', 'Y', '12432@qq.com', 'sasss', '3', '0', '0', '111111', '');
INSERT INTO `sys_user` VALUES ('24', null, '1', '王五', 'wangwu', '12345', 'Y', '12432@qq.com', '秘书', '1', '0', '0', '111111', null);
INSERT INTO `sys_user` VALUES ('25', null, '1', '楼秘书', '123', '123', 'Y', '12432@qq.com', '秘书', '1', '0', '0', '111111', null);
INSERT INTO `sys_user` VALUES ('29', null, '1', '老司机', 'laosiji', '123456', 'Y', '12432@qq.com', '总管', '1', '0', '0', '111111', '18665678976');
INSERT INTO `sys_user` VALUES ('36', null, '9', '郝精锐', 'haojingrui', 'FC8DBA5223C2E94AC30740FF35477648', 'Y', 'haojingrui@qq.com', '信息部经理', '3', '0', '0', '001-8678688', '15268507072');

-- ----------------------------
-- Table structure for sys_user_and_right
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_and_right`;
CREATE TABLE `sys_user_and_right` (
  `id` int(11) NOT NULL,
  `sysright` int(11) NOT NULL,
  `sysuser` int(11) NOT NULL,
  `childrights` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sysright` (`sysright`),
  KEY `sysuser` (`sysuser`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户和菜单表';

-- ----------------------------
-- Records of sys_user_and_right
-- ----------------------------
INSERT INTO `sys_user_and_right` VALUES ('529', '20', '35', '1');
INSERT INTO `sys_user_and_right` VALUES ('538', '1', '36', '1');
INSERT INTO `sys_user_and_right` VALUES ('528', '3', '35', '127');
INSERT INTO `sys_user_and_right` VALUES ('527', '21', '35', '1');
INSERT INTO `sys_user_and_right` VALUES ('363', '16', '24', '1');
INSERT INTO `sys_user_and_right` VALUES ('362', '18', '24', '1');
INSERT INTO `sys_user_and_right` VALUES ('361', '5', '24', '33');
INSERT INTO `sys_user_and_right` VALUES ('537', '20', '36', '1');
INSERT INTO `sys_user_and_right` VALUES ('536', '3', '36', '127');
INSERT INTO `sys_user_and_right` VALUES ('535', '21', '36', '1');
INSERT INTO `sys_user_and_right` VALUES ('534', '8', '35', '55');
INSERT INTO `sys_user_and_right` VALUES ('732', '8', '1', '31');
INSERT INTO `sys_user_and_right` VALUES ('360', '7', '24', '1');
INSERT INTO `sys_user_and_right` VALUES ('359', '1', '24', '1');
INSERT INTO `sys_user_and_right` VALUES ('358', '2', '24', '1');
INSERT INTO `sys_user_and_right` VALUES ('357', '3', '24', '111');
INSERT INTO `sys_user_and_right` VALUES ('532', '6', '35', '1');
INSERT INTO `sys_user_and_right` VALUES ('531', '7', '35', '15');
INSERT INTO `sys_user_and_right` VALUES ('530', '1', '35', '1');
INSERT INTO `sys_user_and_right` VALUES ('146', '8', '25', '52');
INSERT INTO `sys_user_and_right` VALUES ('145', '7', '25', '45');
INSERT INTO `sys_user_and_right` VALUES ('144', '6', '25', '32');
INSERT INTO `sys_user_and_right` VALUES ('143', '5', '25', '49');
INSERT INTO `sys_user_and_right` VALUES ('142', '4', '25', '1');
INSERT INTO `sys_user_and_right` VALUES ('141', '3', '25', '85');
INSERT INTO `sys_user_and_right` VALUES ('140', '16', '25', '105');
INSERT INTO `sys_user_and_right` VALUES ('731', '22', '1', '127');
INSERT INTO `sys_user_and_right` VALUES ('730', '5', '1', '15');
INSERT INTO `sys_user_and_right` VALUES ('729', '6', '1', '127');
INSERT INTO `sys_user_and_right` VALUES ('728', '7', '1', '15');
INSERT INTO `sys_user_and_right` VALUES ('727', '1', '1', '1');
INSERT INTO `sys_user_and_right` VALUES ('726', '20', '1', '1');
INSERT INTO `sys_user_and_right` VALUES ('725', '3', '1', '127');
INSERT INTO `sys_user_and_right` VALUES ('533', '5', '35', '51');
INSERT INTO `sys_user_and_right` VALUES ('539', '7', '36', '15');
INSERT INTO `sys_user_and_right` VALUES ('540', '6', '36', '1');
INSERT INTO `sys_user_and_right` VALUES ('541', '5', '36', '51');
INSERT INTO `sys_user_and_right` VALUES ('542', '8', '36', '55');
INSERT INTO `sys_user_and_right` VALUES ('724', '21', '1', '1');
INSERT INTO `sys_user_and_right` VALUES ('696', '5', '2', '1');
INSERT INTO `sys_user_and_right` VALUES ('695', '1', '2', '1');
INSERT INTO `sys_user_and_right` VALUES ('694', '20', '2', '1');
INSERT INTO `sys_user_and_right` VALUES ('693', '3', '2', '1');
INSERT INTO `sys_user_and_right` VALUES ('692', '21', '2', '1');

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `stime` varchar(50) DEFAULT NULL COMMENT '开始时间',
  `etime` varchar(50) DEFAULT NULL COMMENT '结束时间',
  `session_id` varchar(50) DEFAULT NULL COMMENT 'sessionId',
  `fm` varchar(50) DEFAULT NULL COMMENT '来源',
  `ip` varchar(50) DEFAULT NULL COMMENT 'ip地址',
  `mac` varchar(50) DEFAULT NULL COMMENT 'mac地址',
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------
INSERT INTO `sys_user_online` VALUES ('19', '1', '2017-03-22 18:56:17', null, '1F05D416513B4F6C4DCD7725B021FB0B', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('20', '1', '2017-03-22 19:11:03', null, 'B3C93978A38C527ADDD69B1A8CA0323E', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('21', '1', '2017-03-22 19:12:40', null, 'CE30CCCA48B8133A15B7DCA02882CCCE', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('18', '1', '2017-03-22 18:45:05', '2017-03-22 18:45:26', 'A8409A16F2F2E7C71D8A398D8DAAB937', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('22', '2', '2017-03-22 19:14:24', '2017-03-22 19:14:57', 'CE30CCCA48B8133A15B7DCA02882CCCE', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('23', '2', '2017-03-22 19:14:58', '2017-03-22 19:15:06', '4CD36705781CDE28E8F199425CF0C633', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('24', '2', '2017-03-22 19:39:28', null, 'BCC0128C0B44212F3660A8129D608F63', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('25', '1', '2017-03-22 19:44:36', '2017-03-22 19:44:43', 'BCC0128C0B44212F3660A8129D608F63', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('26', '1', '2017-03-22 19:44:54', '2017-03-22 19:45:07', 'DE26BD366278B17AA75F72FFBD0006E6', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('27', '1', '2017-03-22 19:47:09', '2017-03-22 19:47:13', 'C37B0CF82EB0362222C0649520E1B741', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('28', '1', '2017-03-22 19:47:21', '2017-03-22 19:47:31', '3C4AD61F393B590D36730901291BDC90', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('29', '1', '2017-03-22 19:48:20', '2017-03-22 19:48:44', 'B4333220FFB3A8EB74354E847DDED2E9', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('30', '1', '2017-03-22 19:49:01', '2017-03-22 19:49:51', '9982845CF915A4180C1251C51CAAE0D4', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('31', '1', '2017-03-22 19:49:52', '2017-03-22 19:50:58', 'E66E78493FD807B0AE26C65012AEE02E', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('32', '2', '2017-03-22 19:51:03', '2017-03-22 19:51:14', '4EF3169B0A2AF6F3BFD964D74C002AA5', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('33', '2', '2017-03-22 19:51:15', null, 'B1A792E5DF331DFC3BC7489D27788816', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('34', '2', '2017-03-22 19:53:46', null, 'FB4FDB1492699680FA7164EB7CBBDFC3', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('35', '1', '2017-03-22 19:59:23', '2017-03-22 19:59:36', 'FB4FDB1492699680FA7164EB7CBBDFC3', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('36', '1', '2017-03-22 20:09:05', null, 'A0DC2856D7F6F2B17CED9163B0DB9C4E', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('37', '1', '2017-03-22 20:10:21', null, 'AC92309780D9D9D5FAA81AC7CAD5DA12', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('38', '2', '2017-03-22 20:10:50', '2017-03-22 20:12:28', 'AC92309780D9D9D5FAA81AC7CAD5DA12', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('39', '2', '2017-03-22 20:20:38', '2017-03-22 20:20:42', '2664FEA568897592B288FE9DA9BBEBE0', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('40', '2', '2017-03-22 20:20:43', '2017-03-22 20:22:31', '76DE018F6674505A654B3B90FEF959BA', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('41', '2', '2017-03-23 10:53:34', '2017-03-23 10:53:50', '6D20134BA433F605306170D7E20E26EF', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('42', '1', '2017-03-23 10:53:54', null, 'A25E11EA0C0EA9BD336134498D63B045', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('43', '2', '2017-03-23 10:54:28', '2017-03-23 10:57:25', 'A25E11EA0C0EA9BD336134498D63B045', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('44', '2', '2017-03-23 11:06:48', '2017-03-23 11:07:01', 'CF4C0A1A3699C66D80EBDAD5757BD9FC', 'PC端', '127.0.0.1', null, null);
INSERT INTO `sys_user_online` VALUES ('45', '1', '2017-03-23 11:07:05', '2017-03-23 11:09:25', '01E37E73B13B1438930C340D44E98618', 'PC端', '127.0.0.1', null, null);

-- ----------------------------
-- Table structure for sys_user_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_type`;
CREATE TABLE `sys_user_type` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `deptid` int(11) DEFAULT NULL COMMENT '部门id',
  `name` varchar(50) NOT NULL COMMENT '类型名',
  PRIMARY KEY (`id`),
  KEY `deptid` (`deptid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_type
-- ----------------------------
INSERT INTO `sys_user_type` VALUES ('1', null, '集团部');
INSERT INTO `sys_user_type` VALUES ('2', null, '信息部管理员');
INSERT INTO `sys_user_type` VALUES ('3', null, '门店管理员');
INSERT INTO `sys_user_type` VALUES ('5', null, '总裁办');

-- ----------------------------
-- Function structure for currval
-- ----------------------------
DROP FUNCTION IF EXISTS `currval`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `currval`(seq_name VARCHAR(50)) RETURNS int(11)
    DETERMINISTIC
BEGIN
     DECLARE value INTEGER; 
     SET value = 0; 
     SELECT current_value INTO value 
          FROM sequence
          WHERE name = seq_name; 
     RETURN value; 
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for nextval
-- ----------------------------
DROP FUNCTION IF EXISTS `nextval`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nextval`(seq_name VARCHAR(50)) RETURNS int(11)
    DETERMINISTIC
BEGIN
     UPDATE sequence
          SET current_value = current_value + increment 
          WHERE name = seq_name; 
     RETURN currval(seq_name); 
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for setval
-- ----------------------------
DROP FUNCTION IF EXISTS `setval`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `setval`(seq_name VARCHAR(50), value INTEGER) RETURNS int(11)
    DETERMINISTIC
BEGIN
     UPDATE sequence
          SET current_value = value 
          WHERE name = seq_name; 
     RETURN currval(seq_name); 
END
;;
DELIMITER ;
