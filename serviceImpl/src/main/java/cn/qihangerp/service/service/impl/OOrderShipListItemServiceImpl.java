package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.model.bo.ShipStockUpBo;
import cn.qihangerp.model.entity.OGoodsSku;
import cn.qihangerp.model.entity.OOrderShipListItem;
import cn.qihangerp.service.mapper.OGoodsSkuMapper;
import cn.qihangerp.service.mapper.OOrderShipListItemMapper;
import cn.qihangerp.service.service.OOrderShipListItemService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;

/**
* @author qilip
* @description 针对表【o_order_ship_list_item(发货-备货表（打单加入备货清单）)】的数据库操作Service实现
* @createDate 2025-05-24 16:03:35
*/
@AllArgsConstructor
@Service
public class OOrderShipListItemServiceImpl extends ServiceImpl<OOrderShipListItemMapper, OOrderShipListItem>
    implements OOrderShipListItemService{
    private final OGoodsSkuMapper goodsSkuMapper;
    @Override
    public PageResult<OOrderShipListItem> queryWarehousePageList(ShipStockUpBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<OOrderShipListItem> queryWrapper = new LambdaQueryWrapper<OOrderShipListItem>()
                .eq(OOrderShipListItem::getShipper,0)
                .eq(bo.getShopId()!=null,OOrderShipListItem::getShopId,bo.getShopId())
                .eq(bo.getStatus()!=null,OOrderShipListItem::getStatus,bo.getStatus())
                .eq(StringUtils.hasText(bo.getOrderNum()),OOrderShipListItem::getOrderNum,bo.getOrderNum())
                ;
        Page<OOrderShipListItem> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }

    @Override
    public PageResult<OOrderShipListItem> querySupplierPageList(ShipStockUpBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<OOrderShipListItem> queryWrapper = new LambdaQueryWrapper<OOrderShipListItem>()
                .eq(OOrderShipListItem::getShipper,1)
                .eq(bo.getShopId()!=null,OOrderShipListItem::getShopId,bo.getShopId())
                .eq(bo.getStatus()!=null,OOrderShipListItem::getStatus,bo.getStatus())
                .eq(StringUtils.hasText(bo.getOrderNum()),OOrderShipListItem::getOrderNum,bo.getOrderNum())
                ;
        Page<OOrderShipListItem> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);

        return PageResult.build(pages);
    }

    @Override
    public ResultVo<Integer> updateErpSkuId(Long id, Long erpSkuId) {
        var oOrderItem = this.baseMapper.selectById(id);
        if(oOrderItem==null){
            return ResultVo.error("找不到数据");
        }else if(oOrderItem.getStatus()==3) return ResultVo.error("发货之后不允许修改");

        OGoodsSku oGoodsSku = goodsSkuMapper.selectById(erpSkuId);
        if(oGoodsSku==null){
            return ResultVo.error("找不到商品Sku数据");
        }

        OOrderShipListItem update = new OOrderShipListItem();
        update.setId(oOrderItem.getId());
        update.setSkuId(erpSkuId);
        update.setOriginalSkuId(oOrderItem.getSkuId()==null?"":oOrderItem.getSkuId().toString());
        update.setUpdateBy("手动修改ERP SKU ID");
        update.setUpdateTime(new Date());
        this.baseMapper.updateById(update);
        return ResultVo.success();
    }
}




