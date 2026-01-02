package cn.qihangerp.service.service;

import cn.qihangerp.common.ResultVo;
import cn.qihangerp.model.entity.OmsShopGoodsSku;
import cn.qihangerp.model.entity.PddGoods;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 1
* @description 针对表【oms_shop_goods_sku(其他渠道店铺商品SKU)】的数据库操作Service
* @createDate 2026-01-02 09:22:54
*/
public interface OmsShopGoodsSkuService extends IService<OmsShopGoodsSku> {
    ResultVo<Integer> saveGoods(OmsShopGoodsSku goods);
}
