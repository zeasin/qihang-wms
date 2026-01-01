package cn.qihangerp.service.service;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;

import cn.qihangerp.model.bo.ShipStockUpBo;
import cn.qihangerp.model.entity.OOrderShipListItem;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【o_order_ship_list_item(发货-备货表（打单加入备货清单）)】的数据库操作Service
* @createDate 2025-05-24 16:03:35
*/
public interface OOrderShipListItemService extends IService<OOrderShipListItem> {
    PageResult<OOrderShipListItem> queryWarehousePageList(ShipStockUpBo bo, PageQuery pageQuery);
    PageResult<OOrderShipListItem> querySupplierPageList(ShipStockUpBo bo, PageQuery pageQuery);
    ResultVo<Integer> updateErpSkuId(Long id, Long erpSkuId);
}
