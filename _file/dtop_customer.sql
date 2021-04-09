SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `dtop_customer`;
CREATE TABLE `dtop_customer`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学校唯一标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学校名称',
  `addr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学校地址',
  `type` tinyint(2) NULL DEFAULT NULL COMMENT '学校类型 1 高校 2 K12 3 中职',
  `dp_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '一卡通系统中的学校code',
  `is_baned` tinyint(1) NULL DEFAULT 0 COMMENT '是否禁用 0 否 1 是',
  `is_ecard_school` tinyint(1) NULL DEFAULT 0 COMMENT '是否上线一卡通 0 否 1 是',
  `is_virtual_card` tinyint(1) NULL DEFAULT 0 COMMENT '是否上线虚拟卡 0 否 1 是',
  `linkman` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学校联系人',
  `phone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学校联系人电话',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '学校描述',
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '校徽图片链接',
  `background_img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '背景图图片链接',
  `latitude` decimal(10, 6) NULL DEFAULT NULL COMMENT '学校地址纬度',
  `longitude` decimal(10, 6) NULL DEFAULT NULL COMMENT '学校地址经度',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 否 1是',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
