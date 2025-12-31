package cn.qihangerp.api.controller.oms;

import cn.qihangerp.common.*;
import cn.qihangerp.model.bo.LinkErpGoodsSkuBo;
import cn.qihangerp.module.goods.service.OGoodsSkuService;
import cn.qihangerp.module.open.pdd.domain.PddGoods;
import cn.qihangerp.module.open.pdd.domain.PddGoodsSku;
import cn.qihangerp.module.open.pdd.domain.bo.PddGoodsBo;
import cn.qihangerp.module.open.pdd.service.PddGoodsService;
import cn.qihangerp.module.open.pdd.service.PddGoodsSkuService;
import cn.qihangerp.security.common.BaseController;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/pdd/goods")
@RestController
@AllArgsConstructor
public class PddGoodsController extends BaseController {
    private final PddGoodsService goodsService;
    private final PddGoodsSkuService skuService;
    private final OGoodsSkuService oGoodsSkuService;
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public TableDataInfo goodsList(PddGoodsBo bo, PageQuery pageQuery) {
        PageResult<PddGoods> result = goodsService.queryPageList(bo, pageQuery);

        return getDataTable(result);
    }

    @RequestMapping(value = "/skuList", method = RequestMethod.GET)
    public TableDataInfo skuList(PddGoodsSku bo, PageQuery pageQuery) {
        PageResult<PddGoodsSku> result = skuService.queryPageList(bo, pageQuery);

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
