package cn.qihangerp.api.controller.oms;

import cn.qihangerp.api.request.ShipOrderItemSkuIdUpdateBo;
import cn.qihangerp.api.request.StockOutEntryGenerateBo;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.common.TableDataInfo;
import cn.qihangerp.model.bo.ShipStockUpBo;
import cn.qihangerp.module.order.bo.SupplierOrderShipBo;
import cn.qihangerp.module.order.service.OOrderShipListItemService;
import cn.qihangerp.module.order.service.OOrderShipListService;
import cn.qihangerp.security.common.BaseController;
import com.alibaba.fastjson2.JSON;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/ship")
public class OrderShipController extends BaseController {
    private final OOrderShipListService shipStockUpService;
    private final OOrderShipListItemService shipStockUpItemService;
    /**
     * 备货列表(仓库发货)
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/stock_up_list_by_warehouse")
    public TableDataInfo stock_up_list(ShipStockUpBo bo, PageQuery pageQuery)
    {
        var pageList = shipStockUpService.queryWarehousePageList(bo,pageQuery);
        return getDataTable(pageList);
    }
    /**
     * 备货列表(仓库发货)
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/stock_up_list_item_by_warehouse")
    public TableDataInfo stock_up_list_item(ShipStockUpBo bo, PageQuery pageQuery)
    {
        var pageList = shipStockUpItemService.queryWarehousePageList(bo,pageQuery);
        return getDataTable(pageList);
    }

    /**
     * 备货中-供应商代发
     * @param bo
     * @param pageQuery
     * @return
     */
    @GetMapping("/stock_up_list_by_supplier")
    public TableDataInfo supplierShipList(ShipStockUpBo bo, PageQuery pageQuery)
    {
//        bo.setShipper(1);
//        bo.setStockStatus(0);
//        bo.setTenantId(getUserId());
//        PageResult<ErpShipmentItem> list = shippingItemService.queryPageList(bo, pageQuery);
//        return getDataTable(list);
//        bo.setShipper(1);
//        bo.setTenantId(getUserId());
//        PageResult<ErpShipment> erpShipmentPageResult = shippingService.queryPageList(bo, pageQuery);
//        return getDataTable(erpShipmentPageResult);
        var pageList = shipStockUpService.querySupplierPageList(bo,pageQuery);
        return getDataTable(pageList);
    }



    /**
     * 生成出库单
     */
    @PostMapping("/generate_stock_out_entry")
    public AjaxResult generateStockOutEntry(@RequestBody StockOutEntryGenerateBo bo)
    {
        log.info("============生成出库单========={}", JSON.toJSONString(bo));
        if(bo.getId()==null||bo.getId()==0) return AjaxResult.error("缺少参数：id");
        var result = shipStockUpService.generateStockOutEntryByShipOrderId(bo.getId());
        if(result.getCode()==0) return AjaxResult.success();
        else return AjaxResult.error(result.getMsg());
//        int result = stockOutEntryService.generateStockOutEntryForOrderItem(bo);
//        if(result == -1) return AjaxResult.error("参数错误：orderItemIds为空");
//        if(result == -2) return AjaxResult.error("参数错误：没有要添加的");
//        else if(result == -1001) return AjaxResult.error("存在错误的orderItemId：状态不对不能生成出库单");
//        else if(result == -1002) return AjaxResult.error("存在错误的订单数据：名单明细中没有skuId请修改！");
//        //wmsStockOutEntryService.insertWmsStockOutEntry(wmsStockOutEntry)
//        return toAjax(1);
    }

    /**
      * 供应商发货确认
      * @param request
      * @return
      */
    @PostMapping("/supplier_ship_confirm")
    public AjaxResult SupplierShipConfirm(@RequestBody SupplierOrderShipBo request) {
        log.info("========供应商发货确认：{}", JSON.toJSONString(request));
        if (request.getId() == null || request.getId() == 0)
            return AjaxResult.error("缺少参数：orderId");
        if (StringUtils.isEmpty(request.getLogisticsCompany()))
            return AjaxResult.error("缺少参数：logisticsCompany");
        if (StringUtils.isEmpty(request.getLogisticsCode()))
            return AjaxResult.error("缺少参数：logisticsCode");

        ResultVo<Integer> result = shipStockUpService.supplierShipOrderManualLogistics(request, getUsername());
        if(result.getCode() == 0) {
            return AjaxResult.success();
        }else  return AjaxResult.error(result.getMsg());
    }
    /**
     * 修改订单明细skuId
     * @param bo
     * @return
     */
    @PostMapping("/order_item_sku_id_update")
    public AjaxResult orderItemSpecIdUpdate(@RequestBody ShipOrderItemSkuIdUpdateBo bo)
    {
        if(bo.getId()==null || bo.getId() ==0) return AjaxResult.error("参数错误：id为空");
        if(bo.getErpGoodsSkuId()==null || bo.getErpGoodsSkuId() ==0) return AjaxResult.error("参数错误：ErpGoodsSkuId为空");

        var result = shipStockUpItemService.updateErpSkuId(bo.getId(),bo.getErpGoodsSkuId());
        if (result.getCode() == 0) {
            return AjaxResult.success();
        } else return AjaxResult.error(result.getMsg());

    }

}
