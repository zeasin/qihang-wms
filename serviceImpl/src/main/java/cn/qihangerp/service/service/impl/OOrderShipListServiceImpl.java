package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;

import cn.qihangerp.common.enums.EnumStockOutType;
import cn.qihangerp.common.utils.DateUtils;
import cn.qihangerp.mapper.ErpStockOutItemMapper;
import cn.qihangerp.mapper.ErpStockOutMapper;
import cn.qihangerp.model.bo.ShipStockUpBo;
import cn.qihangerp.model.entity.*;
import cn.qihangerp.model.bo.SupplierOrderShipBo;
import cn.qihangerp.service.mapper.*;
import cn.qihangerp.service.service.OOrderShipListService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
* @author qilip
* @description 针对表【o_order_ship_list(发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）)】的数据库操作Service实现
* @createDate 2025-05-24 16:03:35
*/
@Slf4j
@AllArgsConstructor
@Service
public class OOrderShipListServiceImpl extends ServiceImpl<OOrderShipListMapper, OOrderShipList>
    implements OOrderShipListService{
    private final OOrderShipListItemMapper shipListItemMapper;
    private final OOrderMapper orderMapper;
    private final OOrderItemMapper orderItemMapper;
    private final OLogisticsCompanyMapper logisticsCompanyMapper;
    private final ErpStockOutMapper outMapper;
    private final ErpStockOutItemMapper outItemMapper;

    @Override
    public PageResult<OOrderShipList> querySupplierPageList(ShipStockUpBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<OOrderShipList> queryWrapper = new LambdaQueryWrapper<OOrderShipList>()
                .eq(OOrderShipList::getShipper,1)
                .eq(bo.getShipSupplierId()!=null,OOrderShipList::getShipSupplierId,bo.getShipSupplierId())
                .eq(bo.getShopId()!=null,OOrderShipList::getShopId,bo.getShopId())
                .eq(bo.getStatus()!=null,OOrderShipList::getStatus,bo.getStatus())
                .eq(StringUtils.hasText(bo.getOrderNum()),OOrderShipList::getOrderNum,bo.getOrderNum())
                ;
        Page<OOrderShipList> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getRecords()!=null && pages.getRecords().size()>0){
            for(OOrderShipList o : pages.getRecords()){
                o.setItems(shipListItemMapper.selectList(new LambdaQueryWrapper<OOrderShipListItem>().eq(OOrderShipListItem::getListId,o.getId())));
            }
        }

        return PageResult.build(pages);
    }


    @Override
    public PageResult<OOrderShipList> queryWarehousePageList(ShipStockUpBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<OOrderShipList> queryWrapper = new LambdaQueryWrapper<OOrderShipList>()
                .eq(OOrderShipList::getShipper,0)
                .eq(bo.getShipSupplierId()!=null,OOrderShipList::getShipSupplierId,bo.getShipSupplierId())
                .eq(bo.getShopId()!=null,OOrderShipList::getShopId,bo.getShopId())
                .eq(bo.getStatus()!=null,OOrderShipList::getStatus,bo.getStatus())
                .eq(StringUtils.hasText(bo.getOrderNum()),OOrderShipList::getOrderNum,bo.getOrderNum())
                ;
        Page<OOrderShipList> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        if(pages.getRecords()!=null && pages.getRecords().size()>0){
            for(OOrderShipList o : pages.getRecords()){
                o.setItems(shipListItemMapper.selectList(new LambdaQueryWrapper<OOrderShipListItem>().eq(OOrderShipListItem::getListId,o.getId())));
            }
        }

        return PageResult.build(pages);
    }

    /**
     * 供应商发货手动确认
     * @param bo
     * @param operator
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo<Integer> supplierShipOrderManualLogistics(SupplierOrderShipBo bo, String operator) {
        if(bo.getId()==null) return ResultVo.error("缺少参数：Id");
        if(!StringUtils.hasText(bo.getLogisticsCompany()) || !StringUtils.hasText(bo.getLogisticsCode()))
            return ResultVo.error("缺少参数：快递信息");

        OOrderShipList shipOrder = this.baseMapper.selectById(bo.getId());
        if (shipOrder == null) return ResultVo.error("找不到数据");
        if(shipOrder.getShipStatus().intValue() !=1) return ResultVo.error("已发货或已取消不能再发货");

        OLogisticsCompany erpLogisticsCompany = logisticsCompanyMapper.selectById(bo.getLogisticsCompany());
        if(erpLogisticsCompany==null) return ResultVo.error("快递公司选择错误");

        OOrder erpOrder = orderMapper.selectById(shipOrder.getOrderId());
        if(erpOrder==null) return ResultVo.error("订单库找不到订单！");

        // 更新供应商订单状态
        OOrderShipList updateShip = new OOrderShipList();
        updateShip.setShipLogisticsCompany(erpLogisticsCompany.getName());
        updateShip.setShipLogisticsCompanyCode(erpLogisticsCompany.getCode());
        updateShip.setShipLogisticsCode(bo.getLogisticsCode());
        updateShip.setShipStatus(2);
        updateShip.setStatus(3);
        updateShip.setUpdateTime(new Date());
        updateShip.setUpdateBy("供应商手动发货");
        updateShip.setId(shipOrder.getId());
        this.baseMapper.updateById(updateShip);

        // 子订单
        List<OOrderShipListItem> shipOrderItemList = shipListItemMapper.selectList(
                new LambdaQueryWrapper<OOrderShipListItem>()
                        .eq(OOrderShipListItem::getListId, bo.getId()));
        if(!shipOrderItemList.isEmpty()){
            for (var item:shipOrderItemList) {
                // 更新子订单发货状态
                OOrderShipListItem shipOrderItem=new OOrderShipListItem();
                shipOrderItem.setStatus(3);
                shipOrderItem.setUpdateTime(new Date());
                shipOrderItem.setUpdateBy("供应商发货手动确认");
                shipOrderItem.setId(item.getId());
                shipListItemMapper.updateById(shipOrderItem);

                // 更新订单明细o_order_item
                OOrderItem updateOrderItem =new OOrderItem();
                updateOrderItem.setId(item.getOrderItemId().toString());
                updateOrderItem.setShipStatus(2);
                updateOrderItem.setOrderStatus(2);
                updateOrderItem.setUpdateBy("供应商发货手动确认");
                updateOrderItem.setUpdateTime(new Date());
                orderItemMapper.updateById(updateOrderItem);
            }
        }

        // 更新订单发货状态

        // 查询订单item是否全部发货
        List<OOrderItem> waitShipList = orderItemMapper.selectList(new LambdaQueryWrapper<OOrderItem>().eq(OOrderItem::getOrderId, shipOrder.getOrderId()).ne(OOrderItem::getShipStatus, 2));
        if(waitShipList.isEmpty()){
            //已经全部发货了
            OOrder update = new OOrder();
            update.setId(shipOrder.getOrderId().toString());
            update.setShipStatus(2);//发货状态 0 待发货 1 部分发货 2全部发货
            update.setOrderStatus(2);
            update.setShipCompany(erpLogisticsCompany.getName());
            update.setShipCode(bo.getLogisticsCode());
            update.setUpdateTime(new Date());
            update.setUpdateBy("供应商发货确认-全部发货完成");
            orderMapper.updateById(update);

            // 更新店铺订单（仅线下订单个螳螂订单）
            // 更新店铺订单


        }else {
            // 部分发货
            OOrder update = new OOrder();
            update.setId(shipOrder.getOrderId().toString());
            update.setShipStatus(1);//发货状态 0 待发货 1 部分发货 2全部发货
//            update.setOrderStatus(2);
            update.setShipCompany(erpLogisticsCompany.getName());
            update.setShipCode(bo.getLogisticsCode());
            update.setUpdateTime(new Date());
            update.setUpdateBy("供应商发货确认-部分发货");
            orderMapper.updateById(update);
        }
        log.info("============供应商发货确认成功===================");
        // 推送到店铺由controller进行操作
        return ResultVo.success();
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo<Long> generateStockOutEntryByShipOrderId(Long shipOrderId) {
        OOrder oOrder = orderMapper.selectById(shipOrderId);
        if(oOrder==null) return ResultVo.error("订单数据不存在");
        if(oOrder.getOrderStatus()==11) return ResultVo.error("已取消的订单不能操作");
        if(oOrder.getShipStatus()!=0) return ResultVo.error("已出库的订单不能操作");
        OOrderShipList oOrderShipList = this.baseMapper.selectById(shipOrderId);
        if(oOrderShipList==null) return ResultVo.error("发货单不存在");
        else if (oOrderShipList.getStatus()==3) {
            return ResultVo.error("已经生成出库单");
        }
        List<OOrderShipListItem> oOrderShipListItems = shipListItemMapper.selectList(new LambdaQueryWrapper<OOrderShipListItem>().eq(OOrderShipListItem::getListId, oOrderShipList.getId()));
        if(oOrderShipListItems.isEmpty()){
            return ResultVo.error("没有找到发货单明细");
        }
        int sum = oOrderShipListItems.stream().mapToInt(OOrderShipListItem::getQuantity).sum();
        // 开始生成出库单

        // 组合出库单子表
        List<ErpStockOutItem> itemList = new ArrayList<>();

        for (OOrderShipListItem item : oOrderShipListItems) {
            if(item.getSkuId()==null||item.getSkuId()==0){
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                log.error("======出库错误：发货单明细没有找到SkuId:{}",item.getSkuId());
                return ResultVo.error("发货单明细没有找到SkuId:"+item.getId());
            }
            ErpStockOutItem outItem = new ErpStockOutItem();
            outItem.setStockOutType(EnumStockOutType.DDCK.getIndex());
            outItem.setSourceOrderId(item.getListId());
            outItem.setSourceOrderItemId(item.getId());
            outItem.setSourceOrderNum(oOrderShipList.getOrderNum());
            outItem.setGoodsId(item.getGoodsId());
            outItem.setSpecId(item.getSkuId());
            outItem.setSpecNum(item.getSkuNum());
            outItem.setOriginalQuantity(item.getQuantity());
            outItem.setOutQuantity(0);
            outItem.setStatus(0);
            outItem.setCreateTime(new Date());
            itemList.add(outItem);
            // 更新自己
            OOrderShipListItem update = new OOrderShipListItem();
            update.setId(item.getId());
            update.setStatus(3);//备货完成
            update.setUpdateBy("备货完成");
            update.setUpdateTime(new Date());
            shipListItemMapper.updateById(update);
        }
        //添加主表信息
        ErpStockOut insert = new ErpStockOut();
        insert.setStockOutNum("DDCK-"+ DateUtils.parseDateToStr("yyyyMMddHHmmss",new Date()));
        insert.setStockOutType(EnumStockOutType.DDCK.getIndex());
        insert.setSourceNum(oOrderShipList.getOrderNum());
        insert.setSourceId(oOrderShipList.getId());
        insert.setRemark("备货单生成出库单");
        insert.setCreateBy("备货单生成出库单");
        insert.setCreateTime(new Date());
        insert.setGoodsUnit(oOrderShipListItems.size());
        insert.setSpecUnit(oOrderShipListItems.size());
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
        OOrderShipList shipOrderUpdate = new OOrderShipList();
        shipOrderUpdate.setId(oOrderShipList.getId());
        shipOrderUpdate.setStatus(3);
        shipOrderUpdate.setUpdateTime(new Date());
        shipOrderUpdate.setUpdateBy("生成出库单");
        this.baseMapper.updateById(shipOrderUpdate);
        return ResultVo.success();
    }
}




