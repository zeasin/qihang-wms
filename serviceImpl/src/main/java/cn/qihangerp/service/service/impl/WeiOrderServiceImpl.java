package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.common.ResultVoEnum;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.mapper.ErpOrderItemMapper;
import cn.qihangerp.mapper.ErpOrderMapper;
import cn.qihangerp.model.entity.OOrder;
import cn.qihangerp.model.entity.OOrderItem;
import cn.qihangerp.model.entity.WeiGoodsSku;
import cn.qihangerp.model.entity.WeiOrder;
import cn.qihangerp.model.entity.WeiOrderItem;
import cn.qihangerp.model.bo.WeiOrderConfirmBo;
import cn.qihangerp.service.mapper.WeiGoodsSkuMapper;
import cn.qihangerp.service.mapper.WeiOrderItemMapper;
import cn.qihangerp.service.mapper.WeiOrderMapper;
import cn.qihangerp.service.service.WeiOrderService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
* @author TW
* @description 针对表【oms_wei_order】的数据库操作Service实现
* @createDate 2024-06-03 16:48:31
*/
@AllArgsConstructor
@Service
public class WeiOrderServiceImpl extends ServiceImpl<WeiOrderMapper, WeiOrder>
    implements WeiOrderService {
    private final WeiOrderMapper mapper;
    private final WeiOrderItemMapper itemMapper;
    private final WeiGoodsSkuMapper goodsSkuMapper;
    private final ErpOrderMapper erpOrderMapper;
    private final ErpOrderItemMapper erpOrderItemMapper;
//    private final MQClientService mqClientService;

    @Override
    public PageResult<WeiOrder> queryPageList(WeiOrder bo, PageQuery pageQuery) {
        LambdaQueryWrapper<WeiOrder> queryWrapper = new LambdaQueryWrapper<WeiOrder>()
                .eq(bo.getShopId()!=null, WeiOrder::getShopId,bo.getShopId())
                .eq(StringUtils.hasText(bo.getOrderId()), WeiOrder::getOrderId,bo.getOrderId())
                .eq(bo.getStatus()!=null, WeiOrder::getStatus,bo.getStatus())
                ;
        if(bo.getErpSendStatus()!=null){
            if(bo.getErpSendStatus()==-1) {
                queryWrapper.lt(WeiOrder::getErpSendStatus,3);
            }else {
                queryWrapper.eq(WeiOrder::getErpSendStatus, bo.getErpSendStatus());
            }
        }

        Page<WeiOrder> page = mapper.selectPage(pageQuery.build(), queryWrapper);
        if(page.getRecords()!=null){
            for (var order:page.getRecords()) {
                order.setItems(itemMapper.selectList(new LambdaQueryWrapper<WeiOrderItem>().eq(WeiOrderItem::getOrderId,order.getOrderId())));
            }
        }
        return PageResult.build(page);
    }

    @Transactional
    @Override
    public ResultVo<Integer> saveOrder(Long shopId, WeiOrder order) {
        try {
            List<WeiOrder> orders = mapper.selectList(new LambdaQueryWrapper<WeiOrder>().eq(WeiOrder::getOrderId, order.getOrderId()));
            if (orders != null && orders.size() > 0) {
                // 存在，修改
                WeiOrder update = new WeiOrder();
                update.setId(orders.get(0).getId());
                update.setOrderId(order.getOrderId());
                update.setStatus(order.getStatus());
                update.setUpdateTime(order.getUpdateTime());
                update.setPayInfo(order.getPayInfo());
                update.setAftersaleDetail(order.getAftersaleDetail());
                update.setDeliveryProductInfo(order.getDeliveryProductInfo());

                mapper.updateById(update);
                // 更新item
                for (var item : order.getItems()) {
                    List<WeiOrderItem> taoOrderItems = itemMapper.selectList(
                            new LambdaQueryWrapper<WeiOrderItem>().eq(WeiOrderItem::getSkuId, item.getSkuId()).eq(WeiOrderItem::getOrderId,order.getOrderId())
                    );

                    if (taoOrderItems != null && taoOrderItems.size() > 0) {
                        // 更新
                        WeiOrderItem itemUpdate = new WeiOrderItem();
                        itemUpdate.setId(taoOrderItems.get(0).getId());
                        List<WeiGoodsSku> skus = goodsSkuMapper.selectList(new LambdaQueryWrapper<WeiGoodsSku>().eq(WeiGoodsSku::getSkuId, item.getSkuId()));
                        if (skus != null && !skus.isEmpty()) {
                            itemUpdate.setOGoodsId(skus.get(0).getErpGoodsId());
                            itemUpdate.setOGoodsSkuId(skus.get(0).getErpGoodsSkuId());
                        }
                        itemMapper.updateById(itemUpdate);
                    } else {
                        // 新增
                        List<WeiGoodsSku> skus = goodsSkuMapper.selectList(new LambdaQueryWrapper<WeiGoodsSku>().eq(WeiGoodsSku::getSkuId, item.getSkuId()));
                        if (skus != null && !skus.isEmpty()) {
                            item.setOGoodsId(skus.get(0).getErpGoodsId());
                            item.setOGoodsSkuId(skus.get(0).getErpGoodsSkuId());
                        }
                        item.setShopId(shopId);
                        item.setOrderId(order.getOrderId());
                        itemMapper.insert(item);
                    }
                }
                return ResultVo.error(ResultVoEnum.DataExist, "订单已经存在，更新成功");
            } else {
                // 不存在，新增

                order.setShopId(shopId);
                mapper.insert(order);
                // 添加item
                for (var item : order.getItems()) {
                    List<WeiGoodsSku> skus = goodsSkuMapper.selectList(new LambdaQueryWrapper<WeiGoodsSku>().eq(WeiGoodsSku::getSkuId, item.getSkuId()));
                    if (skus != null && !skus.isEmpty()) {
                        item.setOGoodsId(skus.get(0).getErpGoodsId());
                        item.setOGoodsSkuId(skus.get(0).getErpGoodsSkuId());
                    }
                    item.setShopId(shopId);
                    item.setOrderId(order.getOrderId());
                    itemMapper.insert(item);
                }
                return ResultVo.success();
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultVo.error(ResultVoEnum.SystemException, "系统异常：" + e.getMessage());
        }
    }


    @Override
    public WeiOrder queryDetailById(Long id) {
        WeiOrder weiOrder = mapper.selectById(id);
        if(weiOrder!=null){
            weiOrder.setItems(itemMapper.selectList(new LambdaQueryWrapper<WeiOrderItem>().eq(WeiOrderItem::getOrderId,weiOrder.getOrderId())));
        }
        return weiOrder;
    }
    @Override
    public WeiOrder queryDetailByOrderId(String orderId) {
        List<WeiOrder> weiOrders = mapper.selectList(new LambdaQueryWrapper<WeiOrder>().eq(WeiOrder::getOrderId,orderId));
        if(weiOrders!=null&&weiOrders.size()>0){
            weiOrders.get(0).setItems(itemMapper.selectList(new LambdaQueryWrapper<WeiOrderItem>().eq(WeiOrderItem::getOrderId,orderId)));
            return weiOrders.get(0);
        }else return null;
    }
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo<Long> confirmOrder(WeiOrderConfirmBo confirmBo) {
        WeiOrder pddOrder = mapper.selectById(confirmBo.getOrderId());
        if(pddOrder==null) return ResultVo.error("订单数据不存在");
        if(pddOrder.getAuditStatus()!=0) return ResultVo.error("已经确认过了！");

        List<WeiOrderItem> pddOrderItems = itemMapper.selectList(
                new LambdaQueryWrapper<WeiOrderItem>()
                        .eq(WeiOrderItem::getOrderId, pddOrder.getOrderId()));
        if(pddOrderItems==null || pddOrderItems.isEmpty()){
            return ResultVo.error("找不到订单item");
        }

        OOrder erpOrder = erpOrderMapper.selectOne(new LambdaQueryWrapper<OOrder>().eq(OOrder::getOrderNum,pddOrder.getOrderId()));
        if(erpOrder!=null) {
            // 已经确认过了，更新自己
            WeiOrder douOrderUpdate = new WeiOrder();
            douOrderUpdate.setId(pddOrder.getId());
            douOrderUpdate.setAuditStatus(1);
            douOrderUpdate.setAuditTime(new Date());
            mapper.updateById(douOrderUpdate);

            return ResultVo.error("已经确认过了");
        }
        OOrder order = new OOrder();
        order.setOrderNum(pddOrder.getOrderId());
        order.setShopType(EnumShopType.WEI.getIndex());
        order.setShopId(pddOrder.getShopId());
//        order.setShipType(confirmBo.getShipType());
        order.setShipType(0);
        order.setBuyerMemo("");
        order.setSellerMemo("");
        order.setRefundStatus(1);
        order.setOrderStatus(1);
        order.setGoodsAmount(pddOrder.getProductPrice()!=null?pddOrder.getProductPrice().doubleValue()/100:0.0);
        order.setPostFee(pddOrder.getFreight()!=null?pddOrder.getFreight().doubleValue()/100:0.0);
        order.setSellerDiscount(pddOrder.getDiscountedPrice()!=null?pddOrder.getDiscountedPrice().doubleValue()/100:0.0);
        order.setPlatformDiscount(0.0);
        order.setAmount(pddOrder.getOrderPrice()!=null?pddOrder.getOrderPrice().doubleValue()/100:0.0);
        order.setPayment(order.getAmount());
        order.setReceiverName(confirmBo.getReceiver());
        order.setReceiverMobile(confirmBo.getMobile());
        order.setAddress(confirmBo.getAddress());
        order.setProvince(confirmBo.getProvince());
        order.setCity(confirmBo.getCity());
        order.setTown(confirmBo.getTown());
        order.setOrderTime(pddOrder.getCreateTime()!=null?new Date(pddOrder.getCreateTime()*1000):new Date());
        order.setShipper(0L);
        order.setShipStatus(0);
        order.setCreateTime(new Date());
        order.setCreateBy("手动确认订单");
        erpOrderMapper.insert(order);
        //插入item
        for (var item : pddOrderItems) {
            OOrderItem oOrderItem = new OOrderItem();
            oOrderItem.setOrderId(order.getId());
            oOrderItem.setOrderNum(order.getOrderNum());
            oOrderItem.setSubOrderNum(order.getOrderNum()+"-"+item.getSkuId());
            oOrderItem.setShopType(EnumShopType.WEI.getIndex());
            oOrderItem.setShopId(pddOrder.getShopId());
            oOrderItem.setSkuId(item.getSkuId());
            oOrderItem.setGoodsId(item.getOGoodsId()!=null?item.getOGoodsId():0L);
            oOrderItem.setGoodsSkuId(item.getOGoodsSkuId()!=null?item.getOGoodsSkuId():0L);
            oOrderItem.setGoodsTitle(item.getTitle());
            oOrderItem.setGoodsImg(item.getThumbImg());
            oOrderItem.setGoodsNum(item.getOutProductId());
            oOrderItem.setGoodsSpec("");
            oOrderItem.setSkuNum(item.getOutSkuId());
            oOrderItem.setGoodsPrice(item.getSalePrice()!=null?item.getSalePrice().doubleValue()/100:0.0);
            oOrderItem.setQuantity(item.getSkuCnt());
            oOrderItem.setItemAmount(oOrderItem.getGoodsPrice()*oOrderItem.getQuantity());
            oOrderItem.setDiscountAmount(0.0);
            oOrderItem.setPayment(0.0);

            oOrderItem.setRefundCount(0);
            oOrderItem.setRefundStatus(1);
            oOrderItem.setShipper(0L);
            oOrderItem.setShipType(order.getShipType());
            oOrderItem.setShipStatus(0);
            oOrderItem.setCreateTime(new Date());
            oOrderItem.setCreateBy("手动确认订单");
            erpOrderItemMapper.insert(oOrderItem);
        }
        // 更新自己
        WeiOrder douOrderUpdate = new WeiOrder();
        douOrderUpdate.setId(pddOrder.getId());
        douOrderUpdate.setAuditStatus(1);
        douOrderUpdate.setAuditTime(new Date());
        mapper.updateById(douOrderUpdate);
        return ResultVo.success();
    }
}




