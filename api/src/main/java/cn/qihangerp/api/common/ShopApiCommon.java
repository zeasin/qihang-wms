package cn.qihangerp.api.common;

import cn.qihangerp.common.ResultVo;
import cn.qihangerp.common.ResultVoEnum;
import cn.qihangerp.common.api.ShopApiParams;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.common.enums.HttpStatus;
import cn.qihangerp.model.entity.OShopPlatform;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.wei.WeiTokenApiHelper;
import cn.qihangerp.open.wei.response.WeiTokenResponse;
import cn.qihangerp.service.service.OShopPlatformService;
import cn.qihangerp.service.service.OShopService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@AllArgsConstructor
@Component
public class ShopApiCommon {
    private final OShopService shopService;
    private final OShopPlatformService platformService;

    /**
     * 更新前的检查
     *
     * @param shopId
     * @return
     * @throws
     */
    public ResultVo<ShopApiParams> checkBefore(Long shopId) {
        var shop = shopService.getById(shopId);
        if (shop == null) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "参数错误，没有找到店铺");
        }
        if(shop.getType().intValue() == EnumShopType.DOU.getIndex()) {
            if (shop.getSellerId() == null || shop.getSellerId() <= 0) {
                return ResultVo.error(HttpStatus.PARAMS_ERROR, "店铺参数错误，请设置平台店铺ID");
            }
        }
        ShopApiParams params = new ShopApiParams();
        params.setShopId(shopId);
        params.setShopType(shop.getType());
        params.setSellerId(shop.getSellerId());

        if(shop.getType()!=EnumShopType.OFFLINE.getIndex()&&shop.getType()!=EnumShopType.WEI.getIndex()) {
            OShopPlatform platform = platformService.getById(shop.getType());
            params.setAppKey(platform.getAppKey());
            params.setAppSecret(platform.getAppSecret());
        }else {
            params.setAppKey(shop.getAppKey());
            params.setAppSecret(shop.getAppSecret());
        }
        if (!StringUtils.hasText(params.getAppKey())) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "平台参数配置错误，没有找到AppKey");
        }
        if (!StringUtils.hasText(params.getAppSecret())) {
            return ResultVo.error(HttpStatus.PARAMS_ERROR, "平台参数配置错误，没有找到AppSercet");
        }
//        if (!StringUtils.hasText(platform.getRedirectUri())) {
//            return ResultVo.error(HttpStatus.PARAMS_ERROR, "第三方平台配置错误，没有找到RedirectUri");
//        }
//        if (!StringUtils.hasText(platform.getServerUrl())) {
//            return ResultVo.error(HttpStatus.PARAMS_ERROR, "第三方平台配置错误，没有找到ServerUrl");
//        }

//        if(shop.getSellerId() == null || shop.getSellerId() <= 0) {
//            return cn.qihangerp.tao.common.ApiResult.build(HttpStatus.PARAMS_ERROR,  "第三方平台配置错误，没有找到SellerUserId");
//        }

        if(shop.getType()!=EnumShopType.OFFLINE.getIndex()&&shop.getType()!=EnumShopType.DOU.getIndex()&&shop.getType()!=EnumShopType.WEI.getIndex()) {
            if (!StringUtils.hasText(shop.getAccessToken())) {
                return ResultVo.error(ResultVoEnum.UNAUTHORIZED.getIndex(), "Token已过期，请重新授权", params);
            }
        }

        if(shop.getType() == EnumShopType.WEI.getIndex()) {
            if (!StringUtils.hasText(params.getAccessToken())) {
                ApiResultVo<WeiTokenResponse> token1 = WeiTokenApiHelper.getToken(params.getAppKey(), params.getAppSecret());
                if(token1.getCode()==0){
                    params.setAccessToken(token1.getData().getAccess_token());
                    shopService.updateSessionKey(shopId, params.getAccessToken());
                    return ResultVo.success(HttpStatus.SUCCESS,params);
                }else{
                    return ResultVo.error(HttpStatus.PARAMS_ERROR, token1.getMsg());
                }
            }else {
                // 调用 店铺基本信息接口 验证Token
                ApiResultVo<WeiTokenResponse> tokenApiResultVo = WeiTokenApiHelper.checkToken(params.getAppKey(), params.getAppSecret(), params.getAccessToken());
                if(tokenApiResultVo.getCode()==0){
//                params.setAccessToken(tokenApiResultVo.getData().getAccess_token());
//                skuService.updateShopSessionByShopId(shopId, params.getAccessToken());
                    return ResultVo.success(HttpStatus.SUCCESS,params);
                }else {
//                ApiResultVo<Token> token2 = TokenApiHelper.getToken(params.getAppKey(), params.getAppSecret());
                    ApiResultVo<WeiTokenResponse> token2 = WeiTokenApiHelper.getToken(params.getAppKey(), params.getAppSecret());
                    if (token2.getCode() == 0) {
                        params.setAccessToken(token2.getData().getAccess_token());
                        shopService.updateSessionKey(shopId, params.getAccessToken());
                        return ResultVo.success(HttpStatus.SUCCESS,params);
                    } else {
                        return ResultVo.error(HttpStatus.PARAMS_ERROR, token2.getMsg());
                    }
                }
            }
        }

        params.setAccessToken(shop.getAccessToken());

        return ResultVo.success(HttpStatus.SUCCESS, params);
    }

}
