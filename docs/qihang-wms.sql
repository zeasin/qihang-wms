/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : qihang-wms

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 03/01/2026 16:12:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for erp_logistics
-- ----------------------------
DROP TABLE IF EXISTS `erp_logistics`;
CREATE TABLE `erp_logistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司编码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NULL DEFAULT NULL COMMENT '状态（0禁用1启用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购物流公司表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_logistics
-- ----------------------------

-- ----------------------------
-- Table structure for erp_purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order`;
CREATE TABLE `erp_purchase_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `order_num` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单编号',
  `order_date` date NOT NULL COMMENT '订单日期',
  `order_time` bigint NOT NULL COMMENT '订单创建时间',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `ship_amount` decimal(6, 2) NOT NULL COMMENT '物流费用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '订单状态 0待审核1已审核101供应商已确认102供应商已发货2已收货3已入库',
  `audit_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '采购单审核人',
  `audit_time` bigint NULL DEFAULT 0 COMMENT '审核时间',
  `supplier_confirm_time` datetime NULL DEFAULT NULL COMMENT '供应商确认时间',
  `supplier_delivery_time` datetime NULL DEFAULT NULL COMMENT '供应商发货时间',
  `received_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order
-- ----------------------------
INSERT INTO `erp_purchase_order` VALUES (2, 34, 'PUR20251228153252', '2025-12-28', 1766907172, 0.00, 0.00, NULL, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2025-12-28 15:32:53', NULL, NULL);
INSERT INTO `erp_purchase_order` VALUES (3, 34, 'PUR20251228153353', '2025-12-28', 1766907233, 0.00, 0.00, NULL, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2025-12-28 15:33:54', NULL, NULL);

-- ----------------------------
-- Table structure for erp_purchase_order_cost
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_cost`;
CREATE TABLE `erp_purchase_order_cost`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '采购单ID（主键）',
  `supplier_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '采购单金额',
  `order_date` date NULL DEFAULT NULL COMMENT '采购订单日期',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购订单编号',
  `order_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `order_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `order_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  `actual_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '实际金额',
  `freight` decimal(6, 2) NULL DEFAULT NULL COMMENT '运费',
  `confirm_user` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '确认人',
  `confirm_time` datetime NULL DEFAULT NULL COMMENT '确认时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `pay_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '已支付金额',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `pay_count` int NULL DEFAULT NULL COMMENT '支付次数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `status` int NULL DEFAULT NULL COMMENT '状态（0未支付1已支付）',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单费用确认表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_cost
-- ----------------------------

-- ----------------------------
-- Table structure for erp_purchase_order_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_item`;
CREATE TABLE `erp_purchase_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NULL DEFAULT 0 COMMENT '订单id',
  `order_num` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `trans_type` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '150501采购 150502退货',
  `amount` double NULL DEFAULT 0 COMMENT '购货金额',
  `order_date` date NULL DEFAULT NULL COMMENT '订单日期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `goods_id` bigint NULL DEFAULT 0 COMMENT '商品ID',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `spec_id` bigint NULL DEFAULT 0 COMMENT '商品规格id',
  `spec_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `color_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `color_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `size_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尺码',
  `style_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '款式',
  `price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '单价',
  `dis_amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '折扣额',
  `dis_rate` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '折扣率',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '数量(采购单据)',
  `inQty` bigint NOT NULL DEFAULT 0 COMMENT '已入库数量',
  `locationId` int NULL DEFAULT NULL COMMENT '入库的仓库id',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '1删除 0正常',
  `status` int NULL DEFAULT 0 COMMENT '状态（同billStatus）0待审核1正常2已作废3已入库',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`trans_type` ASC) USING BTREE,
  INDEX `billdate`(`order_date` ASC) USING BTREE,
  INDEX `invId`(`goods_id` ASC) USING BTREE,
  INDEX `transType`(`trans_type` ASC) USING BTREE,
  INDEX `iid`(`order_id` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_item
-- ----------------------------
INSERT INTO `erp_purchase_order_item` VALUES (2, 2, 'PUR20251228153252', 'Purchase', 22.9, '2025-12-28', '', 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 47, 'LSZMLED0010024W', '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', '24W', '', 22.90, 0.00, 0.00, 1, 0, NULL, 0, 0);
INSERT INTO `erp_purchase_order_item` VALUES (3, 3, 'PUR20251228153353', 'Purchase', 22.9, '2025-12-28', '', 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 46, 'LSZMLED0010018W', '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', '18W', '', 22.90, 0.00, 0.00, 1, 0, NULL, 0, 0);

-- ----------------------------
-- Table structure for erp_purchase_order_payable
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_payable`;
CREATE TABLE `erp_purchase_order_payable`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商名称',
  `amount` decimal(10, 2) NOT NULL COMMENT '应付金额',
  `date` date NOT NULL COMMENT '应付日期',
  `invoice_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票号码',
  `purchase_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购单号',
  `purchase_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购说明',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购单应付款' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_payable
-- ----------------------------

-- ----------------------------
-- Table structure for erp_purchase_order_ship
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_ship`;
CREATE TABLE `erp_purchase_order_ship`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '采购单ID（主键）',
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `order_id` bigint NULL DEFAULT NULL,
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `freight` decimal(6, 2) NULL DEFAULT NULL COMMENT '运费',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `receipt_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` int NULL DEFAULT NULL COMMENT '状态（0未收货1已收货2已入库）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `back_count` int NULL DEFAULT NULL COMMENT '退回数量',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `stock_in_count` int NULL DEFAULT NULL COMMENT '入库数量',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `order_date` date NULL DEFAULT NULL COMMENT '采购订单日期',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购订单编号',
  `order_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `order_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `order_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单物流表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_ship
-- ----------------------------

-- ----------------------------
-- Table structure for erp_stock_in
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_in`;
CREATE TABLE `erp_stock_in`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_in_num` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '入库单据编号',
  `stock_in_type` int NOT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `source_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  `source_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `stock_in_operator_id` bigint NULL DEFAULT NULL COMMENT '操作入库人id',
  `stock_in_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作入库人',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '入库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_in
-- ----------------------------

-- ----------------------------
-- Table structure for erp_stock_in_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_in_item`;
CREATE TABLE `erp_stock_in_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_in_id` bigint NOT NULL COMMENT '入库单id',
  `stock_in_type` int NULL DEFAULT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_no` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_item_id` bigint NOT NULL COMMENT '来源单itemId',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `quantity` int NOT NULL COMMENT '原始数量',
  `in_quantity` int NOT NULL DEFAULT 0 COMMENT '入库数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '入库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_in_item
-- ----------------------------

-- ----------------------------
-- Table structure for erp_stock_out
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_out`;
CREATE TABLE `erp_stock_out`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_out_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出库单编号',
  `source_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源单据号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单据Id',
  `stock_out_type` int NOT NULL DEFAULT 1 COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `goods_unit` int NOT NULL COMMENT '商品数',
  `spec_unit` int NOT NULL COMMENT '商品规格数',
  `spec_unit_total` int NOT NULL COMMENT '总件数',
  `out_total` int NULL DEFAULT NULL COMMENT '已出库数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态：0待出库1部分出库2全部出库',
  `print_status` int NOT NULL COMMENT '打印状态：是否打印1已打印0未打印',
  `print_time` datetime NULL DEFAULT NULL COMMENT '打印时间',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `operator_id` int NULL DEFAULT 0 COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_out
-- ----------------------------
INSERT INTO `erp_stock_out` VALUES (5, 'DDCK-20251009144849', '251002-171237742200640', 5, 1, 1, 1, 1, 0, '备货单生成出库单', 0, 0, NULL, NULL, NULL, 0, '', '2025-10-09 14:48:49', '备货单生成出库单', '2025-10-09 06:48:49', NULL);
INSERT INTO `erp_stock_out` VALUES (6, 'DDCK-20251009145209', '251002-171237742200640', 5, 1, 1, 1, 1, 0, '备货单生成出库单', 0, 1, '2025-10-09 23:16:41', NULL, NULL, 0, '', '2025-10-09 14:52:09', '备货单生成出库单', '2025-10-09 15:16:41', NULL);

-- ----------------------------
-- Table structure for erp_stock_out_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_out_item`;
CREATE TABLE `erp_stock_out_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_out_type` int NOT NULL COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `entry_id` bigint NOT NULL COMMENT '出库单id（外键）',
  `source_order_id` bigint NOT NULL COMMENT '来源订单id',
  `source_order_item_id` bigint NOT NULL COMMENT '来源订单itemId出库对应的itemId，如：order_item表id、invoice_info表id',
  `source_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '来源订单号',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `spec_id` bigint NOT NULL COMMENT '商品规格id',
  `spec_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码',
  `original_quantity` int NOT NULL COMMENT '总数量',
  `out_quantity` int NOT NULL DEFAULT 0 COMMENT '已出库数量',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `picked_time` datetime NULL DEFAULT NULL COMMENT '完成拣货时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态：0待出库1部分出库2全部出库',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`spec_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_out_item
-- ----------------------------
INSERT INTO `erp_stock_out_item` VALUES (5, 1, 5, 5, 6, '251002-171237742200640', 0, 45, 'LEDDP00102', 1, 0, NULL, NULL, 0, '2025-10-09 14:48:49', NULL);
INSERT INTO `erp_stock_out_item` VALUES (6, 1, 6, 5, 6, '251002-171237742200640', 0, 45, 'LEDDP00102', 1, 0, NULL, NULL, 0, '2025-10-09 14:52:09', NULL);

-- ----------------------------
-- Table structure for erp_stock_out_item_position
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_out_item_position`;
CREATE TABLE `erp_stock_out_item_position`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `entry_id` bigint NOT NULL COMMENT '出库单ID',
  `entry_item_id` bigint NOT NULL DEFAULT 0 COMMENT '出库单ItemID',
  `goods_inventory_id` bigint NOT NULL DEFAULT 0 COMMENT '库存ID',
  `goods_inventory_detail_id` bigint NOT NULL DEFAULT 0 COMMENT '库存详情ID',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '出库数量',
  `warehouse_id` bigint NULL DEFAULT NULL COMMENT '仓库ID',
  `position_id` bigint NULL DEFAULT NULL COMMENT '仓位id',
  `position_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓位编码',
  `operator_id` bigint NULL DEFAULT 0 COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_stock_info_item_id_index`(`goods_inventory_detail_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库仓位详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_out_item_position
-- ----------------------------

-- ----------------------------
-- Table structure for erp_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouse`;
CREATE TABLE `erp_warehouse`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库名称',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '街道',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态0禁用  1正常',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_warehouse
-- ----------------------------

-- ----------------------------
-- Table structure for erp_warehouse_position
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouse_position`;
CREATE TABLE `erp_warehouse_position`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL COMMENT '仓库id',
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库/货架编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓位/货架名称',
  `parent_id` int NOT NULL COMMENT '上级id',
  `depth` int NULL DEFAULT 1 COMMENT '层级深度1级2级3级',
  `parent_id1` int NOT NULL COMMENT '一级类目id',
  `parent_id2` int NOT NULL COMMENT '二级类目id',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_delete` int NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库仓位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_warehouse_position
-- ----------------------------

-- ----------------------------
-- Table structure for o_after_sale
-- ----------------------------
DROP TABLE IF EXISTS `o_after_sale`;
CREATE TABLE `o_after_sale`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` int NULL DEFAULT NULL COMMENT '类型（0无需处理；10退货；20换货；80补发；99订单拦截；）',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NULL DEFAULT NULL COMMENT '店铺类型',
  `refund_id` bigint NULL DEFAULT NULL COMMENT '退款id（o_refund表主键）',
  `refund_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后单号',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `sub_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单号',
  `o_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单id（o_order表主键id）',
  `o_order_item_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单id（o_order_item表主键id）',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '平台商品skuid',
  `quantity` int NULL DEFAULT NULL COMMENT '售后数量',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `img` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku描述',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '系统商品id（o_goods表主键id）',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '系统商品skuId（o_goods表主键id）',
  `has_goods_send` int NULL DEFAULT NULL COMMENT ' 是否发货',
  `send_logistics_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货物流单号',
  `return_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回人信息json',
  `return_logistics_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回快递单号',
  `return_logistics_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回物流公司名称',
  `receiver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人联系电话',
  `receiver_province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `receiver_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `receiver_town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人详细地址',
  `reissue_logistics_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货快递单号（补发、换货发货）',
  `reissue_logistics_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货快递公司',
  `status` int NULL DEFAULT NULL COMMENT '状态:0待处理；1已发出；2已收货；10已完成',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS售后处理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_after_sale
-- ----------------------------

-- ----------------------------
-- Table structure for o_goods
-- ----------------------------
DROP TABLE IF EXISTS `o_goods`;
CREATE TABLE `o_goods`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图片地址',
  `outer_erp_goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品唯一ID',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '商品编号',
  `unit_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '单位名称',
  `category_id` bigint NULL DEFAULT 0 COMMENT '商品分类ID',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '条码',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态1销售中2已下架',
  `length` float NOT NULL DEFAULT 0 COMMENT '衣长/裙长/裤长',
  `height` float NOT NULL DEFAULT 0 COMMENT '高度/袖长',
  `width` float NOT NULL DEFAULT 0 COMMENT '宽度/胸阔(围)',
  `width1` float NOT NULL DEFAULT 0 COMMENT '肩阔',
  `width2` float NOT NULL DEFAULT 0 COMMENT '腰阔',
  `width3` float NOT NULL DEFAULT 0 COMMENT '臀阔',
  `weight` float NOT NULL DEFAULT 0 COMMENT '重量',
  `disable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0启用   1禁用',
  `period` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '保质期',
  `pur_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '预计采购价格',
  `whole_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议批发价',
  `retail_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议零售价',
  `unit_cost` decimal(8, 2) NULL DEFAULT NULL COMMENT '单位成本',
  `supplier_id` bigint NULL DEFAULT 0 COMMENT '供应商id',
  `brand_id` bigint NULL DEFAULT 0 COMMENT '品牌id',
  `attr1` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性1：季节',
  `attr2` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性2：分类',
  `attr3` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性3：风格',
  `attr4` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性4：年份',
  `attr5` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性5：面料',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外链url',
  `low_qty` int NULL DEFAULT 0 COMMENT '最低库存（预警）',
  `high_qty` int NULL DEFAULT 0 COMMENT '最高库存（预警）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地市',
  `town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地区',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `goods_id_unique`(`outer_erp_goods_id` ASC) USING BTREE,
  INDEX `number`(`goods_num` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OMS商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods
-- ----------------------------
INSERT INTO `o_goods` VALUES (16, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 'LSZMLED001', '', 4, '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, '0', 22.90, 0.00, 0.00, NULL, 34, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'admin', '2025-10-09 14:40:12', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for o_goods_brand
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_brand`;
CREATE TABLE `o_goods_brand`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品牌名',
  `status` int NULL DEFAULT NULL COMMENT '状态',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_brand
-- ----------------------------

-- ----------------------------
-- Table structure for o_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_category`;
CREATE TABLE `o_goods_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类编码',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类名称',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_id` bigint NULL DEFAULT NULL COMMENT '上架分类id',
  `path` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '分类路径',
  `sort` int NULL DEFAULT 0 COMMENT '排序值',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `isDelete` tinyint(1) NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_category
-- ----------------------------
INSERT INTO `o_goods_category` VALUES (3, 'ZM', '照明', NULL, 0, '', 0, NULL, 0, 'admin', '2025-10-09 14:36:08', NULL, NULL);
INSERT INTO `o_goods_category` VALUES (4, 'LED', 'LED光源', NULL, 3, '', 0, NULL, 0, 'admin', '2025-10-09 14:36:32', NULL, NULL);

-- ----------------------------
-- Table structure for o_goods_category_attribute
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_category_attribute`;
CREATE TABLE `o_goods_category_attribute`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `category_id` bigint NOT NULL,
  `type` int NOT NULL DEFAULT 0 COMMENT '类型：0属性1规格',
  `title` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '\'属性名\'',
  `code` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '固定值color颜色size尺码style款式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_category_attribute
-- ----------------------------
INSERT INTO `o_goods_category_attribute` VALUES (2, 3, 1, '颜色', 'color');
INSERT INTO `o_goods_category_attribute` VALUES (3, 3, 1, '亮度', 'size');

-- ----------------------------
-- Table structure for o_goods_category_attribute_value
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_category_attribute_value`;
CREATE TABLE `o_goods_category_attribute_value`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，属性值id',
  `category_attribute_id` bigint NULL DEFAULT NULL COMMENT '属性id',
  `value` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性值文本',
  `sku_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成SKU的编码',
  `orderNum` int NULL DEFAULT 0,
  `isDelete` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 431 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_category_attribute_value
-- ----------------------------
INSERT INTO `o_goods_category_attribute_value` VALUES (427, 2, '白光', '00', 0, 0);
INSERT INTO `o_goods_category_attribute_value` VALUES (428, 3, '12W', '12W', 0, 0);
INSERT INTO `o_goods_category_attribute_value` VALUES (429, 3, '18W', '18W', 0, 0);
INSERT INTO `o_goods_category_attribute_value` VALUES (430, 3, '24W', '24W', 0, 0);

-- ----------------------------
-- Table structure for o_goods_inventory
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_inventory`;
CREATE TABLE `o_goods_inventory`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名',
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'SKU名',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '当前库存',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIdIndex`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品库存表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_inventory
-- ----------------------------
INSERT INTO `o_goods_inventory` VALUES (45, 16, 'LSZMLED001', NULL, NULL, 45, 'LSZMLED0010012W', NULL, 0, 0, '2025-10-09 14:40:12', '添加商品', '2025-10-09 06:40:12', NULL);
INSERT INTO `o_goods_inventory` VALUES (46, 16, 'LSZMLED001', NULL, NULL, 46, 'LSZMLED0010018W', NULL, 0, 0, '2025-10-09 14:40:12', '添加商品', '2025-10-09 06:40:12', NULL);
INSERT INTO `o_goods_inventory` VALUES (47, 16, 'LSZMLED001', NULL, NULL, 47, 'LSZMLED0010024W', NULL, 0, 0, '2025-10-09 14:40:12', '添加商品', '2025-10-09 06:40:12', NULL);

-- ----------------------------
-- Table structure for o_goods_inventory_batch
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_inventory_batch`;
CREATE TABLE `o_goods_inventory_batch`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `inventory_id` bigint NOT NULL COMMENT '库存id',
  `batch_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '批次号',
  `origin_qty` bigint NOT NULL COMMENT '初始数量',
  `current_qty` bigint NOT NULL DEFAULT 0 COMMENT '当前数量',
  `pur_price` double NULL DEFAULT 0 COMMENT '采购价',
  `pur_id` bigint NOT NULL COMMENT '采购单id',
  `pur_item_id` bigint NOT NULL COMMENT '采购单itemId',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `sku_id` bigint NOT NULL COMMENT '规格id',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品库存批次' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_inventory_batch
-- ----------------------------

-- ----------------------------
-- Table structure for o_goods_inventory_operation
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_inventory_operation`;
CREATE TABLE `o_goods_inventory_operation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `batch_id` bigint NOT NULL COMMENT '库存批次id',
  `batch_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '库存批次号',
  `type` int NOT NULL COMMENT '库存类型（1增加库存2减少库存3锁定库存）',
  `inventory_detail_id` bigint NOT NULL COMMENT '商品库存id（本表id减库存的时候关联）',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '操作库存数量',
  `locked_quantity` int NOT NULL COMMENT '锁定库存数量（status变成已结算时把该字段值更新到quantity）',
  `price` double NULL DEFAULT 0 COMMENT '价格（type=1采购价格；type=2出库时的价格）',
  `biz_type` int NOT NULL COMMENT '业务类型（10采购入库20采购退货30退货入库40订单出库）',
  `biz_id` bigint NOT NULL COMMENT '业务单id',
  `biz_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务单号',
  `biz_item_id` bigint NOT NULL COMMENT '业务单itemId',
  `status` int NOT NULL COMMENT '状态（0待结算1已结算）',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库库存操作记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_inventory_operation
-- ----------------------------

-- ----------------------------
-- Table structure for o_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_sku`;
CREATE TABLE `o_goods_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` bigint NOT NULL COMMENT '外键（o_goods）',
  `outer_erp_goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部erp系统商品id',
  `outer_erp_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部erp系统skuId(唯一)',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名',
  `goods_num` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `sku_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规格名',
  `sku_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规格编码',
  `color_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色label',
  `color_id` bigint NULL DEFAULT 0 COMMENT '颜色id',
  `color_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色值',
  `color_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色图片',
  `size_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尺码label',
  `size_id` bigint NULL DEFAULT 0 COMMENT '尺码id',
  `size_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尺码值(材质)',
  `style_label` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '款式label',
  `style_id` bigint NULL DEFAULT 0 COMMENT '款式id',
  `style_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '款式值',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '库存条形码',
  `pur_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '预计采购价格',
  `retail_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议零售价',
  `unit_cost` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '单位成本',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态',
  `low_qty` int NULL DEFAULT 0 COMMENT '最低库存（预警）',
  `high_qty` int NULL DEFAULT 0 COMMENT '最高库存（预警）',
  `volume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'erp商品体积',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sku_id_unique`(`outer_erp_sku_id` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE,
  INDEX `number`(`sku_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS商品SKU表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_sku
-- ----------------------------
INSERT INTO `o_goods_sku` VALUES (45, 16, NULL, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', NULL, '白光 12W', 'LSZMLED0010012W', NULL, 427, '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 428, '12W', NULL, 0, '', NULL, 22.90, 0.00, 0.00, '', 1, 0, 0, NULL, '2025-10-09 06:40:12', NULL);
INSERT INTO `o_goods_sku` VALUES (46, 16, NULL, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', NULL, '白光 18W', 'LSZMLED0010018W', NULL, 427, '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 429, '18W', NULL, 0, '', NULL, 22.90, 0.00, 0.00, '', 1, 0, 0, NULL, '2025-10-09 06:40:12', NULL);
INSERT INTO `o_goods_sku` VALUES (47, 16, NULL, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', NULL, '白光 24W', 'LSZMLED0010024W', NULL, 427, '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 430, '24W', NULL, 0, '', NULL, 22.90, 0.00, 0.00, '', 1, 0, 0, NULL, '2025-10-09 06:40:12', NULL);

-- ----------------------------
-- Table structure for o_goods_sku_attr
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_sku_attr`;
CREATE TABLE `o_goods_sku_attr`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint NOT NULL,
  `type` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `k` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kid` int NULL DEFAULT NULL,
  `vid` int NULL DEFAULT NULL,
  `v` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_sku_attr
-- ----------------------------
INSERT INTO `o_goods_sku_attr` VALUES (1, 16, 'color', '颜色', 114, 427, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (2, 16, 'size', '尺码', 115, 428, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (3, 16, 'size', '尺码', 115, 429, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (4, 16, 'size', '尺码', 115, 430, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (5, 16, 'style', '款式', 116, 427, NULL, NULL);

-- ----------------------------
-- Table structure for o_goods_supplier
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_supplier`;
CREATE TABLE `o_goods_supplier`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商名称',
  `number` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商编码',
  `taxRate` double NULL DEFAULT 0 COMMENT '税率',
  `amount` double NULL DEFAULT 0 COMMENT '期初应付款',
  `periodMoney` double NULL DEFAULT 0 COMMENT '期初预付款',
  `difMoney` double NULL DEFAULT 0 COMMENT '初期往来余额',
  `beginDate` date NULL DEFAULT NULL COMMENT '余额日期',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `place` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '职位',
  `linkMan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系方式',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `county` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区县',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货地址详情',
  `pinYin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `disable` tinyint(1) NULL DEFAULT 0 COMMENT '0启用   1禁用',
  `isDelete` tinyint(1) NULL DEFAULT 0 COMMENT '0正常 1删除',
  `purchaserName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分管采购员',
  `createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_supplier
-- ----------------------------
INSERT INTO `o_goods_supplier` VALUES (34, 'ASAA', 'AAS', 0, 0, 0, 0, NULL, 'AA', 'AA', 'AA', 'AA', NULL, NULL, NULL, 'AA', '', 0, 0, NULL, '2025-10-07 14:16:23');

-- ----------------------------
-- Table structure for o_logistics_company
-- ----------------------------
DROP TABLE IF EXISTS `o_logistics_company`;
CREATE TABLE `o_logistics_company`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform_id` int NULL DEFAULT NULL COMMENT '平台id',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺ID',
  `logistics_id` bigint NULL DEFAULT NULL COMMENT '物流公司id（值来自于平台返回）',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司编码（值来自于平台返回）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司名称（值来自于平台返回）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NULL DEFAULT NULL COMMENT '状态（0禁用1启用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '快递公司表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_logistics_company
-- ----------------------------
INSERT INTO `o_logistics_company` VALUES (1, 100, NULL, NULL, 'aad', 'avd', 'aaa', 1);
INSERT INTO `o_logistics_company` VALUES (2, 400, NULL, NULL, 'JTSD', '极兔速递', NULL, 1);
INSERT INTO `o_logistics_company` VALUES (4, 300, NULL, NULL, 'AA', 'AA', NULL, 1);

-- ----------------------------
-- Table structure for o_order
-- ----------------------------
DROP TABLE IF EXISTS `o_order`;
CREATE TABLE `o_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单id，自增',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号（第三方平台订单号）',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shop_id` bigint NOT NULL COMMENT '店铺ID',
  `remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `buyer_memo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家留言信息',
  `seller_memo` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家留言信息',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签',
  `refund_status` int NOT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `order_status` int NOT NULL COMMENT '订单状态0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12退款中；21待付款；22锁定，29删除，101部分发货',
  `goods_amount` double NOT NULL DEFAULT 0 COMMENT '订单商品金额',
  `change_amount` double NOT NULL DEFAULT 0 COMMENT '订单改价折扣金额，单位元',
  `post_fee` double NULL DEFAULT 0 COMMENT '订单运费',
  `seller_discount` double NULL DEFAULT 0 COMMENT '商家优惠金额，单位：元',
  `platform_discount` double NULL DEFAULT 0 COMMENT '平台优惠金额，单位：元',
  `amount` double NOT NULL DEFAULT 0 COMMENT '订单实际金额',
  `payment` double NOT NULL DEFAULT 0 COMMENT '实付金额',
  `service_fee` double NOT NULL DEFAULT 0 COMMENT '服务费',
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人手机号',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人地址',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `order_created` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单时间',
  `order_updated` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单更新时间',
  `order_pay_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单支付时间',
  `order_finish_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单完成时间',
  `shipper` bigint NOT NULL DEFAULT 0 COMMENT '发货人',
  `ship_type` int NOT NULL DEFAULT 0 COMMENT '发货方式2供应商代发0仓库发货',
  `ship_status` int NOT NULL DEFAULT 0 COMMENT '发货状态 0 待发货 1 已分配供应商发货 2全部发货',
  `ship_company` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '发货快递公司',
  `ship_code` varchar(33) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货物流公司',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '取消原因',
  `platform_order_status_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台订单状态文本',
  `platform_order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台订单状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_sn_index`(`order_num` ASC) USING BTREE,
  INDEX `shopid_index`(`shop_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_order
-- ----------------------------
INSERT INTO `o_order` VALUES (1, '260103-143340377723488', 300, 1011, NULL, '', '', NULL, 4, 1, 39.32, 0, 0, 0, 14.54, 24.78, 24.78, 0, '', '', '', '', '', '', '2026-01-03 13:08:45', '2026-01-03 13:18:01', '2026-01-03 13:08:46', '', 0, 0, 0, '0', NULL, NULL, '2026-01-03 16:08:13', NULL, NULL, NULL, NULL, '待发货', '1');
INSERT INTO `o_order` VALUES (2, '260103-064550356563156', 300, 1011, NULL, '', '', NULL, 1, 2, 33.93, 0, 0, 0, 0, 33.93, 33.93, 0, NULL, NULL, NULL, '', '', '', '2026-01-03 13:45:26', '2026-01-03 15:41:10', '2026-01-03 13:45:27', '', 0, 0, 0, '0', NULL, NULL, '2026-01-03 16:08:13', NULL, NULL, NULL, NULL, '已发货待签收', '2');

-- ----------------------------
-- Table structure for o_order_item
-- ----------------------------
DROP TABLE IF EXISTS `o_order_item`;
CREATE TABLE `o_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id，自增',
  `shop_id` bigint NOT NULL COMMENT '店铺ID',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `order_id` bigint NOT NULL COMMENT '订单ID（o_order外键）',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号（第三方平台）',
  `sub_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '子订单号（第三方平台）',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台skuId',
  `goods_id` bigint NOT NULL DEFAULT 0 COMMENT '商品id(o_goods外键)',
  `goods_sku_id` bigint NOT NULL DEFAULT 0 COMMENT '商品skuid(o_goods_sku外键)',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `goods_price` double NOT NULL COMMENT '商品单价',
  `item_amount` double NULL DEFAULT NULL COMMENT '子订单金额',
  `discount_amount` double NULL DEFAULT 0 COMMENT '子订单优惠金额',
  `payment` double NULL DEFAULT NULL COMMENT '实际支付金额',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `refund_count` int NULL DEFAULT 0 COMMENT '已退货数量',
  `refund_status` int NULL DEFAULT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `order_status` int NULL DEFAULT NULL COMMENT '订单状态1：待发货，2：已发货，3：已完成，11已取消；21待付款',
  `shipper` bigint NOT NULL DEFAULT 0 COMMENT '发货人',
  `ship_type` int NOT NULL DEFAULT 0 COMMENT '发货方式 0 自己发货或待处理2供应商发货',
  `ship_status` int NOT NULL DEFAULT 0 COMMENT '发货状态 0 待发货  2全部发货',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `platform_order_status` int NULL DEFAULT NULL COMMENT '平台订单状态',
  `platform_order_status_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台订单状态文本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goodId_index`(`goods_id` ASC) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  INDEX `order_num_index`(`order_num` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_order_item
-- ----------------------------
INSERT INTO `o_order_item` VALUES (1, 1011, 300, 1, NULL, '260103-143340377723488-1742164849117', '1742164849117', 0, 13, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 'LEDDX001', '24W白光-215mm', 'LEDDX00103', 39.32, 39.32, 0, 39.32, 1, NULL, 0, 1, 1, 0, 0, 0, '2026-01-03 16:08:13', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (2, 1011, 300, 2, NULL, '260103-064550356563156-1742164849116', '1742164849116', 0, 12, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 'LEDDX001', '18W白光-175mm', 'LEDDX00102', 33.93, 33.93, 0, 33.93, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-03 16:08:13', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for o_order_ship_list
-- ----------------------------
DROP TABLE IF EXISTS `o_order_ship_list`;
CREATE TABLE `o_order_ship_list`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shipper` bigint NOT NULL COMMENT '发货方 0 仓库发货 1 供应商发货',
  `ship_supplier_id` bigint NOT NULL DEFAULT 0 COMMENT '发货供应商ID（0自己发货）',
  `ship_supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货供应商',
  `order_id` bigint NULL DEFAULT NULL COMMENT 'erp订单id',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `receiver_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人手机号',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人地址',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `buyer_memo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家留言信息',
  `seller_memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家留言信息',
  `ship_logistics_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_logistics_company_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司code',
  `ship_logistics_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `ship_status` int NOT NULL COMMENT '发货状态1：待发货，2：已发货，3已推送',
  `status` int NOT NULL COMMENT '状态0待备货1备货中2备货完成3已发货',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_order_ship_list
-- ----------------------------
INSERT INTO `o_order_ship_list` VALUES (3, 1007, 400, 0, 0, '仓库发货', 74, '6921377343921159820', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '极兔速递', 'JTSD', 'AAAAA', 2, 2, '2025-10-06 20:29:42', '手动发货', '2025-10-07 13:52:45', '备货完成');
INSERT INTO `o_order_ship_list` VALUES (4, 1011, 300, 1, 34, 'ASAA', 76, '251002-085338365560640', '彭**', '***********', '江西省***********************', '江西省', '南昌市', '西湖区', NULL, '', '', '极兔速递', 'JTSD', 'aaaaa', 2, 3, '2025-10-07 14:43:05', '分配供应商发货', '2025-10-07 16:02:43', '供应商手动发货');
INSERT INTO `o_order_ship_list` VALUES (5, 1011, 300, 0, 0, '仓库发货', 75, '251002-171237742200640', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', 'AA', 'AA', 'AAAAA', 2, 3, '2025-10-09 12:53:46', '手动发货', '2025-10-09 14:52:09', '生成出库单');

-- ----------------------------
-- Table structure for o_order_ship_list_item
-- ----------------------------
DROP TABLE IF EXISTS `o_order_ship_list_item`;
CREATE TABLE `o_order_ship_list_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `list_id` bigint NOT NULL COMMENT '外键id',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shipper` bigint NOT NULL DEFAULT 0 COMMENT '发货方 0 仓库发货 1 供应商发货',
  `ship_supplier_id` bigint NOT NULL DEFAULT 0 COMMENT '发货供应商ID（0自己发货）',
  `ship_supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货供应商',
  `order_id` bigint NULL DEFAULT NULL COMMENT 'erp订单id',
  `order_item_id` bigint NULL DEFAULT NULL COMMENT 'erp订单itemid',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `original_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原始订单skuid',
  `goods_id` bigint NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `sku_id` bigint NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `quantity` int NOT NULL COMMENT '商品数量',
  `status` int NOT NULL COMMENT '状态0待备货1备货中2备货完成3已发货',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货-备货表（打单加入备货清单）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_order_ship_list_item
-- ----------------------------
INSERT INTO `o_order_ship_list_item` VALUES (1, 3, 1007, 400, 0, 0, '仓库发货', 74, 54, '6921377343921159820', '3415147054562818', 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"XL\"}]', '', 1, 2, '2025-10-06 20:29:59', '手动发货', '2025-10-07 12:25:15', '备货完成');
INSERT INTO `o_order_ship_list_item` VALUES (2, 3, 1007, 400, 0, 0, '仓库发货', 74, 55, '6921377343921159820', '3415147054562562', 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"L\"}]', '', 1, 2, '2025-10-06 20:30:12', '手动发货', '2025-10-07 12:25:15', '备货完成');
INSERT INTO `o_order_ship_list_item` VALUES (3, 3, 1007, 400, 0, 0, '仓库发货', 74, 56, '6921377343921159820', '3415147054562306', 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"M\"}]', '', 1, 2, '2025-10-06 20:30:12', '手动发货', '2025-10-07 12:25:15', '备货完成');
INSERT INTO `o_order_ship_list_item` VALUES (4, 3, 1007, 400, 0, 0, '仓库发货', 74, 57, '6921377343921159820', '3415147054562050', 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"S\"}]', '', 1, 2, '2025-10-06 20:30:12', '手动发货', '2025-10-07 12:25:15', '备货完成');
INSERT INTO `o_order_ship_list_item` VALUES (5, 4, 1011, 300, 1, 34, 'ASAA', 76, 59, '251002-085338365560640', '1742373848729', 0, 0, NULL, 'https://img.pddpic.com/mms-material-img/2025-06-02/0d875ad2-529b-43be-b699-96748b4c0bb4.jpeg.a.jpeg', 'LEDDP001', 'E27螺口 3瓦白光 1级能效', 'LEDDP00101', 1, 3, '2025-10-07 14:43:05', '分配供应商发货', '2025-10-07 16:02:43', '供应商发货手动确认');
INSERT INTO `o_order_ship_list_item` VALUES (6, 5, 1011, 300, 0, 0, '仓库发货', 75, 58, '251002-171237742200640', '0', 0, 45, NULL, 'https://img.pddpic.com/mms-material-img/2025-06-02/0d875ad2-529b-43be-b699-96748b4c0bb4.jpeg.a.jpeg', 'LEDDP001', 'E27螺口 5瓦白光 1级能效', 'LEDDP00102', 1, 3, '2025-10-09 12:53:46', '手动发货', '2025-10-09 14:52:09', '备货完成');

-- ----------------------------
-- Table structure for o_refund
-- ----------------------------
DROP TABLE IF EXISTS `o_refund`;
CREATE TABLE `o_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `refund_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '退货单号',
  `refund_type` int NULL DEFAULT NULL COMMENT '类型(1-售前退款 10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NULL DEFAULT NULL COMMENT '店铺类型',
  `order_amount` float NULL DEFAULT NULL COMMENT '订单金额',
  `refund_fee` float NOT NULL COMMENT '退款金额',
  `refund_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '源订单号',
  `order_item_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单号或id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '源skuId',
  `goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  `sku_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `has_good_return` int NULL DEFAULT NULL COMMENT '买家是否需要退货。可选值:1(是),0(否)',
  `goods_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_sku` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品sku',
  `goods_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `quantity` bigint NULL DEFAULT NULL COMMENT '退货数量',
  `return_logistics_company` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货物流公司',
  `return_logistics_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货物流单号',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（10001待审核 10002等待买家退货 10003等待平台审核 10004待买家处理 10005等待卖家处理 10006等待卖家发货 14000拒绝退款 10011退款关闭 10010退款完成 10020售后成功 10021售后失败 10090退款中 10091换货成功 10092换货失败 10093维修关闭 10094维修成功 ）',
  `create_time` datetime NOT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `erp_push_status` int NULL DEFAULT 0 COMMENT 'ERP推送状态(200成功，其他失败）',
  `erp_push_result` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ERP推送状态结果',
  `erp_push_time` datetime NULL DEFAULT NULL COMMENT 'ERP最近推送时间',
  `has_processing` int NOT NULL DEFAULT 0 COMMENT '是否处理0未处理1已处理',
  `after_sale_id` bigint NULL DEFAULT NULL COMMENT '处理id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS售后处理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_refund
-- ----------------------------

-- ----------------------------
-- Table structure for o_ship_stock_up
-- ----------------------------
DROP TABLE IF EXISTS `o_ship_stock_up`;
CREATE TABLE `o_ship_stock_up`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `sale_order_id` bigint NULL DEFAULT NULL COMMENT 'erp订单id',
  `sale_order_item_id` bigint NULL DEFAULT NULL COMMENT 'erp订单itemid',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `original_sku_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '原始订单skuid',
  `goods_id` bigint NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `spec_id` bigint NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_spec` varchar(2550) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `goods_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `spec_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `quantity` int NOT NULL COMMENT '商品数量',
  `status` int NOT NULL COMMENT '状态0待备货1备货中2备货完成3已发货',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1827537194227638275 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货-备货表（打单加入备货清单）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_ship_stock_up
-- ----------------------------
INSERT INTO `o_ship_stock_up` VALUES (1817540108503371777, 1, 1817230905045843970, 1817230905091981313, '1722092947647399', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-07-28 20:38:25', '消息通知备货', '2024-07-30 23:06:18', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823982945285689345, 1, 1823969793328271361, 1823969793403768833, '172370314299481', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-08-15 15:19:57', '消息通知备货', '2024-08-15 15:36:51', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823989949987192833, 2, 1823988373058998273, 1823988373058998274, '1723707501431263', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-08-15 15:47:47', '消息通知备货', '2024-08-18 16:14:59', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823991276628770817, 2, 1823991184286973954, 1823991184349888514, '1723708260966435', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-08-15 15:53:03', '消息通知备货', '2024-08-18 16:13:54', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823991276628770818, 2, 1823991184286973954, 1823991184349888515, '1723708260966435', '2', 0, 0, 'AAABBB', 'https://cbu01.alicdn.com/img/ibank/O1CN012YyP5f1hbcSsvkd3k_!!2218127114296-0-cib.jpg', '红罐加多宝', NULL, 'AABB002', 1, 3, '2024-08-15 15:53:03', '消息通知备货', '2024-08-18 16:13:54', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1825085906361516034, 1, 1825085325148422145, 1825085325215531009, '1723968921461168', '2', 0, 0, 'AAABBB', 'https://cbu01.alicdn.com/img/ibank/O1CN012YyP5f1hbcSsvkd3k_!!2218127114296-0-cib.jpg', '红罐加多宝', NULL, 'AABB002', 1, 0, '2024-08-18 16:22:43', '消息通知备货', NULL, NULL);
INSERT INTO `o_ship_stock_up` VALUES (1827537194227638274, 1, 1827306479443587074, 1827306487383404546, '1724485556330230', '2', 0, 0, 'AAABBB', 'https://cbu01.alicdn.com/img/ibank/O1CN012YyP5f1hbcSsvkd3k_!!2218127114296-0-cib.jpg', '红罐加多宝', NULL, 'AABB002', 1, 3, '2024-08-25 10:43:16', '消息通知备货', '2024-08-25 10:46:09', '消息通知发货完成');

-- ----------------------------
-- Table structure for o_shipment
-- ----------------------------
DROP TABLE IF EXISTS `o_shipment`;
CREATE TABLE `o_shipment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `order_id` bigint NULL DEFAULT NULL COMMENT 'o_order表id',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `order_time` datetime NULL DEFAULT NULL COMMENT '订单时间',
  `shipper` int NOT NULL DEFAULT 0 COMMENT '发货方 0 仓库发货 1 供应商发货',
  `supplier_id` bigint NOT NULL DEFAULT 0 COMMENT '供应商ID',
  `supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `ship_type` int NULL DEFAULT NULL COMMENT '发货类型（1订单发货2商品补发3商品换货）',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_company_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司code',
  `ship_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `ship_fee` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '物流费用',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `ship_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货操作人',
  `ship_status` int NULL DEFAULT NULL COMMENT '物流状态（0 待发货1已发货2已完成）',
  `package_weight` float NULL DEFAULT NULL COMMENT '包裹重量',
  `package_length` float NULL DEFAULT NULL COMMENT '包裹长度',
  `package_width` float NULL DEFAULT NULL COMMENT '包裹宽度',
  `package_height` float NULL DEFAULT NULL COMMENT '包裹高度',
  `packsge_operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打包操作人',
  `packsge_time` datetime NULL DEFAULT NULL COMMENT '打包时间',
  `packages` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '包裹内容JSON',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人手机号',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人地址',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_index`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shipment
-- ----------------------------
INSERT INTO `o_shipment` VALUES (1, 1007, 400, 74, '6921377343921159820', '2025-10-06 10:16:50', 0, 0, NULL, 1, '极兔速递', 'JTSD', 'AAAAA', 0.00, '2025-10-06 20:29:47', NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, '2025-10-06 20:29:50', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (2, 1007, 2, 0, 'aaa', NULL, 0, 0, NULL, 2, '极兔速递', 'JTSD', 'aa', 0.00, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-07 17:23:55', '手动添加发货记录', NULL, NULL, 'a', 'a', 'a', NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (3, 1007, 2, 0, 'aaa', NULL, 0, 0, NULL, 2, '极兔速递', 'JTSD', 'aa', 0.00, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-07 17:24:27', '手动添加发货记录', NULL, NULL, 'a', 'a', 'a', NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (4, 1007, 1, 0, 'aa', NULL, 0, 0, NULL, 1, '极兔速递', 'JTSD', 'aa', 0.00, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-07 17:25:06', '手动添加发货记录', NULL, NULL, 'd', 'd', 'a', NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (5, 1011, 300, 75, '251002-171237742200640', '2025-10-02 03:56:59', 0, 0, NULL, 1, 'AA', 'AA', 'AAAAA', 0.00, '2025-10-09 12:53:46', NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, '2025-10-09 12:53:46', 'admin', NULL, NULL, '彭**', '***********', '江西省***********************', '江西省', '南昌市', '西湖区');

-- ----------------------------
-- Table structure for o_shipment_item
-- ----------------------------
DROP TABLE IF EXISTS `o_shipment_item`;
CREATE TABLE `o_shipment_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id，自增',
  `shipment_id` bigint NOT NULL COMMENT '发货id',
  `shipper` int NOT NULL COMMENT '发货方 0 仓库发货 1 供应商发货',
  `supplier_id` bigint NOT NULL DEFAULT 0 COMMENT '供应商ID',
  `supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `order_id` bigint NOT NULL COMMENT '订单 id',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_time` datetime NULL DEFAULT NULL COMMENT '订单时间',
  `order_item_id` bigint NOT NULL COMMENT '订单itemID（o_order_item外键）',
  `erp_goods_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `erp_sku_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `stock_status` int NOT NULL COMMENT '仓库状态 0 备货中 1 已出库 2 已发走',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goodId_index`(`erp_goods_id` ASC) USING BTREE,
  INDEX `order_id`(`order_item_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shipment_item
-- ----------------------------
INSERT INTO `o_shipment_item` VALUES (1, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 54, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"XL\"}]', '', 1, NULL, 0, '2025-10-06 20:30:05', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (2, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 55, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"L\"}]', '', 1, NULL, 0, '2025-10-06 20:30:12', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (3, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 56, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"M\"}]', '', 1, NULL, 0, '2025-10-06 20:30:12', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (4, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 57, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"S\"}]', '', 1, NULL, 0, '2025-10-06 20:30:12', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (5, 5, 0, 0, NULL, 300, 1011, 75, '251002-171237742200640', '2025-10-02 03:56:59', 58, 0, 0, NULL, 'https://img.pddpic.com/mms-material-img/2025-06-02/0d875ad2-529b-43be-b699-96748b4c0bb4.jpeg.a.jpeg', 'LEDDP001', 'E27螺口 5瓦白光 1级能效', 'LEDDP00102', 1, NULL, 0, '2025-10-09 12:53:46', 'admin', NULL, NULL);

-- ----------------------------
-- Table structure for o_shop
-- ----------------------------
DROP TABLE IF EXISTS `o_shop`;
CREATE TABLE `o_shop`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '店铺名',
  `type` int NOT NULL COMMENT '对应第三方平台Id',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '店铺url',
  `sort` int NOT NULL DEFAULT 9 COMMENT '排序',
  `status` int NULL DEFAULT 0 COMMENT '状态（1正常2已删除）',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `seller_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台店铺id',
  `app_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Appkey',
  `app_secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Appsercet',
  `access_token` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第三方平台sessionKey（access_token）',
  `expires_in` bigint NULL DEFAULT NULL COMMENT '到期',
  `access_token_begin` bigint NULL DEFAULT NULL COMMENT 'access_token开始时间',
  `refresh_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刷新token',
  `refresh_token_timeout` bigint NULL DEFAULT NULL COMMENT '刷新token过期时间',
  `api_request_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求url',
  `api_redirect_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回调url',
  `manage_user_id` bigint NULL DEFAULT NULL COMMENT '负责人id',
  `manage_dept_id` bigint NULL DEFAULT NULL COMMENT '负责人部门id',
  `region_id` bigint NOT NULL DEFAULT 0 COMMENT '国家/地区',
  `api_status` int NOT NULL COMMENT 'api运行状态0不运行1运行',
  `modify_on` bigint NOT NULL COMMENT '更新时间',
  `create_on` bigint NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1014 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop
-- ----------------------------
INSERT INTO `o_shop` VALUES (1007, '抖店测试', 400, NULL, 9, 1, NULL, '4463798', NULL, NULL, 'c3tzx2q5p41h7zl69zjws9900002noae-11', NULL, NULL, '070t45roa51h7zl69zjws9900002noae-12', NULL, NULL, NULL, NULL, NULL, 0, 0, 1759307372, 1759307261);
INSERT INTO `o_shop` VALUES (1011, '爱顾家的小店', 300, NULL, 9, 1, NULL, '0', NULL, NULL, '64411135d0a54e43a9a92b9690390032de409a4f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1759371874, 1759371874);
INSERT INTO `o_shop` VALUES (1012, '微信小店测试', 500, NULL, 9, 1, NULL, '0', 'wx82dd65f284dd6ee3', 'a6054ccf2694e8dc51d2616e634cad39', '99_fTlkZRP6GjasIVJEoEmbvMpEFOIO99Pld8JwA4eSzFfIa2-sbgbjbL6iGSzt2ZX7ydg0CKxe6kzLxvs9L1GxoINeyST5efbptdvrqu0LJkCEXzkZ4crveaIK5vMKKMgABAUUW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1759373401, 1759373401);
INSERT INTO `o_shop` VALUES (1013, '测试TMALL', 100, NULL, 9, 1, NULL, '2', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1767360004, 1767360004);

-- ----------------------------
-- Table structure for o_shop_platform
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_platform`;
CREATE TABLE `o_shop_platform`  (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台名',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `app_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `app_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台回调uri',
  `server_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口访问地址',
  `status` int NULL DEFAULT NULL COMMENT '状态（0启用1关闭）',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `region_id` bigint NULL DEFAULT NULL COMMENT '国家/地区',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺平台配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_platform
-- ----------------------------
INSERT INTO `o_shop_platform` VALUES (100, '淘宝天猫', 'TMALL', '', '', 'http://www.qihangerp.cn', 'http://gw.api.taobao.com/router/rest', 0, 3, 1);
INSERT INTO `o_shop_platform` VALUES (200, '京东POP', 'JD-POP', '', NULL, 'http://www.qihangerp.cn', 'https://api.jd.com/routerjson', 0, 4, 1);
INSERT INTO `o_shop_platform` VALUES (300, '拼多多', 'PDD', 'dc953bcf16d24b27abf3e64a59e1ecd1', '89c639b1ceaf8e5260acc73b2bdbb5c529cf23a4', 'https://qihangerp.cn', 'https://gw-api.pinduoduo.com/api/router', 0, 1, 1);
INSERT INTO `o_shop_platform` VALUES (400, '抖店', 'DOUDIAN', '7005157746437834253', '8104c8b8-9085-4a80-9248-629759b4f1a3', 'https://www.qihangerp.cn', 'https://openapi-fxg.jinritemai.com/', 0, 0, 1);
INSERT INTO `o_shop_platform` VALUES (500, '微信小店', 'WEISHOP', '', NULL, 'http://www.qihangerp.cn', 'https://api.weixin.qq.com', 0, 2, 1);
INSERT INTO `o_shop_platform` VALUES (999, '其他平台', 'OFFLINE', NULL, NULL, NULL, NULL, 0, 10, 1);

-- ----------------------------
-- Table structure for o_shop_pull_lasttime
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_pull_lasttime`;
CREATE TABLE `o_shop_pull_lasttime`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `pull_type` enum('ORDER','REFUND','GOODS') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型（ORDER:订单，REFUND:退款）',
  `lasttime` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1577832450 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺更新最后时间记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_pull_lasttime
-- ----------------------------
INSERT INTO `o_shop_pull_lasttime` VALUES (102, 1007, 'ORDER', '2025-10-02 16:16:23', '2025-10-01 17:11:03', '2026-01-01 17:18:44');
INSERT INTO `o_shop_pull_lasttime` VALUES (103, 1010, 'ORDER', '2025-10-02 08:47:13', '2025-10-02 08:43:16', '2025-10-02 08:47:13');
INSERT INTO `o_shop_pull_lasttime` VALUES (104, 1011, 'ORDER', '2025-12-22 21:31:11', '2025-10-02 10:31:11', '2026-01-02 09:06:08');
INSERT INTO `o_shop_pull_lasttime` VALUES (1577832449, 1011, 'GOODS', '2026-01-02 10:19:37', '2026-01-02 09:00:45', '2026-01-02 10:19:39');

-- ----------------------------
-- Table structure for o_shop_pull_logs
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_pull_logs`;
CREATE TABLE `o_shop_pull_logs`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '平台id',
  `pull_type` enum('ORDER','REFUND','GOODS') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型（ORDER订单，GOODS商品，REFUND退款）',
  `pull_way` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉取方式（主动拉取、定时任务）',
  `pull_params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉取参数',
  `pull_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '拉取结果',
  `pull_time` datetime NULL DEFAULT NULL COMMENT '拉取时间',
  `duration` bigint NULL DEFAULT NULL COMMENT '耗时（毫秒）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2007363351869005827 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺更新日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_pull_logs
-- ----------------------------
INSERT INTO `o_shop_pull_logs` VALUES (2007051452283584514, 1007, 400, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-02 19:28:50', 9);
INSERT INTO `o_shop_pull_logs` VALUES (2007051615710445570, 1007, 400, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-02 19:29:10', 19818);
INSERT INTO `o_shop_pull_logs` VALUES (2007053815446753282, 1011, 300, 'GOODS', '主动拉取商品sku', '', 'access_token已过期', '2026-01-02 19:38:13', 339);
INSERT INTO `o_shop_pull_logs` VALUES (2007054121874214913, 1011, 300, 'GOODS', '主动拉取商品sku', '', 'access_token已过期', '2026-01-02 19:39:26', 212);
INSERT INTO `o_shop_pull_logs` VALUES (2007054347586490370, 1011, 300, 'GOODS', '主动拉取商品sku', '', '{successTotal:35}', '2026-01-02 19:40:17', 3004);
INSERT INTO `o_shop_pull_logs` VALUES (2007060914402689025, 1007, 400, 'GOODS', '主动拉取商品sku', '', '请求API错误：认证失败, 确保app_key, method, param_json, timestamp, v, sign等参数不为空', '2026-01-02 20:06:26', 246);
INSERT INTO `o_shop_pull_logs` VALUES (2007061626629062658, 1007, 400, 'GOODS', '主动拉取商品sku', '', '系统异常：Cannot invoke \"java.net.http.HttpResponse.statusCode()\" because \"response\" is null', '2026-01-02 20:07:44', 92188);
INSERT INTO `o_shop_pull_logs` VALUES (2007063329415884802, 1007, 400, 'GOODS', '主动拉取商品sku', '', '{successTotal:299}', '2026-01-02 20:15:27', 34667);
INSERT INTO `o_shop_pull_logs` VALUES (2007080897514033153, 1013, 100, 'GOODS', '主动拉取商品sku', '', 'SessionKey非法', '2026-01-02 21:25:32', 18452);
INSERT INTO `o_shop_pull_logs` VALUES (2007080916300320770, 1013, 100, 'GOODS', '主动拉取商品sku', '', 'SessionKey非法', '2026-01-02 21:25:55', 54);
INSERT INTO `o_shop_pull_logs` VALUES (2007081406052421634, 1013, 100, 'GOODS', '主动拉取商品sku', '', 'SessionKey非法', '2026-01-02 21:26:02', 109359);
INSERT INTO `o_shop_pull_logs` VALUES (2007084780449681410, 1013, 100, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-02 21:27:58', 798366);
INSERT INTO `o_shop_pull_logs` VALUES (2007086428349714433, 1013, 100, 'GOODS', '主动拉取商品sku', '', '{successTotal:887}', '2026-01-02 21:45:42', 127474);
INSERT INTO `o_shop_pull_logs` VALUES (2007246559934894081, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-03 08:24:07', 5);
INSERT INTO `o_shop_pull_logs` VALUES (2007247972962381826, 1012, 500, 'GOODS', '主动拉取商品sku', '', 'invalid credential, access_token is invalid or not latest, could get access_token by getStableAccessToken, more details at https://mmbizurl.cn/s/JtxxFh33r rid: 695862e9-14c7ceab-423f4f5c', '2026-01-03 08:29:24', 20600);
INSERT INTO `o_shop_pull_logs` VALUES (2007247993237647361, 1012, 500, 'GOODS', '主动拉取商品sku', '', 'invalid credential, access_token is invalid or not latest, could get access_token by getStableAccessToken, more details at https://mmbizurl.cn/s/JtxxFh33r rid: 695862fd-06f01503-4fa2639f', '2026-01-03 08:29:49', 73);
INSERT INTO `o_shop_pull_logs` VALUES (2007248036346703874, 1012, 500, 'GOODS', '主动拉取商品sku', '', 'invalid credential, access_token is invalid or not latest, could get access_token by getStableAccessToken, more details at https://mmbizurl.cn/s/JtxxFh33r rid: 69586307-50f58f7f-3572dd68', '2026-01-03 08:29:59', 76);
INSERT INTO `o_shop_pull_logs` VALUES (2007254711795396610, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-03 08:55:58', 33005);
INSERT INTO `o_shop_pull_logs` VALUES (2007255303028682753, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-03 08:56:36', 136242);
INSERT INTO `o_shop_pull_logs` VALUES (2007255692893470721, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:6}', '2026-01-03 09:00:23', 2095);
INSERT INTO `o_shop_pull_logs` VALUES (2007363351869005826, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-03 00:00:01,endTime:2026-01-03 23:59:59}', '{insert:2,update:0,fail:0}', '2026-01-03 16:08:09', 3437);

-- ----------------------------
-- Table structure for o_shop_region
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_region`;
CREATE TABLE `o_shop_region`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区名称',
  `exchange_rate` float NULL DEFAULT NULL COMMENT '汇率',
  `num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区编码',
  `status` int NULL DEFAULT NULL COMMENT '状态0正常1禁用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺地区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_region
-- ----------------------------
INSERT INTO `o_shop_region` VALUES (1, '中国', 1, '86', 0, '2025-02-10 10:42:54', 'system', '2025-02-10 10:42:57', NULL);

-- ----------------------------
-- Table structure for oms_dou_order
-- ----------------------------
DROP TABLE IF EXISTS `oms_dou_order`;
CREATE TABLE `oms_dou_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺父订单号，抖店平台生成，平台下唯一；',
  `order_level` int NULL DEFAULT NULL COMMENT '订单层级，主订单是2级',
  `order_phase_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '定金预售阶段单json',
  `order_status` int NULL DEFAULT NULL COMMENT '订单状态1 待确认/待支付（订单创建完毕）105 已支付 2 备货中 101 部分发货 3 已发货（全部发货）4 已取消5 已完成（已收货）',
  `order_status_desc` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单状态描述',
  `order_tag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '\r\n订单的一些c端标签json',
  `order_type` int NULL DEFAULT NULL COMMENT '【订单类型】 0、普通订单 2、虚拟商品订单 4、电子券（poi核销） 5、三方核销',
  `order_type_desc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单类型描述',
  `app_id` int NULL DEFAULT NULL COMMENT '具体某个小程序的ID',
  `open_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抖音小程序ID',
  `accept_order_status` int NULL DEFAULT NULL COMMENT '小时达订单的接单状态 0-未接单；1-已接单；2-超时取消，或商家取消',
  `appointment_ship_time` int NULL DEFAULT NULL COMMENT '预约发货时间',
  `author_cost_amount` int NULL DEFAULT NULL COMMENT '作者（达人）承担金额（单位：分），订单参与活动和优惠中作者（达人）承担部分的总金额',
  `aweme_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '达人抖音号，样品订单场景下才会返回的申样达人信息；',
  `b_type` int NULL DEFAULT NULL COMMENT '【下单端】 0、站外 1、火山 2、抖音 3、头条 4、西瓜 5、微信 6、值点app 7、头条lite 8、懂车帝 9、皮皮虾 11、抖音极速版 12、TikTok 13、musically 14、穿山甲 15、火山极速版 16、服务市场 26、番茄小说 27、UG教育营销电商平台 28、Jumanji 29、电商SDK',
  `b_type_desc` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下单端描述',
  `sub_b_type` int NULL DEFAULT NULL COMMENT '【下单场景】 0、未知 1、app内-原生 2、app内-小程序 3、H5 13、电商SDK-头条 35、电商SDK-头条lite',
  `sub_b_type_desc` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下单场景描述',
  `biz` int NULL DEFAULT NULL COMMENT '【业务来源】 1 -鲁班 2 -小店 3 -好好学习 4 -ev 5 -虚拟 6 -建站 7 -核销 8 -玉石 9 -ez 10 -ep 11 -虚拟卡券 12 -服务市场 13 - EP 视频课 14 - EP 直播课 21 -跨境BBC 22 -跨境BC 23 -跨境CC|UPU 24 -手机充值 25 -拍卖保证金 26 -懂车帝抵扣券 27 -懂车帝返现券 28 -离岛免税 29 -海南会员购 30 -抽奖 31 -清北-企业代付 32 -抖+券 33 -联盟寄样 49 -刀剑 53 -通信卡 66 -加油包 76 -大闸蟹 99 -保险 102-小店海外 108-上门取件收款',
  `biz_desc` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务来源描述',
  `buyer_words` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家留言',
  `seller_words` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商家备注',
  `seller_remark_stars` int NULL DEFAULT NULL COMMENT '插旗信息：0-灰 1-紫 2-青 3-绿 4-橙 5-红',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '取消原因',
  `channel_payment_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付渠道的流水号',
  `create_time` int NULL DEFAULT NULL COMMENT '下单时间，时间戳，秒',
  `pay_time` int NULL DEFAULT NULL COMMENT '支付时间，时间戳，秒',
  `update_time` int NULL DEFAULT NULL COMMENT '订单更新时间，时间戳，秒',
  `finish_time` int NULL DEFAULT NULL COMMENT '订单完成时间，时间戳，秒',
  `order_expire_time` int NULL DEFAULT NULL COMMENT '订单过期时间，时间戳，秒',
  `doudian_open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户唯一id',
  `encrypt_post_receiver` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '收件人姓名',
  `encrypt_post_tel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '收件人电话',
  `encrypt_post_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '收件地址',
  `exp_ship_time` int NULL DEFAULT NULL COMMENT '预计发货时间，时间戳，秒',
  `logistics_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '物流信息JSON',
  `main_status` int NULL DEFAULT NULL COMMENT '主流程状态，1 待确认/待支付（订单创建完毕）103 部分支付105 已支付2 备货中101 部分发货3 已发货（全部发货）4 已取消5 已完成（已收货）21 发货前退款完结22 发货后退款完结39 收货后退款完结',
  `main_status_desc` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主流程状态描述',
  `mask_post_receiver` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名（脱敏后）',
  `mask_post_tel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人电话（脱敏后）',
  `mask_post_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人地址（脱敏后）',
  `province_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `province_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `town_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `town_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `street_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `street_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `open_address_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标识收件人地址的id，可用于合单',
  `modify_amount` int NULL DEFAULT NULL COMMENT '改价金额变化量（单位：分）',
  `modify_post_amount` int NULL DEFAULT NULL COMMENT '改价运费金额变化量（单位：分）',
  `only_platform_cost_amount` int NULL DEFAULT NULL COMMENT '仅平台承担金额（单位：分），订单参与活动和优惠中平台承担部分的总金额',
  `order_amount` int NULL DEFAULT NULL COMMENT '订单金额（单位：分）',
  `pay_amount` int NULL DEFAULT NULL COMMENT '支付金额（单位：分）',
  `pay_type` int NULL DEFAULT NULL COMMENT '7=无需支付（0元单）；8=DOU分期（信用支付）；9=新卡支付；12=先用后付；16=收银台支付',
  `post_amount` int NULL DEFAULT NULL COMMENT '快递费（单位：分）',
  `post_insurance_amount` int NULL DEFAULT NULL COMMENT '运费险金额（单位：分）',
  `post_origin_amount` int NULL DEFAULT NULL COMMENT '运费原价（单位：分），post_origin_amount = post_amount + post_promotion_amount',
  `post_promotion_amount` int NULL DEFAULT NULL COMMENT '运费优惠金额（单位：分）',
  `promotion_amount` int NULL DEFAULT NULL COMMENT '订单优惠总金额（单位：分） = 店铺优惠金额 + 平台优惠金额 + 达人优惠金额',
  `promotion_pay_amount` int NULL DEFAULT NULL COMMENT '支付优惠金额（单位：分），支付渠道上的优惠金额',
  `promotion_platform_amount` int NULL DEFAULT NULL COMMENT '平台优惠金额（单位：分），属于平台的优惠活动、优惠券、红包的总优惠金额',
  `promotion_redpack_amount` int NULL DEFAULT NULL COMMENT '红包优惠金额（单位：分）',
  `promotion_redpack_platform_amount` int NULL DEFAULT NULL COMMENT '平台红包优惠金额（单位：分），属于平台的红包的优惠金额',
  `promotion_redpack_talent_amount` int NULL DEFAULT NULL COMMENT '达人红包优惠金额（单位：分），属于达人的红包的优惠金额',
  `promotion_shop_amount` int NULL DEFAULT NULL COMMENT '店铺优惠金额（单位：分），属于店铺的优惠活动、优惠券、红包的总优惠金额',
  `promotion_talent_amount` int NULL DEFAULT NULL COMMENT '达人优惠金额（单位：分），属于达人的优惠活动、优惠券、红包的总优惠金额',
  `ship_time` int NULL DEFAULT NULL COMMENT '发货时间，时间戳，秒',
  `shop_cost_amount` int NULL DEFAULT NULL COMMENT '商家承担金额（单位：分），订单参与活动和优惠中商家承担部分的总金额',
  `platform_cost_amount` int NULL DEFAULT NULL COMMENT '平台承担金额（单位：分），订单参与活动和优惠中平台+作者（达人）承担部分的总金额,包含作者（达人）承担金额：platform_cost_amount = only_platform_cost_amount + author_cost_amount',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id，抖店平台生成，平台下唯一；',
  `shop_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户名称',
  `total_promotion_amount` int NULL DEFAULT NULL COMMENT '总优惠金额（单位：分），total_promotion_amount = promotion_amount + post_promotion_amount',
  `user_tag_ui` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '用户特征标签；JSON',
  `s_shop_id` bigint NULL DEFAULT NULL COMMENT '系统店铺id',
  `pull_time` datetime NULL DEFAULT NULL COMMENT '第一次拉取时间',
  `last_pull_time` datetime NULL DEFAULT NULL COMMENT '最后一次拉取时间',
  `audit_status` int NOT NULL DEFAULT 0 COMMENT '0待确认，1已确认2已拦截-9未拉取',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `oms_push_status` int NULL DEFAULT 0 COMMENT 'oms订单库推送状态0未推送1已推送2推送失败',
  `oms_push_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'oms订单库推送结果',
  `oms_push_time` datetime NULL DEFAULT NULL COMMENT 'oms订单库推送时间（记录最后一次）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_index`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '抖店订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_dou_order
-- ----------------------------
INSERT INTO `oms_dou_order` VALUES (8, '6921497618860834061', NULL, '[]', NULL, '已关闭', NULL, NULL, '平台发码订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '核销', '', '', NULL, '', '2025092922001454231458313285', NULL, NULL, NULL, NULL, NULL, '1@#43uGN+JKFNqreDgenQ9w9ub86MDpmqGd/AjVD4F7L0XQzhNTtn1mArlsWg98RQ7X308GKdU=', '#aZ4lCnZ9#tLgG3sZ1N0jBOEJM7Sn8PaFb7P0NJ4VF7wxEY3e7LdjyOUqliX2Z+fak01Vsf9MXZvZmTGYQpK6UKbgyZR3pmJUqcqf/WCzsdaM8YKhb7Q==*CgYIASAHKAESPgo8fJBmyQh+c4wrYTn94RFa5xw8DwcOJEbWGkTkfM964Cod6uHddtMIv165zgt3z2ikP3ukRDdOVa53HK44GgA=#1##', '$OLdQVKNpxS0zdV71kvM8cp3ZrAV3E2hxDLEiLEN3zZY=$BNmmaxVeBegfvdUjskoA9Q48SgvFoIPdptqLmY901rn/VVof8d3OOWaCB5rDeTL+TCsPZ0auPsj01w47JkmeRZ2sMLCcw4JkH5JNulK4Z8Qf*CgYIASAHKAESPgo8AvfsQUg+WxWP/MizV6NNEnIjoySBhW0gE7bEfjVWXnpZDa7/3qpi4r6/mlnHgwOrSyYYLijltENc2NQJGgA=$1$$', '', NULL, '[]', NULL, '发货后退款完成', '顾*', '1**********', '', '', '0', '', '', '', '0', '', '0', '#D8Ylgbv1g0N650LX01udcRdss+U8JjG4xAxaqltlan9+K8suLBL0KfuQ+qfUjSw3bC2lx9hrzKDriGDF/2HAasMYLsfcxZMLViDKszjf4mZ0yGJAWSD759Z47iw9ZuyVTIm8GXzqPw==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:07:07', '2025-10-01 17:11:01', 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (9, '6921160422267125024', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509100600980829435593', NULL, NULL, NULL, NULL, NULL, '1@#IScHlMNO6h7qVhBvExLmBw5clC5DxMf7KKm+W3Xazh5a2ZRqSGOSiefZBHw1HIrmn6s=', '#Sfks#4AdpZNNQe8j+WfnYnVtzkFlOZ+rmBrqssepkjBqbSvOZJhfr9qHLOLb4eI48gn+pbHYT8X+mrQXT+Jb2k4PTEC7v+HDYlsmV/zENeg==*CgYIASAHKAESPgo8uk16brs34EtQmRrE7ppXL6wecTRbAx1uOihG7HNMMNhEo7mMZdyzsisf5pwHJ0pFm5wMsP5dwVEvSlxXGgA=#1##', '$lA9O9Lh/tdrJ1ZD/D7juXhrcDOgSKfPW0I3FYXB3En8=$K1wDU6b02aSHcDxLAeSo2LR/SzwKlW2M2jpomIFK+YqKqf5c1xOYnDwv9NeR+FV4mQtihHM8HKPrTXprgPkEPi5MnFmlh/jS+E53g7q+0RtD*CgYIASAHKAESPgo8l6jAJTDQaoI1a0Vaaqi74sMVgbxSguNca8IimN8MFJIkh3+cNaYOzI/SHuC+ysNxHfcSwxKahINy+zJwGgA=$1$$', '#F4m/l49/1hIZfTj1tilH0Yrcy630#fyIw3Z3ZTB10wAT33IvqeR7MUYKT5mLA60YZOUAzcus/ePtEpDN50gTGLCu+F84bVKcnPcWPR+a51HTTQPg1qwtRsXKIUf5MrXW2e1GL1TbwumvscEuTjbux*CgYIASAHKAESPgo8kVvTSFpGdP42EJLULK5Sr5vohPhwgSh99wgf2CQv9ZpiDexK2pumjwPhDQpiq7DxBVY8W1tZNgcJCUUhGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '杨*', '1**********', '********', '广东省', '44', '深圳市', '440300', '福田区', '440304', '梅林街道', '440304007', '#phQPVjT6lZXDF8OONCiRRpEriHde3y+Ye24eD2IVkEixY9Y1k7QsZ+prhJmXHonIHvFZ8Figd0tCl0+YPsjZNad5iXZGgm4NcWLkKVB73cz7BxTMTuE8/8LjdeFLUntLZgZQrsdTqg==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:07:08', '2025-10-01 17:11:02', 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (10, '6921377343921159820', NULL, '[]', 3, '已发货', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2025092422001442321408983531', NULL, NULL, NULL, NULL, NULL, '1@#NkU3rsjol0qhQk4UpV2UNkwyiD03l/Y2AjTxwHD/4hMYsPCXIE27KYYDMQxuDI2v3yBHMQl1', '#jN+4#vzpVXWjUDImVra3Rm6mBO8NI5FCdCInFAYPMF0a+alKHVWRy1YoTKAiAjBZxk4iQgWAOQTfKw5VP5HonVPGaNVnFRo1tEuRwB/TwMA==*CgYIASAHKAESPgo8HDeqxDqmSU+EamcuSH7M2RBn/x0nqJmo2NfgN/VXR8QQ9Av6n7QxXbVHEVEzjY0Qy7JZSMaZxFkdsRMxGgA=#1##', '$KIxzDjkaDJQX0+/bZPsRveim24HMJrYHBXdwZ/ovKjI=$enD3HBVHOPclgjHTcXe1EqS+Zl5sRaYT+e0B//yKVzIbVZNMxFvwZdP+r8ENoL5vY6woGtSChZ8xNx2mxiEqJiONojA7FpybX2GkvfLnY9Du*CgYIASAHKAESPgo8len1T1tv0R7kUFbzuH4TzK9eSr4zJMf5eiF++STJPk1l0ktndvshkygoSpp2PAx52Z2uHi95eUEJoU4jGgA=$1$$', '#Z82gmU8k#ktT36gKV4lGwEAJJb4G6EHJBipth4wgNH4WRSmYPt6B3578NA5Ccjp48tzgmGJfMXyC6guaMB5LH4jnGuh+dYjFElu3OQtw8dpC7njOa5w==*CgYIASAHKAESPgo8Pr2l4n7JMS5/bKvSawNMIDW8+zAk31gzzpyOh5bFrN6tNKRQ0DKnRSLw0pRoIef6simzKMsrsoqAzH2hGgA=#1##', NULL, '[{\"company\":\"jd\",\"company_name\":\"京东物流\",\"delivery_id\":\"147149636126188389\",\"guarantee_amount\":0,\"hour_up_pickup_code\":\"\",\"product_info\":[{\"outer_sku_id\":\"\",\"price\":1,\"product_count\":1,\"product_id\":3704250147174219802,\"product_id_str\":\"3704250147174219802\",\"product_name\":\"通用气质针织春夏收腰欧美法式潮流短款外套\",\"sku_id\":3415147054562818,\"sku_order_id\":\"6921377343921159820\",\"sku_specs\":[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"XL\"}]},{\"outer_sku_id\":\"\",\"price\":1,\"product_count\":1,\"product_id\":3704250147174219802,\"product_id_str\":\"3704250147174219802\",\"product_name\":\"通用气质针织春夏收腰欧美法式潮流短款外套\",\"sku_id\":3415147054562562,\"sku_order_id\":\"6921377343921225356\",\"sku_specs\":[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"L\"}]},{\"outer_sku_id\":\"\",\"price\":1,\"product_count\":1,\"product_id\":3704250147174219802,\"product_id_str\":\"3704250147174219802\",\"product_name\":\"通用气质针织春夏收腰欧美法式潮流短款外套\",\"sku_id\":3415147054562306,\"sku_order_id\":\"6921377343921290892\",\"sku_specs\":[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"M\"}]},{\"outer_sku_id\":\"\",\"price\":1,\"product_count\":1,\"product_id\":3704250147174219802,\"product_id_str\":\"3704250147174219802\",\"product_name\":\"通用气质针织春夏收腰欧美法式潮流短款外套\",\"sku_id\":3415147054562050,\"sku_order_id\":\"6921377343921356428\",\"sku_specs\":[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"S\"}]}],\"ship_time\":1758704030,\"sp_discount_price\":0,\"sp_price\":0,\"sp_total_price\":0,\"tracking_no\":\"JDAZ21355577515\"}]', NULL, '已全部发货', '新*', '1**********', '***', '四川省', '51', '成都市', '510100', '金牛区', '510106', '荷花池街道', '5101060270000', '#rZqnOZn5gc5bQ6RcgAlcbxiMv3b3sO8Le7Sgl3giLnFm61aZAn2zmLDs/dcIEjJoENGpLrssuaeYFDRQ3ocn8WPguJrft63bwojureCWVfGEFoRj4Wq5r0MvVszQeROVeWuZ6mSiUQ==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:09:59', '2025-10-01 17:16:48', 1, '2025-10-06 10:16:50', 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (11, '6946646239948707088', NULL, '[]', 2, '待发货', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '测试店铺备注', NULL, '', '2105012509300502776975064759', NULL, NULL, NULL, NULL, NULL, '1@#4b7yb3uvanE9Ph/nTZJaQZZ0ldINE14nOfQh6OGmmaLYNS7Y7gztR+vuHaDhTvR+i07zfMIe', '#SbkESbkESbkEioIy#5FfrFVXjCtol7UQpVZaekjYDShenA+x5e7i92Wy5iuyQVsOfWwhj9Uz9HL+Y90FJtSoxMshgWxRTQI7BgcYoLPEBBzMo40diEpSCMEr52xsz+cffZg==*CgYIASAHKAESPgo87dOIebUe57L4PRq1ZkXZcJEcdLEdJaxbYL2bNzzkNhYZTVwD6FpuyRJQJVr7mVVo2o6RZIkCE2Fpv3OWGgA=#1##', '$w8zrYbLzkWWVM//DltRxNHOwqDXG/kcJqdE+ekmHLbU=$J/Jdm8NLMRaG/aO8JyKrguBRTz0p7nkpIdUW2pUnz1GBnP+jW+xPtjoMGn+ER62LZJNYx9bAmoRjD60gdayo3WgoT4E0i/TaBpayhWEA6dyE*CgYIASAHKAESPgo8+rYCT76llk6t4BG/LyvAGbm3RGf4MbW+twLFTrjs/ZX+J6kc2k/fTnwYWKwsGMueagFdZUdMvMdF+vneGgA=$1$$', '#CvPEYmeV1J0giydzjf4nsWqviDjle19UFPgS#fKNebPOHERoCKrwyWb93sGouiU6eEOkvanfXfdQBiEYsuDvhUecs5fV7Jn8xKT4DD7UgGdAJCvuxwNaYn+D1VYqYHKVwVfqa6o2QzWmNNXVghH57tfyrjqeZVo4Wwx1DRVcNQA==*CgYIASAHKAESPgo87Qvwe6iD4HIiw7zz3N9y7DvPMVJSWW8IZyrPn/pSJJyDfX4n1ueVBW/mSrsTx0GpZfjK8Ote4vZUDS+cGgA=#1##', NULL, '[]', NULL, '备货中', '苏*', '1**********', '**********', '福建省', '35', '三明市', '350400', '建宁县', '350430', '客坊乡', '350430204', '#cD7NvYoYboGVV9RD04hR90HnUz7vrKxdq6ZTqYyneHtCLGGXcPGReHPdgnxCGsYZv6z0AWHf8g/GVqL4LS2mm/Y/r92160j3VwLxR0JpMYesF5t3un26a7wPjS7WwdazRdnOi5ivTA==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:01', '2025-10-01 17:16:51', 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (12, '6946059443096458667', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509120502537876591012', NULL, NULL, NULL, NULL, NULL, '1@#Fq6vuTIMt21BwqWHfJ7iIjkAXYaA2oPVDZGCTEFikbEy/rck998C+1AS5KaFk+aXJg==', '#PZ9X#kZ0OvMHABzf9ompG7FJs610aQrdAJsWpOP6/DmxXyOomPOm0fU+BYjGBQC54tbc1l3OArX0QNJoxbgp9xhIeNwYtskEzWrLNwLaZ8w==*CgYIASAHKAESPgo8Gj828JwvI+uuSDf367jyT3aEoB6G18/HaZ9bBgNHQ3LHCpMGPdzXP7lejAvE6VCNqGHp2NWsOPe5+GRiGgA=#1##', '$/ZCkppZZQbrrE8yh3yQ9uK709XjbgMLjcowcpegm0pI=$1JCF4z1TV7lthqZhnHCX2SLHwLbdVumFTl0UK9kqKrNVsQvf7DjQdGSDGiSTHbtbmbu2VJUYY6/OZ0lOiaBzZvIdKBesUbuqjNnDZRdfRmXN*CgYIASAHKAESPgo8VM30zZpl2o4dUqRU0ob8sNOZaV49k/RVZS9UY7KyS2Im2wqRCQ4rT4v75JuSmIiUxO5XnlRtO0V5Yi5OGgA=$1$$', '#RJITyV5H/+ePTO11iw6CyEB/nH1jASmYpdFWZf0KV19ktx2JimIL#/MwlpLh5s1Us8QoUkYE0UtP4Qvo4KmjOkfD6KG43RONiRPA+4A0taX0Ah78KvuRuQfsfwnuWEWjAjn0UR52LOOmzZHAHCs6fMLEyM68Qp/NlSp/D1fSIAVzP9o46r4GnW9w/SBeP*CgYIASAHKAESPgo8g6OYEl4MQpLFEsJL0TokljD/h7cIpqKyPdoanVrJQNHDf71wvMaXhvCMjJtg542ZllD/kG8LewXIgrffGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '雨*', '1**********', '**************', '浙江省', '33', '杭州市', '330100', '余杭区', '3301100000000', '五常街道', '3301100050000', '#iSzzI8AylihNSNZUyei4RilrYkrReoC7H9kYkaousJ9vlgreoQkp4qT0MUQV3vacfIADctsguYVZAFQETFLT+Z76rLK9krcBbOHQ1rU0t1Kuk3nuKD7PpoIIZ1gdvBPQyJkaM9ci3A==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:01', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (13, '6946161523578312107', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509150502311789779025', NULL, NULL, NULL, NULL, NULL, '1@#Fq6vuTIMt21BwqWHfJ7iIjkAXYaA2oPVDZGCTEFikbEy/rck998C+1AS5KaFk+aXJg==', '#PZ9X#4fuNrv2Gl7TeA+9uBu0HmGk4aYYPwEf1ubF5IDs2JbrVoVIiBStpIReSSM7R4wDbU/cPo+h0H8D6xH1tcwI31gdAzwhN6VQ5jZZgdQ==*CgYIASAHKAESPgo8JCdJU2Iwk/h+JU0UxJehqVNvwNdld82Ko82oJlvRQQ/g7ld0y/dwngmPH/HZ8UBm9UyDli/+BabQQoghGgA=#1##', '$/ZCkppZZQbrrE8yh3yQ9uK709XjbgMLjcowcpegm0pI=$zYOoIEqytehwrTA2/2jMxklMUgcvh++7MGVpFJlZ20hsWWooegQczqcvr2MzL67zpRoAipquVTccwM+GylzO9LCBd0JZspHrN1WJl3jj8798*CgYIASAHKAESPgo8FtcCyljIFbR6pRWH2uYP+dNqEXF0pnbLORrcDXmoTooWHxaDceCC8yqpXS1G+btrgr7V5GyjwvzFtc79GgA=$1$$', '#RJITyV5H/+ePTO11iw6CyEB/nH1jASmYpdFWZf0KV19ktx2JimIL#RQ1BRuGMmI9F6BuIUFIkkvwYQvA4X46szbe9Ng/lqWTY0oo1bPckMPs6GKcYEfCR9Z8mabK7Aq8ApgIyDSMT8Y799e94eSt7zN0o3NFiDTpa+dicttFEfMZm7piVMwMy2p1GXV5z*CgYIASAHKAESPgo8yE0xTurfiZZ23AGv8U8b3PFzi63UyzfPEcdDjugP+vUd+xFKFd+HkC0Mp1M96rjCww9AXMii00HwN7q7GgA=#1##', NULL, '[]', NULL, '发货前退款完成', '雨*', '1**********', '**************', '浙江省', '33', '杭州市', '330100', '余杭区', '3301100000000', '五常街道', '3301100050000', '#iSzzI8AylihNSNZUyei4RilrYkrReoC7H9kYkaousJ9vlgreoQkp4qT0MUQV3vacfIADctsguYVZAFQETFLT+Z76rLK9krcBbOHQ1rU0t1Kuk3nuKD7PpoIIZ1gdvBPQyJkaM9ci3A==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:01', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (14, '6946199662331172267', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509160502673157647232', NULL, NULL, NULL, NULL, NULL, '1@#Fq6vuTIMt21BwqWHfJ7iIjkAXYaA2oPVDZGCTEFikbEy/rck998C+1AS5KaFk+aXJg==', '#PZ9X#U4AUyR3QzdGYT+YkZY6JMZxgGCJWCAElC30K6Oc7knZo4wkZ8e6us0m63X48vWGpeTVPLRyQA5PJlHgo0/fRzKaJjyimtrvLAKKYHw==*CgYIASAHKAESPgo8ocXlbBqKA7+6I/HLYBQFkCJJYQDtPb+EAraUl4PwZIchV5WkLNpI1anf9J4jIpkHY3yi1uIAl0PHwlz8GgA=#1##', '$/ZCkppZZQbrrE8yh3yQ9uK709XjbgMLjcowcpegm0pI=$BKVEBPIPMYwAzfVGvzYS6BeESzpNvgfZ7+hVqTM1wur2vUp7LMZ03m6L9sL4H5tA+5/6HjNhUFxAdmW6vxrAW3JrFjIOSlA9nJd/YNQqEXLY*CgYIASAHKAESPgo8ShMv1CUtAL9eSikjh6xJP3Q5Q2KjJiov8mUkiCmtNWQb374EHsMROVnajX26APnuXySxDGuuizi1oHXfGgA=$1$$', '#RJITyV5H/+ePTO11iw6CyEB/nH1jASmYpdFWZf0KV19ktx2JimIL#Jen5J9Q7j8Nx3QNtdr4uIPOLgSNlH9pYw52adfiSfcI7wzpP3MwPb24PnGeFIlRgeIUMjv9gIDluJqbMiphXglbeYK/+zYd64Y8Dk67OflGBEXgUF8ZS+lGnWXr3VaPEdovu6N5p*CgYIASAHKAESPgo84lLBIS6K5jRdgD5EmYqxy6w6OSBwQ2cJpfuU+70tw8BPMLFyk9vK56/AkqiNYT5Knu3vdZmmBL6c9JnaGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '雨*', '1**********', '**************', '浙江省', '33', '杭州市', '330100', '余杭区', '3301100000000', '五常街道', '3301100050000', '#iSzzI8AylihNSNZUyei4RilrYkrReoC7H9kYkaousJ9vlgreoQkp4qT0MUQV3vacfIADctsguYVZAFQETFLT+Z76rLK9krcBbOHQ1rU0t1Kuk3nuKD7PpoIIZ1gdvBPQyJkaM9ci3A==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:01', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (15, '6946185895022761387', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509160502658250653540', NULL, NULL, NULL, NULL, NULL, '1@#Fq6vuTIMt21BwqWHfJ7iIjkAXYaA2oPVDZGCTEFikbEy/rck998C+1AS5KaFk+aXJg==', '#PZ9X#aarkK+f/urqHDbRqvYd65BErTmNkgcGnbgE0700Rlq6i4SvWF4yp9Y31TNudhV9IpjM0N1eayHCOMvdGjv2BsSyssVLLR51+DKyh9A==*CgYIASAHKAESPgo8TTuPMc+yY/HLYV8Js2fSCYTA2BgTAtimFEFI8UrSx4ES663DKWCSGUeBP2l20fKqQh6aO41ffIKXd6e/GgA=#1##', '$/ZCkppZZQbrrE8yh3yQ9uK709XjbgMLjcowcpegm0pI=$3DQGCnBzhYfTGxhTniI0FgSaWBu/vZvPfPyx5nvMdDnRGgyVIeEfwxQ3pyITkbTFLQunD45shgqR+DmC3Asvixp3GxWbZiFuUoLRhyxlF+pM*CgYIASAHKAESPgo8TA+yuJVPxr04mAWwp7Y6sS9W6oH88Y/B4+W1U+7vjJmV9QklBQtOiAtDIrXBD4QRMTZ6Fw3ZYvHk+f4kGgA=$1$$', '#RJITyV5H/+ePTO11iw6CyEB/nH1jASmYpdFWZf0KV19ktx2JimIL#U0H7OYSGPgSC0hSjxQU7fqjGshRcILmK3ApSHVJiXucjjFnzWkE6GOgHRiPwS6C51QIEW+Pwb3pG4J5uaQX1mpOHEJWcClW66+TwxLHdvxINcDbSZx8YEfVPKQ/gfWZoNX1m7wAo*CgYIASAHKAESPgo8q5a/EdO/MPTNCH2tHXQDvGwns+wtzF5n9CIqcCNmXt4R4AMfKcoucEyntCwtlVmKbPKcEWbLZgzkKZsiGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '雨*', '1**********', '**************', '浙江省', '33', '杭州市', '330100', '余杭区', '3301100000000', '五常街道', '3301100050000', '#iSzzI8AylihNSNZUyei4RilrYkrReoC7H9kYkaousJ9vlgreoQkp4qT0MUQV3vacfIADctsguYVZAFQETFLT+Z76rLK9krcBbOHQ1rU0t1Kuk3nuKD7PpoIIZ1gdvBPQyJkaM9ci3A==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:01', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (16, '6946161548473734571', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509150502314237447777', NULL, NULL, NULL, NULL, NULL, '1@#Fq6vuTIMt21BwqWHfJ7iIjkAXYaA2oPVDZGCTEFikbEy/rck998C+1AS5KaFk+aXJg==', '#PZ9X#+xzDqOw7KoYn3amU25D5QO6/9D3Ro0iZXilm+bmD/5CexjWmkX5O7+IfyBfwkvzYRMFYNzW0zMZcbfVqr7Yze5MEkC4Ceo9abyDeDg==*CgYIASAHKAESPgo8QY4gBtOFLThsolc0lwTXM+qXZvs4cie8e94qQy4u8s+BkBLFsdYO9UCAIPOkT5vYn3o327NqLMvVqVwAGgA=#1##', '$/ZCkppZZQbrrE8yh3yQ9uK709XjbgMLjcowcpegm0pI=$43OPHqCV9FxvklLagFMTAsW2ZHyVGBkWIfP/QGa/xkU+DC7FIsdrn0p8PV45HpciEPPIvbGDbCpYB1/4ymtlllAQRO8/80L6OFAWjha1WVym*CgYIASAHKAESPgo82xLokC0w7ufLzBQNZPRylo+Gd5C/ALqg+j3yOh75kBqgDYCDKB6tCYTMy/Jf99FTaSDV0aQ4+aJfYVkTGgA=$1$$', '#RJITyV5H/+ePTO11iw6CyEB/nH1jASmYpdFWZf0KV19ktx2JimIL#nzTOuLZMY5Hziok6c61DD7DeThhT7oKQodEjsY3BU6DERXCy2zRURGCGBpD+0JWqxMrt+okjyvCvn/R++cYlf8Y6+tgdwJerRso8hK9N9v+wsZEt7G7seXRZhtXd4ai1ER4MlNPJ*CgYIASAHKAESPgo8hLopFlENKEtLiI41bncq2CKBd5THH6e9EboUQby1w6BdquYgeLFUa7o9LD99InS2cavknU/UUPW/Tl0cGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '雨*', '1**********', '**************', '浙江省', '33', '杭州市', '330100', '余杭区', '3301100000000', '五常街道', '3301100050000', '#iSzzI8AylihNSNZUyei4RilrYkrReoC7H9kYkaousJ9vlgreoQkp4qT0MUQV3vacfIADctsguYVZAFQETFLT+Z76rLK9krcBbOHQ1rU0t1Kuk3nuKD7PpoIIZ1gdvBPQyJkaM9ci3A==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:01', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (17, '6946157501303494059', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509150502630035242902', NULL, NULL, NULL, NULL, NULL, '1@#Fq6vuTIMt21BwqWHfJ7iIjkAXYaA2oPVDZGCTEFikbEy/rck998C+1AS5KaFk+aXJg==', '#PZ9X#ZNfqa5aoYyorR1qHwcCVX0Q9ybW3L/z8ZQ1bmxhcnseJAwWOIqyS7fjH0kUDjz4HqG/QtWNVxX/hD4isSZXSgj147yy9rItPoKK1kw==*CgYIASAHKAESPgo8nBCgMoW9VRmBYtbufwfr5pzpWihf7CExX7ocqZMafcVIo+5OiRQGDwSAUgBONUY5Oa6nIhwvnJieLZP7GgA=#1##', '$/ZCkppZZQbrrE8yh3yQ9uK709XjbgMLjcowcpegm0pI=$a4RqJeV9mKHnuQXltEBVZaldV39mDaGw9OhRXaZJzbsBVaTSs9rCbO1TXRFpo3CCrFWKCQTMxNfgWUGGXcvFVaFumXy4X/N0SG6tw8X8/9eQ*CgYIASAHKAESPgo8oEd9p3qHu+KVyvDgQNLzki9bpamddQ5Iz75fU98ibzw27r93+Bei+sX0CCKTswJMcQ3JmQIuZiSSynsiGgA=$1$$', '#RJITyV5H/+ePTO11iw6CyEB/nH1jASmYpdFWZf0KV19ktx2JimIL#9qqo9PuBDL6riZiABRDPTArJzmkDgRuvlDMKMoK/6CSW3pSHwZDjtQJXpfVomfpCFg8kMmbLfK1K1z0zB0qnx1DI3qhFP5M0Y8l97DjdsOPyyAZVtpUk12PJ5pvMKkr/W6LWo5TE*CgYIASAHKAESPgo8TBTOZ8H2G2qwxAIQVedRMf5fZvREMi2NalpEbXdhbzWUFkrh+OTXHBcS7OyMiLjF3kUf2neTaxO9iesBGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '雨*', '1**********', '**************', '浙江省', '33', '杭州市', '330100', '余杭区', '3301100000000', '五常街道', '3301100050000', '#iSzzI8AylihNSNZUyei4RilrYkrReoC7H9kYkaousJ9vlgreoQkp4qT0MUQV3vacfIADctsguYVZAFQETFLT+Z76rLK9krcBbOHQ1rU0t1Kuk3nuKD7PpoIIZ1gdvBPQyJkaM9ci3A==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:01', NULL, 1, '2025-10-02 15:37:01', 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (18, '6946198576192755115', NULL, '[]', 3, '已发货', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', 0, '', '2105012509170502687255456156', 1758073971, 1758073972, 1759300344, 0, 1800, '1@#Fq6vuTIMt21BwqWHfJ7iIjkAXYaA2oPVDZGCTEFikbEy/rck998C+1AS5KaFk+aXJg==', '#PZ9X#DWfuuKCY5fc1lO3ohvwVeRBpErnucAca75CUIkpV4HKKjYk5Ais8VOaSCcT6cJD/uSIBK3WOLw/omRAwUeShY34agDBZ/kn8c288QA==*CgYIASAHKAESPgo8OGxamXioWlS4rwLYnAxteGhj7XPnAhSxpTJ3hzZs6kQV8J0FatDh0gLathZQ7eLXTDy10QXhVBZDgAzbGgA=#1##', '$/ZCkppZZQbrrE8yh3yQ9uK709XjbgMLjcowcpegm0pI=$47R2hd+VlZd34twfr0t0bAlZV8NoY4K9Q7UDU9iN3xwrD98SM1aQ4DJBt3iI0yBQMjDighibe6Y6WwFuKGcmUmH1ATAOVf7Mo40PDYhGMMip*CgYIASAHKAESPgo8dWYf9rexImAC1WFdRhuNynLz8ST5gfZuacu3/L9BdhBGbBpv7OzAsQbScCJWY/7h0+r945AxkhSKIW9nGgA=$1$$', '#RJITyV5H/+ePTO11iw6CyEB/nH1jASmYpdFWZf0KV19ktx2JimIL#NH/JNeVDIS3GvzhGfLc/WduIakGjaSiirF3TXn9g5muG1S/A/380E1PtGcFWcQDMDF19l7bW05EVo9ekEJIu4Iuymklvq3uRIYWtHc8te9WfaCSf+CQcUprQ833pfTd/vKmxT+GG*CgYIASAHKAESPgo8Y+k1tyvT/ajRZuUz9x6fkHgCCeCQ409MmR9M+XoC1zPyhIdCCcwGozt9KNCLRty4USc3w55tG7hrRGCNGgA=#1##', NULL, '[{\"company\":\"yuantong\",\"company_name\":\"圆通快递\",\"delivery_id\":\"147139091376125714\",\"guarantee_amount\":0,\"hour_up_pickup_code\":\"\",\"product_info\":[{\"outer_sku_id\":\"\",\"price\":10,\"product_count\":1,\"product_id\":3775102360922227137,\"product_id_str\":\"3775102360922227137\",\"product_name\":\"【测试商品勿拍】养车式_粉色波点吊带连衣裙子组合商品2\",\"sku_id\":3553832070819586,\"sku_order_id\":\"6946198576192755115\",\"sku_specs\":[{\"name\":\"尺码大小\",\"value\":\"M\"},{\"name\":\"颜色分类\",\"value\":\"红色\"}]}],\"ship_time\":1758075511,\"sp_discount_price\":0,\"sp_price\":0,\"sp_total_price\":0,\"tracking_no\":\"YT1970294480762\"}]', 3, '已全部发货', '雨*', '1**********', '**************', '浙江省', '33', '杭州市', '330100', '余杭区', '3301100000000', '五常街道', '3301100050000', '#TtdarET6OaCDWvQu5vZ9cM3tgtk5NvStZY2f+PKeqJ7jy4kyNURb8D8oCQ15ojfYPHbWFPyMna0Vu1jUaHlEnFqQLDM7+dsvSFvhJRTZlahP+5IWKor8K+gmB3yWJLNFuVJeICFwwQ==', 0, 0, NULL, NULL, 20, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1758075511, NULL, NULL, 1007, '开放平台测试专用店', 0, NULL, 1007, '2025-10-01 17:11:01', '2025-10-01 19:14:43', 1, '2025-10-01 23:19:51', 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (19, '6946634625004279575', NULL, '[]', 4, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', 0, '', '2025093022001468691435509104', 1759201269, 1759201276, 1759290002, 0, 1800, '1@#A/siNWBLgw3jLQuwzuXHjvuhW1W78BHowaZxoG9eKOrzW1LeJM1CRaGvv308RdZK7ns7ZzU=', '#T0Y8#rZd/uOG6nM6RqDe1uqLbBi2td2rTrEr+Wrt0QXOHkJCl5yObzB3CHBCNYpvQzG6bVGNy5PrCM07hLNTlR4NI2Zj2dOOvJwlMwQFGNg==*CgYIASAHKAESPgo8DJhRIgjxd0B7a3gPYzcxtywgNu9ffERm69VWfd+pAFfSKmy5cX+TjltjgK0XAMJ9BhvoE871UrJjovl4GgA=#1##', '$sCTPF8vGRIx3Kn1dNeQDZWDw1rCV3PgRmwKKVmcE3mA=$8Y8cswG1JouwV9vjtzUcLOvCtiZK/LZN+WWOIMF4I5DyRfHjbrA2X8g2OU28UJSLrJyPzF7G/PHYQyWG5OGg3husqjsw4y/sBkMzbCogOLdh*CgYIASAHKAESPgo8NfFwL0KXq+jI5YwqR2ENh3ONibJDBu9t+m6KXbjRvUZje9mupx/iOZFsr6ql9qC8nCf0wnuX+eo4GElTGgA=$1$$', '#H+PbjTo3iJjTX4hFIrBACApHlwwhNpz9UhgUeJx6TCAul1VYlx0QpcRaLNI/z6d5UhaVxWqg+iAIHy2Ry630IfRt6MLMZf0K#bnXIA2kCJqJrGO/Z2YIhff7aQwJJNh9SjHV8VfYQBDvPw5DG4iNlX7b6GCm+TyrK91iHxOWdetRBhmSjUUaW2rDJ6rQAa5qgUaxn1+/igs7KVF1Vuu37x+uRPu3yLRi/jJyh432/+dpOat64rKM7uIm/TrKILYaRV26PF+3wITXVEdqY5QYh*CgYIASAHKAESPgo8hR9Gt4UqXE4O1Yrz0bvW4WHbE2btQ32VDfCXlef1XKz/kuDfITV+DTotrQBK6mPllDVFYW8vqDhYNXdXGgA=#1##', NULL, '[]', 21, '发货前退款完成', '彭*', '1**********', '*************************', '四川省', '51', '成都市', '510100', '武侯区', '510107', '', '', '#kk8hxiLk4kxF09GSQrG7NWUqvjni6JHvESvA32KkQZoJ4K+N6OsoJtMQVn6LVf6hPnC8VDPaulGfJbEaCQfake3WHWv5X7c0fT6AJZQocTRkQwlWkyABgKIdM7R2c0coMJ+FcB2UWQ==', 0, 0, NULL, NULL, 2000, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 4463798, '开放平台测试专用店', 0, NULL, 1007, '2025-10-01 17:11:02', '2025-10-01 23:16:47', 1, '2025-10-01 23:17:28', 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (20, '6921468105543351451', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '平台备注', NULL, '', '2025092822001408841455177168', NULL, NULL, NULL, NULL, NULL, '1@#vAxXEiYr1hvyQBOx1c7im3tSKGqOk8wTCu63zisCnCXa35QKR+Tyy0D+VGFmQISvSCCOeQE=', '#Wz62#7FxC0pFZNvRUKUmLvodQl+M/RulN3BYf6P9P7yqwdvD5bZATDAm37sGYpWL0DblW8JzaiY0/56stOsl/GkSDzMlqdmr2YvBgkwlkYQ==*CgYIASAHKAESPgo8CFwjjLH5B8vBsd2Oat1LV+zugzvXtVbilQuVBu8xpuicebwjOjDB6eTBCrSoYLt8ZTJASfnDZL6POgHkGgA=#1##', '$q9iaxg5ocSz4jZRJiqowrVnAROdeaibUJjpfu3Fey/c=$uWdXVH9c0NONEywRC0GcjkvMp2chmjpcYecLZYbPVVfbHZ3H4uXHZZRCudH6m77lzVrxOIJ7HhbaiuA950xxDuQhVRpY0PjU48kOfWDO1ZBa*CgYIASAHKAESPgo84XjJY+9KOgcy48kxxp0CSIVMbW5oLfAwQirL25ceX/T1jbtr1mwm3J5DKUa70YIVWlCHRnNgfrACJsWqGgA=$1$$', '#7Oj1MyPF3VVAuOV2y630IfRtHmvtFAC95+zS#/qJYeToVLJH6OLtyD7KXRvxF+idOKIKibqrtmkcKt6GbBKsY2G8+eFD2FM6xRbj9lhWNgrnsF6xjAqLywgEyS54a8U8JssJ9muTAPfBBCM6Yx2fPS5La3bIU*CgYIASAHKAESPgo8PDvwdqbdtModG9m5u1u6uhHcIHX6C0f6jgJpZjdvaMZXWP0mxo8uUtAP25MmetaLMSOrLnHb1mxqjJWSGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '贺*', '1**********', '**********', '江苏省', '32', '苏州市', '320500', '苏州工业园区', '3205710000000', '东沙湖社区工作委员会', '3205714030003', '#rNswyOQKPNn4j7nod2IBhAH/XnqlmSdAt8EPGS+qCrUpzr0Keqcco/ZumTVuORvbm46TVLXNDCOe9f4aQ6qsc4tagNFQwA+Mo0zXkNI2tTBc6r6I3MXmnSsVybeJWv86wDXhdwIqSA==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:02', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (21, '6921459271215119515', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2025092822001408841455262181', NULL, NULL, NULL, NULL, NULL, '1@#vAxXEiYr1hvyQBOx1c7im3tSKGqOk8wTCu63zisCnCXa35QKR+Tyy0D+VGFmQISvSCCOeQE=', '#Wz62#I1IFcaY7COu9VBeT9MqlkWirsY3y9qaoEY6wDsZbC6ykVAUkKEikgwpo00IKpmCwIQYG62AMKTMf5fqcoUOIxw6mdJdpZsignVVpBA==*CgYIASAHKAESPgo864azigf2p027oS1aWd+NxvoDzrg3ImCSAYSNB41Xg/9/iObNYOm+Cnl0/1mzIXv7IV8q4gHhVe/AxUj3GgA=#1##', '$q9iaxg5ocSz4jZRJiqowrVnAROdeaibUJjpfu3Fey/c=$ZEKgvGq3l1TJ3AkGeOLeAj2taYfDGU941aU/duK06q4YoOemxsSV2KJSuyH1FEGnw9BpAS/AHR/QaQMvna9d5Wk37mdkZeXdOtGFA14j1vRt*CgYIASAHKAESPgo82wXCZr7Sz+2DvZOaxla4MOwS93pGsSc+DCJfHznmXiv/VdV9ZII1iDDiapKiZ8Jw3Anbvi4+8VmNIkAaGgA=$1$$', '#7Oj1MyPF3VVAuOV2y630IfRtHmvtFAC95+zS#gOdPW3JgHXOHbAKjPvQwtTWKD7QxJCmyw+eL7HYuBEtyyYxCuW8ZusE0mW5K9E0uRcW1Upxu2l6yQnbi91wN9Y/TaqG85NMhqpIQdc0gnFnfdPz+VpmY/o5T*CgYIASAHKAESPgo8TBEoSnGUp/yoT4RulojNQepnVut+5f7EiB/qeW8d5n5KGGjfJGJAziotkPt4FOJeGZl8f/qbp3xh5ho8GgA=#1##', NULL, '[]', NULL, '发货前退款完成', '贺*', '1**********', '**********', '江苏省', '32', '苏州市', '320500', '苏州工业园区', '3205710000000', '东沙湖社区工作委员会', '3205714030003', '#rNswyOQKPNn4j7nod2IBhAH/XnqlmSdAt8EPGS+qCrUpzr0Keqcco/ZumTVuORvbm46TVLXNDCOe9f4aQ6qsc4tagNFQwA+Mo0zXkNI2tTBc6r6I3MXmnSsVybeJWv86wDXhdwIqSA==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:02', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (22, '6921466225005329563', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2025092822001408841458572890', NULL, NULL, NULL, NULL, NULL, '1@#vAxXEiYr1hvyQBOx1c7im3tSKGqOk8wTCu63zisCnCXa35QKR+Tyy0D+VGFmQISvSCCOeQE=', '#Wz62#KB0i5SSLw/LCBqtJEOba3YJoFxX082i5bkwG6GSu/nWsQqfZ1XNYcvkCJxioMLF0OfctES1SnmYzZtEwGTr+7kKyASKRgP8NNY2lkg==*CgYIASAHKAESPgo8pTqevh8c1b6qBWADw1D7pZLlrUH5tDeLMOCNaFO58YlVB75KKpO4Wwk57+jot8oWPJZTCHH5YN55a0eyGgA=#1##', '$q9iaxg5ocSz4jZRJiqowrVnAROdeaibUJjpfu3Fey/c=$Ab5nNf5ZCRWsNpCYqXGL+Vc5342xMU3AfAIsnrN/6hMzPmwEV3pvMk5zNMohB7Ldz5ZsHWK1xwUypoHaO2ZbmC6YG6zmlq4mE1/ZHMOSgRq5*CgYIASAHKAESPgo8fq+36yAZAoSECv80CHYbu5vPkcTF4e8bIMx/ExL1sEfUYY1hGNPO1xSfnTHCQmqbxbYy7iBx45CG7i/EGgA=$1$$', '#7Oj1MyPF3VVAuOV2y630IfRtHmvtFAC95+zS#+f5c38zCyCzzA2RMZ9J+YwmxJcFAuGtVfGajVM3K/Vfv2MIC1wvUPinoLKyLxou2w78tw0Ya9kN44MGcK8IfUXShiG8jEZSAs5fZPj1FUb6BCJpbAA6jpsEX*CgYIASAHKAESPgo8Hf/JDhzXA0+KJaqXddoSUqt87zSv2IYOWB1HPLhfKrX7FouanwSJ+FAt1j414phCFl2oIH1ycRQOJRoFGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '贺*', '1**********', '**********', '江苏省', '32', '苏州市', '320500', '苏州工业园区', '3205710000000', '东沙湖社区工作委员会', '3205714030003', '#rNswyOQKPNn4j7nod2IBhAH/XnqlmSdAt8EPGS+qCrUpzr0Keqcco/ZumTVuORvbm46TVLXNDCOe9f4aQ6qsc4tagNFQwA+Mo0zXkNI2tTBc6r6I3MXmnSsVybeJWv86wDXhdwIqSA==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:02', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (23, '6921461665048394907', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2025092822001408841455252884', NULL, NULL, NULL, NULL, NULL, '1@#vAxXEiYr1hvyQBOx1c7im3tSKGqOk8wTCu63zisCnCXa35QKR+Tyy0D+VGFmQISvSCCOeQE=', '#Wz62#WpBF4B5hlYjyizRP1/YbbddXOxzP+1QrCUuLrK7X84bbyOOfhuEbMhQYB1Q56Ze1lECTyHiJf9233gZYdQm3Nm5rRe1OLydo06lNEA==*CgYIASAHKAESPgo89SPLMen577Ugd9rQdC+ZiKpBfJExzi7ZeTF7L7IexTHe5wm+/ChYanssrZaEPQrlAnegSjXsvUfsC41pGgA=#1##', '$q9iaxg5ocSz4jZRJiqowrVnAROdeaibUJjpfu3Fey/c=$+YNB96JcwGMtpma+eoqSAuURelSzu6NZ4bMN4KL7Hu/yJ574YtDxsY2+lyEl8sizoela4xGpaxzzKXRuR014G5D+kKxTpnUNjRz6ciTVLEIY*CgYIASAHKAESPgo8vFUGYSoKfJq09Wavq0140b+/CxOFhv5QQKFiv9pU5VrA384uyz3i0qdeHDv9pfFPfcaUFVu81qmC+p54GgA=$1$$', '#7Oj1MyPF3VVAuOV2y630IfRtHmvtFAC95+zS#Tng3FXdzixBSkfdT6QEg0vZQ3ghllXZYDBzQO74LYn5ruic1G675zKYSsqoTgS5ooaN8gm7HnWHLcflAe5f7uUfAVciq0qBmPSdt6xDrBy3Q0ls3FxVhX0yX*CgYIASAHKAESPgo8do/RS4vG9+OzUNmluKFwTa71ZsTesGCazsqHki6KvDfiTvOYu9+C58jlFKf1Tr406woUnKJo99uW2q1NGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '贺*', '1**********', '**********', '江苏省', '32', '苏州市', '320500', '苏州工业园区', '3205710000000', '东沙湖社区工作委员会', '3205714030003', '#V007bkr6ONaiX9e0gV4cLLjCkmyAISQ6onExYQ/p2kO17bXUHkJ7ZJ76Vf44/ydwEIWpz/LoHoLaOb2hHhmUNQD6u563G65Xgo2V8jwWzq0/eHfbgMozdjBrgVqKuchG0f4mu/9IHg==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:03', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (24, '6921335415919443411', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509230601046284578595', NULL, NULL, NULL, NULL, NULL, '1@#w3mdKIAdPyGtCS4Hre3B/dbP2Wj+o5agmUpyfhQye/ZKijImo8pWKRuOf4ekZ7nQLg==', '#FSSM#eYMgvfN/mttBDBnQNHfkSLYc2vRZ6p+HQCc0RRibGjsHZgU0pqsOwyVy8CckagnNkm180JVWJ3w6QeEdp0x/eFTQF9WDyfNXmjH0ug==*CgYIASAHKAESPgo8QQ1YlkbtzCkPHHnnFRx3kZ71ELBuQ0v8YHRVaGFzVjxGdH2wKdETo4EuFS8PqtDaPl2sbmBEq1My0CH2GgA=#1##', '$L4UhPkYhUF6a2aQuKrLUr6wKS1s8Ubu+fgbuFLk6YEQ=$FoGuUDwcgXFKHwmdvV3oK1KvY3Wpd+E6CVbBQPlIhSxTMHFndcqFhJ5W/tg+Tw5Iwe+8lKVmbEg7uiczyFLHQCJHo0DMGmEdqtI6hBKxw//q*CgYIASAHKAESPgo81Bf8USn+tO5x57FW8Vi1xNJf6q0w7zbidmvZ73WqDk5g7UYhOMGrUes9YoRBQUwmQbo9tNMmGpyw0idAGgA=$1$$', '#jhGr8im62NVZjWDwC8nUCqITGdaY#PtPll9oA84yNwv9b67YvlnJTC1P5FZMW/6wGgEeCYUOaK3+kfo8PF+ClICGx2EQ/zVuiw7ZO1b47J/XxhsgfHOio92yX6h/ie58zvEm19Go/BRnUBp6DSQq4vaefHg==*CgYIASAHKAESPgo8gk3mj9yKwFor+8Ekb0ewxoVKSxtRi+19VAaYQqIfLjuQc1H+2EKN6IxMb0IOhJHHURhnSn6QPP+38PpUGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '测*', '1**********', '********', '河北省', '13', '邯郸市', '130400', '大名县', '130425', '大名镇', '130425100', '#LjmL0USa61WUtrYNKql+qVMEvSMAvNLoHeVX/dR3E/psH6GrwvJU+Hp/MJtNR3vzaMy3R0MZ7QON5yUuvK6WZOmXGeyqtch5pCKNraa+0GxHAj1Kax8O8rM/yrNxqTuYSrdH+tIbVA==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:03', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (25, '6921291986960743891', NULL, '[]', NULL, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', NULL, '', '2105012509220601041777413200', NULL, NULL, NULL, NULL, NULL, '1@#w3mdKIAdPyGtCS4Hre3B/dbP2Wj+o5agmUpyfhQye/ZKijImo8pWKRuOf4ekZ7nQLg==', '#FSSM#63OOqQdXQQb92KTc39AnF0zrlKGbNUis5MFARmUF17RpJUQ3w+9uvTkaIZ6pjnIDXHHvNnIIpD0FnBDYNOYYjSNbY3ok4QAkOFrK9A==*CgYIASAHKAESPgo8HOryI9bd1ZV3V65rEMf1VTd0m7BUCWouSqrhjDj+R0FbMbbqIEaD23g6TzyWrmhy+UGnH3xbZOA9zXDrGgA=#1##', '$L4UhPkYhUF6a2aQuKrLUr6wKS1s8Ubu+fgbuFLk6YEQ=$lN50vjhD196YBViXpOpzN4iLE6OVhsl4AWOIpfrplU6cnZX2Zu80H0mYaCSxO3hXcBFbJAhJOa8peOmtYKFa9f/6fsOIknJ85eBC6dwVb7p/*CgYIASAHKAESPgo8XWFCWCkZIVe1Y1TvHMWpk8sy4iUgx6QFDm8gUMFS5Zt9zDYK4M13nbre2bAKr4WtgiyKTWcUV15H3AW2GgA=$1$$', '#jhGr8im62NVZjWDwC8nUCqITGdaY#4fMdTdwyC1XxgIa3Dcx9I0chMYSxKhQYluhnEr6I00imTlY7hXTgKPBuwxWmkYUFAmd26ItdjsKa8j+hov4Rg2xUlwriNmreu5sHnYuhQYBm+HzYFix3S8d1AmnwpQ==*CgYIASAHKAESPgo8FYC3d/4zYMiwekx5HhewoWg54A0eUv1yyXqYmsmnT24KS8U3g5PsXob0ELVCwal+k91a2cR1h60zlvuhGgA=#1##', NULL, '[]', NULL, '发货前退款完成', '测*', '1**********', '********', '河北省', '13', '邯郸市', '130400', '大名县', '130425', '大名镇', '130425100', '#IR5rLOiAe+aM760Tczl2lBcYgVuhVz9bsY71bzO4S7x4fvrlVVtnhCYA/DjweKc9hPJZVPzhVsvOkgmKRugKG9hgeC50fpEdLZsoGEKY/6DLwdlRTRERz0FCbNfed1fK1Azck9D5OQ==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1007, '开放平台测试专用店', NULL, NULL, 1007, '2025-10-01 17:11:03', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (26, '6921346817299348947', NULL, '[]', 4, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', 0, '', '2105012509230601045874042782', NULL, 1758590987, 1759281315, 0, 1800, '1@#w3mdKIAdPyGtCS4Hre3B/dbP2Wj+o5agmUpyfhQye/ZKijImo8pWKRuOf4ekZ7nQLg==', '#gvO4#VZ/+RGtd76mEh1ZqlE1F5FhhXjR4Y74lZf5I/dx2dbai/bcUkV/if2/4lmeRtqWZ9QTlHCb6BNmt/J3hQVhQbRWWp+cYPzg0ZZs0uQ==*CgYIASAHKAESPgo8RfirSu0xS+sYaXG3zi/CT3ebmN+CAcJtP/6W4A+zGeeZaSP+ZgnQj8aZWneK3OFNldrtQW9vY2YvbwetGgA=#1##', '$+RdWsK5Lq1+n95G9R5UFmOTO9Uv7oWzSeD1aRl5V4a0=$L1Qgn5PatEn4K4Hd+S8U7zLPniG75Ng3SjEzDLsazksZ9cfkY5986uJdjD/fU4VaiHEUdo5mU5l4S6jN4HjVPxGUgmZqXTJMuQPKq9AuogHa*CgYIASAHKAESPgo8W1wP6o5JVFtLVnchAu5lVC0QzMBQuPk9b1hoyzFbVYUworcVY4Nn7OD4/UEjr2XfIxPjeq3qe8oqOAbPGgA=$1$$', '#co9BGVsICkX2bRxtLW43UtUiRiTtRjFbX57QLW435+zSBPll#3IFYpShOVJLaz+UhaF26d5TKeuboYfO68TH6r/8WtDGcoO3KjnkKmllMP4hwiNPJv9gK0XVY9LUcfX655QPlOVWOLpHjxXzQohfCfIiOjPKd2hPvjJW1Vcz0uJpGCV0xfg==*CgYIASAHKAESPgo8PDmIMQtdFxx0TWAKh0JEmBLx1kHM7ZoJ6cH22If8kvy5afrGTmhgVTjw7WpUKklvuIYNf6z5c0dB97rfGgA=#1##', NULL, '[]', 21, '发货前退款完成', '仇*', '1**********', '*************', '山东省', '37', '威海市', '371000', '环翠区', '371002', '田和街道', '371002007', '#ODUiVvTkW8pqhESUIT9u8rMkrBt7TrWeJJ+7c0P1dQ+9ukm0qxchcSIUikiYKrpqD6eXHkpwNRV/OHa9OUvk+NtcnsYhdoYTS3NN26UoQZ0dWufqNWaYnNt3ToVXPmERPavVmgOcEA==', 0, 0, NULL, NULL, 3, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1007, '开放平台测试专用店', 0, NULL, 1007, '2025-10-01 17:11:03', '2025-10-01 19:13:53', 1, '2025-10-06 09:57:09', 0, NULL, NULL);
INSERT INTO `oms_dou_order` VALUES (27, '6921344645306088915', NULL, '[]', 4, '已关闭', NULL, NULL, '普通订单', NULL, '', NULL, NULL, NULL, '', NULL, '抖音', NULL, 'H5', NULL, '小店', '', '', 0, '', '2105012509230601046191053060', 1758595976, 1758595977, 1759281311, 0, 1800, '1@#w3mdKIAdPyGtCS4Hre3B/dbP2Wj+o5agmUpyfhQye/ZKijImo8pWKRuOf4ekZ7nQLg==', '#gvO4#ja6HI8qB/N5M54CoJLITyiBqHkALxaHoqBDtlot1rrO+3w998EGYVQfFJKDWzhAVqfcnKiF0fCUumILKjmjgAaNfGV0okbclRBCpBA==*CgYIASAHKAESPgo8Yr375FlniO9/uBxladUpCR/Z9nROtCX0ARLdM2CECR8B0cVztphVURirjIOQIfZISzFQYtFkvTH9cWBbGgA=#1##', '$+RdWsK5Lq1+n95G9R5UFmOTO9Uv7oWzSeD1aRl5V4a0=$e8+mR3AWryuofoMaURMVeugzakh4gUIM77YM2Pk7mEvx1Kk+snj4CDOCb5dNo187Zzvbim7BkplKq7nPLJyYUJyduc2m6VumxlAu5q35xVoK*CgYIASAHKAESPgo8jjfplbYWDhpliWTbc/JySnxszeCQSjLCA/pMLBdcE9pEzCfOQlr4SHq+XxRsZICLrGkTCi+eKKvve8PBGgA=$1$$', '#co9BGVsICkX2bRxtLW43UtUiRiTtRjFbX57QLW435+zSBPll#SP36d3/WDHsEZgOS4a6DX1jNiMOeVtZtnR+ndbecD6u3xgGXjJtj7xS+vPzoLhcx7NuB2QxrZnwQyhgNZ4MuIPnpC89/LrKKcUzfZ4IPBoZqdra12C83Z4k0tiwkE5R8Fg==*CgYIASAHKAESPgo8itF6uwKV7zAst9FBHfCOjcy3sf2ddDpjPnT4j7UjoKlUFCg4gyI8T/2WtKxVOK++kGa5idbALMbYszY+GgA=#1##', NULL, '[]', 21, '发货前退款完成', '仇*', '1**********', '*************', '山东省', '37', '威海市', '371000', '环翠区', '371002', '田和街道', '371002007', '#kmr07wNrx6zCt0sqRf1zcRVzD3R8HIi9wuYn8yafVgUt2q8a4bEdHCY/KdQRLEv9OfHVpXxCHYIwe3Obz+DzbqWbPc3V7zhH6tOJ2sp7+pqD4xHRLfDs/z0MibDAZPUOt1vNwQO4jg==', 0, 0, NULL, NULL, 2, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1007, '开放平台测试专用店', 0, NULL, 1007, '2025-10-01 17:11:03', '2025-10-01 19:14:45', 1, '2025-10-01 23:19:13', 0, NULL, NULL);

-- ----------------------------
-- Table structure for oms_dou_order_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_dou_order_item`;
CREATE TABLE `oms_dou_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺子订单号，抖店平台生成，平台下唯一；注意：一笔订单下有一个子订单和父订单单号相同。',
  `parent_order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺父订单号，抖店平台生成，平台下唯一；',
  `order_level` int NULL DEFAULT NULL COMMENT '订单层级',
  `ad_env_type` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '广告来源，video-短视频 live-直播',
  `after_sale_status` int NULL DEFAULT NULL COMMENT '售后状态；6-售后申请；27-拒绝售后申请；12-售后成功；7-售后退货中；11-售后已发货；29-售后退货拒绝；13-【换货返回：换货售后换货商家发货】，【补寄返回：补寄待用户收货】； 14-【换货返回：（换货）售后换货用户收货】，【补寄返回：（补寄）用户已收货】 ；28-售后失败；51-订单取消成功；53-逆向交易已完成；',
  `after_sale_type` int NULL DEFAULT NULL COMMENT '售后类型 ；0-退货退款;1-已发货仅退款;2-未发货仅退款;3-换货;4-系统取消;5-用户取消;6-价保;7-补寄;',
  `refund_status` int NULL DEFAULT NULL COMMENT '退款状态:1-待退款；3-退款成功； 4-退款失败；当买家发起售后后又主动取消售后，此时after_sale_status=28并且refund_status=1的状态不变，不会流转至4状态；',
  `author_cost_amount` int NULL DEFAULT NULL COMMENT '作者（达人）承担金额（单位：分），订单参与活动和优惠中作者（达人）承担部分的总金额',
  `author_id` bigint NULL DEFAULT NULL COMMENT '直播主播id（达人）;仅直播间和橱窗产生的订单会有值返回;',
  `author_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '直播主播名称;仅直播间和橱窗产生的订单会有值返回',
  `c_biz` int NULL DEFAULT NULL COMMENT '【C端流量来源】 0-unknown 2-精选联盟 8-小店自卖',
  `c_biz_desc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'C端流量来源业务类型描述',
  `cancel_reason` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '\r\n取消原因',
  `channel_payment_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付渠道的流水号',
  `code` varchar(88) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家后台商品编码',
  `confirm_receipt_time` int NULL DEFAULT NULL COMMENT '用户确认收货时间',
  `finish_time` int NULL DEFAULT NULL COMMENT '订单完成时间，时间戳，秒',
  `goods_price` int NULL DEFAULT NULL COMMENT '\r\n商品原价（单位：分）',
  `goods_type` int NULL DEFAULT NULL COMMENT '【商品类型】 0-实体 1-虚拟',
  `is_comment` int NULL DEFAULT NULL COMMENT '\r\n是否评价 :1-已评价，0-未评价，2 -追评',
  `item_num` int NULL DEFAULT NULL COMMENT '订单商品数量',
  `logistics_receipt_time` int NULL DEFAULT NULL COMMENT '物流收货时间 ',
  `modify_amount` int NULL DEFAULT NULL COMMENT '\r\n改价金额变化量（单位：分）',
  `modify_post_amount` int NULL DEFAULT NULL COMMENT '改价运费金额变化量（单位：分）',
  `only_platform_cost_amount` int NULL DEFAULT NULL COMMENT '仅平台承担金额（单位：分），订单参与活动和优惠中平台承担部分的总金额',
  `order_amount` int NULL DEFAULT NULL COMMENT '订单金额（单位：分）',
  `pay_amount` int NULL DEFAULT NULL COMMENT '支付金额（单位：分）',
  `post_insurance_amount` int NULL DEFAULT NULL COMMENT '运费险金额（单位：分）',
  `promotion_amount` int NULL DEFAULT NULL COMMENT '订单优惠总金额（单位：分） = 店铺优惠金额 + 平台优惠金额 + 达人优惠金额',
  `promotion_shop_amount` int NULL DEFAULT NULL COMMENT '店铺优惠金额（单位：分），属于店铺的优惠活动、优惠券、红包的总优惠金额',
  `promotion_platform_amount` int NULL DEFAULT NULL COMMENT '平台优惠金额（单位：分），属于平台的优惠活动、优惠券、红包的总优惠金额',
  `shop_cost_amount` int NULL DEFAULT NULL COMMENT '商家承担金额（单位：分），订单参与活动和优惠中商家承担部分的总金额',
  `platform_cost_amount` int NULL DEFAULT NULL COMMENT '平台承担金额（单位：分），订单参与活动和优惠中平台+作者（达人）承担部分的总金额,包含作者（达人）承担金额：platform_cost_amount = only_platform_cost_amount + author_cost_amount',
  `promotion_talent_amount` int NULL DEFAULT NULL COMMENT '达人优惠金额（单位：分），属于达人的优惠活动、优惠券、红包的总优惠金额',
  `promotion_pay_amount` int NULL DEFAULT NULL COMMENT '支付优惠金额（单位：分），支付渠道上的优惠金额',
  `origin_amount` int NULL DEFAULT NULL COMMENT '商品现价（单位：分）',
  `out_product_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品外部编码',
  `out_sku_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部Skuid',
  `product_id` bigint NULL DEFAULT NULL COMMENT '商品ID',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuId',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `product_pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `promotion_redpack_amount` int NULL DEFAULT NULL COMMENT '平台优惠金额（单位：分），属于平台的优惠活动、优惠券、红包的总优惠金额',
  `promotion_redpack_platform_amount` int NULL DEFAULT NULL COMMENT '平台红包优惠金额（单位：分），属于平台的红包的优惠金额',
  `promotion_redpack_talent_amount` int NULL DEFAULT NULL COMMENT '达人红包优惠金额（单位：分），属于达人的红包的优惠金额',
  `room_id` bigint NULL DEFAULT NULL COMMENT '直播间id，有值则代表订单来自直播间',
  `ship_time` int NULL DEFAULT NULL COMMENT '\r\n发货时间',
  `spec` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '规格信息JSON',
  `theme_type_desc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下单来源描述（废弃）',
  `update_time` int NULL DEFAULT NULL COMMENT '订单更新时间，时间戳，秒',
  `create_time` int NULL DEFAULT NULL COMMENT '下单时间，时间戳，秒',
  `video_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频id，有值则代表订单来自短视频video_id',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_index`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '抖店订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_dou_order_item
-- ----------------------------
INSERT INTO `oms_dou_order_item` VALUES (22, '6921497618860834061', '6921497618860834061', NULL, '', 12, 1, 3, NULL, NULL, '', NULL, '小店自卖', '', '2025092922001454231458313285', '', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3777656114016026758, 3565179609033218, '【测试商品勿拍】【测试】THREE.js 2025实战课程', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/png_m_19d5039e2e0bb8deb4ef98a8aaac77cf_sx_856118_www992-992', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"套餐类型\",\"value\":\"标准版 - 视频课程\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (23, '6946059443096458667', '6946059443096458667', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509120502537876591012', 'MQL000025058/00', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3774537802461609985, 3551675625798914, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子组合商品', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"尺码大小\",\"value\":\"M\"},{\"name\":\"颜色分类\",\"value\":\"红色\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (24, '6946161523578312107', '6946161523578312107', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509150502311789779025', 'JINGU000000060', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3774020370663866599, 3549519084210434, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"尺码大小\",\"value\":\"M\"},{\"name\":\"颜色分类\",\"value\":\"红色\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (25, '6946199662331172267', '6946199662331172267', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509160502673157647232', 'SIOECHOY0005/00', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3775102360922227137, 3553832070819586, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子组合商品2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"尺码大小\",\"value\":\"M\"},{\"name\":\"颜色分类\",\"value\":\"红色\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (26, '6946185895022761387', '6946185895022761387', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509160502658250653540', 'SIOECHOY0005', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3775104366671954225, 3553850395099138, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子舒淇轮胎', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"尺码大小\",\"value\":\"M\"},{\"name\":\"颜色分类\",\"value\":\"红色\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (27, '6946161548473734571', '6946161548473734571', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509150502314237447777', 'MQL000025058/00', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3774537802461609985, 3551675625798914, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子组合商品', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"尺码大小\",\"value\":\"M\"},{\"name\":\"颜色分类\",\"value\":\"红色\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (28, '6946157501303494059', '6946157501303494059', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509150502630035242902', 'MQL000025058/00', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3774537802461609985, 3551675625798914, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子组合商品', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"尺码大小\",\"value\":\"M\"},{\"name\":\"颜色分类\",\"value\":\"红色\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (31, '6921160422267125024', '6921160422267125024', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509100600980829435593', 'FQ4109_700', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562562, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"L\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (33, '6921468105543351451', '6921468105543351451', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2025092822001408841455177168', 'EE6262_510', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562306, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"M\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (34, '6921468105543416987', '6921468105543351451', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2025092822001408841455177168', 'BY9961_290', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562050, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"S\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (35, '6921459271215119515', '6921459271215119515', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2025092822001408841455262181', 'BY9961_250', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054561794, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"XS\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (36, '6921466225005329563', '6921466225005329563', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2025092822001408841458572890', 'FQ4109_700', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562562, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"L\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (37, '6921461665048394907', '6921461665048394907', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2025092822001408841455252884', 'DU0404_690', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562818, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"XL\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (38, '6921335415919443411', '6921335415919443411', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509230601046284578595', 'FQ4109_680', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054563074, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"3XL\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (39, '6921291986960743891', '6921291986960743891', NULL, '', 12, 2, 3, NULL, NULL, '', NULL, '小店自卖', '', '2105012509220601041777413200', 'EE6262_510', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562306, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"M\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (71, '6921377343921159820', '6921377343921159820', NULL, '', 28, 3, 0, NULL, NULL, '', NULL, '小店自卖', '', '2025092422001442321408983531', 'DU0404_690', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562818, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"XL\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (72, '6921377343921225356', '6921377343921159820', NULL, '', 28, 0, 1, NULL, NULL, '', NULL, '小店自卖', '', '2025092422001442321408983531', 'FQ4109_700', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562562, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"L\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (73, '6921377343921290892', '6921377343921159820', NULL, '', 12, 1, 3, NULL, NULL, '', NULL, '小店自卖', '', '2025092422001442321408983531', 'EE6262_510', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562306, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"M\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (74, '6921377343921356428', '6921377343921159820', NULL, '', 0, 0, 0, NULL, NULL, '', NULL, '小店自卖', '', '2025092422001442321408983531', 'BY9961_290', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054562050, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"S\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (75, '6946646239948707088', '6946646239948707088', NULL, '', 0, 0, 0, NULL, NULL, '', NULL, '小店自卖', '', '2105012509300502776975064759', '520667', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3763623848264728892, 3515165148530178, '【测试商品勿拍】DKT EMILY测试专用勿动勿动勿动勿动', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_e4556eb3e48eececc2973af5cc29c74c_sx_208191_www800-800', NULL, NULL, NULL, NULL, NULL, '[{\"name\":\"颜色分类\",\"value\":\"白色\"},{\"name\":\"尺码大小\",\"value\":\"MP(单品520667)\"}]', '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (81, '6921346817299348947', '6921346817299348947', NULL, '', NULL, NULL, NULL, NULL, NULL, '', NULL, '小店自卖', '', '2105012509230601045874042782', 'DU0404_680', NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054563330, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, NULL, '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (84, '6946198576192755115', '6946198576192755115', NULL, '', NULL, NULL, NULL, NULL, NULL, '', NULL, '小店自卖', '', '2105012509170502687255456156', 'SIOECHOY0005/00', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3775102360922227137, 3553832070819586, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子组合商品2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, NULL, '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (85, '6946198576192820651', '6946198576192755115', NULL, '', NULL, NULL, NULL, NULL, NULL, '', NULL, '小店自卖', '', '2105012509170502687255456156', 'SIOECHOY0005', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3775104366671954225, 3553850395099138, '【测试商品勿拍】养车式_粉色波点吊带连衣裙子舒淇轮胎', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_6e81220e4cc8108c6619174f5ae353e3_sx_979970_www1440-1440', NULL, NULL, NULL, NULL, NULL, NULL, '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (86, '6921344645306088915', '6921344645306088915', NULL, '', NULL, NULL, NULL, NULL, NULL, '', NULL, '小店自卖', '', '2105012509230601046191053060', 'FQ4109_670', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3704250147174219802, 3415147054563586, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', NULL, NULL, NULL, NULL, NULL, NULL, '-', NULL, NULL, '', NULL, NULL);
INSERT INTO `oms_dou_order_item` VALUES (89, '6946634625004279575', '6946634625004279575', NULL, '', NULL, NULL, NULL, NULL, NULL, '', NULL, '小店自卖', '', '2025093022001468691435509104', '20250929', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', 3775071782860619993, 3553739561195010, '酒店一次性棉麻拖鞋居家待客便携加厚防滑半包全包客人拖鞋定 制', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_de9e0dd4d97fb13808d817386b96be7e_sx_188032_www800-800', NULL, NULL, NULL, NULL, NULL, NULL, '-', NULL, NULL, '', NULL, NULL);

-- ----------------------------
-- Table structure for oms_dou_refund
-- ----------------------------
DROP TABLE IF EXISTS `oms_dou_refund`;
CREATE TABLE `oms_dou_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '售后订单id，自增',
  `shop_id` bigint NOT NULL COMMENT '订单所属商户id',
  `aftersale_id` bigint NOT NULL DEFAULT 0 COMMENT '售后id',
  `aftersale_order_type` bigint NULL DEFAULT NULL COMMENT '售后订单类型，枚举为-1(历史订单),1(商品单),2(店铺单)',
  `aftersale_type` bigint NOT NULL COMMENT '售后类型；0-退货退款；1-已发货仅退款；2-未发货仅退款；3-换货；6-价保；7-补寄；8-维修',
  `aftersale_status` bigint NOT NULL COMMENT '售后状态和请求参数standard_aftersale_status字段对应；3-换货待买家收货；6-待商家同意；7-待买家退货；8-待商家发货；11-待商家二次同意；12-售后成功；14-换货成功；27-商家一次拒绝；28-售后失败；29-商家二次拒绝；',
  `aftersale_status_to_final_time` bigint NULL DEFAULT NULL COMMENT '售后完结时间，完结时间是平台根据商品的类型，售后状态等综合判断生成，当售后单有完结时间返回时售后单不可再做任何操作；未完结售后单的该字段值为0；Unix时间戳：秒',
  `related_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '\r\n关联的订单ID',
  `order_sku_order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抖音子订单id',
  `order_status` bigint NULL DEFAULT NULL COMMENT '订单状态',
  `order_pay_amount` bigint NULL DEFAULT NULL COMMENT '付款金额',
  `order_post_amount` bigint NULL DEFAULT NULL COMMENT '\r\n付运费金额',
  `order_item_num` bigint NULL DEFAULT NULL COMMENT '购买数量',
  `order_product_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名',
  `order_product_image` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `order_product_id` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品id',
  `order_sku_spec` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格JSON',
  `order_shop_sku_code` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家SKU编码',
  `apply_time` bigint NULL DEFAULT NULL COMMENT '申请时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '最近更新时间',
  `status_deadline` bigint NULL DEFAULT NULL COMMENT '当前节点逾期时间',
  `refund_amount` bigint NULL DEFAULT NULL COMMENT '售后退款金额，单位为分',
  `refund_post_amount` bigint NULL DEFAULT NULL COMMENT '售后退运费金额，单位为分',
  `aftersale_num` bigint NULL DEFAULT NULL COMMENT '\r\n售后数量',
  `part_type` bigint NULL DEFAULT NULL COMMENT '部分退类型',
  `aftersale_refund_type` bigint NULL DEFAULT NULL COMMENT '售后退款类型，枚举为-1(历史数据默认值),0(订单货款/原路退款),1(货到付款线下退款),2(备用金),3(保证金),4(无需退款),5(平台垫付)',
  `refund_type` bigint NULL DEFAULT NULL COMMENT '退款方式，枚举为1(极速退款助手)、2(售后小助手)、3(售后急速退)、4(闪电退货)',
  `arbitrate_status` bigint NULL DEFAULT NULL COMMENT '仲裁状态，枚举为0(无仲裁记录),1(仲裁中),2(客服同意),3(客服拒绝),4(待商家举证),5(协商期),255(仲裁结束)',
  `create_time` bigint NULL DEFAULT NULL COMMENT '\r\n售后单创建时间',
  `risk_decision_reason` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风控理由',
  `risk_decision_description` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风控描述',
  `return_promotion_amount` bigint NULL DEFAULT NULL COMMENT '退优惠金额',
  `refund_status` bigint NULL DEFAULT NULL COMMENT '退款状态；1-待退款;2-退款中;3-退款成功;4-退款失败;5-追缴成功;',
  `arbitrate_blame` bigint NULL DEFAULT NULL COMMENT '仲裁责任方 1:商家责任,2:买家责任,3:双方有责,4:平台责任,5:达人责任',
  `return_logistics_code` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货物流单号',
  `return_logistics_company_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货物流公司名称',
  `exchange_sku_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '换货SKU信息JSON',
  `exchange_logistics_company_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '换货物流公司名称',
  `remark` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `got_pkg` bigint NULL DEFAULT NULL COMMENT '买家是否收到货物，0表示未收到，1表示收到',
  `is_agree_refuse_sign` bigint NULL DEFAULT NULL COMMENT '是否拒签后退款（1：已同意拒签, 2：未同意拒签）',
  `order_logistics` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商家首次发货的正向物流信息JSON',
  `aftersale_tags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '售后标签（含时效延长、风险预警、豁免体验分等标签）标签在平台侧会有更新，标签仅做展示使用，请勿作为系统判断依赖。JSON',
  `aftersale_sub_type` bigint NULL DEFAULT NULL COMMENT '售后子类型；8001-以换代修。',
  `auto_audit_bits` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '自动审核方式：1-发货前极速退；2-小助手自动同意退款；3-发货后极速退；4-闪电退货；5-跨境零秒退；6-云仓拦截自动退；7-小助手自动同意退货；8-小助手自动同意拒签后退款；9-商家代客填写卡片发起售后；10-治理未发货自动同意退款；11-治理已发货自动同意退款；12-商家快递拦截成功自动退款；13-质检商品免审核；14-协商方案自动同意退款；15-平台卡券自动同意退款；16-三方卡券自动同意退款；17-治理一审自动同意退货退款',
  `text_part` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文案部分JSON',
  `related_order_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '售后关联的订单信息JSON',
  `pull_time` datetime NULL DEFAULT NULL COMMENT '第一次拉取时间',
  `pull_last_time` datetime NULL DEFAULT NULL COMMENT '最后一次拉取时间',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抖音skuid',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `aftersale_id_index`(`aftersale_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '抖店退款表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_dou_refund
-- ----------------------------

-- ----------------------------
-- Table structure for oms_jd_order
-- ----------------------------
DROP TABLE IF EXISTS `oms_jd_order`;
CREATE TABLE `oms_jd_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` int NOT NULL COMMENT '店铺id',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单id',
  `vender_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家id',
  `order_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '	订单类型（22 SOP；75 LOC） 可选字段，需要在输入参数optional_fields中写入才能返回',
  `pay_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式（1货到付款, 2邮局汇款, 3自提, 4在线支付, 5公司转账, 6银行卡转账）',
  `order_total_price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单总金额。总金额=订单金额（不减优惠，不加运费服务费税费）',
  `order_seller_price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单货款金额（订单总金额-商家优惠金额）',
  `order_payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户应付金额。应付款=货款-用户优惠-余额+运费+税费+服务费。',
  `freight_price` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品的运费',
  `seller_discount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家优惠金额',
  `order_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '	1）WAIT_SELLER_STOCK_OUT 等待出库 2）WAIT_GOODS_RECEIVE_CONFIRM 等待确认收货 3）WAIT_SELLER_DELIVERY等待发货（只适用于海外购商家，含义为\'等待境内发货\'标签下的订单,非海外购商家无需使用） 4) POP_ORDER_PAUSE POP暂停 5）FINISHED_L 完成 6）TRADE_CANCELED 取消 7）LOCKED 已锁定 8）WAIT_SEND_CODE 等待发码',
  `order_state_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单状态说明（中文）',
  `delivery_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '送货（日期）类型（1-只工作日送货(双休日、假日不用送);2-只双休日、假日送货(工作日不用送);3-工作日、双休日与假日均可送货;其他值-返回“任意时间”）',
  `invoice_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票信息 “invoice_info: 不需要开具发票”下无需开具发票；其它返回值请正常开具发票 。（没有电子发票具体信息）',
  `invoice_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '普通发票纳税人识别码',
  `order_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家下单时订单备注',
  `order_start_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下单时间',
  `order_end_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结单时间 如返回信息为“0001-01-01 00:00:00”和“1970-01-01 00:00:00”，可认为此订单为未完成状态。',
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `telephone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '固定电话',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
  `full_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `county` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `province_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `county_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `town_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `vender_remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家订单备注（不大于500字符） 可选字段，需要在输入参数optional_fields中写入才能返回',
  `balance_used` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '余额支付金额 可选字段，需要在输入参数optional_fields中写入才能返回',
  `pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家的账号信息',
  `return_order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后订单标记 0:不是换货订单 1返修发货,直接赔偿,客服补件 2售后调货 可选字段，需要在输入参数optional_fields中写入才能返回',
  `payment_confirm_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款确认时间 如果没有付款时间 默认返回0001-01-01 00:00:00 可选字段，需要在输入参数optional_fields中写入才能返回',
  `waybill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '运单号(当厂家自送时运单号可为空，不同物流公司的运单号用|分隔，如果同一物流公司有多个运单号，则用英文逗号分隔) 可选字段，需要在输入参数optional_fields中写入才能返回',
  `logistics_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司ID 可选字段，需要在输入参数optional_fields中写入才能返回',
  `modified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单更新时间',
  `direct_parent_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '	直接父订单号 可选字段，需要在输入参数optional_fields中写入才能返回',
  `parent_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '	根父订单号 可选字段，需要在输入参数optional_fields中写入才能返回',
  `order_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单来源。如：移动端订单',
  `store_order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '京仓订单/云仓订单/空“”',
  `id_sop_shipmenttype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否京配。68=京配，69=京配自提',
  `real_pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家的账号信息(区分大小写) 可选字段，需要在输入参数optional_fields中写入才能返回',
  `open_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家的账号信息 ',
  `open_id_buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家的账号信息(区分大小写) 可选字段',
  `create_time` datetime NULL DEFAULT NULL,
  `audit_status` int NOT NULL DEFAULT 0 COMMENT '0待确认，1已确认2已拦截-9未拉取',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_index`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1464 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '京东订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_jd_order
-- ----------------------------

-- ----------------------------
-- Table structure for oms_jd_order_coupon
-- ----------------------------
DROP TABLE IF EXISTS `oms_jd_order_coupon`;
CREATE TABLE `oms_jd_order_coupon`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单编号',
  `skuId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '京东sku编号。(只有30-单品促销优惠 此skuId才非空)',
  `coupon_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优惠类型: 20-套装优惠, 28-闪团优惠, 29-团购优惠, 30-单品促销优惠, 34-手机红包, 35-满返满送(返现), 39-京豆优惠,41-京东券优惠, 52-礼品卡优惠,100-店铺优惠',
  `coupon_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优惠金额。',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '京东订单优惠明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_jd_order_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for oms_jd_order_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_jd_order_item`;
CREATE TABLE `oms_jd_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jd_order_id` bigint NOT NULL COMMENT '外键id（jd_order表id）',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '京东平台订单id',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '京东内部SKU的ID',
  `outer_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'SKU外部ID（极端情况下不保证返回，建议从商品接口获取',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品的名称+SKU规格',
  `jd_price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'SKU的京东价',
  `gift_point` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赠送积分',
  `ware_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '	京东内部商品ID（极端情况下不保证返回，建议从商品接口获取）',
  `item_total` int NULL DEFAULT NULL COMMENT '数量',
  `product_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `new_store_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `erp_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `erp_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1794 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '京东订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_jd_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for oms_jd_refund
-- ----------------------------
DROP TABLE IF EXISTS `oms_jd_refund`;
CREATE TABLE `oms_jd_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `apply_id` bigint NULL DEFAULT NULL COMMENT '申请单号',
  `service_id` bigint NULL DEFAULT NULL COMMENT '服务单号（退款单id）',
  `refund_id` bigint NULL DEFAULT NULL COMMENT '退款单id',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单号',
  `apply_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  `apply_refund_sum` double NULL DEFAULT NULL COMMENT '退款金额(单位分)',
  `customer_expect` int NOT NULL COMMENT '客户期望(1-售前退款 10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)',
  `customer_expect_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户期望名称',
  `service_status` int NULL DEFAULT NULL COMMENT '服务单状态（10000-待审核领取 10001-待审核 10002-待客户反馈 10004-审核关闭 10005-待收货 10006-待处理领取 10007-待处理 10009-待用户确认 10010-完成 10011-取消 10012-客户已反馈 10013-待审核和待客户反馈 10041-提交退款申请 1100-待下发维修中心接单 12000-上门维修中 14000-上门检测中 13000-商家催收待处理 13000-未收货，待收款 13000-已收货，待收款）',
  `service_status_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务单状态名称',
  `customer_pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户账号',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `customer_tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户电话',
  `pickware_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '取件地址',
  `pickware_type` int NULL DEFAULT NULL COMMENT '取件方式(4-上门取件 5-上门换新取件 7-客户送货 8-大家电上门取件 9-大家电换新取件 40-客户发货 70-送货至门店 71-快递至门店 72-门店上门取件 80-京东快运上门取件 85-德邦取件)',
  `order_type` int NULL DEFAULT NULL COMMENT '订单类型(0-一般订单 2-拍卖订单 11-售后调货 15-返修发货 16-直接赔偿 21-POPFBP 22-POPSOP 23-POPLBP 24-POPLBV 25-POPSOPL 18-厂商直送 19-客服补件 42-通用合约 61-EPT订单 69-京东服务产品订单 19-客服补件 75-LOC订单 77-LSP订单 42-虚拟订单 88-总代订单 96-sop虚拟订单 100-提货卡订单 33-电子礼品卡 49-礼品卡 108-京东维修服务产品订单 131-X无人超市订单 142-企业店铺IBS订单 151-品牌门店线下订单 112-自营采购，以销定结 159-领货码订单 89-移动仓库订单 170-实体领货码订单 140-商家采购订单 193-scf订单 54-线下礼品卡订单 202-月卡订单 4-虚拟商品)',
  `order_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单类型名称',
  `actual_pay_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '实付金额',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '商品编号',
  `ware_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `ware_type` int NULL DEFAULT NULL COMMENT '售后商品类型(10-申请主商品 20-申请的赠品 30-附件 40-发票 50-发票复印件 60-出检报告 70-包装 80-防损吊牌 90-贺卡 100-礼品购包装 110-loc订单验证码 120-服务产品标识)',
  `ware_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品类型名称',
  `ware_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `sku_type` int NULL DEFAULT NULL COMMENT '商品类型(1-单品 2-赠品套装中的主商品 3-赠品套装中的赠品 4-套装中的单品 5-套装中的赠品 6-加价购赠品 7-延保通 8-延保通赠品)',
  `sku_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'skuType对应名称',
  `approve_pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人账号',
  `approve_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人姓名',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `approve_result` int NULL DEFAULT NULL COMMENT '审核结果(11-直赔积分 12-直赔余额 13-直赔优惠卷 14-直赔京豆 21-直赔商品 22-上门换新 31-自营取件 32-客户送货 33-客户发货 34-闪电退款 35-虚拟退款 36-上门检测 37-客户送货至门店 38-保外维修 39-快递至门店 40-门店上门取件 80-大家电检测 81-大家电安装 82-大家电移机 83-大家电维修 84-大家电其它 85-闪电催收 86-上门维修 87-补发商品 91-退款不退货 92-预授权冻结 93-ACS换新 95-(超级体验店)门店换新 96-(超级体验店)主站换新 97-厂商维修-寄修 98-厂商维修-上门维修 99-厂商维修-送修 101-厂商大家电检测鉴定 102-厂商大家电安装 103-厂商大家电移机拆机 104-厂商大家电维修(上门维修) 105-厂商大家电拆机鉴定 106-换货 100-客户退货至团长 107-3c上门维修 108-增值服务 109-退货(筋斗云使用) 110-直赔(筋斗云使用) 111-上门检测取件)',
  `approve_result_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核结果名称',
  `approve_notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `process_pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理人账号',
  `process_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理人姓名',
  `process_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `process_result` int NULL DEFAULT NULL COMMENT '处理结果(0-初始化 1-安装完成 2-维修完成 3-检测完成 4-拆机完成 5-咨询解释 6-取消 70-原返 80-换货 100-赔付)',
  `process_result_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理结果名称',
  `platform_src` int NULL DEFAULT NULL COMMENT '平台来源',
  `platform_src_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台来源名称',
  `service_count` int NULL DEFAULT NULL COMMENT '服务单售后数量',
  `desen_customer_tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户电话',
  `buyer_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户帐号',
  `buyer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `refund_check_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核日期',
  `refund_status` int NULL DEFAULT NULL COMMENT '退款审核状态: 0代表未审核， 1代表审核通过 2代表审核不通过 3代表京东财务审核通过；4代表京东财务审核不通过',
  `refund_complete_time` datetime NULL DEFAULT NULL COMMENT '退款完成时间',
  `refund_check_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `refund_check_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核备注',
  `refund_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因',
  `refund_system_id` int NULL DEFAULT NULL COMMENT ' 退款来源(10:客服; 11:网站; 12:配送拒收; 28:APP; 87:分拣中心,逆向物流; 98:微信手Q;)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  `sku_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品明细列表JSON',
  `sku_count` int NULL DEFAULT NULL COMMENT '退款数量',
  `question_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `service_id_index`(`service_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '京东退款与售后表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_jd_refund
-- ----------------------------

-- ----------------------------
-- Table structure for oms_pdd_refund
-- ----------------------------
DROP TABLE IF EXISTS `oms_pdd_refund`;
CREATE TABLE `oms_pdd_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '售后编号',
  `shop_id` int NOT NULL COMMENT '内部店铺ID',
  `order_sn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `after_sales_type` int NOT NULL COMMENT '售后类型 1：全部 2：仅退款 3：退货退款 4：换货 5：缺货补寄 6：维修',
  `after_sales_status` int NOT NULL COMMENT '售后状态 0：无售后 2：买家申请退款，待商家处理 3：退货退款，待商家处理 4：商家同意退款，退款中 5：平台同意退款，退款中 6：驳回退款，待买家处理 7：已同意退货退款,待用户发货 8：平台处理中 9：平台拒绝退款，退款关闭 10：退款成功 11：买家撤销 12：买家逾期未处理，退款失败 13：买家逾期，超过有效期 14：换货补寄待商家处理 15：换货补寄待用户处理 16：换货补寄成功 17：换货补寄失败 18：换货补寄待用户确认完成 21：待商家同意维修 22：待用户确认发货 24：维修关闭 25：维修成功 27：待用户确认收货 31：已同意拒收退款，待用户拒收 32：补寄待商家发货 33：待商家召回',
  `after_sale_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后原因',
  `confirm_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单成团时间',
  `created_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建时间',
  `discount_amount` double NOT NULL COMMENT '订单折扣金额（元）',
  `dispute_refund_status` double NULL DEFAULT NULL COMMENT '1纠纷退款 0非纠纷退款',
  `goods_image` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_id` bigint NULL DEFAULT NULL COMMENT '拼多多商品id',
  `goods_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_price` double NOT NULL COMMENT '商品价格，单位：元',
  `order_amount` double NOT NULL COMMENT '订单金额（元）',
  `refund_amount` double NOT NULL COMMENT '退款金额（元）',
  `refund_operator_role` int NULL DEFAULT NULL COMMENT '同意退款操作人角色0:\"默认\",1:\"用户\",2:\"商家\",3:\"平台\",4:\"系统\",5:\"团长\",6:\"司机\",7:\"代理人\"',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '拼多多商品skuid',
  `outer_goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家外部编码（商品）',
  `outer_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商家外部编码（sku）',
  `goods_spec` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品规格',
  `goods_number` int NOT NULL COMMENT '数量',
  `shipping_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货物流公司名称',
  `speed_refund_flag` int NULL DEFAULT NULL COMMENT '极速退款标志位 1：极速退款，0：非极速退款',
  `speed_refund_status` int NULL DEFAULT NULL COMMENT '极速退款状态，\"1\"：有极速退款资格，\"2\"：极速退款失败, \"3\" 表示极速退款成功，其他表示非极速退款',
  `user_shipping_status` int NULL DEFAULT NULL COMMENT '0-未勾选 1-消费者选择的收货状态为未收到货 2-消费者选择的收货状态为已收到货',
  `tracking_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递单号',
  `updated_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL COMMENT '系统更新时间',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40559843813 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '拼多多订单退款表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_pdd_refund
-- ----------------------------

-- ----------------------------
-- Table structure for oms_shop_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `oms_shop_goods_sku`;
CREATE TABLE `oms_shop_goods_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台商品id',
  `product_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名',
  `outer_product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家商品编码',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku名',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台skuId',
  `outer_sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家自定义skuID。如果添加时没录入，回包可能不包含该字段',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku小图',
  `price` int NULL DEFAULT NULL COMMENT '售卖价格，以分为单位',
  `stock_num` int NULL DEFAULT NULL COMMENT 'sku库存',
  `status` int NULL DEFAULT NULL COMMENT 'sku状态平台',
  `sku_attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku_attrs',
  `add_time` bigint NULL DEFAULT NULL COMMENT '添加时间平台',
  `modify_time` bigint NULL DEFAULT NULL COMMENT '修改时间平台',
  `erp_goods_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `erp_goods_sku_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品skuid',
  `erp_status` int NOT NULL DEFAULT 0 COMMENT 'erp状态0未绑定1已绑定',
  `create_on` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_on` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1230 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '其他渠道店铺商品SKU' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_shop_goods_sku
-- ----------------------------
INSERT INTO `oms_shop_goods_sku` VALUES (3, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 12瓦白光 1级能效', '1740677623154', 'LEDDP00104', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 1, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (4, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 5瓦白光 1级能效', '1742373848730', 'LEDDP00102', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 0, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (5, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 18瓦白光 1级能效', '1740677623155', 'LEDDP00105', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 2, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (6, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 3瓦白光 1级能效', '1742373848729', 'LEDDP00101', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 2, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (7, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 24瓦白光 1级能效', '1742374330747', 'LEDDP00106', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 0, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (8, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 7瓦白光 1级能效', '1740677623153', 'LEDDP00103', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 1, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (9, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 30瓦白光 1级能效', '1742374330748', 'LEDDP00107', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 2, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (10, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '36W三色变光-300mm', '1742164849118', 'LEDDX00104', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 27, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (11, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '48W三色变光-330mm', '1742164849119', 'LEDDX00105', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 0, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (12, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '18W白光-175mm', '1742164849116', 'LEDDX00102', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 38, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (13, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '24W白光-215mm', '1742164849117', 'LEDDX00103', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 36, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (14, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '12W白光-135mm', '1742164849115', 'LEDDX00101', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 52, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (15, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '60W三色变光-360mm', '1742164849120', 'LEDDX00106', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 0, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (16, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '19寸黑金刚加强筋骨抗砸耐摔旗舰款', '1741926779986', '648700666529452', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 924, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (17, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '22寸黑金刚加强筋骨抗砸耐摔旗舰款', '1741926779987', '648700666529453', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 856, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (18, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '17寸三层折叠工具箱精工款', '1741926779984', '648700666529450', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 938, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (19, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '21寸三层折叠工具箱精工款', '1741926779985', '648700666529451', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 933, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (20, 1011, 300, '755635245980', '雷士照明led灯泡节能E27螺口球泡飞碟灯夜市地摊工矿大功率厂房灯', '', '白色款18W白光 其它', '1742372682345', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-01/c59032e87cd4a8aa1d6615eb3770bddb.jpeg', 0, 100, 1, NULL, 1748770918, 1748770918, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (21, 1011, 300, '755635245980', '雷士照明led灯泡节能E27螺口球泡飞碟灯夜市地摊工矿大功率厂房灯', '', '白色款30W白光 其它', '1742148962888', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-01/c59032e87cd4a8aa1d6615eb3770bddb.jpeg', 0, 100, 1, NULL, 1748770918, 1748770918, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (22, 1011, 300, '755635245980', '雷士照明led灯泡节能E27螺口球泡飞碟灯夜市地摊工矿大功率厂房灯', '', '白色款24W白光 其它', '1742148962887', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-01/c59032e87cd4a8aa1d6615eb3770bddb.jpeg', 0, 100, 1, NULL, 1748770918, 1748770918, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (23, 1011, 300, '756679247197', '雷士照明LED灯泡高亮E27螺口节能灯泡吊灯光源大功率护眼LED球泡', '', '【五只装】E27 18W 正白光', '1743027340565', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/1f92d0247e00defa30fe23ccc15be4fe.jpeg', 0, 100, 1, NULL, 1748965226, 1748965226, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (24, 1011, 300, '756679247197', '雷士照明LED灯泡高亮E27螺口节能灯泡吊灯光源大功率护眼LED球泡', '', '【五只装】E27 30W 正白光', '1743027340569', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/1f92d0247e00defa30fe23ccc15be4fe.jpeg', 0, 100, 1, NULL, 1748965226, 1748965226, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (25, 1011, 300, '756679247197', '雷士照明LED灯泡高亮E27螺口节能灯泡吊灯光源大功率护眼LED球泡', '', '【五只装】E27 24W 正白光', '1743027340567', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/1f92d0247e00defa30fe23ccc15be4fe.jpeg', 0, 100, 1, NULL, 1748965226, 1748965226, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (26, 1011, 300, '756684220589', '雷士照明led吸顶灯灯条客厅卧室灯板磁吸灯条长条形灯芯家用节能', '', '48W白光【一拖四】 【磁铁吸附 快捷替换】', '1749116485132', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/8079acdcba55f2fb96b57b775b87c002.jpeg', 0, 10, 1, NULL, 1748965956, 1748965956, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (27, 1011, 300, '762810718533', '雷士照明应急灯户外露营充电灯泡地摊照明灯超亮节能家用应急灯', '', '4W USB充电式灯泡', '1748010394260', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-15/d74171a6b86b15ddf9d2adc6632a6185.jpeg', 0, 0, 1, NULL, 1749996455, 1749996455, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (28, 1011, 300, '762810718533', '雷士照明应急灯户外露营充电灯泡地摊照明灯超亮节能家用应急灯', '', '7W USB充电式灯泡', '1748010394261', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-15/d74171a6b86b15ddf9d2adc6632a6185.jpeg', 0, 100, 1, NULL, 1749996455, 1749996455, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (29, 1011, 300, '770936903345', '雷士照明LED集成吊顶灯无边框防水厨房卫生间厕所全面发光平板灯', '', '30X30【24W悬浮曲面照明】', '1754155826431', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/3a3e4097cfebbbc95462edc234c8e488.jpeg', 0, 100, 1, NULL, 1751280371, 1751280371, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (30, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*600 24W珍珠白集成款', '1754157954617', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (31, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*300 18W雾银集成款', '1754157954614', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (32, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*600 24W雾银集成款', '1754157954616', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (33, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*300 18W珍珠白集成款', '1754157954615', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (34, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '三色模组48W 直径30CM', '1756355886272', 'LEDDX00105', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 0, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (35, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '三色模组60W 直径30CM', '1756355886273', 'LEDDX00106', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 0, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (36, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '白光24W 直径22CM', '1756354078309', 'LEDDX00103', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 0, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (37, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '三色模组36W 直径23CM', '1756355886271', 'LEDDX00104', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 98, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (38, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 2XL', '3628285618986498', '0', '3101777916e7c95984525ac33a27588f2077cc1793', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 106, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (39, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 XL', '3628285618986242', '0', '3101777916ff773b20589386b71b093160f2278141', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 133, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (40, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 L', '3628285618985986', '0', '310177791641707615a062ba2af4e56fe5f739f3de', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 449, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (41, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 M', '3628285618985730', '0', '3101777916ef5287dcf85bcd35eac09ca181a7b1e6', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 464, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (42, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 2XL', '3628285618985474', '0', '31017779160aafdfee412d4e86f3baf5c2b875211f', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 251, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (43, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 XL', '3628285618985218', '0', '31017779160e0fabf19d19389323b96b26bd9a4568', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 196, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (44, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 L', '3628285618984962', '0', '31017779163b8cbfb5961ded1f3c6fcc3e8e5f37b0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 265, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (45, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 M', '3628285618984706', '0', '31017779164882fd1cc4cbb8bb15fe8d453498820d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 458, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (46, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 2XL', '3628285618984450', '0', '310177791696118a2a7d521ef75307b7f82d105db9', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 617, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (47, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 XL', '3628285618984194', '0', '310177791661d09a5c4734af472bdc3d34d9569166', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (48, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 L', '3628285618983938', '0', '31017779164af1259ef7a73891dc671d186125b1fe', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (49, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 M', '3628285618983682', '0', '3101777916d3163efeb6ff8ece2e90c256e5b62999', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1110, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (50, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 2XL', '3628285618983426', '0', '31017779168b7a4dae7733ababf5660f6dcd8b2515', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 312, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (51, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 XL', '3628285618983170', '0', '3101777916bc68bdfb475f2696c5b6cb2b3af4c9d2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (52, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 L', '3628285618982914', '0', '3101777916ce72fba1c7b206ffb0fa8af68b29ab05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 205, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (53, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 M', '3628285618982658', '0', '31017779166e9fbce2f27e992431150d9275f40a6a', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (54, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 2XL', '3628285618982402', '0', '31017779165dc1cd470cf24a64b16969e95df1463e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 297, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (55, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 XL', '3628285618982146', '0', '3101777916b00c505b3b98340ff5a4e304a092e1c2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (56, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 L', '3628285618981890', '0', '310177791626375f3b2a885181df4702094a4a3b0d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (57, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 M', '3628285618981634', '0', '310177791659ab945c1c6ca33f7c196fc6709cea75', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 282, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (58, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 2XL', '3628285618981378', '0', '3101777916ebe6270b2c78e38b1cf29a32492ecc86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 75, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (59, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 XL', '3628285618981122', '0', '3101777916f59a865fab841f543226a33a4869ee4b', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 216, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (60, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 L', '3628285618980866', '0', '310177791681abc2c13110c48f7c4c7b5102682dbd', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 394, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (61, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 M', '3628285618980610', '0', '31017779166744717b6b93c7a114b94f9fa5a10dca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 516, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (62, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 2XL', '3628285618980354', '0', '3101777916ad329013903f6dfd621d572ea5632632', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (63, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 XL', '3628285618980098', '0', '3101777916cc70b9d5f165e5759b2f99916ac17df2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 611, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (64, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 L', '3628285618979842', '0', '31017779167bc60ee657252f1afaac1f8a02a23619', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 645, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (65, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 M', '3628285618979586', '0', '310177791684facce3f925095c4104c54f6a3b4997', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1133, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (66, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 2XL', '3628285618979330', '0', '3101777916e3869515c1f8b92c7340bfce88a300e7', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 878, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (67, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 XL', '3628285618979074', '0', '310177791627da0277c857de533bebb9e02cc645f4', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 419, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (68, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 L', '3628285618978818', '0', '3101777916a44f25eef859f272250b0194da4b0896', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 247, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (69, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 M', '3628285618978562', '0', '3101777916b0527c82042f8a0239fbf34c7d794ce5', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 606, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (70, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 2XL', '3628285618978306', '0', '31017779168b2f4e290780ac75a57fe05a8bbc9d86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1104, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (71, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 XL', '3628285618978050', '0', '3101777916549966d4600eeafd839208dbb8aca76c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (72, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 L', '3628285618977794', '0', '310177791634a634124ee41cfce853161a09bcb5e0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 900, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (73, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 M', '3628285618977538', '0', '310177791636651006f01928209e4b7f267d6d9811', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 2345, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (74, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 2XL', '3628285618977282', '0', '3101777916f9cf404ce55b9d7d38bf8204d923667e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 375, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (75, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 XL', '3628285618977026', '0', '31017779164c5e118ead1250341c882648ce32e0ee', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 557, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (76, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 L', '3628285618976770', '0', '3101777916fe938577e35eb370a2c7dd64eb4960ca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 847, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (77, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 M', '3628285618976514', '0', '310177791660b1f614dbe3f077d880c7befdfb2c71', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 627, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (78, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 2XL', '3628285618976258', '0', '3101777916805b45b6ceaf6fc4b62910113c24703c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 202, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (79, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 XL', '3628285618976002', '0', '3101777916617ec907472ad0affbe25ea595ab46ac', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 193, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (80, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 L', '3628285618975746', '0', '31017779164e74574230b02b815fdff4fe2931ada2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 204, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (81, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 M', '3628285618975490', '0', '31017779162c99dbfef3c7eba8c9227a24a65c7916', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 267, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (82, 1007, 400, '3794982173375856864', '【测试商品勿拍】测试国标3C充电宝大容量20000', 'tb_1688_833550355146_6DMZk54Zni', '20000mAh 标准版', '3628115019615490', '0', '3c认证版-紫色★标准版【智能数显★自带三线】20000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 7990, 630, 1, NULL, 1767177393, 1767177393, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (83, 1007, 400, '3794982173375856864', '【测试商品勿拍】测试国标3C充电宝大容量20000', 'tb_1688_833550355146_6DMZk54Zni', '10000mAh 标准版', '3628115019615234', '0', '3c认证版-紫色★标准版【智能数显★自带三线】10000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 5990, 604, 1, NULL, 1767177393, 1767177393, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (84, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 杯子+杯刷吸管刷4颗立体贴', '3628115096533506', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (85, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 500mL单杯', '3628115096533250', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (86, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 杯子+杯刷吸管刷4颗立体贴', '3628115096532994', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (87, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 500mL单杯', '3628115096532738', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (88, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 杯子+杯刷吸管刷4颗立体贴', '3628115096532482', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (89, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 500mL单杯', '3628115096532226', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (90, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 杯子+杯刷吸管刷4颗立体贴', '3628115096531970', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (91, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 500mL单杯', '3628115096531714', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (92, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 杯子+杯刷吸管刷4颗立体贴', '3628115096531458', '0', '前缀JXQ-139号毛绒儿童保温杯-红色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (93, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 500mL单杯', '3628115096531202', '0', '前缀JXQ-139号毛绒儿童保温杯-红色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (94, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 3XL', '3628301544437250', '0', '3794785772951962048-07-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8885, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (95, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 2XL', '3628301544436994', '0', '3794785772951962048-07-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8882, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (96, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 XL', '3628301544436738', '0', '3794785772951962048-07-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8886, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (97, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 L', '3628301544436482', '0', '3794785772951962048-07-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8884, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (98, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 M', '3628301544436226', '0', '3794785772951962048-07-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (99, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 3XL', '3628301544435970', '0', '3794785772951962048-05-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8838, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (100, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 2XL', '3628301544435714', '0', '3794785772951962048-05-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8831, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (101, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 XL', '3628301544435458', '0', '3794785772951962048-05-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8833, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (102, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 L', '3628301544435202', '0', '3794785772951962048-05-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8851, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (103, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 M', '3628301544434946', '0', '3794785772951962048-05-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8879, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (104, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 3XL', '3628301544434690', '0', '3794785772951962048-03-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8825, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (105, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 2XL', '3628301544434434', '0', '3794785772951962048-03-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8764, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (106, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 XL', '3628301544434178', '0', '3794785772951962048-03-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8787, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (107, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 L', '3628301544433922', '0', '3794785772951962048-03-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8829, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (108, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 M', '3628301544433666', '0', '3794785772951962048-03-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8854, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (109, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 3XL', '3628301544433410', '0', '3794785772951962048-01-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (110, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 2XL', '3628301544433154', '0', '3794785772951962048-01-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8864, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (111, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 XL', '3628301544432898', '0', '3794785772951962048-01-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8845, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (112, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 L', '3628301544432642', '0', '3794785772951962048-01-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8856, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (113, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 M', '3628301544432386', '0', '3794785772951962048-01-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8883, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (114, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 杯子+杯刷吸管刷4颗立体贴', '3628114613808386', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (115, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 500mL单杯', '3628114613808130', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (116, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 杯子+杯刷吸管刷4颗立体贴', '3628114613807874', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (117, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 500mL单杯', '3628114613807618', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (118, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 杯子+杯刷吸管刷4颗立体贴', '3628114613807362', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (119, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 500mL单杯', '3628114613807106', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (120, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 杯子+杯刷吸管刷4颗立体贴', '3628114613806850', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (121, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 500mL单杯', '3628114613806594', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (122, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 杯子+杯刷吸管刷4颗立体贴', '3628114613806338', '0', '前缀JXQ-139号毛绒儿童保温杯-红色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (123, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 500mL单杯', '3628114613806082', '0', '前缀JXQ-139号毛绒儿童保温杯-红色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (124, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 2XL', '3628250427086082', '0', '3101777916e7c95984525ac33a27588f2077cc1793', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 106, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (125, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 XL', '3628250427085826', '0', '3101777916ff773b20589386b71b093160f2278141', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 133, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (126, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 L', '3628250427085570', '0', '310177791641707615a062ba2af4e56fe5f739f3de', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 449, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (127, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 M', '3628250427085314', '0', '3101777916ef5287dcf85bcd35eac09ca181a7b1e6', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 464, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (128, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 2XL', '3628250427085058', '0', '31017779160aafdfee412d4e86f3baf5c2b875211f', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 251, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (129, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 XL', '3628250427084802', '0', '31017779160e0fabf19d19389323b96b26bd9a4568', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 196, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (130, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 L', '3628250427084546', '0', '31017779163b8cbfb5961ded1f3c6fcc3e8e5f37b0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 265, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (131, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 M', '3628250427084290', '0', '31017779164882fd1cc4cbb8bb15fe8d453498820d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 458, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (132, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 2XL', '3628250427084034', '0', '310177791696118a2a7d521ef75307b7f82d105db9', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 617, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (133, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 XL', '3628250427083778', '0', '310177791661d09a5c4734af472bdc3d34d9569166', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (134, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 L', '3628250427083522', '0', '31017779164af1259ef7a73891dc671d186125b1fe', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (135, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 M', '3628250427083266', '0', '3101777916d3163efeb6ff8ece2e90c256e5b62999', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1110, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (136, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 2XL', '3628250427083010', '0', '31017779168b7a4dae7733ababf5660f6dcd8b2515', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 312, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (137, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 XL', '3628250427082754', '0', '3101777916bc68bdfb475f2696c5b6cb2b3af4c9d2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (138, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 L', '3628250427082498', '0', '3101777916ce72fba1c7b206ffb0fa8af68b29ab05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 205, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (139, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 M', '3628250427082242', '0', '31017779166e9fbce2f27e992431150d9275f40a6a', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (140, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 2XL', '3628250427081986', '0', '31017779165dc1cd470cf24a64b16969e95df1463e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 297, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (141, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 XL', '3628250427081730', '0', '3101777916b00c505b3b98340ff5a4e304a092e1c2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (142, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 L', '3628250427081474', '0', '310177791626375f3b2a885181df4702094a4a3b0d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (143, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 M', '3628250427081218', '0', '310177791659ab945c1c6ca33f7c196fc6709cea75', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 282, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (144, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 2XL', '3628250427080962', '0', '3101777916ebe6270b2c78e38b1cf29a32492ecc86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 75, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (145, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 XL', '3628250427080706', '0', '3101777916f59a865fab841f543226a33a4869ee4b', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 216, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (146, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 L', '3628250427080450', '0', '310177791681abc2c13110c48f7c4c7b5102682dbd', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 394, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (147, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 M', '3628250427080194', '0', '31017779166744717b6b93c7a114b94f9fa5a10dca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 516, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (148, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 2XL', '3628250427079938', '0', '3101777916ad329013903f6dfd621d572ea5632632', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (149, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 XL', '3628250427079682', '0', '3101777916cc70b9d5f165e5759b2f99916ac17df2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 611, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (150, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 L', '3628250427079426', '0', '31017779167bc60ee657252f1afaac1f8a02a23619', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 645, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (151, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 M', '3628250427079170', '0', '310177791684facce3f925095c4104c54f6a3b4997', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1133, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (152, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 2XL', '3628250427078914', '0', '3101777916e3869515c1f8b92c7340bfce88a300e7', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 878, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (153, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 XL', '3628250427078658', '0', '310177791627da0277c857de533bebb9e02cc645f4', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 419, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (154, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 L', '3628250427078402', '0', '3101777916a44f25eef859f272250b0194da4b0896', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 247, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (155, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 M', '3628250427078146', '0', '3101777916b0527c82042f8a0239fbf34c7d794ce5', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 606, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (156, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 2XL', '3628250427077890', '0', '31017779168b2f4e290780ac75a57fe05a8bbc9d86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1104, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (157, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 XL', '3628250427077634', '0', '3101777916549966d4600eeafd839208dbb8aca76c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (158, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 L', '3628250427077378', '0', '310177791634a634124ee41cfce853161a09bcb5e0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 900, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (159, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 M', '3628250427077122', '0', '310177791636651006f01928209e4b7f267d6d9811', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 2345, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (160, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 2XL', '3628250427076866', '0', '3101777916f9cf404ce55b9d7d38bf8204d923667e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 375, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (161, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 XL', '3628250427076610', '0', '31017779164c5e118ead1250341c882648ce32e0ee', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 557, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (162, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 L', '3628250427076354', '0', '3101777916fe938577e35eb370a2c7dd64eb4960ca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 847, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (163, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 M', '3628250427076098', '0', '310177791660b1f614dbe3f077d880c7befdfb2c71', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 627, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (164, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 2XL', '3628250427075842', '0', '3101777916805b45b6ceaf6fc4b62910113c24703c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 202, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (165, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 XL', '3628250427075586', '0', '3101777916617ec907472ad0affbe25ea595ab46ac', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 193, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (166, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 L', '3628250427075330', '0', '31017779164e74574230b02b815fdff4fe2931ada2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 204, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (167, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 M', '3628250427075074', '0', '31017779162c99dbfef3c7eba8c9227a24a65c7916', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 267, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (168, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 3XL', '3628249384985858', '0', '3794785772951962048-07-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8885, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (169, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 2XL', '3628249384985602', '0', '3794785772951962048-07-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8882, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (170, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 XL', '3628249384985346', '0', '3794785772951962048-07-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8886, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (171, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 L', '3628249384985090', '0', '3794785772951962048-07-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8884, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (172, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 M', '3628249384984834', '0', '3794785772951962048-07-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (173, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 3XL', '3628249384984578', '0', '3794785772951962048-05-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8838, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (174, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 2XL', '3628249384984322', '0', '3794785772951962048-05-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8831, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (175, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 XL', '3628249384984066', '0', '3794785772951962048-05-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8833, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (176, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 L', '3628249384983810', '0', '3794785772951962048-05-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8851, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (177, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 M', '3628249384983554', '0', '3794785772951962048-05-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8879, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (178, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 3XL', '3628249384983298', '0', '3794785772951962048-03-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8825, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (179, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 2XL', '3628249384983042', '0', '3794785772951962048-03-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8764, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (180, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 XL', '3628249384982786', '0', '3794785772951962048-03-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8787, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (181, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 L', '3628249384982530', '0', '3794785772951962048-03-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8829, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (182, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 M', '3628249384982274', '0', '3794785772951962048-03-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8854, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (183, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 3XL', '3628249384982018', '0', '3794785772951962048-01-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (184, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 2XL', '3628249384981762', '0', '3794785772951962048-01-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8864, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (185, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 XL', '3628249384981506', '0', '3794785772951962048-01-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8845, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (186, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 L', '3628249384981250', '0', '3794785772951962048-01-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8856, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (187, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 M', '3628249384980994', '0', '3794785772951962048-01-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8883, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (188, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '黑色 可调节5458cm', '3628265555138818', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (189, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '灰色 可调节5458cm', '3628265555138562', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (190, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '咖啡色 可调节5458cm', '3628265555138306', '0', 'test~HamCXMNBLMeee_KFS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (191, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '杏色【1】 可调节5458cm', '3628265555138050', '0', 'test~HamCXMNBLMeee_XS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (192, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '摩卡色摩卡 可调节5458cm', '3628265555137794', '0', 'test~HamCXMNBLMeee_MKS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (193, 1007, 400, '3794971272623030594', '[测试商品勿拍X]秋冬新款加绒束脚运动裤女士腰头松紧斜插口袋宽', '', '白蛋白 S', '3628233317459458', '0', 'HCK04910310', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_759fa940a40b17c03bbb19fe4ca116d7_sx_116476_www800-800', 6700, 65, 1, NULL, 1767173140, 1767173140, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (194, 1007, 400, '3794971272623030594', '[测试商品勿拍X]秋冬新款加绒束脚运动裤女士腰头松紧斜插口袋宽', '', '干花色 S', '3628233317459202', '0', 'HCK04908710', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_759fa940a40b17c03bbb19fe4ca116d7_sx_116476_www800-800', 6700, 55, 1, NULL, 1767173140, 1767173140, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (195, 1007, 400, '3794971272623030594', '[测试商品勿拍X]秋冬新款加绒束脚运动裤女士腰头松紧斜插口袋宽', '', '黑色 S', '3628233317458946', '0', 'HCK04900110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_759fa940a40b17c03bbb19fe4ca116d7_sx_116476_www800-800', 6700, 0, 1, NULL, 1767173140, 1767173140, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (196, 1007, 400, '3794971923293798443', '【测试商品勿拍】国标3C充电宝大容量20000毫安', 'tb_1688_833550355146_A3J9En8lGP', '20000mAh 标准版', '3628233265400578', '0', '3c认证版-紫色★标准版【智能数显★自带三线】20000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 7990, 630, 1, NULL, 1767172765, 1767172765, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (197, 1007, 400, '3794971923293798443', '【测试商品勿拍】国标3C充电宝大容量20000毫安', 'tb_1688_833550355146_A3J9En8lGP', '10000mAh 标准版', '3628233265400322', '0', '3c认证版-紫色★标准版【智能数显★自带三线】10000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 5990, 604, 1, NULL, 1767172765, 1767172765, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (198, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 140cm', '3628265252734722', '0', 'Y232-SJT-JR140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8845, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (199, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 130cm', '3628265252734466', '0', 'Y232-SJT-JR130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8841, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (200, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 120cm', '3628265252734210', '0', 'Y232-SJT-JR120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8829, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (201, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 110cm', '3628265252733954', '0', 'Y232-SJT-JR110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8830, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (202, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 100cm', '3628265252733698', '0', 'Y232-SJT-JR100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8824, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (203, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 90cm', '3628265252733442', '0', 'Y232-SJT-JR90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8830, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (204, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 80cm', '3628265252733186', '0', 'Y232-SJT-JR80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8831, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (205, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 140cm', '3628265252732930', '0', 'Y232-QZ-JR140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8848, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (206, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 130cm', '3628265252732674', '0', 'Y232-QZ-JR130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8849, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (207, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 120cm', '3628265252732418', '0', 'Y232-QZ-JR120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8847, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (208, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 110cm', '3628265252732162', '0', 'Y232-QZ-JR110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8842, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (209, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 100cm', '3628265252731906', '0', 'Y232-QZ-JR100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8840, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (210, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 90cm', '3628265252731650', '0', 'Y232-QZ-JR90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8844, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (211, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 80cm', '3628265252731394', '0', 'Y232-QZ-JR80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8848, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (212, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 140cm', '3628265252731138', '0', 'Y232-SJT140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8802, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (213, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 130cm', '3628265252730882', '0', 'Y232-SJT130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8806, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (214, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 120cm', '3628265252730626', '0', 'Y232-SJT120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8787, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (215, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 110cm', '3628265252730370', '0', 'Y232-SJT110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8784, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (216, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 100cm', '3628265252730114', '0', 'Y232-SJT100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8791, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (217, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 90cm', '3628265252729858', '0', 'Y232-SJT90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8783, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (218, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 80cm', '3628265252729602', '0', 'Y232-SJT80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8788, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (219, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 140cm', '3628265252729346', '0', 'Y232-QZ140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8821, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (220, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 130cm', '3628265252729090', '0', 'Y232-QZ130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8807, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (221, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 120cm', '3628265252728834', '0', 'Y232-QZ120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8810, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (222, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 110cm', '3628265252728578', '0', 'Y232-QZ110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8812, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (223, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 100cm', '3628265252728322', '0', 'Y232-QZ100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8816, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (224, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 90cm', '3628265252728066', '0', 'Y232-QZ90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8820, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (225, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 80cm', '3628265252727810', '0', 'Y232-QZ80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8829, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (226, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 XL', '3628078572764674', '0', 'test~A#749026384071eee_KFS_XL', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (227, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 L', '3628078572764418', '0', 'test~A#749026384071eee_KFS_L', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (228, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 M', '3628078572764162', '0', 'test~A#749026384071eee_KFS_M', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (229, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 S', '3628078572763906', '0', 'test~A#749026384071eee_KFS_S', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (230, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '黑色 可调节5458cm', '3628198405998850', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (231, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '灰色 可调节5458cm', '3628198405998594', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (232, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '咖啡色 可调节5458cm', '3628198405998338', '0', 'test~HamCXMNBLMeee_KFS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (233, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '杏色【1】& 可调节5458cm', '3628198405998082', '0', 'test~HamCXMNBLMeee_XS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (234, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '摩卡色&摩卡 可调节5458cm', '3628198405997826', '0', 'test~HamCXMNBLMeee_MKS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (235, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 170', '3628113596534018', '0', 'AINI5228MIX170', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4970, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (236, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 160', '3628113596533762', '0', 'AINI5228MIX160', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4720, 40, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (237, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 150', '3628113596533506', '0', 'AINI5228MIX150', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4470, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (238, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 140', '3628113596533250', '0', 'AINI5228MIX140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4220, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (239, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 130', '3628113596532994', '0', 'AINI5228MIX130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4000, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (240, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 120', '3628113596532738', '0', 'AINI5228MIX120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3780, 30, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (241, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 110', '3628113596532482', '0', 'AINI5228MIX110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3560, 4, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (242, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 100', '3628113596532226', '0', 'AINI5228MIX100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3360, 16, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (243, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 90', '3628113596531970', '0', 'AINI5228MIX090', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3160, 5, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (244, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 170', '3628113596531714', '0', 'AINI5230AA170', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2280, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (245, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 160', '3628113596531458', '0', 'AINI5230AA160', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2180, 42, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (246, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 150', '3628113596531202', '0', 'AINI5230AA150', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2080, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (247, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 140', '3628113596530946', '0', 'AINI5230AA140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1980, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (248, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 130', '3628113596530690', '0', 'AINI5230AA130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1880, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (249, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 120', '3628113596530434', '0', 'AINI5230AA120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1780, 30, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (250, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 110', '3628113596530178', '0', 'AINI5230AA110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1680, 4, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (251, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 100', '3628113596529922', '0', 'AINI5230AA100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1580, 16, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (252, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 90', '3628113596529666', '0', 'AINI5230AA090', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1480, 5, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (253, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 170', '3628113596529410', '0', 'AINI5228AA170', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2690, 53, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (254, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 160', '3628113596529154', '0', 'AINI5228AA160', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2540, 40, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (255, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 150', '3628113596528898', '0', 'AINI5228AA150', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2390, 14, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (256, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 140', '3628113596528642', '0', 'AINI5228AA140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2240, 24, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (257, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 130', '3628113596528386', '0', 'AINI5228AA130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2120, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (258, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 120', '3628113596528130', '0', 'AINI5228AA120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2000, 97, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (259, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 110', '3628113596527874', '0', 'AINI5228AA110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1880, 124, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (260, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 100', '3628113596527618', '0', 'AINI5228AA100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1780, 161, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (261, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 90', '3628113596527362', '0', 'AINI5228AA090', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1680, 72, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (262, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '黑色 均码', '3628149916230146', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 662, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (263, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '米白 均码', '3628149916229890', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 664, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (264, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '灰色 均码', '3628149916229634', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 662, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (265, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '浅蓝 均码', '3628149916229378', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 655, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (266, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '黑色 可调节5458cm', '3628059051505922', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (267, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '灰色 可调节5458cm', '3628059051505666', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (268, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '咖啡色 可调节5458cm', '3628059051505410', '0', 'test~HamCXMNBLMeee_KFS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (269, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '杏色【1】 可调节5458cm', '3628059051505154', '0', 'test~HamCXMNBLMeee_XS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (270, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '摩卡色&摩卡 可调节5458cm', '3628059051504898', '0', 'test~HamCXMNBLMeee_MKS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (271, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 110cm-XXL', '3628041733334018', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 7310, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (272, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 100cm-XL', '3628041733333762', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 7712, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (273, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 90cm-L', '3628041733333506', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 7745, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (274, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 80cm-M', '3628041733333250', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 8161, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (275, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 110cm-XXL', '3628041733332994', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 6256, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (276, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 100cm-XL', '3628041733332738', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 3625, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (277, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 90cm-L', '3628041733332482', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 3125, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (278, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 80cm-M', '3628041733332226', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1730, 4365, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (279, 1007, 400, '3794964428567478515', 'test勿拍@美式复古v领套头毛衣秋冬！', '', '卡其色 均码', '3628130474780418', '0', '3794786271252054177-03-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5854d11ed633c4ef0f66c771f6213afb_sx_405366_www800-800', 3600, 10000, 1, NULL, 1767169679, 1767169679, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (280, 1007, 400, '3794964428567478515', 'test勿拍@美式复古v领套头毛衣秋冬！', '', '杏色 均码', '3628130474780162', '0', '3794786271252054177-01-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5854d11ed633c4ef0f66c771f6213afb_sx_405366_www800-800', 3600, 10000, 1, NULL, 1767169679, 1767169679, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (281, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 5XL', '3628283609447170', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (282, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 4XL', '3628283609446914', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8887, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (283, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 3XL', '3628283609446658', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8885, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (284, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 2XL', '3628283609446402', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8882, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (285, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 XL', '3628283609446146', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (286, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 L', '3628283609445890', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8884, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (287, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 M', '3628283609445634', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8877, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (288, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 5XL', '3628283609445378', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8872, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (289, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 4XL', '3628283609445122', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8857, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (290, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 3XL', '3628283609444866', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8838, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (291, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 2XL', '3628283609444610', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8831, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (292, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 XL', '3628283609444354', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8833, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (293, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 L', '3628283609444098', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8851, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (294, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 M', '3628283609443842', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8879, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (295, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 5XL', '3628283609443586', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8862, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (296, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 4XL', '3628283609443330', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8844, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (297, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 3XL', '3628283609443074', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8825, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (298, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 2XL', '3628283609442818', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8764, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (299, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 XL', '3628283609442562', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8785, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (300, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 L', '3628283609442306', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8828, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (301, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 M', '3628283609442050', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8854, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (302, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 5XL', '3628283609441794', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (303, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 4XL', '3628283609441538', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8882, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (304, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 3XL', '3628283609441282', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8877, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (305, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 2XL', '3628283609441026', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8863, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (306, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 XL', '3628283609440770', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8844, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (307, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 L', '3628283609440514', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8856, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (308, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 M', '3628283609440258', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (309, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 5XL', '3628112641875714', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (310, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 4XL', '3628112641875458', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8887, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (311, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 3XL', '3628112641875202', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8885, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (312, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 2XL', '3628112641874946', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8882, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (313, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 XL', '3628112641874690', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (314, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 L', '3628112641874434', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8884, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (315, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 M', '3628112641874178', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8877, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (316, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 5XL', '3628112641873922', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8872, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (317, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 4XL', '3628112641873666', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8859, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (318, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 3XL', '3628112641873410', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8839, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (319, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 2XL', '3628112641873154', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8831, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (320, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 XL', '3628112641872898', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8833, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (321, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 L', '3628112641872642', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8852, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (322, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 M', '3628112641872386', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8879, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (323, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 5XL', '3628112641872130', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8865, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (324, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 4XL', '3628112641871874', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8845, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (325, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 3XL', '3628112641871618', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8826, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (326, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 2XL', '3628112641871362', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8764, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (327, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 XL', '3628112641871106', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8793, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (328, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 L', '3628112641870850', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8832, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (329, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 M', '3628112641870594', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8855, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (330, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 5XL', '3628112641870338', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (331, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 4XL', '3628112641870082', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8882, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (332, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 3XL', '3628112641869826', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8877, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (333, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 2XL', '3628112641869570', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8864, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (334, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 XL', '3628112641869314', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8847, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:02', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (335, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 L', '3628112641869058', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8859, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:02', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (336, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 M', '3628112641868802', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:02', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1224, 1012, 500, '10000239789987', '牧马人K100机械键盘黑色经典电竞游戏办公有线背光键鼠套装网吧', '', '', '3531937224', '', '', '', 19900, 100, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:24', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1225, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 18W白光', '3531475359', '', '', '', 3990, 9, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:24', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1226, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 24W白光', '3531318781', '', '', '', 4990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1227, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 36W白光', '3531485362', '', '', '', 5990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1228, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 48W白光', '3531313894', '', '', '', 6990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1229, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 72W白光', '3531430948', '', '', '', 7990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);

-- ----------------------------
-- Table structure for oms_tao_order
-- ----------------------------
DROP TABLE IF EXISTS `oms_tao_order`;
CREATE TABLE `oms_tao_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `shop_id` int NOT NULL DEFAULT 0 COMMENT '店铺id',
  `tid` bigint NOT NULL COMMENT '交易编号 (父订单的交易编号)',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易标题，以店铺名作为此标题的值。',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易类型列表，同时查询多种交易类型可用逗号分隔。',
  `seller_flag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家备注旗帜（与淘宝网上订单的卖家备注旗帜对应，只有卖家才能查看该字段）红、黄、绿、蓝、紫 分别对应 1、2、3、4、5',
  `has_buyer_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '判断订单是否有买家留言，有买家留言返回true，否则返回false',
  `credit_card_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '使用信用卡支付金额数',
  `step_trade_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分阶段付款的订单状态（例如万人团订单等），目前有三返回状态FRONT_NOPAID_FINAL_NOPAID(定金未付尾款未付)，FRONT_PAID_FINAL_NOPAID(定金已付尾款未付)，FRONT_PAID_FINAL_PAID(定金和尾款都付)',
  `step_paid_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分阶段付款的已付金额（万人团订单已付金额）',
  `buyer_open_uid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家OpenUid',
  `mark_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单出现异常问题的时候，给予用户的描述,没有异常的时候，此值为空',
  `buyer_nick` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '买家昵称',
  `num_iid` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品数字编号',
  `num` int NULL DEFAULT NULL COMMENT '商品购买数量。取值范围：大于零的整数,对于一个trade对应多个order的时候（一笔主订单，对应多笔子订单），num=0，num是一个跟商品关联的属性，一笔订单对应多比子订单的时候，主订单上的num无意义。',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品价格。精确到2位小数；单位：元。如：200.07，表示：200元7分',
  `total_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品金额（商品价格乘以数量的总金额）。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `adjust_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '卖家手工调整金额，精确到2位小数，单位：元。如：200.07',
  `post_fee` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT '邮费',
  `discount_fee` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠金额',
  `payment` decimal(10, 2) NOT NULL COMMENT '实付金额',
  `received_payment` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '卖家实际收到的支付宝打款金额（由于子订单可以部分确认收货，这个金额会随着子订单的确认收货而不断增加，交易成功后等于买家实付款减去退款金额）。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `available_confirm_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '交易中剩余的确认收货金额（这个金额会随着子订单确认收货而不断减少，交易成功后会变为零）。精确到2位小数;单位:元。如:200.07，表示:200 元7分',
  `cod_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '货到付款服务费。',
  `cod_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '货到付款物流状态。初始状态 NEW_CREATED,接单成功 ACCEPTED_BY_COMPANY,接单失败 REJECTED_BY_COMPANY,接单超时 RECIEVE_TIMEOUT,揽收成功 TAKEN_IN_SUCCESS,揽收失败 TAKEN_IN_FAILED,揽收超时 TAKEN_TIMEOUT,签收成功 SIGN_IN,签收失败 REJECTED_BY_OTHER_SIDE,订单等待发送给物流公司 WAITING_TO_BE_SENT,用户取消物流订单 CANCELED',
  `buyer_cod_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家货到付款服务费',
  `seller_cod_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家货到付款服务费',
  `express_agency_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递代收款。',
  `commission_fee` float NULL DEFAULT NULL COMMENT '交易佣金。',
  `shipping_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建交易时的物流方式（交易完成前，物流方式有可能改变，但系统里的这个字段一直不变）。可选值：free(卖家包邮),post(平邮),express(快递),ems(EMS),virtual(虚拟发货)，25(次日必达)，26(预约配送)。',
  `created` datetime NOT NULL COMMENT '交易创建时间。格式:yyyy-MM-dd HH:mm:ss',
  `modified` datetime NULL DEFAULT NULL COMMENT '交易修改时间(用户对订单的任何修改都会更新此字段)。格式:yyyy-MM-dd HH:mm:ss',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '付款时间。格式:yyyy-MM-dd HH:mm:ss。订单的付款时间即为物流订单的创建时间。',
  `consign_time` datetime NULL DEFAULT NULL COMMENT '卖家发货时间。格式:yyyy-MM-dd HH:mm:ss',
  `end_time` datetime NULL DEFAULT NULL COMMENT '交易结束时间。交易成功时间(更新交易状态为成功的同时更新)/确认收货时间或者交易关闭时间 。格式:yyyy-MM-dd HH:mm:ss',
  `seller_memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家备忘信息',
  `buyer_memo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家备注',
  `buyer_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '买家留言',
  `point_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家使用积分,下单时生成，且一直不变。格式:100;单位:个.',
  `real_point_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家实际使用积分（扣除部分退款使用的积分），交易完成后生成（交易成功或关闭），交易未完成时该字段值为0。格式:100;单位:个',
  `buyer_obtain_point_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家获得积分,返点的积分。格式:100;单位:个。返点的积分要交易成功之后才能获得。',
  `receiving_time` datetime NULL DEFAULT NULL COMMENT '收货时间，这里返回的是完全收货时间',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '交易状态。可选值: * TRADE_NO_CREATE_PAY(没有创建支付宝交易) * WAIT_BUYER_PAY(等待买家付款) * SELLER_CONSIGNED_PART(卖家部分发货) * WAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款) * WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货) * TRADE_BUYER_SIGNED(买家已签收,货到付款专用) * TRADE_FINISHED(交易成功) * TRADE_CLOSED(付款以后用户退款成功，交易自动关闭) * TRADE_CLOSED_BY_TAOBAO(付款以前，卖家或买家主动关闭交易) * PAY_PENDING(国际信用卡支付付款确认中) * WAIT_PRE_AUTH_CONFIRM(0元购合约中) * PAID_FORBID_CONSIGN(拼团中订单或者发货强管控的订单，已付款但禁止发货)',
  `trade_memo` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易备注。',
  `erp_send_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'erp发货快递公司',
  `erp_send_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'erp发货快递单号',
  `erp_send_status` int NULL DEFAULT 0 COMMENT 'erp发货状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '数据库创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '数据库更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据库更新人',
  `oaid` varchar(2552) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '（收货人+手机号+座机+收货地址+create）5个字段组合成oaid，原始订单上座机为空也满足条件，否则生成不了oaid',
  `aid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址aid字段',
  `receiver_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人国籍',
  `receiver_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的所在省份',
  `receiver_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的所在城市',
  `receiver_district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的所在地区',
  `receiver_town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人街道地址',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的详细地址',
  `receiver_zip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的邮编',
  `receiver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的姓名',
  `receiver_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的手机号码',
  `receiver_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人的电话号码',
  `seller_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家是否已评价。可选值:true(已评价),false(未评价)',
  `seller_nick` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家昵称',
  `buyer_rate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '买家是否已评价。可选值:true(已评价),false(未评价)。如买家只评价未打分，此字段仍返回false',
  `buyer_area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家下单的地区',
  `alipay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付宝交易号，如：2009112081173831',
  `buyer_alipay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家支付宝账号',
  `buyer_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家邮件地址',
  `seller_alipay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家支付宝账号',
  `has_post_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否包含邮费。与available_confirm_fee同时使用。可选值:true(包含),false(不包含)',
  `timeout_action_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超时到期时间。格式:yyyy-MM-dd HH:mm:ss。业务规则：前提条件：只有在买家已付款，卖家已发货的情况下才有效如果申请了退款，那么超时会落在子订单上；比如说3笔ABC，A申请了，那么返回的是BC的列表, 主定单不存在如果没有申请过退款，那么超时会挂在主定单上；比如ABC，返回主定单，ABC的超时和主定单相同',
  `snapshot_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易快照地址',
  `promotion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易促销详细信息',
  `yfx_fee` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单的运费险，单位为元',
  `has_yfx` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单中是否包含运费险订单，如果包含运费险订单返回true，不包含运费险订单，返回false',
  `send_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单将在此时间前发出，主要用于预售订单',
  `is_part_consign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否是多次发货的订单如果卖家对订单进行多次发货，则为true否则为false',
  `sid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流运单号',
  `tmall_coupon_fee` bigint NULL DEFAULT NULL COMMENT '天猫商家使用，订单使用的红包信息',
  `audit_status` int NOT NULL DEFAULT 0 COMMENT '0待确认，1已确认2已拦截-9未拉取',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_tid`(`tid` ASC) USING BTREE,
  INDEX `shop_id_index`(`shop_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '淘宝订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_tao_order
-- ----------------------------

-- ----------------------------
-- Table structure for oms_tao_order_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_tao_order_item`;
CREATE TABLE `oms_tao_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tid` bigint NOT NULL COMMENT '订单id',
  `oid` bigint NOT NULL COMMENT '子订单编号',
  `total_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '应付金额（商品价格 * 商品数量 + 手工调整金额 - 子订单级订单优惠金额）。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `discount_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '子订单级订单优惠金额。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `adjust_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '手工调整金额.格式为:1.01;单位:元;精确到小数点后两位.',
  `divide_order_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '分摊之后的实付金额',
  `part_mjz_discount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠分摊',
  `payment` decimal(10, 2) NULL DEFAULT NULL COMMENT '子订单实付金额。精确到2位小数，单位:元。如:200.07，表示:200元7分。对于多子订单的交易，计算公式如下：payment = price * num + adjust_fee - discount_fee ；单子订单交易，payment与主订单的payment一致，对于退款成功的子订单，由于主订单的优惠分摊金额，会造成该字段可能不为0.00元。建议使用退款前的实付金额减去退款单中的实际退款金额计算。',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `pic_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品主图',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `num_iid` bigint NULL DEFAULT NULL COMMENT '商品数字ID',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品的最小库存单位Sku的id.可以通过taobao.item.sku.get获取详细的Sku信息天猫的SKUID',
  `outer_iid` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家外部编码(可与商家外部系统对接)。',
  `outer_sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部网店自己定义的Sku编号',
  `sku_properties_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'SKU的值。如：机身颜色:黑色;手机套餐:官方标配',
  `item_meal_id` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '套餐ID',
  `item_meal_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '套餐的值。如：M8原装电池:便携支架:M8专用座充:莫凡保护袋',
  `num` int NULL DEFAULT NULL COMMENT '数量',
  `timeout_action_time` datetime NULL DEFAULT NULL COMMENT '订单超时到期时间。格式:yyyy-MM-dd HH:mm:ss',
  `item_memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品备注',
  `buyer_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家是否已评价。可选值：true(已评价)，false(未评价)',
  `seller_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家是否已评价。可选值：true(已评价)，false(未评价)',
  `seller_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家类型，可选值为：B（商城商家），C（普通卖家）',
  `cid` bigint NULL DEFAULT NULL COMMENT '交易商品对应的类目ID',
  `is_oversold` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '	是否超卖',
  `end_time` datetime NULL DEFAULT NULL COMMENT '子订单的交易结束时间说明：子订单有单独的结束时间，与主订单的结束时间可能有所不同，在有退款发起的时候或者是主订单分阶段付款的时候，子订单的结束时间会早于主订单的结束时间，所以开放这个字段便于订单结束状态的判断',
  `order_from` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单来源,如jhs(聚划算)、taobao(淘宝)、wap(无线)',
  `is_service_order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否是服务订单，是返回true，否返回false。',
  `consign_time` datetime NULL DEFAULT NULL COMMENT '子订单发货时间，当卖家对订单进行了多次发货，子订单的发货时间和主订单的发货时间可能不一样了，那么就需要以子订单的时间为准。（没有进行多次发货的订单，主订单的发货时间和子订单的发货时间都一样）',
  `shipping_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单的运送方式（卖家对订单进行多次发货之后，一个主订单下的子订单的运送方式可能不同，用order.shipping_type来区分子订单的运送方式）',
  `logistics_company` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单发货的快递公司名称',
  `invoice_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单所在包裹的运单号',
  `bind_oid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '捆绑的子订单号，表示该子订单要和捆绑的子订单一起发货，用于卖家子订单捆绑发货',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单状态（请关注此状态，如果为TRADE_CLOSED_BY_TAOBAO状态，则不要对此订单进行发货，切记啊！）。可选值:\r\nTRADE_NO_CREATE_PAY(没有创建支付宝交易)\r\nWAIT_BUYER_PAY(等待买家付款)\r\nWAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款)\r\nWAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货)\r\nTRADE_BUYER_SIGNED(买家已签收,货到付款专用)\r\nTRADE_FINISHED(交易成功)\r\nTRADE_CLOSED(付款以后用户退款成功，交易自动关闭)\r\nTRADE_CLOSED_BY_TAOBAO(付款以前，卖家或买家主动关闭交易)\r\nPAY_PENDING(国际信用卡支付付款确认中)',
  `refund_status` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'NO_REFUND' COMMENT '退款状态。退款状态。可选值 WAIT_SELLER_AGREE(买家已经申请退款，等待卖家同意) WAIT_BUYER_RETURN_GOODS(卖家已经同意退款，等待买家退货) WAIT_SELLER_CONFIRM_GOODS(买家已经退货，等待卖家确认收货) SELLER_REFUSE_BUYER(卖家拒绝退款) CLOSED(退款关闭) SUCCESS(退款成功)',
  `refund_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '最近退款ID',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid_index`(`tid` ASC) USING BTREE,
  INDEX `oid_index`(`oid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '淘宝订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_tao_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for oms_tao_order_promotion
-- ----------------------------
DROP TABLE IF EXISTS `oms_tao_order_promotion`;
CREATE TABLE `oms_tao_order_promotion`  (
  `id` bigint NOT NULL COMMENT '交易的主订单或子订单号',
  `promotion_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优惠信息的名称',
  `discount_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优惠金额（免运费、限时打折时为空）,单位：元',
  `gift_item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '满就送商品时，所送商品的名称',
  `gift_item_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赠品的宝贝id',
  `gift_item_num` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '满就送礼物的礼物数量',
  `promotion_desc` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优惠活动的描述',
  `promotion_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优惠id，(由营销工具id、优惠活动id和优惠详情id组成，结构为：营销工具id-优惠活动id_优惠详情id，如mjs-123024_211143）',
  `kd_discount_fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分摊优惠金额（免运费、限时打折时为空）,单位：元',
  `kd_child_discount_fee` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '若优惠项在主订单上，返回子订单的分摊信息'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '淘宝订单优惠明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_tao_order_promotion
-- ----------------------------

-- ----------------------------
-- Table structure for oms_tao_refund
-- ----------------------------
DROP TABLE IF EXISTS `oms_tao_refund`;
CREATE TABLE `oms_tao_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `refund_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款id',
  `dispute_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款类型，可选值REFUND(仅退款),REFUND_AND_RETURN(退货退款),TMALL_EXCHANGE(天猫换货),TAOBAO_EXCHANGE(淘宝换货),REPAIR(维修),RESHIPPING(补寄),OTHERS(其他)',
  `shop_id` int NOT NULL COMMENT '店铺id',
  `tid` bigint NULL DEFAULT NULL COMMENT '淘宝交易单号（订单号）',
  `oid` bigint NULL DEFAULT NULL COMMENT '子订单号。如果是单笔交易oid会等于tid',
  `payment` float NULL DEFAULT NULL COMMENT '支付给卖家的金额(交易总金额-退还给买家的金额)。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `price` float NULL DEFAULT NULL COMMENT '商品价格。',
  `total_fee` float NULL DEFAULT NULL COMMENT '交易总金额。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `refund_fee` float NULL DEFAULT NULL COMMENT '退还金额(退还给买家的金额)。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `split_seller_fee` float NULL DEFAULT NULL COMMENT '	分账给卖家的钱',
  `split_taobao_fee` float NULL DEFAULT NULL COMMENT '分账给淘宝的钱',
  `created` datetime NULL DEFAULT NULL COMMENT '退款申请时间。格式:yyyy-MM-dd HH:mm:ss',
  `modified` datetime NULL DEFAULT NULL COMMENT '更新时间。格式:yyyy-MM-dd HH:mm:ss',
  `seller_nick` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家昵称',
  `cs_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '不需客服介入1;需要客服介入2;客服已经介入3;客服初审完成4;客服主管复审失败5;客服处理完成6;系统撤销(B2B使用)，维权撤销(集市使用) 7;支持买家 8;支持卖家 9;举证中 10;开放申诉 11;',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款状态。可选值WAIT_SELLER_AGREE(买家已经申请退款，等待卖家同意) WAIT_BUYER_RETURN_GOODS(卖家已经同意退款，等待买家退货) WAIT_SELLER_CONFIRM_GOODS(买家已经退货，等待卖家确认收货) SELLER_REFUSE_BUYER(卖家拒绝退款) CLOSED(退款关闭) SUCCESS(退款成功)',
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款对应的订单交易状态。可选值TRADE_NO_CREATE_PAY(没有创建支付宝交易) WAIT_BUYER_PAY(等待买家付款) WAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款) WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货) TRADE_BUYER_SIGNED(买家已签收,货到付款专用) TRADE_FINISHED(交易成功) TRADE_CLOSED(交易关闭) TRADE_CLOSED_BY_TAOBAO(交易被淘宝关闭) ALL_WAIT_PAY(包含：WAIT_BUYER_PAY、TRADE_NO_CREATE_PAY) ALL_CLOSED(包含：TRADE_CLOSED、TRADE_CLOSED_BY_TAOBAO) 取自\"http://open.taobao.com/dev/index.php/%E4%BA%A4%E6%98%93%E7%8A%B6%E6%80%81\"',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家收货地址',
  `advance_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款先行垫付默认的未申请状态 0;退款先行垫付申请中 1;退款先行垫付，垫付完成 2;退款先行垫付，卖家拒绝收货 3;退款先行垫付，垫付关闭 4;退款先行垫付，垫付分账成功 5;',
  `alipay_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付宝交易号',
  `good_return_time` datetime NULL DEFAULT NULL COMMENT '退货时间。格式:yyyy-MM-dd HH:mm:ss',
  `good_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '货物状态。可选值BUYER_NOT_RECEIVED (买家未收到货) BUYER_RECEIVED (买家已收到货) BUYER_RETURNED_GOODS (买家已退货)',
  `has_good_return` int NULL DEFAULT NULL COMMENT '买家是否需要退货。可选值:true(是),false(否)',
  `num_iid` bigint NULL DEFAULT NULL COMMENT '申请退款的商品数字编号',
  `num` bigint NOT NULL DEFAULT 0 COMMENT '退货数量',
  `outer_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品外部商家编码',
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因',
  `refund_phase` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款阶段，可选值：onsale/aftersale',
  `shipping_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流方式.可选值:free(卖家包邮),post(平邮),express(快递),ems(EMS).',
  `desc1` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款说明',
  `company_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `sid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货运单号',
  `send_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家发货时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '	完结时间。格式:yyyy-MM-dd HH:mm:ss',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `sku` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品SKU信息',
  `buyer_open_uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家openUid',
  `buyer_nick` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家昵称',
  `combine_item_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组合品信息\r\nnum_iid	String	2342344	商品数字编号\r\nitem_name	String	测试商品	商品标题\r\nquantity	Number	123	数量\r\nsku_id	String	123	sku_id\r\nouter_iid	String	123	商家外部编码(可与商家外部系统对接)\r\nouter_sku_id	String	123	123',
  `create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '平台skuId',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `refund_id_index`(`refund_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '淘宝退款表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_tao_refund
-- ----------------------------

-- ----------------------------
-- Table structure for oms_tao_waybill_account
-- ----------------------------
DROP TABLE IF EXISTS `oms_tao_waybill_account`;
CREATE TABLE `oms_tao_waybill_account`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `seller_id` bigint NULL DEFAULT NULL COMMENT '商家ID',
  `cp_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流服务商编码',
  `cp_type` int NULL DEFAULT NULL COMMENT '1是直营，2是加盟',
  `quantity` int NULL DEFAULT NULL COMMENT '可用单数',
  `allocated_quantity` int NULL DEFAULT NULL COMMENT '已用单数',
  `branch_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网点ID',
  `branch_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网点名称',
  `print_quantity` int NULL DEFAULT NULL COMMENT '已经打印的面单总数',
  `cancel_quantity` int NULL DEFAULT NULL COMMENT '取消的面对总数',
  `waybill_address_id` bigint NULL DEFAULT NULL COMMENT 'waybill 地址记录ID(非地址库ID)',
  `province` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省名称（一级地址）',
  `city` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市名称（二级地址）',
  `area` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区名称（三级地址）',
  `address_detail` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货人',
  `mobile` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货手机号',
  `phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货固定电话',
  `is_show` int NULL DEFAULT NULL COMMENT '是否前台显示1显示0不显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '淘宝电子面单账户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_tao_waybill_account
-- ----------------------------

-- ----------------------------
-- Table structure for oms_wei_order
-- ----------------------------
DROP TABLE IF EXISTS `oms_wei_order`;
CREATE TABLE `oms_wei_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `openid` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家身份标识',
  `create_time` int NULL DEFAULT NULL COMMENT '秒级时间戳',
  `update_time` int NULL DEFAULT NULL COMMENT '秒级时间戳',
  `unionid` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL COMMENT '状态10	待付款；20	待发货；21	部分发货；30	待收货；100	完成；200	全部商品售后之后，订单取消；250	未付款用户主动取消或超时未付款订单自动取消；',
  `aftersale_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '售后信息json',
  `pay_info` varchar(5500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付信息json',
  `product_price` int NULL DEFAULT NULL COMMENT '商品总价，单位为分',
  `order_price` int NULL DEFAULT NULL COMMENT '订单金额，单位为分，order_price=original_order_price-discounted_price-deduction_price-change_down_price',
  `freight` int NULL DEFAULT NULL COMMENT '运费，单位为分',
  `discounted_price` int NULL DEFAULT NULL COMMENT '优惠券优惠金额，单位为分',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `province_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `county_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `detail_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `tel_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系方式\r\n',
  `house_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '门牌号码',
  `virtual_order_tel_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '虚拟发货订单联系方式(deliver_method=1时返回)',
  `tel_number_ext_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '额外的联系方式信息（虚拟号码相关）',
  `use_tel_number` int NULL DEFAULT NULL COMMENT '0：不使用虚拟号码，1：使用虚拟号码',
  `hash_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标识当前店铺下一个唯一的用户收货地址',
  `delivery_product_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发货物流信息JSON',
  `ship_done_time` int NULL DEFAULT NULL COMMENT '发货完成时间，秒级时间戳',
  `ewaybill_order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子面单代发时的订单密文\r\n',
  `settle_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算信息json',
  `audit_status` int NOT NULL DEFAULT 0 COMMENT '订单审核状态（0待审核1已审核）',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '订单审核时间',
  `erp_send_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'erp发货快递公司',
  `erp_send_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'erp发货快递单号',
  `erp_send_status` int NULL DEFAULT 0 COMMENT 'erp发货状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_index`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_wei_order
-- ----------------------------
INSERT INTO `oms_wei_order` VALUES (35, 1012, '3731295703781745408', 'oVlvg5OITOvZQ2PVmvycrr_1qXa4', 1759373714, 1759373715, NULL, 10, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"prepay_id\":\"up_wx02105515357564b31a3d3867c503a60000\",\"prepay_time\":1759373715}', 3990, 3990, 0, NULL, '齐**', '000000', '广东省', '深圳市', '宝安区', '****', '158****0119', '', '', 'null', 0, '5f2f993769c055852bb3da1592ac10d2', '[]', 0, 'ofv3mn_OLHd9owLe00A_kqPtHu5BTNqqde3E7esIWixRtwHJB-tuKIU7UGgnDMpWMnCdAE2lFRjA', '{\"predict_commission_fee\":199}', 1, '2025-10-06 10:31:11', NULL, NULL, 0);

-- ----------------------------
-- Table structure for oms_wei_order_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_wei_order_item`;
CREATE TABLE `oms_wei_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单id（平台订单id）',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品skuid\r\n',
  `thumb_img` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku小图',
  `sku_cnt` int NULL DEFAULT NULL COMMENT 'sku数量',
  `sale_price` int NULL DEFAULT NULL COMMENT '售卖单价（单位：分）',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `on_aftersale_sku_cnt` int NULL DEFAULT NULL COMMENT '正在售后/退款流程中的 sku 数量',
  `finish_aftersale_sku_cnt` int NULL DEFAULT NULL COMMENT '完成售后/退款的 sku 数量',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `market_price` int NULL DEFAULT NULL COMMENT '市场单价（单位：分）',
  `sku_attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku属性JSON',
  `real_price` int NULL DEFAULT NULL COMMENT 'sku实付总价，取estimate_price和change_price中较小值',
  `out_product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品外部spuid',
  `out_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品外部skuid',
  `is_discounted` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否有优惠金额，非必填，默认为false',
  `estimate_price` int NULL DEFAULT NULL COMMENT '优惠后sku总价，非必填，is_discounted为true时有值',
  `is_change_price` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否修改过价格，非必填，默认为false',
  `change_price` int NULL DEFAULT NULL COMMENT '改价后sku总价，非必填，is_change_price为true时有值',
  `out_warehouse_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区域库存id',
  `sku_deliver_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品发货信息JSON',
  `extra_service` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品额外服务信息JSON',
  `use_deduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否使用了会员积分抵扣\r\n',
  `deduction_price` int NULL DEFAULT NULL COMMENT '会员积分抵扣金额，单位为分',
  `order_product_coupon_info_list` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品优惠券信息，逐步替换 order.order_detail.coupon_info',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_wei_order_item
-- ----------------------------
INSERT INTO `oms_wei_order_item` VALUES (34, 1012, '3731295703781745408', '10000239803737', '3531475359', 'https://wst.wxapp.tc.qq.com/161/20304/snscosdownload/SZ/reserved/6839f1ff00015fba288ae5867af20115000000a000004f50', 1, 3990, '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', 0, 0, '', 3990, '[{\"attr_key\":\"规格\",\"attr_value\":\"18W白光\"}]', 3990, NULL, NULL, 'null', 3990, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":0}', 'null', NULL, '[]', NULL, NULL);

-- ----------------------------
-- Table structure for oms_wei_refund
-- ----------------------------
DROP TABLE IF EXISTS `oms_wei_refund`;
CREATE TABLE `oms_wei_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `after_sale_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后单号',
  `after_sales_status` int NULL DEFAULT NULL COMMENT '售后状态（参考拼多多）',
  `after_sales_type` int NULL DEFAULT NULL COMMENT '售后类型（参考拼多多）',
  `status` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后单当前状态，参考：\r\nUSER_CANCELD	用户取消申请\r\nMERCHANT_PROCESSING	商家受理中\r\nMERCHANT_REJECT_REFUND	商家拒绝退款\r\nMERCHANT_REJECT_RETURN	商家拒绝退货退款\r\nUSER_WAIT_RETURN	待买家退货\r\nRETURN_CLOSED	退货退款关闭\r\nMERCHANT_WAIT_RECEIPT	待商家收货\r\nMERCHANT_OVERDUE_REFUND	商家逾期未退款\r\nMERCHANT_REFUND_SUCCESS	退款完成\r\nMERCHANT_RETURN_SUCCESS	退货退款完成\r\nPLATFORM_REFUNDING	平台退款中\r\nPLATFORM_REFUND_FAIL	平台退款失败\r\nUSER_WAIT_CONFIRM	待用户确认\r\nMERCHANT_REFUND_RETRY_FAIL	商家打款失败，客服关闭售后\r\nMERCHANT_FAIL	售后关闭\r\nUSER_WAIT_CONFIRM_UPDATE	待用户处理商家协商\r\nUSER_WAIT_HANDLE_MERCHANT_AFTER_SALE	待用户处理商家代发起的售后申请',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家身份标识',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家在开放平台的唯一标识符，若当前视频号小店已绑定到微信开放平台账号下会返回',
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品skuid',
  `count` int NULL DEFAULT NULL COMMENT '售后数量',
  `fast_refund` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否极速退款RefundInfo',
  `refund_reason` int NULL DEFAULT NULL COMMENT '标明售后单退款直接原因, 枚举值参考 RefundReason',
  `refund_amount` int NULL DEFAULT NULL COMMENT '退款金额（分）',
  `return_waybill_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递单号',
  `return_delivery_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司id',
  `return_delivery_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `merchant_upload_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '售后相关商品信息JSON',
  `create_time` int NULL DEFAULT NULL COMMENT '售后单创建时间戳',
  `update_time` int NULL DEFAULT NULL COMMENT '售后单更新时间戳',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因',
  `reason_text` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因解释',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后类型。REFUND:退款；RETURN:退货退款。',
  `order_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号，该字段可用于获取订单',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'detail json',
  `complaint_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纠纷id，该字段可用于获取纠纷信息',
  `refund_resp` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信支付退款的响应',
  `pull_status` int NULL DEFAULT NULL COMMENT '推送状态（0未推送；1推送成功；2推送失败）',
  `pull_time` datetime NULL DEFAULT NULL COMMENT '订单审核时间',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '商品id(o_goods外键)',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '商品skuid(o_goods_sku外键)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频号小店退款' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_wei_refund
-- ----------------------------

-- ----------------------------
-- Table structure for oms_wei_waybill_account
-- ----------------------------
DROP TABLE IF EXISTS `oms_wei_waybill_account`;
CREATE TABLE `oms_wei_waybill_account`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `seller_shop_id` bigint NULL DEFAULT NULL COMMENT '平台店铺id，全局唯一，一个店铺分配一个shop_id',
  `delivery_id` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递公司编码',
  `company_type` int NULL DEFAULT NULL COMMENT '快递公司类型1：加盟型 2：直营型',
  `site_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网点编码',
  `site_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网点名称',
  `acct_id` bigint NULL DEFAULT NULL COMMENT '电子面单账号id，每绑定一个网点分配一个acct_id',
  `acct_type` int NULL DEFAULT NULL COMMENT '面单账号类型0：普通账号 1：共享账号',
  `status` int NULL DEFAULT NULL COMMENT '面单账号状态',
  `available` int NULL DEFAULT NULL COMMENT '面单余额',
  `allocated` int NULL DEFAULT NULL COMMENT '累积已取单',
  `cancel` int NULL DEFAULT NULL COMMENT '累计已取消',
  `recycled` int NULL DEFAULT NULL COMMENT '累积已回收',
  `monthly_card` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '月结账号，company_type 为直营型时有效',
  `site_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '网点信息JSON',
  `sender_province` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省名称（一级地址）',
  `sender_city` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市名称（二级地址）',
  `sender_county` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sender_street` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sender_address` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货人',
  `mobile` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货手机号',
  `phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货固定电话',
  `is_show` int NULL DEFAULT NULL COMMENT '是否前台显示1显示0不显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频号小店电子面单账户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_wei_waybill_account
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '系统名称', 'sys.name', '启航电商WMS系统', 'Y', 'admin', '2023-08-07 19:31:38', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2023-08-07 19:31:38', '', NULL, '是否开启验证码功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '启航技术', 0, '老齐', '15888888888', '280645618@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2024-09-15 17:52:12');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '研发中心', 1, '老齐', '15888888888', '280645618@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2024-09-15 17:52:47');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '市场中心', 2, '方', '15888888888', 'market@qihangerp.cn', '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2024-09-15 17:53:28');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2137 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '电商销售管理', 0, 10, '/sales', 'Layout', '', 1, 0, 'M', '0', '0', '', 'shop', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-01 09:22:11', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '入库管理', 0, 30, '/refund', 'Layout', '', 1, 0, 'M', '0', '0', '', 'edit', 'admin', '2023-12-27 15:00:27', 'admin', '2025-12-30 02:56:39', '至简官网地址');
INSERT INTO `sys_menu` VALUES (4, '商品管理', 0, 0, 'goods', 'Layout', '', 1, 0, 'M', '0', '0', '', 'international', 'admin', '2023-12-29 16:53:03', 'admin', '2025-10-01 12:16:48', '');
INSERT INTO `sys_menu` VALUES (5, '系统设置', 0, 99, '/system', 'Layout', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2023-12-27 15:00:27', 'admin', '2023-12-29 09:07:42.856856', '系统管理目录');
INSERT INTO `sys_menu` VALUES (6, '出库管理', 0, 20, 'ship', 'Layout', NULL, 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2024-03-30 17:36:10', 'admin', '2025-12-30 02:33:36', '');
INSERT INTO `sys_menu` VALUES (7, '仓库设置', 0, 40, 'stock', 'Layout', NULL, 1, 0, 'M', '0', '0', '', 'lock', 'admin', '2024-08-25 15:54:14', 'admin', '2025-12-30 03:01:19', '');
INSERT INTO `sys_menu` VALUES (100, '发货订单库', 1, 1, 'order_list', 'order/index', '', 1, 0, 'C', '0', '0', '', 'shopping', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-02 01:05:49', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '电商订单拉取', 1, 32, 'order_pull', 'order/pull_order', '', 1, 0, 'C', '0', '0', '', 'documentation', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-03 05:47:11', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '店铺订单管理', 1, 3, 'shop_order_list', 'order/shopOrder/index', '', 1, 0, 'C', '0', '0', '', 'list', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-01 07:08:26', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (106, '店铺售后管理', 1, 20, 'shop_refund_list', 'refund/shopRefund/index', '', 1, 0, 'C', '0', '0', '', 'edit', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-01 07:08:01', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (108, '店铺管理', 1, 86, 'shop_list', 'shop/index', '', 1, 0, 'C', '0', '0', '', 'shop', 'admin', '2023-12-29 09:14:02', 'admin', '2026-01-01 07:07:02', '');
INSERT INTO `sys_menu` VALUES (110, '平台参数设置', 1, 88, 'platform/setting', 'shop/platform/index', '', 1, 0, 'C', '0', '0', '', 'system', 'admin', '2023-12-29 13:32:41', 'admin', '2025-07-11 13:59:36', '');
INSERT INTO `sys_menu` VALUES (116, '用户管理', 5, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', '', 'user', 'admin', '2023-12-27 15:00:27', '', '', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (117, '菜单管理', 5, 1, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', '', 'user', 'admin', '2023-12-27 15:00:27', '', '', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (177, '店铺商品管理', 1, 30, 'shop_goods', 'goods/shopGoods/goods_item_list', NULL, 1, 0, 'C', '0', '0', '', 'goods', 'admin', '2024-03-28 10:29:59', 'admin', '2026-01-02 02:04:37', '');
INSERT INTO `sys_menu` VALUES (401, '渠道商品管理', 4, 50, 'offline_goods_list', 'offline/goods/index', NULL, 1, 0, 'C', '0', '1', '', 'documentation', 'admin', '2024-07-27 17:33:54', 'admin', '2024-09-07 23:17:59', '');
INSERT INTO `sys_menu` VALUES (404, '商品库', 4, 0, 'goods_list', 'goods/goods/index', NULL, 1, 0, 'C', '0', '0', 'goods', 'example', 'admin', '2024-08-25 14:35:54', 'admin', '2025-09-08 20:05:25', '');
INSERT INTO `sys_menu` VALUES (407, '添加商品', 4, 99, 'create', 'goods/goods/create', NULL, 1, 0, 'C', '1', '0', '', 'checkbox', 'admin', '2024-03-18 07:59:57', 'admin', '2025-12-30 02:31:01', '');
INSERT INTO `sys_menu` VALUES (409, '商品分类管理', 4, 80, 'category_list', 'goods/category/index', NULL, 1, 0, 'C', '0', '0', '', 'edit', 'admin', '2024-08-25 18:43:28', 'admin', '2024-09-07 15:47:44', '');
INSERT INTO `sys_menu` VALUES (410, '商品品牌管理', 4, 81, 'brand_list', 'goods/brand/index', NULL, 1, 0, 'C', '0', '0', '', 'icon', 'admin', '2024-08-25 18:45:47', 'admin', '2024-09-07 15:48:31', '');
INSERT INTO `sys_menu` VALUES (412, '规格属性值', 4, 102, 'goods_category/attribute_value', 'goods/category/categoryAttributeValue', NULL, 1, 0, 'C', '1', '0', '', 'date', 'admin', '2024-08-25 18:51:55', 'admin', '2024-09-07 16:23:53', '');
INSERT INTO `sys_menu` VALUES (413, '分类规格属性', 4, 101, 'goods_category/attribute', 'goods/category/categoryAttribute', NULL, 1, 0, 'C', '1', '0', '', 'button', 'admin', '2024-08-25 18:49:22', 'admin', '2024-09-07 16:17:01', '');
INSERT INTO `sys_menu` VALUES (808, '供应商管理', 4, 90, 'supplier_list', 'goods/supplier/index', NULL, 1, 0, 'C', '0', '0', '', 'people', 'admin', '2024-08-25 18:27:55', 'admin', '2025-12-30 02:30:41', '');
INSERT INTO `sys_menu` VALUES (2079, '字典管理', 5, 9, 'dict', 'system/dict/index', NULL, 1, 0, 'C', '0', '0', '', 'dict', 'admin', '2024-03-18 08:43:55', 'admin', '2024-03-18 08:44:08', '');
INSERT INTO `sys_menu` VALUES (2088, '发货设置', 7, 9, 'ship_set', 'shipping/logistics/index', NULL, 1, 0, 'C', '0', '0', '', 'checkbox', 'admin', '2024-03-30 17:37:01', 'admin', '2025-12-30 03:01:01', '');
INSERT INTO `sys_menu` VALUES (2089, '发货记录', 6, 3, 'record', 'shipping/record/index', NULL, 1, 0, 'C', '0', '0', '', 'list', 'admin', '2024-03-30 17:37:42', 'admin', '2025-10-10 00:44:48', '');
INSERT INTO `sys_menu` VALUES (2090, '角色管理', 5, 2, 'role', 'system/role/index', NULL, 1, 0, 'C', '0', '0', NULL, 'peoples', 'admin', '2024-03-31 12:40:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '部门管理', 5, 3, 'dept', 'system/dept/index', NULL, 1, 0, 'C', '0', '0', NULL, 'tree', 'admin', '2024-03-31 12:42:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2093, '发货订单商品', 1, 2, 'order_item_list', 'order/item_list', NULL, 1, 0, 'C', '1', '0', '', 'chart', 'admin', '2024-04-06 18:58:06', 'admin', '2025-10-01 08:36:11', '');
INSERT INTO `sys_menu` VALUES (2096, '备货出库', 6, 2, 'stockup', 'shipping/stockup', NULL, 1, 0, 'C', '0', '0', '', 'email', 'admin', '2024-07-20 11:53:24', 'admin', '2025-10-09 02:37:28', '');
INSERT INTO `sys_menu` VALUES (2099, '私域订单管理', 1, 10, 'offline_order_list', 'order/private/index', NULL, 1, 0, 'C', '0', '1', '', 'checkbox', 'admin', '2024-07-27 17:33:03', 'admin', '2025-05-24 13:10:53', '');
INSERT INTO `sys_menu` VALUES (2100, '私域售后管理', 2, 3, 'offline_aftersale', 'refund/private/index', NULL, 1, 0, 'C', '0', '1', '', 'code', 'admin', '2024-07-27 17:33:33', 'admin', '2025-05-25 14:59:03', '');
INSERT INTO `sys_menu` VALUES (2103, '手动创建订单', 1, 49, 'order_create', 'order/create', NULL, 1, 0, 'C', '1', '0', '', 'date', 'admin', '2024-07-27 20:30:07', 'admin', '2026-01-03 02:48:11', '');
INSERT INTO `sys_menu` VALUES (2106, '入库管理', 2, 10, 'stock_in', 'stock/stockIn/index.vue', NULL, 1, 0, 'C', '0', '0', '', 'download', 'admin', '2024-08-25 15:56:04', 'admin', '2025-12-30 02:57:11', '');
INSERT INTO `sys_menu` VALUES (2114, '库位管理', 7, 90, 'warehouse', 'stock/warehouse/index.vue', NULL, 1, 0, 'C', '0', '0', '', 'cascader', 'admin', '2024-09-21 20:07:26', 'admin', '2025-12-30 03:01:41', '');
INSERT INTO `sys_menu` VALUES (2115, '商品库存', 4, 10, 'goods_inventory', 'stock/goodsInventory/index.vue', NULL, 1, 0, 'C', '0', '0', '', 'chart', 'admin', '2024-09-21 20:43:00', 'admin', '2025-12-30 03:00:22', '');
INSERT INTO `sys_menu` VALUES (2116, '出库管理', 6, 20, 'stock_out', 'stock/stockOut/index', NULL, 1, 0, 'C', '0', '0', '', 'guide', 'admin', '2024-09-21 20:44:46', 'admin', '2025-12-30 02:55:57', '');
INSERT INTO `sys_menu` VALUES (2117, '仓位管理', 7, 91, 'position', 'stock/warehouse/position', NULL, 1, 0, 'C', '1', '0', '', '404', 'admin', '2024-09-22 11:52:18', 'admin', '2025-03-24 13:47:04', '');
INSERT INTO `sys_menu` VALUES (2118, '新建入库单', 2, 11, 'stock_in/create', 'stock/stockIn/create.vue', NULL, 1, 0, 'C', '1', '0', '', '404', 'admin', '2024-09-22 14:49:40', 'admin', '2025-12-30 02:57:28', '');
INSERT INTO `sys_menu` VALUES (2129, '订单发货', 6, 0, 'ship_order', 'shipping/wait_ship.vue', NULL, 1, 0, 'C', '0', '0', '', 'checkbox', 'admin', '2025-06-01 13:36:57', 'admin', '2025-10-09 02:43:33', '');
INSERT INTO `sys_menu` VALUES (2135, '退货入库', 2, 20, 's', NULL, NULL, 1, 0, 'C', '0', '0', '', 'download', 'admin', '2025-12-30 02:58:18', 'admin', '2025-12-30 02:59:16', '');
INSERT INTO `sys_menu` VALUES (2136, '采购入库', 2, 30, 'p', NULL, NULL, 1, 0, 'C', '0', '0', NULL, 'checkbox', 'admin', '2025-12-30 02:58:43', '', NULL, '');

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'URL地址',
  `object_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '对象名',
  `bucket` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '桶名',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------
INSERT INTO `sys_oss` VALUES (1, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/a3e935aa-d1b3-4524-bd84-e567df01f2e3.jpg', '/images/2024/09/07/a3e935aa-d1b3-4524-bd84-e567df01f2e3.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:38:57', '', NULL);
INSERT INTO `sys_oss` VALUES (2, '主图画板2.jpg', '主图画板2.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/1dbe1530-787f-4461-9f20-3efa3c332588.jpg', '/images/2024/09/07/1dbe1530-787f-4461-9f20-3efa3c332588.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:57:54', '', NULL);
INSERT INTO `sys_oss` VALUES (3, '主图画板5.jpg', '主图画板5.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/2dc06b89-8661-4a72-a7cd-7f85f4545c6e.jpg', '/images/2024/09/07/2dc06b89-8661-4a72-a7cd-7f85f4545c6e.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 18:03:24', '', NULL);
INSERT INTO `sys_oss` VALUES (4, '主图画板 4.jpg', '主图画板 4.jpg', '.jpg', 'http://127.0.0.1:9000/ecerp//images/2024/09/07/3ed00452-5973-4c7e-91ae-5e87aa32dd23.jpg', '/images/2024/09/07/3ed00452-5973-4c7e-91ae-5e87aa32dd23.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 18:03:46', '', NULL);
INSERT INTO `sys_oss` VALUES (5, '主图画板5.jpg', '主图画板5.jpg', '.jpg', 'http://127.0.0.1:9000/ecerp/images/2024/09/07/4b2583ae-65ae-45b6-9227-ebbee99d6558.jpg', '/images/2024/09/07/4b2583ae-65ae-45b6-9227-ebbee99d6558.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 18:04:47', '', NULL);
INSERT INTO `sys_oss` VALUES (6, '主图画板2.jpg', '主图画板2.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/a64ff14b-09d4-42d6-8d52-0344360efdbf.jpg', '/images/2024/09/07/a64ff14b-09d4-42d6-8d52-0344360efdbf.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 19:10:39', '', NULL);
INSERT INTO `sys_oss` VALUES (7, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/af19385d-a1dd-4efb-8257-3099706d1272.jpg', '/images/2024/09/07/af19385d-a1dd-4efb-8257-3099706d1272.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 19:26:36', '', NULL);
INSERT INTO `sys_oss` VALUES (8, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/5aac40e1-ddc1-41a8-a468-28d81e699980.jpg', '/images/2024/09/07/5aac40e1-ddc1-41a8-a468-28d81e699980.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 20:37:14', '', NULL);
INSERT INTO `sys_oss` VALUES (9, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/b28f4e15-8997-418c-bd32-b4beb4966f6b.jpg', '/images/2024/09/07/b28f4e15-8997-418c-bd32-b4beb4966f6b.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 20:37:51', '', NULL);
INSERT INTO `sys_oss` VALUES (50, 'x4.jpg', 'x4.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/08/28/x4.jpg', '/images/2024/08/28/x4.jpg', 'ecerp', 0, '0', '0', '', '2024-08-28 22:39:05', '', NULL);
INSERT INTO `sys_oss` VALUES (51, 'x11.jpg', 'x11.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/08/28/x11.jpg', '/images/2024/08/28/x11.jpg', 'ecerp', 0, '0', '0', '', '2024-08-28 22:47:11', '', NULL);
INSERT INTO `sys_oss` VALUES (52, '主图画板 4.jpg', '主图画板 4.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/主图画板 4.jpg', '/images/2024/09/07/主图画板 4.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:31:44', '', NULL);
INSERT INTO `sys_oss` VALUES (53, '主图画板 4.jpg', '主图画板 4.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/主图画板 4.jpg', '/images/2024/09/07/主图画板 4.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:35:41', '', NULL);
INSERT INTO `sys_oss` VALUES (54, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/f35a3cb8-1b9e-41f4-8158-31d458c7efb3.jpg', '/images/2024/09/07/f35a3cb8-1b9e-41f4-8158-31d458c7efb3.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:36:09', '', NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2025-12-30 02:32:13', '普通角色');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 404);
INSERT INTO `sys_role_menu` VALUES (2, 407);
INSERT INTO `sys_role_menu` VALUES (2, 409);
INSERT INTO `sys_role_menu` VALUES (2, 410);
INSERT INTO `sys_role_menu` VALUES (2, 412);
INSERT INTO `sys_role_menu` VALUES (2, 413);
INSERT INTO `sys_role_menu` VALUES (2, 808);

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task`  (
  `id` int NOT NULL,
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台任务配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
INSERT INTO `sys_task` VALUES (1, '拉取淘宝订单', '-', NULL, '定时更新淘宝订单', 0, '2024-03-07 09:52:40');
INSERT INTO `sys_task` VALUES (2, '拉取京东POP订单', '-', NULL, '拉取京东POP订单', 0, '2024-03-07 09:23:36');
INSERT INTO `sys_task` VALUES (3, '拉取拼多多订单', '0 0/1 * * * ?', NULL, '定时拉取拼多多订单', 1, '2024-04-09 11:24:14');
INSERT INTO `sys_task` VALUES (4, '拉取抖店订单', '-', NULL, '定时拉取抖店订单', 0, '2024-04-09 11:24:54');
INSERT INTO `sys_task` VALUES (5, '拉取天猫退款', '-', NULL, '定时拉取天猫退款', 0, '2024-04-09 11:25:43');
INSERT INTO `sys_task` VALUES (6, '拉取京东售后', '-', NULL, '定时拉取京东售后', 0, '2024-04-09 11:26:26');
INSERT INTO `sys_task` VALUES (7, '拉取拼多多退款', '-', NULL, '定时拉取拼多多退款', 0, '2024-04-09 11:27:01');
INSERT INTO `sys_task` VALUES (8, '拉取抖店退款', '-', NULL, '定时拉取抖店退款', 0, '2024-04-09 11:27:38');
INSERT INTO `sys_task` VALUES (11, '拉取京东自营订单', '-', NULL, '拉取京东自营订单', 0, '2024-05-27 10:57:44');
INSERT INTO `sys_task` VALUES (12, '拉取京东自营退货', '-', NULL, '拉取京东自营退货', 0, NULL);
INSERT INTO `sys_task` VALUES (21, '推送待发货订单到ERP', '-', NULL, '推送待发货订单到ERP', 0, '2024-04-22 15:48:48');
INSERT INTO `sys_task` VALUES (22, '推送待处理售后到ERP', '-', NULL, '推送待处理售后到ERP', 0, '2024-04-22 15:48:48');
INSERT INTO `sys_task` VALUES (23, '推送已取消的订单到ERP', '-', NULL, '推送已取消的订单到ERP', 0, '2024-05-29 17:57:02');

-- ----------------------------
-- Table structure for sys_task_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_logs`;
CREATE TABLE `sys_task_logs`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `task_id` int NULL DEFAULT NULL COMMENT '任务ID',
  `result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结果',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始运行时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `status` int NULL DEFAULT NULL COMMENT '状态1运行中，2已结束',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台任务运行日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_task_logs
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, NULL, 'admin', '启航老齐A', '00', '280645618@qq.com', '18123879144', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-01-03 16:06:43', 'admin', '2023-08-07 19:31:37', '', '2026-01-03 08:06:42', '管理员');
INSERT INTO `sys_user` VALUES (2, NULL, 'openapi', 'openApi接口专用', '00', '2806456181@qq.com', '15818590000', '0', '', '$2a$10$fHkhoqbMiyracAsTzl38H.55bu.M.of1FXk2EK7RQBjfic3tLU0Ue', '0', '0', '127.0.0.1', '2024-06-24 10:23:35', 'admin', '2024-03-17 14:55:22', 'admin', '2024-06-24 10:23:35', NULL);
INSERT INTO `sys_user` VALUES (101, 101, '15818590119', 'aaa123', '00', '', '', '0', '', '$2a$10$pXcT6cHaObMeKuYd9vZb5uEb8PyUdF2AcqqRN1cBqiA9rV4qYQW7G', '0', '2', '', NULL, 'admin', '2024-08-15 13:45:25', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (102, 101, '15818590119', '老齐', '00', '', '', '0', '', '$2a$10$ysk.zgJ8wh25c7vOjKyZ8uarM2hkG0S51j8GYdJSo2kZmc3f8HdKe', '0', '0', '', NULL, 'admin', '2024-08-15 13:49:59', 'admin', '2025-02-10 16:26:20', NULL);
INSERT INTO `sys_user` VALUES (103, 100, '18025303180', '老方', '00', '', '', '0', '', '$2a$10$QnLM3NluG5q1xpmWep0QUOFfvNrd02hwenL4HkV0uhMbm4cEX1uIG', '0', '0', '', NULL, 'admin', '2024-09-21 17:17:56', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (102, 2);
INSERT INTO `sys_user_role` VALUES (103, 2);

-- ----------------------------
-- Table structure for wms_inventory_operation
-- ----------------------------
DROP TABLE IF EXISTS `wms_inventory_operation`;
CREATE TABLE `wms_inventory_operation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `batch_id` bigint NOT NULL COMMENT '库存批次id',
  `batch_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '库存批次号',
  `type` int NOT NULL COMMENT '库存类型（1增加库存2减少库存3锁定库存）',
  `inventory_detail_id` bigint NOT NULL COMMENT '商品库存id（本表id减库存的时候关联）',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '操作库存数量',
  `locked_quantity` int NOT NULL COMMENT '锁定库存数量（status变成已结算时把该字段值更新到quantity）',
  `price` double NULL DEFAULT 0 COMMENT '价格（type=1采购价格；type=2出库时的价格）',
  `biz_type` int NOT NULL COMMENT '业务类型（10采购入库20采购退货30退货入库40订单出库）',
  `biz_id` bigint NOT NULL COMMENT '业务单id',
  `biz_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务单号',
  `biz_item_id` bigint NOT NULL COMMENT '业务单itemId',
  `status` int NOT NULL COMMENT '状态（0待结算1已结算）',
  `remark` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库库存操作记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_inventory_operation
-- ----------------------------

-- ----------------------------
-- Table structure for wms_stock_in
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_in`;
CREATE TABLE `wms_stock_in`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_in_num` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '入库单据编号',
  `stock_in_type` int NOT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `source_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  `source_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `stock_in_operator_id` bigint NULL DEFAULT NULL COMMENT '操作入库人id',
  `stock_in_operator` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作入库人',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '入库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_in
-- ----------------------------
INSERT INTO `wms_stock_in` VALUES (1, '1726994500872422', 1, 'AAA', NULL, 1, 15, 1, NULL, 1, 'aaa', '2024-09-22 16:41:54', 0, 'admin', '2024-09-22 16:41:54', NULL, NULL);
INSERT INTO `wms_stock_in` VALUES (2, '1726994500872422', 1, 'AAA', NULL, 1, 15, 1, NULL, 1, 'aaa', NULL, 0, 'admin', '2024-09-22 17:51:55', NULL, NULL);

-- ----------------------------
-- Table structure for wms_stock_in_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_in_item`;
CREATE TABLE `wms_stock_in_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_in_id` bigint NOT NULL COMMENT '入库单id',
  `stock_in_type` int NULL DEFAULT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_no` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_item_id` bigint NOT NULL COMMENT '来源单itemId',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `quantity` int NOT NULL COMMENT '原始数量',
  `in_quantity` int NOT NULL DEFAULT 0 COMMENT '入库数量',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1837791930231152643 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '入库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_in_item
-- ----------------------------
INSERT INTO `wms_stock_in_item` VALUES (1837774310068998145, 1, 1, 'AAA', 0, 0, 78, NULL, '红罐加多宝', 'https://cbu01.alicdn.com/img/ibank/O1CN012YyP5f1hbcSsvkd3k_!!2218127114296-0-cib.jpg', 1832398056436318216, 'JIADUOBAO2600', '大红色 均码', 15, 0, '', 0, 'admin', '2024-09-22 16:41:54', NULL, NULL);
INSERT INTO `wms_stock_in_item` VALUES (1837791930231152642, 2, 1, 'AAA', 0, 0, 78, NULL, '红罐加多宝', NULL, 1832398056436318200, 'JIADUOBAO2600', '大红色 均码', 15, 0, '', 0, 'admin', '2024-09-22 17:51:55', NULL, NULL);

-- ----------------------------
-- Table structure for wms_stock_out
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_out`;
CREATE TABLE `wms_stock_out`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_out_num` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出库单编号',
  `source_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '来源单据号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单据Id',
  `stock_out_type` int NOT NULL DEFAULT 1 COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `goods_unit` int NOT NULL COMMENT '商品数',
  `spec_unit` int NOT NULL COMMENT '商品规格数',
  `spec_unit_total` int NOT NULL COMMENT '总件数',
  `out_total` int NULL DEFAULT NULL COMMENT '已出库数量',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态：0待出库1部分出库2全部出库',
  `print_status` int NOT NULL COMMENT '打印状态：是否打印1已打印0未打印',
  `print_time` datetime NULL DEFAULT NULL COMMENT '打印时间',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `operator_id` int NULL DEFAULT 0 COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `create_by` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1794205460481933314 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_out
-- ----------------------------
INSERT INTO `wms_stock_out` VALUES (1785676644348735490, '202405012220056', NULL, NULL, 1, 1, 1, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, '2024-05-01 22:24:23', '生成拣货单', '2024-05-01 22:24:22', NULL);
INSERT INTO `wms_stock_out` VALUES (1786204816504958978, '202405030923075', NULL, NULL, 1, 1, 1, 1, 1, NULL, 2, 0, NULL, '2024-05-03 10:56:33', '2024-05-03 10:56:33', 1, 'admin', '2024-05-03 09:23:09', '生成拣货单', '2024-05-03 10:56:34', '出库');
INSERT INTO `wms_stock_out` VALUES (1788393466709282818, '202405091020024', NULL, NULL, 1, 1, 1, 1, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, '2024-05-09 10:20:04', '生成拣货单', '2024-05-09 10:20:03', NULL);
INSERT INTO `wms_stock_out` VALUES (1794205460481933313, '202405251109432', NULL, NULL, 1, 1, 1, 1, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, '2024-05-25 11:14:51', '生成拣货单', '2024-05-25 11:14:51', NULL);

-- ----------------------------
-- Table structure for wms_stock_out_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_out_item`;
CREATE TABLE `wms_stock_out_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_out_type` int NOT NULL COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `entry_id` bigint NOT NULL COMMENT '出库单id（外键）',
  `source_order_id` bigint NOT NULL COMMENT '来源订单id',
  `source_order_item_id` bigint NOT NULL COMMENT '来源订单itemId出库对应的itemId，如：order_item表id、invoice_info表id',
  `source_order_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '来源订单号',
  `goods_id` int NOT NULL COMMENT '商品id',
  `spec_id` int NOT NULL COMMENT '商品规格id',
  `spec_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '规格编码',
  `original_quantity` bigint NOT NULL COMMENT '总数量',
  `out_quantity` bigint NOT NULL DEFAULT 0 COMMENT '已出库数量',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `picked_time` datetime NULL DEFAULT NULL COMMENT '完成拣货时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态：0待出库1部分出库2全部出库',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`spec_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1794205460544847874 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_out_item
-- ----------------------------
INSERT INTO `wms_stock_out_item` VALUES (1785676644373901314, 1, 1785676644348735490, 38, 442, '2055782964491095876', 9, 23, '2720210080260001', 1, 0, NULL, NULL, 0, '2024-05-01 22:24:23', NULL);
INSERT INTO `wms_stock_out_item` VALUES (1786204816504958979, 1, 1786204816504958978, 41, 1785584827112509446, '2137984935735126281', 9, 32, '2720210080260105', 1, 1, '2024-05-03 10:56:27', '2024-05-03 10:56:26', 2, '2024-05-03 09:23:09', NULL);
INSERT INTO `wms_stock_out_item` VALUES (1788393466763808769, 1, 1788393466709282818, 51, 1785584827112509452, 'A13885020023320', 1228, 1228, 'GZYYZ72773100', 1, 0, NULL, NULL, 0, '2024-05-09 10:20:04', NULL);
INSERT INTO `wms_stock_out_item` VALUES (1794205460544847873, 1, 1794205460481933313, 49, 1785584827112509450, 'AD3702565220', 1229, 1229, 'GZYYZ72776200', 1, 0, NULL, NULL, 0, '2024-05-25 11:14:51', NULL);

-- ----------------------------
-- Table structure for wms_stock_out_item_position
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_out_item_position`;
CREATE TABLE `wms_stock_out_item_position`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `entry_id` bigint NOT NULL COMMENT '出库单ID',
  `entry_item_id` bigint NOT NULL DEFAULT 0 COMMENT '出库单ItemID',
  `goods_inventory_id` bigint NOT NULL DEFAULT 0 COMMENT '库存ID',
  `goods_inventory_detail_id` bigint NOT NULL DEFAULT 0 COMMENT '库存详情ID',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '出库数量',
  `location_id` int NULL DEFAULT NULL COMMENT '出库仓位ID',
  `operator_id` int NULL DEFAULT 0 COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_stock_info_item_id_index`(`goods_inventory_detail_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1786228283631636482 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库仓位详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_out_item_position
-- ----------------------------
INSERT INTO `wms_stock_out_item_position` VALUES (1786220616376844290, 1786204816504958978, 1786204816504958979, 6, 7, 1, 20, 1, 'admin', '2024-05-03 10:25:55');
INSERT INTO `wms_stock_out_item_position` VALUES (1786228283631636481, 1786204816504958978, 1786204816504958979, 6, 7, 1, 20, 1, 'admin', '2024-05-03 10:56:24');

-- ----------------------------
-- Table structure for wms_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `wms_warehouse`;
CREATE TABLE `wms_warehouse`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库名称',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '街道',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态0禁用  1正常',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_warehouse
-- ----------------------------
INSERT INTO `wms_warehouse` VALUES (1, 'SHENZHEN', '深圳仓库', '广东省', '深圳市', '宝安区', '福永街道', NULL, '自营仓库', 1, 'admin', '2022-03-07 20:06:10', NULL, '2022-03-07 20:06:10');

-- ----------------------------
-- Table structure for wms_warehouse_position
-- ----------------------------
DROP TABLE IF EXISTS `wms_warehouse_position`;
CREATE TABLE `wms_warehouse_position`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL COMMENT '仓库id',
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库/货架编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓位/货架名称',
  `parent_id` int NOT NULL COMMENT '上级id',
  `depth` int NULL DEFAULT 1 COMMENT '层级深度1级2级3级',
  `parent_id1` int NOT NULL COMMENT '一级类目id',
  `parent_id2` int NOT NULL COMMENT '二级类目id',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `isDelete` int NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库仓位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_warehouse_position
-- ----------------------------
INSERT INTO `wms_warehouse_position` VALUES (1, 1, '001', '深圳虚拟仓库', 0, 1, 0, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:10', NULL, '2022-03-07 20:06:10');
INSERT INTO `wms_warehouse_position` VALUES (2, 1, 'A', 'A区', 1, 2, 1, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:24', NULL, '2022-03-07 20:06:24');
INSERT INTO `wms_warehouse_position` VALUES (3, 1, 'B', 'B区', 1, 2, 1, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:38', NULL, '2022-03-07 20:06:38');
INSERT INTO `wms_warehouse_position` VALUES (4, 1, 'C', 'C区', 1, 2, 1, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:47', NULL, '2022-03-07 20:06:47');
INSERT INTO `wms_warehouse_position` VALUES (5, 1, 'A01-1-01', 'A01-1-01', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (6, 1, 'A01-1-02', 'A01-1-02', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (7, 1, 'A01-1-03', 'A01-1-03', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (8, 1, 'A01-1-04', 'A01-1-04', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (9, 1, 'A01-1-05', 'A01-1-05', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (10, 1, 'A01-1-06', 'A01-1-06', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (11, 1, 'A01-1-07', 'A01-1-07', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (12, 1, 'A01-1-08', 'A01-1-08', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (13, 1, 'A01-1-09', 'A01-1-09', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (14, 1, 'A01-1-10', 'A01-1-10', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (15, 1, 'A01-1-11', 'A01-1-11', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (16, 1, 'A01-1-12', 'A01-1-12', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (17, 1, 'A01-1-13', 'A01-1-13', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (18, 1, 'A01-1-14', 'A01-1-14', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (19, 1, 'A01-1-15', 'A01-1-15', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_warehouse_position` VALUES (20, 1, 'A01-1-16', 'A01-1-16', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');

SET FOREIGN_KEY_CHECKS = 1;
