SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer_dept
-- ----------------------------
DROP TABLE IF EXISTS `dtop_customer_dept`;
CREATE TABLE `dtop_customer_dept`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属学校唯一标识',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构名称',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父节点 0-顶级结点',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校自定的编号 level为1时-院系号 level为2时-专业号 level为4时-班号 ',
  `level` tinyint(2) NULL DEFAULT NULL COMMENT '教学院系级别 1-院系 2-专业 3-年级 4-班级 0-非教学院系',
  `type` tinyint(2)  NULL DEFAULT NULL COMMENT '组织机构类型 1-教学院系 2-科研机构 3-公共服务(指图书馆、档案馆、分析测试中心、计算/网络/信息/电教/教育技术中心等学术支撑单位 ) 4-党务部门(含工会、团委、妇委会)  5-行政机构  6-附属单位  7-后勤部门  8-校办产业  9-其他',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `is_parent` tinyint(2) NULL DEFAULT NULL COMMENT '是否父节点 1-是  0-否',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 1-删除  0-未删除',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户部门表' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
