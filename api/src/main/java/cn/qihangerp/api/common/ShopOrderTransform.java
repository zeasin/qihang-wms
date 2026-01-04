package cn.qihangerp.api.common;

import cn.qihangerp.model.entity.OOrder;
import cn.qihangerp.model.entity.OOrderItem;
import cn.qihangerp.open.pdd.model.Order;
import cn.qihangerp.open.pdd.model.OrderItem;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ShopOrderTransform {

    public static OOrder transformDouOrder(cn.qihangerp.open.dou.model.order.Order order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getOrderId());
        shopOrder.setBuyerMemo(order.getBuyerWords());
        shopOrder.setSellerMemo(order.getSellerWords());
        shopOrder.setPlatformOrderStatus(order.getOrderStatus().toString());
        shopOrder.setPlatformOrderStatusText(order.getOrderStatusDesc());
        //订单状态 0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12退款中；21待付款；22锁定，29删除，101部分发货
        //订单状态 1 待确认/待支付（订单创建完毕）105 已支付 2 备货中 101 部分发货 3 已发货（全部发货）4 已取消5 已完成（已收货）
        if(order.getOrderStatus()==1){
            shopOrder.setOrderStatus(21);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==2){
            shopOrder.setOrderStatus(1);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==3){
            shopOrder.setOrderStatus(2);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==4){
            shopOrder.setOrderStatus(11);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==5){
            shopOrder.setOrderStatus(3);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==105){
            shopOrder.setOrderStatus(0);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==101){
            shopOrder.setOrderStatus(101);
            shopOrder.setRefundStatus(1);
        }

        // 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime createTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getCreateTime()), ZoneId.of("UTC"));
        LocalDateTime updateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getUpdateTime()), ZoneId.of("UTC"));
        LocalDateTime payTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getPayTime()), ZoneId.of("UTC"));
        LocalDateTime finishTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getFinishTime()), ZoneId.of("UTC"));

        shopOrder.setOrderCreated(createTime.format(formatter));
        shopOrder.setOrderUpdated(updateTime.format(formatter));
        shopOrder.setOrderPayTime(payTime.format(formatter));
        shopOrder.setOrderFinishTime(finishTime.format(formatter));

        // 价格
        Double orderAmount = order.getOrderAmount().doubleValue() / 100;
        Double postAmount = order.getPostAmount().doubleValue() / 100;
        Double payAmount = order.getPayAmount().doubleValue() / 100;
        Double modifyAmount = order.getModifyAmount().doubleValue() / 100;
        Double promotionShopAmount = order.getPromotionShopAmount().doubleValue() / 100;
        Double promotionPlatformAmount = order.getPromotionPlatformAmount().doubleValue() / 100;


        shopOrder.setGoodsAmount(orderAmount);
        shopOrder.setChangeAmount(modifyAmount);
        shopOrder.setPostFee(postAmount);
        shopOrder.setSellerDiscount(promotionShopAmount);
        shopOrder.setPlatformDiscount(promotionPlatformAmount);
        shopOrder.setPayment(payAmount);
        shopOrder.setServiceFee(0.0);
        shopOrder.setAmount(shopOrder.getPayment() - shopOrder.getServiceFee());
        // 收货地址
        shopOrder.setProvince(order.getMaskPostAddr().getProvince().getName());
        shopOrder.setCity(order.getMaskPostAddr().getCity().getName());
        shopOrder.setTown(order.getMaskPostAddr().getTown().getName());
        if(order.getOrderStatus()==2){
            shopOrder.setAddress(order.getMaskPostAddr().getDetail());
//            shopOrder.setReceiverName(order.getMaskPostReceiver());
            shopOrder.setReceiverName(order.getSkuOrderList().get(0).getMaskPostReceiver());
            shopOrder.setReceiverMobile(order.getMaskPostTel());
        }


        // 订单明细
        List<OOrderItem> itemList = new ArrayList<>();
        if (order.getSkuOrderList() != null) {
            for (cn.qihangerp.open.dou.model.order.OrderItem line : order.getSkuOrderList()) {

                OOrderItem item = new OOrderItem();
                item.setOrderNum(line.getParentOrderId());
                item.setSubOrderNum(line.getOrderId());
                item.setSkuId(line.getSkuId()+"");
                item.setGoodsTitle(line.getProductName());
                item.setGoodsImg(line.getProductPic());
                item.setGoodsNum(line.getOutProductId());
//                item.setGoodsSpec(line.getSpec());
                Integer price = line.getGoodsPrice();
                item.setGoodsPrice(price.doubleValue()/100);
                item.setSkuNum(line.getOutSkuId());
                Integer itemAmount =  line.getOrderAmount();
                item.setItemAmount(itemAmount.doubleValue()/100);
                Integer promotionAmount =line.getPromotionAmount();
                item.setDiscountAmount(promotionAmount.doubleValue()/100);
                Integer payment = line.getPayAmount();
                item.setPayment(payment.doubleValue()/100);
                item.setQuantity(line.getItemNum());
                //主流程状态，1 待确认/待支付（订单创建完毕）103 部分支付105 已支付2 备货中101 部分发货3 已发货（全部发货）4 已取消5 已完成（已收货）21 发货前退款完结22 发货后退款完结39 收货后退款完结
                if(line.getMainStatus() == 4 || line.getMainStatus() == 21 || line.getMainStatus() == 22 || line.getMainStatus() == 39){
                    item.setRefundCount(line.getItemNum());
                    item.setRefundStatus(4);
                }else{
                    item.setRefundCount(0);
                    item.setRefundStatus(1);
                }
                item.setOrderStatus(line.getOrderStatus());

                itemList.add(item);
            }
        }
        shopOrder.setItemList(itemList);
        return shopOrder;
    }

    public static OOrder transformPddOrder(cn.qihangerp.open.pdd.model.Order order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getOrderSn());
        shopOrder.setBuyerMemo(order.getBuyerMemo());
        shopOrder.setSellerMemo(order.getRemark());
        shopOrder.setRefundStatus(order.getRefundStatus());
        if(order.getRefundStatus()==1){
            shopOrder.setOrderStatus(order.getOrderStatus());
        }else{
            shopOrder.setOrderStatus(11);//已取消
        }
        shopOrder.setPlatformOrderStatus(order.getOrderStatus()+"");
        //发货状态，枚举值：1：待发货，2：已发货待签收，3：已签收
        if(order.getOrderStatus()==1){
            shopOrder.setPlatformOrderStatusText("待发货");
        }else if (order.getOrderStatus()==2){
            shopOrder.setPlatformOrderStatusText("已发货待签收");
        }else if (order.getOrderStatus()==3){
            shopOrder.setPlatformOrderStatusText("已签收");
        }
        shopOrder.setOrderCreated(order.getCreatedTime());
        shopOrder.setOrderUpdated(order.getUpdatedAt());
        shopOrder.setOrderPayTime(order.getPayTime());
        shopOrder.setOrderFinishTime(order.getReceiveTime());
        // 价格
        shopOrder.setGoodsAmount(order.getGoodsAmount());
        shopOrder.setChangeAmount(order.getOrderChangeAmount());
        shopOrder.setPostFee(order.getPostage());
        shopOrder.setSellerDiscount(order.getSellerDiscount());
        shopOrder.setPlatformDiscount(order.getPlatformDiscount());
        shopOrder.setPayment(order.getPayAmount());
        shopOrder.setServiceFee(0.0);
        shopOrder.setAmount(shopOrder.getPayment() - shopOrder.getServiceFee());
        // 收货地址
        shopOrder.setProvince(order.getProvince());
        shopOrder.setCity(order.getCity());
        shopOrder.setTown(order.getTown());
        if(order.getOrderStatus()==1){
            shopOrder.setAddress(order.getReceiverAddressMask());
            shopOrder.setReceiverName(order.getReceiverNameMask());
            shopOrder.setReceiverMobile(order.getReceiverPhoneMask());
        }


        // 订单明细
        List<OOrderItem> itemList = new ArrayList<>();
        if (order.getItemList() != null) {
            for (OrderItem line : order.getItemList()) {
                OOrderItem item = new OOrderItem();
                item.setOrderNum(shopOrder.getOrderNum());
                item.setSubOrderNum(shopOrder.getOrderNum()+"-"+line.getSkuId());
                item.setSkuId(line.getSkuId()+"");
                item.setGoodsTitle(line.getGoodsName());
                item.setGoodsImg(line.getGoodsImg());
                item.setGoodsNum(line.getOuterGoodsId());
                item.setGoodsSpec(line.getGoodsSpec());
                item.setGoodsPrice(line.getGoodsPrice());
                item.setSkuNum(line.getOuterId());
                item.setItemAmount(line.getGoodsPrice()*line.getGoodsCount());
                item.setDiscountAmount(0.0);
                item.setPayment(item.getItemAmount());
                item.setQuantity(line.getGoodsCount());
                item.setRefundStatus(order.getRefundStatus());
                if(order.getRefundStatus()==1){
                    item.setRefundCount(0);
                }else {
                    item.setRefundStatus(line.getGoodsCount());
                }
                item.setOrderStatus(order.getOrderStatus());

                itemList.add(item);
            }
        }
        shopOrder.setItemList(itemList);
        return shopOrder;
    }
}
