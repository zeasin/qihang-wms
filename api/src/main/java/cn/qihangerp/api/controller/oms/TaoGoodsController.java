package cn.qihangerp.api.controller.oms;


import cn.qihangerp.common.*;
import cn.qihangerp.model.bo.LinkErpGoodsSkuBo;
import cn.qihangerp.module.goods.service.OGoodsSkuService;
import cn.qihangerp.module.open.tao.domain.TaoGoods;
import cn.qihangerp.module.open.tao.domain.TaoGoodsSku;
import cn.qihangerp.module.open.tao.domain.bo.TaoGoodsBo;
import cn.qihangerp.module.open.tao.service.TaoGoodsService;
import cn.qihangerp.module.open.tao.service.TaoGoodsSkuService;
import cn.qihangerp.security.common.BaseController;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/tao/goods")
@RestController
@AllArgsConstructor
public class TaoGoodsController extends BaseController {
    private final TaoGoodsService goodsService;
    private final TaoGoodsSkuService skuService;
    private final OGoodsSkuService oGoodsSkuService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(TaoGoodsBo bo, PageQuery pageQuery) {
        PageResult<TaoGoods> result = goodsService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }

    @RequestMapping(value = "/skuList", method = RequestMethod.GET)
    public TableDataInfo skuList(TaoGoodsBo bo, PageQuery pageQuery) {
        PageResult<TaoGoodsSku> result = skuService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }

    /**
     * 获取店铺订单详细信息
     */
    @GetMapping(value = "/sku/{id}")
    public AjaxResult getSkuInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(skuService.getById(id));
    }
    @PostMapping(value = "/sku/linkErp")
    public AjaxResult linkErp(@RequestBody LinkErpGoodsSkuBo bo)
    {
        if(StringUtils.isBlank(bo.getId())){
            return AjaxResult.error(500,"缺少参数Id");
        }
        if(StringUtils.isBlank(bo.getErpGoodsSkuId())){
            return AjaxResult.error(500,"缺少参数oGoodsSkuId");
        }
        ResultVo resultVo = skuService.linkErpGoodsSku(bo);
        if(resultVo.getCode()==0)
            return success();
        else return AjaxResult.error(resultVo.getMsg());
    }

}
