package cn.qihangerp.api.controller.oms;

import cn.qihangerp.api.common.ShopApiCommon;
import cn.qihangerp.api.request.PullRequest;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.common.enums.HttpStatus;
import cn.qihangerp.model.entity.OShopPullLogs;
import cn.qihangerp.model.entity.OmsShopGoodsSku;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.dou.DouGoodsApiHelper;
import cn.qihangerp.open.dou.DouTokenApiHelper;
import cn.qihangerp.open.dou.model.GoodsListResultVo;
import cn.qihangerp.open.dou.model.Token;
import cn.qihangerp.open.jd.JdGoodsApiHelper;
import cn.qihangerp.open.jd.response.JdGoodsSkuListResponse;
import cn.qihangerp.open.pdd.PddGoodsApiHelper;
import cn.qihangerp.open.pdd.model.GoodsResultVo;
import cn.qihangerp.open.tao.TaoGoodsApiHelper;
import cn.qihangerp.open.tao.response.TaoGoodsResponse;
import cn.qihangerp.open.wei.WeiGoodsApiService;
import cn.qihangerp.open.wei.model.Product;
import cn.qihangerp.service.service.OShopPullLasttimeService;
import cn.qihangerp.service.service.OShopPullLogsService;
import cn.qihangerp.service.service.OmsShopGoodsSkuService;
import com.alibaba.fastjson2.JSONObject;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@RequestMapping("/shop/goods")
@RestController
@AllArgsConstructor
public class ShopGoodsApiController {
    private final ShopApiCommon shopApiCommon;
    private final OmsShopGoodsSkuService shopGoodsSkuService;
    private final WeiGoodsApiService goodsApiService;
    private final OShopPullLogsService pullLogsService;




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
            return AjaxResult.error(checkResult.getMsg());
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
            log.info("=============拉取PDD店铺商品=========");
            ApiResultVo<GoodsResultVo> resultVo = PddGoodsApiHelper.pullGoodsList(appKey, appSecret, accessToken, 1, 20);
            apiResponseCode = resultVo.getCode();
            apiResponseMsg = resultVo.getMsg();
            if(apiResponseCode==0) {
                if (resultVo.getData().getGoodsList() == null) return AjaxResult.error(1200,"数据获取失败");
                // sku列表
                List<OmsShopGoodsSku> skuList = new ArrayList<>();
                for (var g : resultVo.getData().getGoodsList()) {
                    for (var s : g.getSkuList()) {
                        OmsShopGoodsSku sku = new OmsShopGoodsSku();
                        sku.setShopId(shopId);
                        sku.setShopType(shopType);
                        sku.setProductId(g.getGoodsId().toString());
                        sku.setProductTitle(g.getGoodsName());
                        sku.setImg(g.getThumbUrl());
                        sku.setSkuName(s.getSpec());
                        sku.setSkuId(s.getSkuId().toString());
                        sku.setOuterSkuId(s.getOuterId());
                        sku.setOuterProductId(s.getOuterGoodsId());
                        sku.setPrice(0);
                        sku.setStockNum(s.getSkuQuantity());
                        sku.setStatus(s.getIsSkuOnsale());
                        sku.setAddTime(Long.parseLong(g.getCreatedAt()+""));
                        sku.setModifyTime(Long.parseLong(g.getCreatedAt()+""));
                        skuList.add(sku);
                        ResultVo<Integer> integerResultVo = shopGoodsSkuService.saveGoods(sku);
                        apiResponseSuccessTotal++;
                    }
                }
            }

        } else if (shopType == EnumShopType.DOU.getIndex()) {
            log.info("=============拉取DOU店铺商品=========");
            ApiResultVo<Token> token = DouTokenApiHelper.getToken(appKey, appSecret,checkResult.getData().getSellerId());

            if(token.getCode()==0) {
                accessToken = token.getData().getAccessToken();
            }else{
                return AjaxResult.error(token.getMsg());
            }

            ApiResultVo<GoodsListResultVo> resultVo = DouGoodsApiHelper.getGoodsList(appKey, appSecret, accessToken, 1, 10);
            apiResponseCode = resultVo.getCode();
            apiResponseMsg = resultVo.getMsg();
            if(apiResponseCode==0) {
                for (var goods : resultVo.getData().getGoodsList()) {
                    List<OmsShopGoodsSku> skuList = new ArrayList<>();
                    for (var s : goods.getSkuList()) {
                        OmsShopGoodsSku sku = new OmsShopGoodsSku();
                        sku.setShopId(shopId);
                        sku.setShopType(shopType);
                        sku.setProductId(goods.getProductId().toString());
                        sku.setProductTitle(goods.getName());
                        sku.setImg(goods.getImg());
                        String skuName ="";
                        if(StringUtils.hasText(s.getSpecDetailName1())){
                            skuName = s.getSpecDetailName1();
                        }
                        if(StringUtils.hasText(s.getSpecDetailName2())){
                            skuName = skuName + " " + s.getSpecDetailName2();
                        }
                        if(StringUtils.hasText(s.getSpecDetailName3())){
                            skuName = skuName + " " + s.getSpecDetailName3();
                        }
                        sku.setSkuName(skuName);
                        sku.setSkuId(s.getId().toString());
                        sku.setSkuCode(s.getCode());
                        sku.setOuterSkuId(s.getOutSkuId().toString());
                        sku.setOuterProductId(goods.getOuterProductId());
                        sku.setPrice(s.getPrice());
                        sku.setStockNum(s.getStockNum());
                        sku.setStatus(1);
                        sku.setAddTime(Long.parseLong(s.getCreateTime()+""));
                        sku.setModifyTime(Long.parseLong(s.getCreateTime()+""));
                        skuList.add(sku);
                        ResultVo<Integer> integerResultVo = shopGoodsSkuService.saveGoods(sku);
                        apiResponseSuccessTotal++;
                    }
                }
            }
        }else if (shopType == EnumShopType.TAO.getIndex()) {
            log.info("=============拉取TAO店铺商品=========");
            ApiResultVo<TaoGoodsResponse> resultVo = TaoGoodsApiHelper.pullGoodsList(appKey, appSecret, accessToken);
            apiResponseCode = resultVo.getCode();
            apiResponseMsg = resultVo.getMsg();
            if (apiResponseCode == 0) {
                for (var goods : resultVo.getList()) {
                    List<OmsShopGoodsSku> skuList = new ArrayList<>();
                    for (var s : goods.getSkuList()) {
                        OmsShopGoodsSku sku = new OmsShopGoodsSku();
                        sku.setShopId(shopId);
                        sku.setShopType(shopType);
                        sku.setProductId(goods.getNum_iid() + "");
                        sku.setOuterProductId(goods.getOuter_id());
                        sku.setProductTitle(goods.getTitle());
                        sku.setImg(goods.getPic_url());
                        String skuName = "";
                        try {
                            if (StringUtils.hasText(s.getProperties_name())) {
                                skuName = s.getProperties_name().replace(s.getProperties(), "");
                            }
                        } catch (Exception e) {
                            skuName = s.getProperties_name();
                        }
                        sku.setSkuName(skuName);
                        sku.setSkuId(s.getSku_id() + "");
                        sku.setOuterSkuId(s.getOuter_id());

//                        BigDecimal.valueOf(sku.getPrice()).setScale(2, BigDecimal.ROUND_HALF_UP);
                        Integer price = BigDecimal.valueOf(Double.parseDouble(s.getPrice())).multiply(BigDecimal.valueOf(100)).intValue();
                        sku.setPrice(price);
                        sku.setStockNum(s.getQuantity());
                        sku.setStatus(1);
                        try {
                            // 定义日期时间格式
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                            // 解析字符串为 LocalDateTime
                            LocalDateTime addTime = LocalDateTime.parse(s.getCreated(), formatter);
                            LocalDateTime modifyTime = LocalDateTime.parse(s.getModified(), formatter);
                            sku.setAddTime(addTime.toEpochSecond(ZoneOffset.UTC));
                            sku.setModifyTime(modifyTime.toEpochSecond(ZoneOffset.UTC));
                        } catch (Exception e) {
                        }
                        skuList.add(sku);
                        ResultVo<Integer> integerResultVo = shopGoodsSkuService.saveGoods(sku);
                        apiResponseSuccessTotal++;
                    }
                }
            }

        }else if (shopType == EnumShopType.WEI.getIndex()) {
            log.info("=============拉取WEI店铺商品=========");
            ApiResultVo<Product> productApiResultVo = goodsApiService.pullGoodsList(accessToken);
            apiResponseCode = productApiResultVo.getCode();
            apiResponseMsg = productApiResultVo.getMsg();
            if (productApiResultVo.getCode() == 0) {
                List<OmsShopGoodsSku> skuList = new ArrayList<>();

                // 成功
                for (var product : productApiResultVo.getList()) {
                    for (var s : product.getSkus()) {
                        OmsShopGoodsSku sku = new OmsShopGoodsSku();
                        sku.setShopId(shopId);
                        sku.setShopType(shopType);
                        sku.setProductId(product.getProduct_id());
                        sku.setOuterProductId(product.getOut_product_id());
                        sku.setProductTitle(product.getTitle());
                        sku.setImg(s.getThumb_img());
//                        sku.setImg(product.getHead_imgs().getString(0));
                        String skuName = "";
                        try {
                            if (!s.getSku_attrs().isEmpty()) {
                                for (int i = 0; i < s.getSku_attrs().size(); i++) {
                                    JSONObject item = s.getSku_attrs().getJSONObject(i);
                                    skuName += " " + item.getString("attr_value");
                                }
                            }
                        } catch (Exception e) {
                            skuName = JSONObject.toJSONString(s.getSku_attrs());
                        }
                        sku.setSkuName(skuName);
                        sku.setSkuId(s.getSku_id() + "");
                        sku.setOuterSkuId(s.getOut_sku_id());
                        sku.setSkuCode(s.getSku_code());
                        sku.setPrice(s.getSale_price());
                        sku.setStockNum(s.getStock_num());
                        sku.setStatus(s.getStatus());
//                            sku.setAddTime(addTime.toEpochSecond(ZoneOffset.UTC));
                        sku.setModifyTime(Long.parseLong(product.getEdit_time()));
                        skuList.add(sku);
                        ResultVo<Integer> integerResultVo = shopGoodsSkuService.saveGoods(sku);
                        apiResponseSuccessTotal++;
                    }
                }
            }
        } else if (shopType == EnumShopType.JD.getIndex()) {
            log.info("=============拉取JD店铺商品=========");
            ApiResultVo<JdGoodsSkuListResponse> resultVo = JdGoodsApiHelper.pullGoodsSkuList(appKey, appSecret, accessToken);
            apiResponseCode = resultVo.getCode();
            apiResponseMsg = resultVo.getMsg();
            List<OmsShopGoodsSku> skuList = new ArrayList<>();
            if (apiResponseCode == 0) {
                for (var s : resultVo.getList()) {
                    OmsShopGoodsSku sku = new OmsShopGoodsSku();
                    sku.setShopId(shopId);
                    sku.setShopType(shopType);
                    sku.setProductId(s.getWareId().toString());
                    sku.setOuterProductId("");
                    sku.setProductTitle(s.getWareTitle());
                    sku.setImg(s.getLogo());
                    sku.setSkuName(s.getSkuName());
                    sku.setSkuId(s.getSkuId().toString());
                    sku.setOuterSkuId(s.getOuterId());
                    sku.setPrice(s.getJdPrice());
                    sku.setStockNum(0);
                    sku.setStatus(s.getStatus());
                    sku.setAddTime(s.getCreated());
                    sku.setModifyTime(s.getModified());
                    skuList.add(sku);
                    ResultVo<Integer> integerResultVo = shopGoodsSkuService.saveGoods(sku);
                    apiResponseSuccessTotal++;
                }
            }
        } else return AjaxResult.error("暂不支持");


        log.info("=============拉取店铺商品完成，code:{},msg:{}",apiResponseCode,apiResponseMsg);
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
