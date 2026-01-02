package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.ResultVo;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.qihangerp.model.entity.OmsShopGoodsSku;
import cn.qihangerp.service.service.OmsShopGoodsSkuService;
import cn.qihangerp.service.mapper.OmsShopGoodsSkuMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
* @author 1
* @description 针对表【oms_shop_goods_sku(其他渠道店铺商品SKU)】的数据库操作Service实现
* @createDate 2026-01-02 09:22:53
*/
@Service
public class OmsShopGoodsSkuServiceImpl extends ServiceImpl<OmsShopGoodsSkuMapper, OmsShopGoodsSku>
    implements OmsShopGoodsSkuService{

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo<Integer> saveGoods(OmsShopGoodsSku goods) {
        List<OmsShopGoodsSku> skus = this.baseMapper.selectList(new LambdaQueryWrapper<OmsShopGoodsSku>()
                .eq(OmsShopGoodsSku::getShopId, goods.getShopId())
                .eq(OmsShopGoodsSku::getSkuId, goods.getSkuId()));
        if(skus.isEmpty()){
            //新增
            goods.setCreateOn(new Date());
            this.baseMapper.insert(goods);
        }else{
            goods.setUpdateOn(new Date());
            this.baseMapper.updateById(goods);
        }
        return ResultVo.success();
    }
}




