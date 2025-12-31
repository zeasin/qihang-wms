package cn.qihangerp.api.controller.oms;

import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.common.TableDataInfo;
import cn.qihangerp.model.entity.OfflineGoodsSku;
import cn.qihangerp.module.order.service.OfflineGoodsSkuService;
import cn.qihangerp.security.common.BaseController;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 商品管理Controller
 * 
 * @author qihang
 * @date 2023-12-29
 */
@AllArgsConstructor
@RestController
@RequestMapping("/offline_goods")
public class OfflineGoodsController extends BaseController
{
    private final OfflineGoodsSkuService skuService;

    /**
     * 搜索商品SKU
     * 条件：商品编码、SKU、商品名称
     */
    @GetMapping("/searchSku")
    public TableDataInfo searchSkuBy(String keyword)
    {
        logger.info("========SKU搜索=========",keyword);
        List<OfflineGoodsSku> list = skuService.searchGoodsSpec(keyword);
        return getDataTable(list);
    }

    @GetMapping("/sku_list")
    public TableDataInfo skuList(OfflineGoodsSku bo, PageQuery pageQuery)
    {
        var pageList = skuService.querySkuPageList(bo,pageQuery);
        return getDataTable(pageList);
    }


    /**
     * 获取商品管理详细信息
     */
    @GetMapping(value = "/sku/{id}")
    public AjaxResult getSkuInfo(@PathVariable("id") Long id)
    {
        return success(skuService.getById(id));
    }



    @PostMapping("/sku")
    public AjaxResult addSku(@RequestBody OfflineGoodsSku goodsSku)
    {
        ResultVo<Long> result = skuService.insertGoodsSku(goodsSku);
        if(result.getCode() != 0) return AjaxResult.error(result.getMsg());
        else return AjaxResult.success();

    }

    @PutMapping("/sku")
    public AjaxResult editSku(@RequestBody OfflineGoodsSku sku)
    {
        return toAjax(skuService.updateById(sku));
    }

    /**
     * 删除商品管理
     */
    @DeleteMapping("/sku/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(skuService.removeBatchByIds(Arrays.stream(ids).toList()));
    }

}
