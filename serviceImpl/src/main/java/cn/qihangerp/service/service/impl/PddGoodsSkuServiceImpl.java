package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.model.bo.LinkErpGoodsSkuBo;
import cn.qihangerp.model.entity.OGoods;
import cn.qihangerp.model.entity.OGoodsSku;
import cn.qihangerp.model.entity.PddGoods;
import cn.qihangerp.model.entity.PddGoodsSku;
import cn.qihangerp.service.mapper.PddGoodsMapper;
import cn.qihangerp.service.mapper.PddGoodsSkuMapper;
import cn.qihangerp.service.service.OGoodsService;
import cn.qihangerp.service.service.OGoodsSkuService;
import cn.qihangerp.service.service.PddGoodsSkuService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

/**
* @author TW
* @description 针对表【pdd_goods_sku(pdd商品SKU表)】的数据库操作Service实现
* @createDate 2024-06-04 17:11:49
*/
@AllArgsConstructor
@Service
public class PddGoodsSkuServiceImpl extends ServiceImpl<PddGoodsSkuMapper, PddGoodsSku>
    implements PddGoodsSkuService {
    private final PddGoodsSkuMapper mapper;
    private final PddGoodsMapper pddGoodsMapper;
    private final OGoodsSkuService oGoodsSkuService;
    private final OGoodsService oGoodsService;
    @Override
    public PageResult<PddGoodsSku> queryPageList(PddGoodsSku bo, PageQuery pageQuery) {
        LambdaQueryWrapper<PddGoodsSku> ew = new LambdaQueryWrapper<PddGoodsSku>()
                .eq(bo.getShopId()!=null,PddGoodsSku::getShopId,bo.getShopId())
                .eq(bo.getGoodsId()!=null,PddGoodsSku::getGoodsId,bo.getGoodsId())
                .eq(bo.getSkuId()!=null,PddGoodsSku::getSkuId,bo.getSkuId())
                .eq(StringUtils.hasText(bo.getOuterGoodsId()),PddGoodsSku::getOuterGoodsId,bo.getOuterGoodsId())
                .eq(StringUtils.hasText(bo.getOuterId()),PddGoodsSku::getOuterId,bo.getOuterId())
                ;
        IPage<PddGoodsSku> result = mapper.selectPage(pageQuery.build(), ew);
        return PageResult.build(result);
    }
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ResultVo linkErpGoodsSku(LinkErpGoodsSkuBo bo) {
        OGoodsSku oGoodsSku = oGoodsSkuService.getById(bo.getErpGoodsSkuId());
        if(oGoodsSku == null) return ResultVo.error("未找到系统商品sku");

        OGoods oGoods=oGoodsService.getById(oGoodsSku.getGoodsId());
        if(oGoods == null){
            return ResultVo.error("未找到系统商品");
        }

        PddGoodsSku taoGoodsSku = mapper.selectById(bo.getId());
        if(taoGoodsSku == null) {
            return ResultVo.error("PDD商品sku数据不存在");
        }
        List<PddGoods> jdGoods = pddGoodsMapper.selectList(new LambdaQueryWrapper<PddGoods>().eq(PddGoods::getGoodsId, taoGoodsSku.getGoodsId()));
        if(jdGoods==null||jdGoods.size()==0){
            return ResultVo.error("PDD商品数据不存在");
        }

        PddGoodsSku sku = new PddGoodsSku();
        sku.setId(Long.parseLong(bo.getId()));
        sku.setErpGoodsId(Long.parseLong(oGoodsSku.getGoodsId()));
        sku.setErpGoodsSkuId(Long.parseLong(oGoodsSku.getId()));
        mapper.updateById(sku);

        PddGoods goodsUp=new PddGoods();
        goodsUp.setId(jdGoods.get(0).getId());
        goodsUp.setErpGoodsId(Long.parseLong(oGoodsSku.getGoodsId()));
        pddGoodsMapper.updateById(goodsUp);
        return ResultVo.success();
    }
}




