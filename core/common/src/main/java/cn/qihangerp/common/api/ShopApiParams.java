package cn.qihangerp.common.api;


public class ShopApiParams {
    private String appKey;
    private String appSecret;
    private String accessToken;
    private String callbackUrl;
//    private String serverUrl;
    private Long sellerId;
    private int shopType;
    private Long shopId;

    public int getShopType() {
        return shopType;
    }

    public void setShopType(int shopType) {
        this.shopType = shopType;
    }

    public Long getShopId() {
        return shopId;
    }

    public void setShopId(Long shopId) {
        this.shopId = shopId;
    }

    public String getAppKey() {
        return appKey;
    }

    public void setAppKey(String appKey) {
        this.appKey = appKey;
    }

    public String getAppSecret() {
        return appSecret;
    }

    public void setAppSecret(String appSecret) {
        this.appSecret = appSecret;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getCallbackUrl() {
        return callbackUrl;
    }

    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
    }

    //    public String getRedirectUri() {
//        return redirectUri;
//    }
//
//    public void setRedirectUri(String redirectUri) {
//        this.redirectUri = redirectUri;
//    }
//
//    public String getServerUrl() {
//        return serverUrl;
//    }
//
//    public void setServerUrl(String serverUrl) {
//        this.serverUrl = serverUrl;
//    }

    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }
}
