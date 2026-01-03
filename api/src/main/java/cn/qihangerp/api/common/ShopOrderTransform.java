package cn.qihangerp.api.common;

import cn.qihangerp.model.entity.OOrder;
import cn.qihangerp.model.entity.OOrderItem;
import cn.qihangerp.open.pdd.model.Order;
import cn.qihangerp.open.pdd.model.OrderItem;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ShopOrderTransform {

    public static OOrder transformPddOrder(Order order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getOrderSn());
        shopOrder.setBuyerMemo(order.getBuyerMemo());
        shopOrder.setSellerMemo(order.getRemark());
        shopOrder.setRefundStatus(order.getRefundStatus());
        shopOrder.setOrderStatus(order.getOrderStatus());
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
