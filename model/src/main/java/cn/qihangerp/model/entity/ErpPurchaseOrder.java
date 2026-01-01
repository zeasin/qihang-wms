package cn.qihangerp.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 采购订单
 * @TableName erp_purchase_order
 */
@TableName(value ="erp_purchase_order")
@Data
public class ErpPurchaseOrder {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 供应商id
     */
    private Long supplierId;

    /**
     * 订单编号
     */
    private String orderNum;

    /**
     * 订单日期
     */
    private Date orderDate;

    /**
     * 订单创建时间
     */
    private Long orderTime;

    /**
     * 订单总金额
     */
    private BigDecimal orderAmount;

    /**
     * 物流费用
     */
    private BigDecimal shipAmount;

    /**
     * 备注
     */
    private String remark;

    /**
     * 订单状态 0待审核1已审核101供应商已确认102供应商已发货2已收货3已入库
     */
    private Integer status;

    /**
     * 采购单审核人
     */
    private String auditUser;

    /**
     * 审核时间
     */
    private Long auditTime;

    /**
     * 供应商确认时间
     */
    private Date supplierConfirmTime;

    /**
     * 供应商发货时间
     */
    private Date supplierDeliveryTime;

    /**
     * 收货时间
     */
    private Date receivedTime;

    /**
     * 入库时间
     */
    private Date stockInTime;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新人
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    @TableField(exist = false)
    private List<ErpPurchaseOrderItem> itemList;
}