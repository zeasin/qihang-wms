package cn.qihangerp.api.controller.oms;

import cn.qihangerp.api.common.ShopApiCommon;
import cn.qihangerp.api.request.PullRequest;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.common.enums.HttpStatus;
import cn.qihangerp.model.entity.OShopPullLogs;
import cn.qihangerp.model.entity.OmsShopGoodsSku;
import cn.qihangerp.model.entity.PddGoods;
import cn.qihangerp.model.entity.PddGoodsSku;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddGoodsApiHelper;
import cn.qihangerp.open.pdd.model.GoodsResultVo;
import cn.qihangerp.service.service.OShopPullLasttimeService;
import cn.qihangerp.service.service.OShopPullLogsService;
import cn.qihangerp.service.service.PddGoodsService;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequestMapping("/shop/goods")
@RestController
@AllArgsConstructor
public class ShopGoodsApiController {
    private final ShopApiCommon shopApiCommon;
    private final PddGoodsService goodsService;
    private final OShopPullLogsService pullLogsService;
    private final OShopPullLasttimeService pullLasttimeService;



    /**
     * 拉取商品列表（包含sku）
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pull_goods_item", method = RequestMethod.POST)
    public AjaxResult pullSkuList(@RequestBody PullRequest params) throws Exception {
        if (params.getShopId() == null || params.getShopId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }
        Long currTimeMillis = System.currentTimeMillis();
        Date currDateTime = new Date();
        var checkResult = shopApiCommon.checkBefore(params.getShopId());
        if (checkResult.getCode() != HttpStatus.SUCCESS) {
            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg());
        }
        String accessToken = checkResult.getData().getAccessToken();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();
        Long shopId = checkResult.getData().getShopId();
        int shopType = checkResult.getData().getShopType();
        int apiResponseSuccessTotal = 0;
        int apiResponseCode = 0;
        String apiResponseMsg = "";
        if(shopType==EnumShopType.PDD.getIndex()) {
            ApiResultVo<GoodsResultVo> resultVo = PddGoodsApiHelper.pullGoodsList(appKey, appSecret, accessToken, 1, 20);
            apiResponseCode = resultVo.getCode();
            apiResponseMsg = resultVo.getMsg();

            if (resultVo.getData().getGoodsList() == null) return AjaxResult.error(1200,"数据获取失败");

            for (var g : resultVo.getData().getGoodsList()) {

                PddGoods pddGoods = new PddGoods();
                BeanUtils.copyProperties(g, pddGoods);
                // TODO:转换goods
                pddGoods.setShopId(params.getShopId());
                pddGoods.setCreateTime(new Date());
                List<PddGoodsSku> skuList = new ArrayList<>();
                for (var s : g.getSkuList()) {
                    PddGoodsSku sku = new PddGoodsSku();
                    BeanUtils.copyProperties(s, sku);
                    sku.setShopId(params.getShopId());
                    sku.setGoodsId(g.getGoodsId());
                    sku.setGoodsName(g.getGoodsName());
                    sku.setThumbUrl(g.getThumbUrl());

                    sku.setCreateTime(new Date());
                    skuList.add(sku);
                }
                pddGoods.setSkuList(skuList);

                goodsService.saveGoods(params.getShopId(),pddGoods);
                apiResponseSuccessTotal++;
            }
        }

        if(apiResponseCode !=0 ){
            OShopPullLogs logs = new OShopPullLogs();
            logs.setShopId(params.getShopId());
            logs.setShopType(shopType);
            logs.setPullType("GOODS");
            logs.setPullWay("主动拉取商品sku");
            logs.setPullParams("");
            logs.setPullResult(apiResponseMsg);
            logs.setPullTime(currDateTime);
            logs.setDuration(System.currentTimeMillis() - currTimeMillis);
            pullLogsService.save(logs);
            if(apiResponseCode == 10019) return AjaxResult.error(HttpStatus.UNAUTHORIZED1,"Token已过期");
            else return AjaxResult.error("接口拉取错误："+apiResponseMsg);
        }


        // 添加拉取日志
        OShopPullLogs logs = new OShopPullLogs();
        logs.setShopId(params.getShopId());
        logs.setShopType(shopType);
        logs.setPullType("GOODS");
        logs.setPullWay("主动拉取商品sku");
        logs.setPullParams("");
        logs.setPullResult("{successTotal:"+ apiResponseSuccessTotal +"}");
        logs.setPullTime(currDateTime);
        logs.setDuration(System.currentTimeMillis() - currTimeMillis);
        pullLogsService.save(logs);

        return AjaxResult.success("接口拉取成功，总数据："+ apiResponseSuccessTotal);
    }
}
