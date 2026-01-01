package cn.qihangerp.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 采购订单明细
 * @TableName erp_purchase_order_item
 */
@TableName(value ="erp_purchase_order_item")
@Data
public class ErpPurchaseOrderItem {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 订单id
     */
    private Long orderId;

    /**
     * 订单编号
     */
    private String orderNum;

    /**
     * 150501采购 150502退货
     */
    private String transType;

    /**
     * 购货金额
     */
    private Double amount;

    /**
     * 订单日期
     */
    private Date orderDate;

    /**
     * 备注
     */
    private String remark;

    /**
     * 商品ID
     */
    private Long goodsId;

    /**
     * 商品编码
     */
    private String goodsNum;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 商品规格id
     */
    private Long specId;

    /**
     * 商品规格编码
     */
    private String specNum;

    /**
     * 颜色
     */
    private String colorValue;

    /**
     * 图片
     */
    private String colorImage;

    /**
     * 尺码
     */
    private String sizeValue;

    /**
     * 款式
     */
    private String styleValue;

    /**
     * 单价
     */
    private BigDecimal price;

    /**
     * 折扣额
     */
    private BigDecimal disAmount;

    /**
     * 折扣率
     */
    private BigDecimal disRate;

    /**
     * 数量(采购单据)
     */
    private Long quantity;

    /**
     * 已入库数量
     */
    private Long inqty;

    /**
     * 入库的仓库id
     */
    private Integer locationid;

    /**
     * 1删除 0正常
     */
    private Integer isDelete;

    /**
     * 状态（同billStatus）0待审核1正常2已作废3已入库
     */
    private Integer status;
}