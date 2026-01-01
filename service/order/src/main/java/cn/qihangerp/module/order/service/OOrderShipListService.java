package cn.qihangerp.module.order.service;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;

import cn.qihangerp.model.bo.ShipStockUpBo;
import cn.qihangerp.model.entity.OOrderShipList;
import cn.qihangerp.model.bo.SupplierOrderShipBo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【o_order_ship_list(发货-备货表（取号发货加入备货清单、分配供应商发货加入备货清单）)】的数据库操作Service
* @createDate 2025-05-24 16:03:35
*/
public interface OOrderShipListService extends IService<OOrderShipList> {
    PageResult<OOrderShipList> querySupplierPageList(ShipStockUpBo bo, PageQuery pageQuery);
    PageResult<OOrderShipList> queryWarehousePageList(ShipStockUpBo bo, PageQuery pageQuery);

    /**
     * 供应商发货手动填写发货物流信息
     * @param bo
     * @param operator
     * @return
     */
    ResultVo<Integer> supplierShipOrderManualLogistics(SupplierOrderShipBo bo, String operator);

    /**
     * 生成出库单（按发货订单）
     * @param shipOrderId
     * @return
     */
    ResultVo<Long> generateStockOutEntryByShipOrderId(Long shipOrderId);
}
