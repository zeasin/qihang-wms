package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.enums.EnumStockOutType;
import cn.qihangerp.common.utils.DateUtils;
import cn.qihangerp.model.entity.*;
import cn.qihangerp.service.mapper.OGoodsMapper;
import cn.qihangerp.service.mapper.OGoodsSkuMapper;
import cn.qihangerp.service.mapper.OGoodsSupplierMapper;
import cn.qihangerp.model.bo.OrderAllocateShipRequest;
import cn.qihangerp.model.bo.OrderShipRequest;
import cn.qihangerp.model.vo.OrderDiscountVo;
import cn.qihangerp.model.vo.SalesDailyVo;
import cn.qihangerp.service.mapper.*;
import cn.qihangerp.service.service.OOrderService;
import cn.qihangerp.model.request.OrderSearchRequest;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.common.ResultVoEnum;
import cn.qihangerp.common.enums.EnumShopType;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
* @author qilip
* @description 针对表【o_order(订单表)】的数据库操作Service实现
* @createDate 2024-03-09 13:15:57
*/
@Slf4j
@AllArgsConstructor
@Service
public class OOrderServiceImpl extends ServiceImpl<OOrderMapper, OOrder>
    implements OOrderService {

    private final OOrderMapper orderMapper;
    private final OOrderItemMapper orderItemMapper;

    private final OmsShopGoodsSkuMapper shopGoodsSkuMapper;

    private final OGoodsMapper goodsMapper;
    private final OGoodsSkuMapper goodsSkuMapper;

    private final OGoodsSupplierMapper supplierMapper;

    private final OShipmentMapper shipmentMapper;
    private final OShipmentItemMapper shipmentItemMapper;

    private final OLogisticsCompanyMapper oLogisticsCompanyMapper;


    private final ErpStockOutMapper outMapper;
    private final ErpStockOutItemMapper outItemMapper;

//    private final PddApiService pddApiService;
//    private final TaoApiService taoApiService;
//    private final JdApiService jdApiService;
//    private final DouApiService douApiService;
//    private final WeiApiService weiApiService;


    private final String DATE_PATTERN =
            "^(?:(?:(?:\\d{4}-(?:0?[1-9]|1[0-2])-(?:0?[1-9]|1\\d|2[0-8]))|(?:(?:(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:(?:0[48]|[2468][048]|[13579][26])00))-0?2-29))$)|(?:(?:(?:\\d{4}-(?:0?[13578]|1[02]))-(?:0?[1-9]|[12]\\d|30))$)|(?:(?:(?:\\d{4}-0?[13-9]|1[0-2])-(?:0?[1-9]|[1-2]\\d|30))$)|(?:(?:(?:\\d{2}(?:0[48]|[13579][26]|[2468][048])|(?:(?:0[48]|[13579][26]|[2468][048])00))-0?2-29))$)$";
    private final Pattern DATE_FORMAT = Pattern.compile(DATE_PATTERN);

    @Override
    public PageResult<OOrder> queryPageList(OrderSearchRequest bo, PageQuery pageQuery) {
        if(org.springframework.util.StringUtils.hasText(bo.getStartTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getStartTime());
            boolean b = matcher.find();
            if(b){
                bo.setStartTime(bo.getStartTime()+" 00:00:00");
            }
        }
        if(org.springframework.util.StringUtils.hasText(bo.getEndTime())){
            Matcher matcher = DATE_FORMAT.matcher(bo.getEndTime());
            boolean b = matcher.find();
            if(b){
                bo.setEndTime(bo.getEndTime()+" 23:59:59");
            }
        }

        LambdaQueryWrapper<OOrder> queryWrapper = new LambdaQueryWrapper<OOrder>()
                .eq(bo.getShopId()!=null,OOrder::getShopId,bo.getShopId())
                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNum()),OOrder::getOrderNum,bo.getOrderNum())
                .eq(bo.getOrderStatus()!=null,OOrder::getOrderStatus,bo.getOrderStatus())
                .ge(org.springframework.util.StringUtils.hasText(bo.getStartTime()),OOrder::getOrderCreated,bo.getStartTime()+" 00:00:00")
                .le(org.springframework.util.StringUtils.hasText(bo.getEndTime()),OOrder::getOrderCreated,bo.getEndTime()+" 23:59:59")

//                .eq(org.springframework.util.StringUtils.hasText(bo.getReceiverName()),OOrder::getReceiverName,bo.getReceiverName())
//                .like(org.springframework.util.StringUtils.hasText(bo.getReceiverMobile()),OOrder::getReceiverMobile,bo.getReceiverMobile())
                ;
//        if(bo.getErpPushStatus()!=null) {
//            if (bo.getErpPushStatus() == 0) {
//                // 未推送
//                queryWrapper.eq(OOrder::getErpPushResult, 0);
//            } else if (bo.getErpPushStatus() == 200) {
//                // 推送成功
//                queryWrapper.eq(OOrder::getErpPushResult, 200);
//            } else if (bo.getErpPushStatus() == 500) {
//                // 推送失败
//                queryWrapper.gt(OOrder::getErpPushResult, 200);
//            }
//        }
//        pageQuery.setOrderByColumn("order_time");
//        pageQuery.setIsAsc("desc");
        Page<OOrder> pages = orderMapper.selectPage(pageQuery.build(), queryWrapper);

        // 查询子订单
        if(pages.getRecords()!=null){
            for (OOrder order:pages.getRecords()) {
//                order.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<OOrderItem>().eq(OOrderItem::getOrderId, order.getId())));
                order.setItemVoList(orderItemMapper.selectOrderItemListByOrderId(Long.parseLong(order.getId())));
            }
        }

        return PageResult.build(pages);
    }
    /**
     * 获取待发货list（去除处理过的）
     * @param bo
     * @param pageQuery
     * @return
     */
    @Override
    public PageResult<OOrder> queryWaitShipmentPageList(OrderSearchRequest bo, PageQuery pageQuery) {

        LambdaQueryWrapper<OOrder> queryWrapper = new LambdaQueryWrapper<OOrder>()
                .eq(bo.getShopId()!=null,OOrder::getShopId,bo.getShopId())
                .eq(bo.getShopType()!=null,OOrder::getShopType,bo.getShopType())
                .eq(OOrder::getOrderStatus,1)
                .eq(OOrder::getRefundStatus,1)
                .eq(OOrder::getShipStatus,0)//发货状态 0 待发货 1 已分配供应商发货 2全部发货
//                .lt(ErpOrder::getShipType,2)//ship_type发货方式 0 自己发货1联合发货2供应商发货
                .ge(org.springframework.util.StringUtils.hasText(bo.getStartTime()),OOrder::getOrderCreated,bo.getStartTime())
                .le(org.springframework.util.StringUtils.hasText(bo.getEndTime()),OOrder::getOrderCreated,bo.getEndTime())
                .eq(org.springframework.util.StringUtils.hasText(bo.getOrderNum()),OOrder::getOrderNum,bo.getOrderNum())
                ;
        Page<OOrder> pages = orderMapper.selectPage(pageQuery.build(), queryWrapper);

        // 查询子订单
        if(pages.getRecords()!=null){
            for (OOrder order:pages.getRecords()) {
                order.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<OOrderItem>()
                                .eq(OOrderItem::getOrderId, order.getId())
                                .eq(OOrderItem::getShipStatus,0)
//                        .eq(ErpOrderItem::getShipType,0)
                ));
            }
        }

        return PageResult.build(pages);
    }





    @Override
    public OOrder queryDetailById(Long id) {
        OOrder oOrder = orderMapper.selectById(id);
        if(oOrder!=null) {
//           oOrder.setItemList(orderItemMapper.selectList(new LambdaQueryWrapper<OOrderItem>().eq(OOrderItem::getOrderId, oOrder.getId())));

            oOrder.setItemVoList(orderItemMapper.selectOrderItemListByOrderId(id));
             //获取优惠信息
            if(oOrder.getShopType()==EnumShopType.TAO.getIndex()){
                oOrder.setDiscounts(orderMapper.getTaoOrderDiscount(oOrder.getOrderNum()));
            } else if (oOrder.getShopType()==EnumShopType.JD.getIndex()) {
                oOrder.setDiscounts(orderMapper.getJdOrderDiscount(oOrder.getOrderNum()));
            }else if (oOrder.getShopType()==EnumShopType.PDD.getIndex()) {
                List<OrderDiscountVo> discountVoList = new ArrayList<>();
                if(oOrder.getPlatformDiscount()!=null&& oOrder.getPlatformDiscount()>0){
                    OrderDiscountVo vo = new OrderDiscountVo();
                    vo.setName("平台优惠");
                    vo.setDiscountAmount(oOrder.getPlatformDiscount().toString());
                    vo.setDescription("平台优惠");
                    discountVoList.add(vo);
                    oOrder.setDiscounts(discountVoList);
                }
            }else if (oOrder.getShopType()==EnumShopType.DOU.getIndex()) {
                List<OrderDiscountVo> discountVoList = new ArrayList<>();
                if(oOrder.getPlatformDiscount()!=null&& oOrder.getPlatformDiscount()>0){
                    OrderDiscountVo vo = new OrderDiscountVo();
                    vo.setName("平台优惠");
                    vo.setDiscountAmount(oOrder.getPlatformDiscount().toString());
                    vo.setDescription("平台优惠");
                    discountVoList.add(vo);
                    oOrder.setDiscounts(discountVoList);
                }
            }
        }

        return oOrder;
    }



    @Override
    public List<SalesDailyVo> salesDaily() {
        return orderMapper.salesDaily();
    }
    @Override
    public SalesDailyVo getTodaySalesDaily() {
        return orderMapper.getTodaySalesDaily();
    }

    @Override
    public Integer getWaitShipOrderAllCount() {
        return orderMapper.getWaitShipOrderAllCount();
    }



    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo cancelOrder(Long id, String cancelReason, String man) {
        OOrder shopOrder = this.baseMapper.selectById(id);
        if (shopOrder == null) return ResultVo.error("找不到订单数据");
        else if (shopOrder.getOrderStatus().intValue() == 3) return ResultVo.error("已完成的单不可以取消");

        // 取消订单
        OOrder update = new OOrder();
        update.setId(id.toString());
        update.setCancelReason(cancelReason);
        update.setUpdateBy(man + " 操作取消订单");
        update.setUpdateTime(new Date());
        update.setOrderStatus(11);
        this.baseMapper.updateById(update);

        // 更新子订单order_status字段值
        OOrderItem itemUpdate = new OOrderItem();
        itemUpdate.setOrderStatus(11);
        itemUpdate.setUpdateBy(update.getUpdateBy());
        itemUpdate.setUpdateTime(new Date());
        orderItemMapper.update(itemUpdate, new LambdaQueryWrapper<OOrderItem>().eq(OOrderItem::getOrderId, id));

        // 取消发货订单
//        List<OOrderStocking> oOrderStockings = oOrderStockingMapper.selectList(new LambdaQueryWrapper<OOrderStocking>().eq(OOrderStocking::getOOrderId, oOrder.getId()));
//        if (!oOrderStockings.isEmpty()) {
//            for (OOrderStocking oOrderStocking : oOrderStockings) {
//                OOrderStocking oOrderStockingUpdate = new OOrderStocking();
//                oOrderStockingUpdate.setId(oOrderStocking.getId());
//                oOrderStockingUpdate.setOrderStatus(11);
//                oOrderStockingUpdate.setUpdateBy("取消订单");
//                oOrderStockingUpdate.setUpdateTime(new Date());
//                oOrderStockingMapper.updateById(oOrderStockingUpdate);
//            }
//        }

        return ResultVo.success();
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo cancelOrderItem(Long orderItemId, String cancelReason, String man) {
        OOrderItem shopOrderItem = orderItemMapper.selectById(orderItemId);
        if(shopOrderItem==null) return ResultVo.error("找不到子订单数据");
        else if(shopOrderItem.getRefundStatus().intValue()!=1) return ResultVo.error("售后中的子订单单不可以取消");

        OOrder shopOrder = this.baseMapper.selectById(shopOrderItem.getOrderId());
        if(shopOrder==null) return ResultVo.error("找不到订单数据");
        else if(shopOrder.getOrderStatus().intValue()==3) return ResultVo.error("已完成的单不可以取消");

        // 取消子订单
        OOrderItem orderItemUpdate = new OOrderItem();
        orderItemUpdate.setId(orderItemId.toString());
        orderItemUpdate.setRefundStatus(4);//售后完成
        orderItemUpdate.setUpdateBy("主动取消");
        orderItemUpdate.setUpdateTime(new Date());
        orderItemMapper.updateById(orderItemUpdate);


        // 判断子订单是否全部取消，全部取消把该订单也取消
        List<OOrderItem> offlineOrderItems = orderItemMapper.selectList(new LambdaQueryWrapper<OOrderItem>()
                .eq(OOrderItem::getOrderId, shopOrder.getId())
                .eq(OOrderItem::getRefundStatus, 1));

        if(offlineOrderItems.isEmpty()) {
            // 全部退款了  ，， 更新订单状态为已关闭
            // 1、取消订单
            OOrder update = new OOrder();
            update.setId(shopOrder.getId());
            update.setCancelReason(cancelReason);
            update.setUpdateBy(man+" 操作取消子订单");
            update.setUpdateTime(new Date());
            update.setOrderStatus(11);
            this.baseMapper.updateById(update);



            // 取消发货订单
//            List<OOrderStocking> oOrderStockings = oOrderStockingMapper.selectList(new LambdaQueryWrapper<OOrderStocking>().eq(OOrderStocking::getOOrderId, oOrderUpdate.getId()));
//            if(!oOrderStockings.isEmpty()){
//                for(OOrderStocking oOrderStocking : oOrderStockings){
//                    OOrderStocking oOrderStockingUpdate = new OOrderStocking();
//                    oOrderStockingUpdate.setId(oOrderStocking.getId());
//                    oOrderStockingUpdate.setOrderStatus(11);
//                    oOrderStockingUpdate.setUpdateBy("取消子订单");
//                    oOrderStockingUpdate.setUpdateTime(new Date());
//                    oOrderStockingMapper.updateById(oOrderStockingUpdate);
//                }
//            }


        }

        return ResultVo.success();
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo saveShopOrder(OOrder order) {
        if(order.getShopId()==null) return ResultVo.error("缺少参数：shopId");
        if(order.getShopType()==null) return ResultVo.error("缺少参数：shopType");
        if(order.getItemList()==null||order.getItemList().isEmpty()) return ResultVo.error("缺少参数：itemList");
        if(StringUtils.isEmpty(order.getOrderNum())) return ResultVo.error("缺少参数：orderNum");
        Long orderId = null;
        List<OOrder> oOrders = this.baseMapper.selectList(new LambdaQueryWrapper<OOrder>()
                .eq(OOrder::getOrderNum, order.getOrderNum())
                .eq(OOrder::getShopId, order.getShopId()));
        if(oOrders.isEmpty()){
            // 新增
            order.setCreateTime(new Date());
            this.baseMapper.insert(order);
            orderId = Long.parseLong(order.getId());
        }else{
            order.setUpdateTime(new Date());
            order.setId(oOrders.get(0).getId());
            orderId = Long.parseLong(order.getId());
            this.baseMapper.updateById(order);
        }

        //保存item
        for(OOrderItem orderItem : order.getItemList()){
            orderItem.setOrderId(orderId.toString());
            orderItem.setShopId(order.getShopId());
            orderItem.setShopType(order.getShopType());
            // 查询店铺商品sku
            List<OmsShopGoodsSku> omsShopGoodsSkus = shopGoodsSkuMapper.selectList(new LambdaQueryWrapper<OmsShopGoodsSku>()
                    .eq(OmsShopGoodsSku::getSkuId, orderItem.getSkuId())
                    .eq(OmsShopGoodsSku::getShopId, orderItem.getShopId()));
            if(!omsShopGoodsSkus.isEmpty()){
                orderItem.setGoodsId(0L);
                orderItem.setGoodsSkuId(omsShopGoodsSkus.get(0).getId());
            }else{
                orderItem.setGoodsId(0L);
                orderItem.setGoodsSkuId(0L);
            }

            List<OOrderItem> oOrderItems = orderItemMapper.selectList(new LambdaQueryWrapper<OOrderItem>()
                    .eq(OOrderItem::getOrderId, order.getId())
                    .eq(OOrderItem::getSkuId, orderItem.getSkuId()));
            if(oOrderItems.isEmpty()){
                // 新增items
                orderItem.setCreateTime(new Date());
                orderItemMapper.insert(orderItem);
            }else{
                orderItem.setId(oOrderItems.get(0).getId());
                orderItem.setUpdateTime(new Date());
                orderItemMapper.updateById(orderItem);
            }
        }

        return ResultVo.success();
    }

//    /**
//     * 新增订单
//     *
//     * @param bo 订单
//     * @return 结果
//     */
//    @Transactional
//    @Override
//    public int insertErpOrder(OrderCreateBo bo,String createBy)
//    {
//        List<OOrder> oOrders = orderMapper.selectList(new LambdaQueryWrapper<OOrder>().eq(OOrder::getOrderNum, bo.getOrderNum()));
//
//        if (oOrders!=null&& oOrders.size()>0) return -1;// 订单号已存在
////        erpOrder.setCreateTime(DateUtils.getNowDate());
////        int rows = erpOrderMapper.insertErpOrder(erpOrder);
////        insertErpOrderItem(erpOrder);
////        return rows;
//        if(bo.getItemList() == null || bo.getItemList().size() == 0) return -2;
//        else{
//            // 循环查找是否缺少specId
//            for (OrderCreateItemBo itemBo : bo.getItemList()) {
//                if(itemBo.getSkuId()==null || itemBo.getQuantity()<=0) return -3;
//            }
//        }
//
//        OShop shop = shopMapper.selectById(bo.getShopId());
//        Integer shopType = 0;
//        if(shop!=null){
//            shopType = shop.getType();
//        }else return -4;
//
//        // 开始组合订单信息
//        OOrder order = new OOrder();
//        order.setOrderNum(bo.getOrderNum());
//        order.setShopId(bo.getShopId());
//        order.setShopType(shopType);
//        order.setBuyerMemo(bo.getBuyerMemo());
//        order.setRemark(bo.getRemark());
//        order.setRefundStatus(1);
//        order.setOrderStatus(1);
//        order.setGoodsAmount(bo.getGoodsAmount());
//        order.setPostFee(bo.getPostage());
//        order.setAmount(bo.getGoodsAmount()+bo.getPostage());
//        order.setSellerDiscount(bo.getSellerDiscount());
//        order.setPlatformDiscount(0.0);
//        order.setPayment(bo.getGoodsAmount()+bo.getPostage()-bo.getSellerDiscount());
//        order.setReceiverName(bo.getReceiverName());
//        order.setReceiverMobile(bo.getReceiverPhone());
//        order.setProvince(bo.getProvince());
//        order.setCity(bo.getCity());
//        order.setTown(bo.getTown());
//        order.setAddress(bo.getAddress());
//        order.setOrderTime(new Date());
//
//        order.setCreateTime(new Date());
//        order.setShipType(0);
//        order.setErpPushStatus(0);
//        order.setCreateBy(createBy);
//
//        orderMapper.insert(order);
//
////        List<OOrderItem> itemList = new ArrayList<OOrderItem>();
//        for (int i = 0; i < bo.getItemList().size(); i++) {
//            OrderCreateItemBo itemBo = bo.getItemList().get(i);
//            OOrderItem orderItem = new OOrderItem();
//
//            orderItem.setOrderId(order.getId());
//            orderItem.setOrderNum(bo.getOrderNum());
//            if(bo.getItemList().size()==1) {
//                orderItem.setSubOrderNum(bo.getOrderNum());
//            }else{
//                orderItem.setSubOrderNum(bo.getOrderNum()+(i+1));
//            }
//            orderItem.setSkuId(itemBo.getSkuId());
//            orderItem.setGoodsId(0L);
//            orderItem.setGoodsSkuId(Long.parseLong(itemBo.getSkuId()));
//            orderItem.setGoodsTitle(itemBo.getGoodsName());
//            orderItem.setGoodsImg(itemBo.getGoodsImg());
//            orderItem.setGoodsSpec(itemBo.getSkuName());
//            orderItem.setSkuNum(itemBo.getSkuCode());
//            orderItem.setGoodsPrice(itemBo.getGoodsPrice().doubleValue());
//            orderItem.setItemAmount(itemBo.getItemAmount().doubleValue());
//            orderItem.setPayment(itemBo.getItemAmount().doubleValue());
//            orderItem.setQuantity(itemBo.getQuantity());
//            orderItem.setRefundCount(0);
//            orderItem.setRefundStatus(1);
//            orderItem.setOrderStatus(order.getOrderStatus());
//            orderItem.setHasPushErp(0);
//            orderItem.setCreateTime(new Date());
//            orderItem.setCreateBy(createBy);
//            orderItemMapper.insert(orderItem);
////            itemList.add(orderItem);
//        }
//
//        return 1;
//    }


    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo<Long> generateStockOutEntryByShipOrderId(Long shipOrderId) {
        OOrder oOrder = orderMapper.selectById(shipOrderId);
        if(oOrder==null) return ResultVo.error("订单数据不存在");
        if(oOrder.getOrderStatus()==11) return ResultVo.error("已取消的订单不能操作");
        if(oOrder.getShipStatus()==2) return ResultVo.error("已出库的订单不能操作");

        List<OOrderItem> oOrderItems = orderItemMapper.selectList(new LambdaQueryWrapper<OOrderItem>().eq(OOrderItem::getOrderId, shipOrderId).eq(OOrderItem::getShipStatus, 0));
        if(oOrderItems.isEmpty()){
            // 都发货了，更新订单状态
            OOrder update = new OOrder();
            update.setId(shipOrderId.toString());
            update.setShipStatus(2);//全部出库
            update.setUpdateTime(new Date());
            orderMapper.updateById(update);
            return ResultVo.error("没有要出库的订单item");
        }
        //统计出库总数量
        int sum = oOrderItems.stream().mapToInt(OOrderItem::getQuantity).sum();
        // 开始生成出库单

        // 组合出库单子表
        List<ErpStockOutItem> itemList = new ArrayList<>();

        for (OOrderItem item : oOrderItems) {
            if(item.getGoodsSkuId()==null||item.getGoodsSkuId()==0){
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                log.error("======出库错误：订单明细没有找到SkuId:{}",item.getSkuId());
                return ResultVo.error("订单明细没有找到SkuId:"+item.getId());
            }
            ErpStockOutItem outItem = new ErpStockOutItem();
            outItem.setStockOutType(EnumStockOutType.DDCK.getIndex());
            outItem.setSourceOrderId(item.getOrderId());
            outItem.setSourceOrderItemId(item.getId());
            outItem.setSourceOrderNum(item.getOrderNum());
            outItem.setSourceSubOrderNum(item.getSubOrderNum());
            outItem.setGoodsId(item.getGoodsId());
            outItem.setSpecId(item.getGoodsSkuId());
            outItem.setSpecNum(item.getSkuNum());
            outItem.setOriginalQuantity(item.getQuantity());
            outItem.setOutQuantity(0);
            outItem.setStatus(0);
            outItem.setCreateTime(new Date());
            itemList.add(outItem);

            // 更新自己
            OOrderItem itemUpdate = new OOrderItem();
            itemUpdate.setId(item.getId());
            itemUpdate.setShipStatus(2);//备货完成
            itemUpdate.setUpdateBy("出库备货");
            itemUpdate.setUpdateTime(new Date());
            orderItemMapper.updateById(itemUpdate);
        }
        //添加主表信息
        ErpStockOut insert = new ErpStockOut();
        insert.setStockOutNum("DDCK-"+ DateUtils.parseDateToStr("yyyyMMddHHmmss",new Date()));
        insert.setStockOutType(EnumStockOutType.DDCK.getIndex());
        insert.setSourceNum(oOrder.getOrderNum());
        insert.setSourceId(oOrder.getId());
        insert.setRemark("订单生成出库单");
        insert.setCreateBy("订单生成出库单");
        insert.setCreateTime(new Date());
        insert.setGoodsUnit(oOrderItems.size());
        insert.setSpecUnit(oOrderItems.size());
        insert.setSpecUnitTotal(sum);
        insert.setOutTotal(0);
        insert.setOperatorId(0L);
        insert.setOperatorName("");
        insert.setPrintStatus(0);
        insert.setStatus(0);//状态：0待出库1部分出库2全部出库
        outMapper.insert(insert);

        itemList.forEach(oItem -> {
            oItem.setEntryId(insert.getId());
            outItemMapper.insert(oItem);
        });

        // 更新发货订单
        OOrder orderUpdate = new OOrder();
        orderUpdate.setId(shipOrderId.toString());
        orderUpdate.setShipStatus(2);
        orderUpdate.setUpdateTime(new Date());
        orderUpdate.setUpdateBy("生成出库单");
        orderMapper.updateById(orderUpdate);
        return ResultVo.success();
    }
}




