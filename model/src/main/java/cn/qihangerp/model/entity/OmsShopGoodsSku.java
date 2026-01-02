package cn.qihangerp.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;

/**
 * 其他渠道店铺商品SKU
 * @TableName oms_shop_goods_sku
 */
@TableName(value ="oms_shop_goods_sku")
public class OmsShopGoodsSku {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 店铺id
     */
    private Long shopId;

    /**
     * 店铺类型
     */
    private Integer shopType;

    /**
     * 平台商品id
     */
    private String productId;

    /**
     * 商品名
     */
    private String productTitle;

    /**
     * 商家商品编码
     */
    private String outerProductId;

    /**
     * sku名
     */
    private String skuName;

    /**
     * 平台skuId
     */
    private String skuId;

    /**
     * 商家自定义skuID。如果添加时没录入，回包可能不包含该字段
     */
    private String outerSkuId;

    /**
     * sku编码
     */
    private String skuCode;

    /**
     * sku小图
     */
    private String img;

    /**
     * 售卖价格，以分为单位
     */
    private Integer price;

    /**
     * sku库存
     */
    private Integer stockNum;

    /**
     * sku状态平台
     */
    private Integer status;

    /**
     * sku_attrs
     */
    private String skuAttrs;

    /**
     * 添加时间平台
     */
    private Long addTime;

    /**
     * 修改时间平台
     */
    private Long modifyTime;

    /**
     * erp系统商品id
     */
    private Long erpGoodsId;

    /**
     * erp系统商品skuid
     */
    private Long erpGoodsSkuId;

    /**
     * erp状态0未绑定1已绑定
     */
    private Integer erpStatus;

    /**
     * 创建时间
     */
    private Date createOn;

    /**
     * 更新时间
     */
    private Date updateOn;

    /**
     * 
     */
    public Long getId() {
        return id;
    }

    /**
     * 
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 店铺id
     */
    public Long getShopId() {
        return shopId;
    }

    /**
     * 店铺id
     */
    public void setShopId(Long shopId) {
        this.shopId = shopId;
    }

    /**
     * 店铺类型
     */
    public Integer getShopType() {
        return shopType;
    }

    /**
     * 店铺类型
     */
    public void setShopType(Integer shopType) {
        this.shopType = shopType;
    }

    /**
     * 平台商品id
     */
    public String getProductId() {
        return productId;
    }

    /**
     * 平台商品id
     */
    public void setProductId(String productId) {
        this.productId = productId;
    }

    /**
     * 商品名
     */
    public String getProductTitle() {
        return productTitle;
    }

    /**
     * 商品名
     */
    public void setProductTitle(String productTitle) {
        this.productTitle = productTitle;
    }

    /**
     * 商家商品编码
     */
    public String getOuterProductId() {
        return outerProductId;
    }

    /**
     * 商家商品编码
     */
    public void setOuterProductId(String outerProductId) {
        this.outerProductId = outerProductId;
    }

    /**
     * sku名
     */
    public String getSkuName() {
        return skuName;
    }

    /**
     * sku名
     */
    public void setSkuName(String skuName) {
        this.skuName = skuName;
    }

    /**
     * 平台skuId
     */
    public String getSkuId() {
        return skuId;
    }

    /**
     * 平台skuId
     */
    public void setSkuId(String skuId) {
        this.skuId = skuId;
    }

    /**
     * 商家自定义skuID。如果添加时没录入，回包可能不包含该字段
     */
    public String getOuterSkuId() {
        return outerSkuId;
    }

    /**
     * 商家自定义skuID。如果添加时没录入，回包可能不包含该字段
     */
    public void setOuterSkuId(String outerSkuId) {
        this.outerSkuId = outerSkuId;
    }

    /**
     * sku编码
     */
    public String getSkuCode() {
        return skuCode;
    }

    /**
     * sku编码
     */
    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }

    /**
     * sku小图
     */
    public String getImg() {
        return img;
    }

    /**
     * sku小图
     */
    public void setImg(String img) {
        this.img = img;
    }

    /**
     * 售卖价格，以分为单位
     */
    public Integer getPrice() {
        return price;
    }

    /**
     * 售卖价格，以分为单位
     */
    public void setPrice(Integer price) {
        this.price = price;
    }

    /**
     * sku库存
     */
    public Integer getStockNum() {
        return stockNum;
    }

    /**
     * sku库存
     */
    public void setStockNum(Integer stockNum) {
        this.stockNum = stockNum;
    }

    /**
     * sku状态平台
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * sku状态平台
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * sku_attrs
     */
    public String getSkuAttrs() {
        return skuAttrs;
    }

    /**
     * sku_attrs
     */
    public void setSkuAttrs(String skuAttrs) {
        this.skuAttrs = skuAttrs;
    }

    /**
     * 添加时间平台
     */
    public Long getAddTime() {
        return addTime;
    }

    /**
     * 添加时间平台
     */
    public void setAddTime(Long addTime) {
        this.addTime = addTime;
    }

    /**
     * 修改时间平台
     */
    public Long getModifyTime() {
        return modifyTime;
    }

    /**
     * 修改时间平台
     */
    public void setModifyTime(Long modifyTime) {
        this.modifyTime = modifyTime;
    }

    /**
     * erp系统商品id
     */
    public Long getErpGoodsId() {
        return erpGoodsId;
    }

    /**
     * erp系统商品id
     */
    public void setErpGoodsId(Long erpGoodsId) {
        this.erpGoodsId = erpGoodsId;
    }

    /**
     * erp系统商品skuid
     */
    public Long getErpGoodsSkuId() {
        return erpGoodsSkuId;
    }

    /**
     * erp系统商品skuid
     */
    public void setErpGoodsSkuId(Long erpGoodsSkuId) {
        this.erpGoodsSkuId = erpGoodsSkuId;
    }

    /**
     * erp状态0未绑定1已绑定
     */
    public Integer getErpStatus() {
        return erpStatus;
    }

    /**
     * erp状态0未绑定1已绑定
     */
    public void setErpStatus(Integer erpStatus) {
        this.erpStatus = erpStatus;
    }

    /**
     * 创建时间
     */
    public Date getCreateOn() {
        return createOn;
    }

    /**
     * 创建时间
     */
    public void setCreateOn(Date createOn) {
        this.createOn = createOn;
    }

    /**
     * 更新时间
     */
    public Date getUpdateOn() {
        return updateOn;
    }

    /**
     * 更新时间
     */
    public void setUpdateOn(Date updateOn) {
        this.updateOn = updateOn;
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        OmsShopGoodsSku other = (OmsShopGoodsSku) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getShopId() == null ? other.getShopId() == null : this.getShopId().equals(other.getShopId()))
            && (this.getShopType() == null ? other.getShopType() == null : this.getShopType().equals(other.getShopType()))
            && (this.getProductId() == null ? other.getProductId() == null : this.getProductId().equals(other.getProductId()))
            && (this.getProductTitle() == null ? other.getProductTitle() == null : this.getProductTitle().equals(other.getProductTitle()))
            && (this.getOuterProductId() == null ? other.getOuterProductId() == null : this.getOuterProductId().equals(other.getOuterProductId()))
            && (this.getSkuName() == null ? other.getSkuName() == null : this.getSkuName().equals(other.getSkuName()))
            && (this.getSkuId() == null ? other.getSkuId() == null : this.getSkuId().equals(other.getSkuId()))
            && (this.getOuterSkuId() == null ? other.getOuterSkuId() == null : this.getOuterSkuId().equals(other.getOuterSkuId()))
            && (this.getSkuCode() == null ? other.getSkuCode() == null : this.getSkuCode().equals(other.getSkuCode()))
            && (this.getImg() == null ? other.getImg() == null : this.getImg().equals(other.getImg()))
            && (this.getPrice() == null ? other.getPrice() == null : this.getPrice().equals(other.getPrice()))
            && (this.getStockNum() == null ? other.getStockNum() == null : this.getStockNum().equals(other.getStockNum()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getSkuAttrs() == null ? other.getSkuAttrs() == null : this.getSkuAttrs().equals(other.getSkuAttrs()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()))
            && (this.getModifyTime() == null ? other.getModifyTime() == null : this.getModifyTime().equals(other.getModifyTime()))
            && (this.getErpGoodsId() == null ? other.getErpGoodsId() == null : this.getErpGoodsId().equals(other.getErpGoodsId()))
            && (this.getErpGoodsSkuId() == null ? other.getErpGoodsSkuId() == null : this.getErpGoodsSkuId().equals(other.getErpGoodsSkuId()))
            && (this.getErpStatus() == null ? other.getErpStatus() == null : this.getErpStatus().equals(other.getErpStatus()))
            && (this.getCreateOn() == null ? other.getCreateOn() == null : this.getCreateOn().equals(other.getCreateOn()))
            && (this.getUpdateOn() == null ? other.getUpdateOn() == null : this.getUpdateOn().equals(other.getUpdateOn()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getShopId() == null) ? 0 : getShopId().hashCode());
        result = prime * result + ((getShopType() == null) ? 0 : getShopType().hashCode());
        result = prime * result + ((getProductId() == null) ? 0 : getProductId().hashCode());
        result = prime * result + ((getProductTitle() == null) ? 0 : getProductTitle().hashCode());
        result = prime * result + ((getOuterProductId() == null) ? 0 : getOuterProductId().hashCode());
        result = prime * result + ((getSkuName() == null) ? 0 : getSkuName().hashCode());
        result = prime * result + ((getSkuId() == null) ? 0 : getSkuId().hashCode());
        result = prime * result + ((getOuterSkuId() == null) ? 0 : getOuterSkuId().hashCode());
        result = prime * result + ((getSkuCode() == null) ? 0 : getSkuCode().hashCode());
        result = prime * result + ((getImg() == null) ? 0 : getImg().hashCode());
        result = prime * result + ((getPrice() == null) ? 0 : getPrice().hashCode());
        result = prime * result + ((getStockNum() == null) ? 0 : getStockNum().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getSkuAttrs() == null) ? 0 : getSkuAttrs().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
        result = prime * result + ((getModifyTime() == null) ? 0 : getModifyTime().hashCode());
        result = prime * result + ((getErpGoodsId() == null) ? 0 : getErpGoodsId().hashCode());
        result = prime * result + ((getErpGoodsSkuId() == null) ? 0 : getErpGoodsSkuId().hashCode());
        result = prime * result + ((getErpStatus() == null) ? 0 : getErpStatus().hashCode());
        result = prime * result + ((getCreateOn() == null) ? 0 : getCreateOn().hashCode());
        result = prime * result + ((getUpdateOn() == null) ? 0 : getUpdateOn().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", shopId=").append(shopId);
        sb.append(", shopType=").append(shopType);
        sb.append(", productId=").append(productId);
        sb.append(", productTitle=").append(productTitle);
        sb.append(", outerProductId=").append(outerProductId);
        sb.append(", skuName=").append(skuName);
        sb.append(", skuId=").append(skuId);
        sb.append(", outerSkuId=").append(outerSkuId);
        sb.append(", skuCode=").append(skuCode);
        sb.append(", img=").append(img);
        sb.append(", price=").append(price);
        sb.append(", stockNum=").append(stockNum);
        sb.append(", status=").append(status);
        sb.append(", skuAttrs=").append(skuAttrs);
        sb.append(", addTime=").append(addTime);
        sb.append(", modifyTime=").append(modifyTime);
        sb.append(", erpGoodsId=").append(erpGoodsId);
        sb.append(", erpGoodsSkuId=").append(erpGoodsSkuId);
        sb.append(", erpStatus=").append(erpStatus);
        sb.append(", createOn=").append(createOn);
        sb.append(", updateOn=").append(updateOn);
        sb.append("]");
        return sb.toString();
    }
}