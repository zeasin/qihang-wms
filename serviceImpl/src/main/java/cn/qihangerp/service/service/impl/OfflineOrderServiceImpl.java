package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.ResultVo;
import cn.qihangerp.model.entity.*;
import cn.qihangerp.model.bo.OfflineOrderCreateBo;
import cn.qihangerp.model.bo.OfflineOrderCreateItemBo;
import cn.qihangerp.model.bo.OfflineOrderShipBo;
import cn.qihangerp.service.mapper.*;
import cn.qihangerp.service.service.OfflineOrderService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.common.mq.MqMessage;
import cn.qihangerp.common.mq.MqType;
import cn.qihangerp.common.mq.MqUtils;

import cn.qihangerp.model.request.OrderSearchRequest;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
* @author qilip
* @description 针对表【offline_order(线下渠道订单表)】的数据库操作Service实现
* @createDate 2024-07-27 23:03:38
*/
@AllArgsConstructor
@Service
public class OfflineOrderServiceImpl extends ServiceImpl<OfflineOrderMapper, OfflineOrder>
    implements OfflineOrderService {
    private final OOrderMapper orderMapper;
    private final OShopMapper shopMapper;
    private final OOrderItemMapper orderItemMapper;
    private final MqUtils mqUtils;




    /**
     * 新增订单
     *
     * @param bo 订单
     * @return 结果
     */
    @Transactional
    @Override
    public ResultVo<Long> insertOfflineOrder(OfflineOrderCreateBo bo, String createBy)
    {
        if(bo.getShopId()==null){
            return ResultVo.error("缺少参数：shopId");
        }
        if(StringUtils.isEmpty(bo.getOrderNum())) return ResultVo.error("缺少参数：orderNum");
        if(bo.getItemList()==null || bo.getItemList().isEmpty()) return ResultVo.error("缺少参数：订单商品List");
        else{
            // 循环查找是否缺少specId
            for (OfflineOrderCreateItemBo itemBo : bo.getItemList()) {
                if(itemBo.getSkuId()==null || itemBo.getQuantity()<=0) return ResultVo.error("请完善订单商品明细");
            }
        }
        OShop shop = shopMapper.selectById(bo.getShopId());
        if(shop == null){
            return ResultVo.error("店铺不存在");
        }

        List<OOrder> oOrders = orderMapper.selectList(new LambdaQueryWrapper<OOrder>()
                .eq(OOrder::getOrderNum, bo.getOrderNum())
                .eq(OOrder::getShopId,bo.getShopId()));

        if (oOrders!=null&& oOrders.size()>0) return ResultVo.error("订单号已存在");// 订单号已存在



        // 开始组合订单信息
        OOrder order = new OOrder();
        order.setOrderNum(bo.getOrderNum());
        order.setShopId(bo.getShopId());
        order.setShopType(shop.getType());
        order.setBuyerMemo(bo.getBuyerMemo());
        order.setRemark(bo.getRemark());
        order.setRefundStatus(1);
        order.setOrderStatus(1);
        order.setGoodsAmount(bo.getGoodsAmount());
        order.setPostFee(bo.getPostage());
        order.setAmount(bo.getGoodsAmount()+bo.getPostage());
        order.setSellerDiscount(bo.getSellerDiscount());
        order.setPlatformDiscount(0.0);
        order.setPayment(bo.getGoodsAmount()+bo.getPostage()-bo.getSellerDiscount());
        order.setReceiverName(bo.getReceiverName());
        order.setReceiverMobile(bo.getReceiverPhone());
        order.setProvince(bo.getProvince());
        order.setCity(bo.getCity());
        order.setTown(bo.getTown());
        order.setAddress(bo.getAddress());
        order.setOrderTime(new Date());
        order.setCreateTime(new Date());
        order.setShipType(0);
        order.setCreateBy(createBy);
        orderMapper.insert(order);

        for (int i = 0; i < bo.getItemList().size(); i++) {
            OfflineOrderCreateItemBo itemBo = bo.getItemList().get(i);
            OOrderItem orderItem = new OOrderItem();
            orderItem.setShopId(order.getShopId());
            orderItem.setShopType(order.getShopType());
            orderItem.setOrderId(order.getId());
            orderItem.setOrderNum(bo.getOrderNum());
            if(bo.getItemList().size()==1) {
                orderItem.setSubOrderNum(bo.getOrderNum());
            }else{
                orderItem.setSubOrderNum(bo.getOrderNum()+(i+1));
            }
            orderItem.setSkuId(itemBo.getSkuId());
            orderItem.setGoodsId(0L);
            orderItem.setGoodsSkuId(Long.parseLong(itemBo.getSkuId()));
            orderItem.setGoodsTitle(itemBo.getGoodsName());
            orderItem.setGoodsImg(itemBo.getGoodsImg());
            orderItem.setGoodsSpec(itemBo.getSkuName());
            orderItem.setSkuNum(itemBo.getSkuCode());
            orderItem.setGoodsPrice(itemBo.getSalePrice().doubleValue());
            orderItem.setItemAmount(itemBo.getItemAmount().doubleValue());
            orderItem.setPayment(itemBo.getItemAmount().doubleValue());
            orderItem.setQuantity(itemBo.getQuantity());
            orderItem.setRefundCount(0);
            orderItem.setRefundStatus(1);
            orderItem.setOrderStatus(order.getOrderStatus());
            orderItem.setCreateTime(new Date());
            orderItem.setCreateBy(createBy);
            orderItemMapper.insert(orderItem);
        }

        return ResultVo.success(Long.parseLong(order.getId()));
    }


}




