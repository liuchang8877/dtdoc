SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for import_rn_auth_user
-- ----------------------------
DROP TABLE IF EXISTS `dtop_import_rn_auth_user`;
CREATE TABLE `dtop_import_rn_auth_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证件类型代码 1 居民身份证 A 护照',
  `identity_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证件号',
  `real_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '真实姓名',
  `mobile_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `customer_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '学校唯一标识',
  `outid` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '一卡通号',
  `serial_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '学工号',
  `type` tinyint(2) NULL DEFAULT NULL COMMENT '在当前部门的职能或角色（1 学生 2 教师 3 家长 4 后勤人员 5 临时人员）',
  `customer_dept_id` bigint(20) NULL DEFAULT NULL COMMENT '所属学校组织机构id',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 否 1 是',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1052 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
