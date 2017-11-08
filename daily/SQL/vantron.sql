/*
Navicat MySQL Data Transfer
Source Host     : localhost:3306
Source Database : vantron
Target Host     : localhost:3306
Target Database : vantron
Date: 2012-12-04 18:06:50
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for t_daily
-- ----------------------------
DROP TABLE IF EXISTS `t_daily`;
CREATE TABLE `t_daily` (
  `daily_id` int(12) NOT NULL AUTO_INCREMENT,
  `daily_user` int(10) NOT NULL,
  `daily_begin_time` datetime NOT NULL,
  `daily_end_time` datetime NOT NULL,
  `daily_time_count` int(10) NOT NULL,
  `daily_project` int(10) DEFAULT '-1',
  `daily_type` int(1) NOT NULL DEFAULT '0',
  `daily_task` int(4) NOT NULL,
  `daily_task_description` varchar(4000) CHARACTER SET gb2312 DEFAULT NULL,
  `daily_task_status` varchar(4000) CHARACTER SET gb2312 NOT NULL,
  `daily_problem` varchar(2000) CHARACTER SET gb2312 DEFAULT NULL,
  `daily_checkup` int(1) NOT NULL DEFAULT '0',
  `daily_remark` varchar(2000) CHARACTER SET gb2312 DEFAULT NULL,
  `daily_submit_time` datetime NOT NULL,
  `daily_check_user` int(10) DEFAULT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve2` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `daily_image` varchar(40) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`daily_id`),
  KEY `fk_daily_user` (`daily_check_user`),
  KEY `fk_daily_project` (`daily_project`),
  KEY `fk_daily_task` (`daily_task`),
  KEY `fk_daily_projectUser` (`daily_user`),
  CONSTRAINT `fk_daily_project` FOREIGN KEY (`daily_project`) REFERENCES `t_project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_daily_task` FOREIGN KEY (`daily_task`) REFERENCES `t_task` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_daily_user_2` FOREIGN KEY (`daily_user`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_daily
-- ----------------------------
INSERT INTO `t_daily` VALUES ('1', '8', '2012-11-19 09:10:41', '2012-11-21 09:10:45', '172804', null, '0', '1', '沃尔沃二', '玩儿额外任务而我二', '沃尔沃任务而我而我算法的有', '1', '通道如果恢复', '2012-11-21 09:10:14', '8', null, null, null);
INSERT INTO `t_daily` VALUES ('2', '8', '2012-11-08 13:35:42', '2012-11-14 13:35:47', '518405', null, '0', '1', '11111', '111111111', '1111111111111', '1', '1231231', '2012-11-21 13:35:18', '12', null, null, null);
INSERT INTO `t_daily` VALUES ('3', '12', '2012-11-01 14:45:39', '2012-11-02 14:45:41', '86402', null, '0', '1', '123', '123', '123', '0', null, '2012-11-21 14:45:22', null, null, null, null);
INSERT INTO `t_daily` VALUES ('4', '12', '2012-11-02 09:12:31', '2012-11-03 09:12:35', '86404', null, '0', '1', '123', '123', '123', '0', null, '2012-11-23 09:12:18', null, null, null, null);
INSERT INTO `t_daily` VALUES ('5', '12', '2012-12-02 16:16:55', '2012-12-03 16:17:00', '86405', null, '0', '1', '123', '123', '123', '0', null, '2012-12-03 16:16:30', null, null, null, null);
INSERT INTO `t_daily` VALUES ('6', '12', '2012-12-03 16:19:10', '2012-12-03 16:19:12', '2', null, '0', '3', 'asd', 'asdas', 'asdasd', '0', null, '2012-12-03 16:18:10', null, null, null, null);
INSERT INTO `t_daily` VALUES ('7', '12', '2012-12-03 16:43:42', '2012-12-03 16:43:43', '1', null, '0', '2', '12121', '11321', '112231', '0', null, '2012-12-03 16:43:23', null, null, null, null);
INSERT INTO `t_daily` VALUES ('8', '12', '2012-12-03 16:49:59', '2012-12-03 16:50:01', '2', null, '0', '3', '111111111', '11111111111', '1111111111111', '0', null, '2012-12-03 16:49:30', null, null, null, null);
INSERT INTO `t_daily` VALUES ('9', '12', '2012-12-03 16:53:55', '2012-12-03 16:54:02', '7', null, '0', '3', '2222222222', '2222222222222', '222222222222222', '0', null, '2012-12-03 16:53:32', null, null, null, '1354524819218.jpg');
INSERT INTO `t_daily` VALUES ('10', '12', '2012-12-02 16:59:10', '2012-12-03 16:59:13', '86403', null, '0', '1', 'ssssssssss', 'sssssssss', 'sssssssssssssss', '0', null, '2012-12-03 16:58:51', null, null, null, null);
INSERT INTO `t_daily` VALUES ('11', '12', '2012-12-03 17:03:58', '2012-12-03 17:04:00', '2', null, '0', '1', 'ccccccc', 'cccccccccccc', 'ccccccccccccccc', '0', null, '2012-12-03 17:03:38', null, null, null, null);
INSERT INTO `t_daily` VALUES ('12', '12', '2012-12-03 17:08:05', '2012-12-03 17:08:08', '3', null, '0', '6', 'uuuuuuuu', 'uuuuuuuuuu', 'uuuuuuuuu', '0', null, '2012-12-03 17:07:55', null, null, null, null);
INSERT INTO `t_daily` VALUES ('13', '12', '2012-12-03 17:10:14', '2012-12-03 17:10:16', '2', null, '0', '1', 'zzzzzz', 'zzzzz', 'zzzzzzzzzzz', '0', null, '2012-12-03 17:10:06', null, null, null, null);
INSERT INTO `t_daily` VALUES ('14', '12', '2012-12-03 17:16:23', '2012-12-03 17:16:25', '2', null, '0', '1', '1111111', '111111111', '11111111111', '0', null, '2012-12-03 17:16:14', null, null, null, null);
INSERT INTO `t_daily` VALUES ('15', '12', '2012-12-03 17:18:03', '2012-12-03 17:18:05', '2', null, '0', '4', 'dddddd', 'ddddddddddd', 'ddddddddddddd', '0', null, '2012-12-03 17:17:44', null, null, null, null);
INSERT INTO `t_daily` VALUES ('16', '12', '2012-12-03 17:20:09', '2012-12-03 17:20:11', '2', null, '0', '1', 'ssssssssss', 'sssssssss', 'ssssssssssss', '0', null, '2012-12-03 17:19:59', null, null, null, '1354526416203.jpg');
INSERT INTO `t_daily` VALUES ('17', '12', '2012-12-03 17:26:52', '2012-12-03 17:26:54', '2', '2', '1', '5', 'dddddddd', 'sssssssssss', 'xxxxxxxx', '0', null, '2012-12-03 17:26:37', null, null, null, '1354526825906.JPG');
INSERT INTO `t_daily` VALUES ('18', '12', '2012-12-03 17:46:03', '2012-12-03 17:46:05', '2', '2', '1', '5', 'ggggggg', 'gggggggg', 'gggggggggg', '1', 'jhklhkljkl', '2012-12-03 17:45:38', '12', null, null, '1354527973218.JPG');
INSERT INTO `t_daily` VALUES ('19', '12', '2012-12-03 17:50:21', '2012-12-03 17:50:23', '2', null, '0', '1', 'ddddddd', 'dddddddd', 'dddddddddddd', '1', '88888', '2012-12-03 17:50:11', '12', null, null, null);
INSERT INTO `t_daily` VALUES ('20', '12', '2012-12-03 17:59:44', '2012-12-03 17:59:46', '2', '2', '1', '5', '11111', '1111111111', '1111111111111', '0', null, '2012-12-03 17:59:31', null, null, null, '1354528797468.JPG');
INSERT INTO `t_daily` VALUES ('21', '12', '2012-12-05 17:52:47', '2012-12-05 17:52:50', '3', '2', '1', '5', 'ddddd', 'ddddddddd', 'ddddddddd', '0', null, '2012-12-05 17:46:00', null, null, null, '1354701139687.JPG');

-- ----------------------------
-- Table structure for t_daily_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_daily_reply`;
CREATE TABLE `t_daily_reply` (
  `daily_reply_id` int(10) NOT NULL AUTO_INCREMENT,
  `daily_reply_daily` int(12) NOT NULL,
  `daily_reply_user` int(10) NOT NULL,
  `daily_reply_time` datetime NOT NULL,
  `daily_reply_content` varchar(2000) CHARACTER SET gb2312 NOT NULL,
  `daily_reply_image` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`daily_reply_id`),
  KEY `fk_reply_daily_1` (`daily_reply_daily`),
  KEY `fk_reply_user_1` (`daily_reply_user`),
  CONSTRAINT `fk_reply_daily_1` FOREIGN KEY (`daily_reply_daily`) REFERENCES `t_daily` (`daily_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reply_user_1` FOREIGN KEY (`daily_reply_user`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_daily_reply
-- ----------------------------
INSERT INTO `t_daily_reply` VALUES ('1', '1', '8', '2012-11-21 09:13:50', 'sdf', null, null);
INSERT INTO `t_daily_reply` VALUES ('2', '1', '8', '2012-11-21 09:14:09', 'ertert', null, null);
INSERT INTO `t_daily_reply` VALUES ('3', '1', '8', '2012-11-21 09:14:22', 'xcvxcv', null, null);
INSERT INTO `t_daily_reply` VALUES ('4', '1', '8', '2012-11-21 09:14:30', 'sdfsfsfczxdvxc', null, null);
INSERT INTO `t_daily_reply` VALUES ('5', '1', '8', '2012-11-21 09:14:48', 'ssdfsdfsd', null, null);
INSERT INTO `t_daily_reply` VALUES ('6', '1', '8', '2012-11-21 09:15:15', 'sdfzdfzd', null, null);
INSERT INTO `t_daily_reply` VALUES ('7', '3', '12', '2012-11-21 14:59:39', '123123123', null, null);
INSERT INTO `t_daily_reply` VALUES ('8', '20', '12', '2012-12-03 18:00:43', 'fdfsdfsdsff', null, null);
INSERT INTO `t_daily_reply` VALUES ('9', '18', '12', '2012-12-04 09:52:42', 'fdsdfsdfsdfsdfsdf', null, null);
INSERT INTO `t_daily_reply` VALUES ('10', '20', '12', '2012-12-04 10:26:13', 'sdsdsddsdss', null, null);
INSERT INTO `t_daily_reply` VALUES ('11', '20', '12', '2012-12-04 10:32:18', 'qqqqqqqqqqqqqqq', '1354588357125.JPG', null);
INSERT INTO `t_daily_reply` VALUES ('12', '20', '12', '2012-12-04 10:38:58', 'eeeeeeeeeee', null, null);
INSERT INTO `t_daily_reply` VALUES ('13', '19', '12', '2012-12-04 10:42:33', 'rrrrrrrrrrrrr', '1354588963468.JPG', null);
INSERT INTO `t_daily_reply` VALUES ('14', '20', '12', '2012-12-04 10:59:11', '88888888888', '1354589975453.jpg', null);
INSERT INTO `t_daily_reply` VALUES ('15', '20', '12', '2012-12-04 11:03:35', 'wwwwwww', '1354590224921.jpg', null);
INSERT INTO `t_daily_reply` VALUES ('16', '3', '12', '2012-12-04 14:04:06', 'hjghjghjgjhghj', '1354601059828.JPG', null);
INSERT INTO `t_daily_reply` VALUES ('17', '20', '12', '2012-12-04 14:06:46', '21122112211221', '1354601218859.JPG', null);
INSERT INTO `t_daily_reply` VALUES ('18', '20', '12', '2012-12-04 15:34:03', 'gfdgdfgdfg', '1354606457296.jpg', null);
INSERT INTO `t_daily_reply` VALUES ('19', '21', '12', '2012-12-05 17:53:36', 'gggggggggg', '1354701229328.jpg', null);

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `department_id` int(3) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(40) CHARACTER SET gb2312 NOT NULL,
  `department_head` int(10) DEFAULT NULL,
  `department_description` varchar(200) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve2` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `fk_department_user` (`department_head`),
  CONSTRAINT `fk_department_user` FOREIGN KEY (`department_head`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('1', 'LINUX组', '12', 'linux研发', null, null);
INSERT INTO `t_department` VALUES ('2', 'WINDOWS组', '3', 'wince研发', null, null);
INSERT INTO `t_department` VALUES ('3', '硬件组', '4', '硬件研发', null, null);
INSERT INTO `t_department` VALUES ('4', '研发测试组', '5', '研发测试', null, null);
INSERT INTO `t_department` VALUES ('5', '其他', '6', '无', null, null);

-- ----------------------------
-- Table structure for t_memo
-- ----------------------------
DROP TABLE IF EXISTS `t_memo`;
CREATE TABLE `t_memo` (
  `memo_id` int(10) NOT NULL AUTO_INCREMENT,
  `memo_user` int(10) NOT NULL,
  `memo_time` date NOT NULL,
  `memo_content` varchar(400) CHARACTER SET gb2312 NOT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`memo_id`),
  KEY `fk_memo_user_1` (`memo_user`),
  CONSTRAINT `fk_memo_user_1` FOREIGN KEY (`memo_user`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_memo
-- ----------------------------
INSERT INTO `t_memo` VALUES ('1', '8', '2012-11-23', '色乳房斯蒂芬', null);
INSERT INTO `t_memo` VALUES ('2', '8', '2012-11-23', '斯蒂芬算法', null);
INSERT INTO `t_memo` VALUES ('3', '12', '2012-11-22', '123', null);
INSERT INTO `t_memo` VALUES ('4', '12', '2012-12-05', 'fdgdgfdgdgfdfg', null);

-- ----------------------------
-- Table structure for t_milestone
-- ----------------------------
DROP TABLE IF EXISTS `t_milestone`;
CREATE TABLE `t_milestone` (
  `milestone_id` int(2) NOT NULL AUTO_INCREMENT,
  `milestone_name` varchar(40) CHARACTER SET gb2312 NOT NULL,
  `milestone_description` varchar(200) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`milestone_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_milestone
-- ----------------------------
INSERT INTO `t_milestone` VALUES ('1', '1122121', '123123123', null);
INSERT INTO `t_milestone` VALUES ('2', '12112223213', '13213123213', null);

-- ----------------------------
-- Table structure for t_milestone_conf
-- ----------------------------
DROP TABLE IF EXISTS `t_milestone_conf`;
CREATE TABLE `t_milestone_conf` (
  `milestone_conf_id` int(10) NOT NULL AUTO_INCREMENT,
  `milestone_conf_PCB` int(10) NOT NULL,
  `milestone_conf_milestone` int(2) NOT NULL,
  `milestone_conf_user` int(10) NOT NULL,
  `milestone_conf_opinion` varchar(200) CHARACTER SET gb2312 DEFAULT NULL,
  `milestone_conf_time` datetime NOT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`milestone_conf_id`),
  KEY `fk_milestoneConf_mile_1` (`milestone_conf_milestone`),
  KEY `fk_milestoneConf_PCB_1` (`milestone_conf_PCB`),
  KEY `fk_milestoneConf_user_1` (`milestone_conf_user`),
  CONSTRAINT `fk_milestoneConf_mile_1` FOREIGN KEY (`milestone_conf_milestone`) REFERENCES `t_milestone` (`milestone_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_milestoneConf_PCB_1` FOREIGN KEY (`milestone_conf_PCB`) REFERENCES `t_pcb` (`PCB_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_milestoneConf_user_1` FOREIGN KEY (`milestone_conf_user`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_milestone_conf
-- ----------------------------
INSERT INTO `t_milestone_conf` VALUES ('1', '1', '1', '12', '123123', '2012-11-21 17:02:12', null);
INSERT INTO `t_milestone_conf` VALUES ('2', '2', '1', '12', 'dtdgf', '2012-12-04 14:22:33', null);

-- ----------------------------
-- Table structure for t_pcb
-- ----------------------------
DROP TABLE IF EXISTS `t_pcb`;
CREATE TABLE `t_pcb` (
  `PCB_id` int(10) NOT NULL AUTO_INCREMENT,
  `PCB_name` varchar(40) CHARACTER SET gb2312 NOT NULL,
  `PCB_project` int(10) NOT NULL,
  `PCB_amount` int(8) DEFAULT NULL,
  `PCB_sample` int(4) DEFAULT NULL,
  `PCB_deliver` int(8) DEFAULT NULL,
  `PCB_produce_style` int(1) DEFAULT NULL,
  `PCB_confirm_opinion` varchar(200) CHARACTER SET gb2312 DEFAULT NULL,
  `PCB_confirm_user` int(10) DEFAULT NULL,
  `PCB_confirm_time` datetime DEFAULT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`PCB_id`),
  KEY `fk_PCB_project_1` (`PCB_project`),
  KEY `fk_PCB_user_1` (`PCB_confirm_user`),
  CONSTRAINT `fk_PCB_project_1` FOREIGN KEY (`PCB_project`) REFERENCES `t_project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PCB_user_1` FOREIGN KEY (`PCB_confirm_user`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_pcb
-- ----------------------------
INSERT INTO `t_pcb` VALUES ('1', '333', '1', '12', '12', '12', '0', '1321313132', '12', '2012-11-21 16:47:21', null);
INSERT INTO `t_pcb` VALUES ('2', '6410_1', '2', '1', '0', '6', '0', 'OK', '12', '2012-12-04 14:21:36', null);

-- ----------------------------
-- Table structure for t_project
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `project_id` int(10) NOT NULL AUTO_INCREMENT,
  `project_number` varchar(15) CHARACTER SET gb2312 NOT NULL,
  `project_name` varchar(40) CHARACTER SET gb2312 NOT NULL,
  `project_manager` int(10) DEFAULT NULL,
  `project_begin_time` datetime NOT NULL,
  `project_end_time` datetime DEFAULT NULL,
  `project_status` int(1) NOT NULL DEFAULT '2',
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve2` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `project_description` varchar(1000) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `fk_project_user_1` (`project_manager`),
  CONSTRAINT `fk_project_user_1` FOREIGN KEY (`project_manager`) REFERENCES `t_user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_project
-- ----------------------------
INSERT INTO `t_project` VALUES ('1', '123', '123', '12', '2012-11-21 14:21:50', '2012-11-23 11:27:09', '0', null, null, '123');
INSERT INTO `t_project` VALUES ('2', '222', '222', '12', '2012-11-23 11:15:41', null, '2', null, null, '11111111');

-- ----------------------------
-- Table structure for t_project_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_project_reply`;
CREATE TABLE `t_project_reply` (
  `project_reply_id` int(10) NOT NULL AUTO_INCREMENT,
  `project_reply_project` int(10) NOT NULL,
  `project_reply_user` int(10) NOT NULL,
  `project_reply_time` datetime NOT NULL,
  `project_reply_content` varchar(2000) CHARACTER SET gb2312 NOT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`project_reply_id`),
  KEY `fk_projectReply_user` (`project_reply_user`),
  KEY `fk_projectReply_project` (`project_reply_project`),
  CONSTRAINT `fk_projectReply_project` FOREIGN KEY (`project_reply_project`) REFERENCES `t_project` (`project_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_projectReply_user` FOREIGN KEY (`project_reply_user`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_project_reply
-- ----------------------------

-- ----------------------------
-- Table structure for t_project_task
-- ----------------------------
DROP TABLE IF EXISTS `t_project_task`;
CREATE TABLE `t_project_task` (
  `project_task_id` int(10) NOT NULL AUTO_INCREMENT,
  `project_task_project` int(10) NOT NULL,
  `project_task_task` int(4) NOT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`project_task_id`),
  KEY `fk_projectTask_project_1` (`project_task_project`),
  KEY `fk_projectTask_task_1` (`project_task_task`),
  CONSTRAINT `fk_projectTask_project_1` FOREIGN KEY (`project_task_project`) REFERENCES `t_project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_projectTask_task_1` FOREIGN KEY (`project_task_task`) REFERENCES `t_task` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_project_task
-- ----------------------------
INSERT INTO `t_project_task` VALUES ('1', '1', '5', null);
INSERT INTO `t_project_task` VALUES ('2', '1', '7', null);
INSERT INTO `t_project_task` VALUES ('3', '2', '5', null);
INSERT INTO `t_project_task` VALUES ('4', '2', '7', null);

-- ----------------------------
-- Table structure for t_project_user
-- ----------------------------
DROP TABLE IF EXISTS `t_project_user`;
CREATE TABLE `t_project_user` (
  `project_user_id` int(10) NOT NULL AUTO_INCREMENT,
  `project_user_project` int(10) NOT NULL,
  `project_user_user` int(10) NOT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`project_user_id`),
  KEY `fk_projectUser_project_1` (`project_user_project`),
  KEY `fk_projectUser_user_1` (`project_user_user`),
  CONSTRAINT `fk_projectUser_project_1` FOREIGN KEY (`project_user_project`) REFERENCES `t_project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_projectUser_user_1` FOREIGN KEY (`project_user_user`) REFERENCES `t_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_project_user
-- ----------------------------
INSERT INTO `t_project_user` VALUES ('2', '1', '8', null);
INSERT INTO `t_project_user` VALUES ('3', '1', '9', null);
INSERT INTO `t_project_user` VALUES ('4', '1', '10', null);
INSERT INTO `t_project_user` VALUES ('5', '1', '11', null);
INSERT INTO `t_project_user` VALUES ('6', '1', '12', null);
INSERT INTO `t_project_user` VALUES ('7', '2', '12', null);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `role_id` int(3) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(40) CHARACTER SET gb2312 NOT NULL,
  `role_description` varchar(200) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve2` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '项目人员', null, null, null);
INSERT INTO `t_role` VALUES ('2', '项目经理', null, null, null);
INSERT INTO `t_role` VALUES ('3', '部门长', null, null, null);
INSERT INTO `t_role` VALUES ('4', 'PMO', null, null, null);
INSERT INTO `t_role` VALUES ('5', '管理员', null, null, null);

-- ----------------------------
-- Table structure for t_task
-- ----------------------------
DROP TABLE IF EXISTS `t_task`;
CREATE TABLE `t_task` (
  `task_id` int(4) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(40) CHARACTER SET gb2312 NOT NULL,
  `task_type` int(1) NOT NULL DEFAULT '1',
  `task_reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_task
-- ----------------------------
INSERT INTO `t_task` VALUES ('1', 'fdff', '0', null);
INSERT INTO `t_task` VALUES ('2', 'xfcgvbcb', '0', null);
INSERT INTO `t_task` VALUES ('3', '3333', '0', null);
INSERT INTO `t_task` VALUES ('4', '1112121', '0', null);
INSERT INTO `t_task` VALUES ('5', '444444', '1', null);
INSERT INTO `t_task` VALUES ('6', '11111', '0', null);
INSERT INTO `t_task` VALUES ('7', '111111111', '1', null);

-- ----------------------------
-- Table structure for t_task_assign
-- ----------------------------
DROP TABLE IF EXISTS `t_task_assign`;
CREATE TABLE `t_task_assign` (
  `task_assign_id` int(10) NOT NULL AUTO_INCREMENT,
  `task_assign_project` int(10) NOT NULL,
  `task_assign_task` int(4) NOT NULL,
  `task_assign_begin_time` datetime NOT NULL,
  `task_assign_end_time` datetime NOT NULL,
  `task_assign_exec_user` int(10) NOT NULL,
  `task_assign_opinion` varchar(200) CHARACTER SET gb2312 DEFAULT NULL,
  `task_assign_confirm_user` int(10) DEFAULT NULL,
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `task_assign_time_limit` int(15) DEFAULT '0',
  PRIMARY KEY (`task_assign_id`),
  KEY `fk_taskAssign_project_1` (`task_assign_project`),
  KEY `fk_taskAssign_user_1` (`task_assign_exec_user`),
  KEY `fk_taskAssign_task_1` (`task_assign_task`),
  KEY `fk_taskAssign_user_100` (`task_assign_confirm_user`),
  CONSTRAINT `fk_taskAssign_projectUser_1` FOREIGN KEY (`task_assign_exec_user`) REFERENCES `t_project_user` (`project_user_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_taskAssign_project_1` FOREIGN KEY (`task_assign_project`) REFERENCES `t_project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_taskAssign_task_1` FOREIGN KEY (`task_assign_task`) REFERENCES `t_task` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_taskAssign_user_100` FOREIGN KEY (`task_assign_confirm_user`) REFERENCES `t_user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_task_assign
-- ----------------------------
INSERT INTO `t_task_assign` VALUES ('1', '1', '5', '2012-11-22 09:45:02', '2012-11-23 09:45:04', '12', '555', '12', null, '86402');
INSERT INTO `t_task_assign` VALUES ('2', '2', '5', '2012-12-04 17:26:24', '2012-12-06 17:26:26', '12', 'sasasad', '12', null, '172802');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) CHARACTER SET gb2312 NOT NULL,
  `user_password` varchar(20) CHARACTER SET gb2312 NOT NULL,
  `user_sex` varchar(2) CHARACTER SET gb2312 NOT NULL,
  `user_department` int(3) DEFAULT NULL,
  `user_email` varchar(40) CHARACTER SET gb2312 DEFAULT NULL,
  `user_role1` int(1) DEFAULT '1',
  `user_role2` int(1) DEFAULT '0',
  `user_role3` int(1) DEFAULT '0',
  `user_role4` int(1) DEFAULT '0',
  `user_role5` int(1) DEFAULT '0',
  `reserve1` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `reserve2` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_role_1` (`user_role1`),
  KEY `fk_user_role_2` (`user_role2`),
  KEY `fk_user_role_3` (`user_role3`),
  KEY `fk_user_role_4` (`user_role4`),
  KEY `fk_user_role_5` (`user_role5`),
  KEY `fk_user_department_1` (`user_department`),
  CONSTRAINT `fk_user_department_1` FOREIGN KEY (`user_department`) REFERENCES `t_department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '123', '男', null, '344@f.com', '1', '0', '0', '0', '1', null, null);
INSERT INTO `t_user` VALUES ('2', '甘西军', '123', '男', '1', 'xj.gan@vantrom.com', '1', '0', '0', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('3', '杜承贤', '123', '男', '2', 'cx.du@vantron.com', '1', '0', '1', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('4', '王成云', '123', '男', '3', 'cy.wang@vantron.com', '1', '0', '1', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('5', '梁亿', '123', '男', '4', 'y.liang@vantron.com', '1', '0', '1', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('6', '孔玮', '123', '男', '5', 'w.kong@vantron.com', '1', '0', '1', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('7', '郭攀峰', '123', '男', '1', 'pf.guo@vantron.com', '1', '0', '0', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('8', '赵汶富', '123', '男', '1', 'wf.zhao@vantron.com', '1', '0', '0', '1', '0', null, null);
INSERT INTO `t_user` VALUES ('9', '王宣智', '123', '男', '1', 'xz.wang@vantron.com', '1', '0', '0', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('10', '刘中刚', '123', '男', '1', 'zg.liu@vantron.com', '1', '0', '0', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('11', '苏德江', '123', '男', '1', 'dj.su@vantron.com', '1', '0', '0', '0', '0', null, null);
INSERT INTO `t_user` VALUES ('12', '123', '123', '男', '1', null, '1', '1', '1', '1', '0', null, null);
