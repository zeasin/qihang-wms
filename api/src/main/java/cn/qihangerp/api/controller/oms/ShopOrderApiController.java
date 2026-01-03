package cn.qihangerp.api.controller.oms;

import cn.qihangerp.api.common.ShopApiCommon;
import cn.qihangerp.api.common.ShopOrderTransform;
import cn.qihangerp.api.request.PullRequest;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.ResultVoEnum;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.common.enums.HttpStatus;
import cn.qihangerp.common.mq.MqMessage;
import cn.qihangerp.common.mq.MqType;
import cn.qihangerp.common.mq.MqUtils;
import cn.qihangerp.model.entity.*;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddOrderApiHelper;
import cn.qihangerp.open.pdd.model.OrderListResultVo;
import cn.qihangerp.service.service.OOrderService;
import cn.qihangerp.service.service.OShopPullLasttimeService;
import cn.qihangerp.service.service.OShopPullLogsService;
import cn.qihangerp.service.service.PddOrderService;
import com.alibaba.fastjson2.JSONObject;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 淘系订单更新
 */
@AllArgsConstructor
@RestController
@RequestMapping("/shop/order")
public class ShopOrderApiController {
    private static Logger log = LoggerFactory.getLogger(ShopOrderApiController.class);

//    private final PddOrderService orderService;
    private final OOrderService orderService;
    private final ShopApiCommon shopApiCommon;
    private final MqUtils mqUtils;
    private final OShopPullLogsService pullLogsService;
    private final OShopPullLasttimeService pullLasttimeService;
    private final String DATE_PATTERN =
            "^(?:(?:(?:\\d{4}-(?:0?[1-9]|1[0-2])-(?:0?[1-9]|1\\d|2[0-8]))|(?:(?:(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:(?:0[48]|[2468][048]|[13579][26])00))-0?2-29))$)|(?:(?:(?:\\d{4}-(?:0?[13578]|1[02]))-(?:0?[1-9]|[12]\\d|30))$)|(?:(?:(?:\\d{4}-0?[13-9]|1[0-2])-(?:0?[1-9]|[1-2]\\d|30))$)|(?:(?:(?:\\d{2}(?:0[48]|[13579][26]|[2468][048])|(?:(?:0[48]|[13579][26]|[2468][048])00))-0?2-29))$)$";
    private final Pattern DATE_FORMAT = Pattern.compile(DATE_PATTERN);

    /**
     * 增量更新订单
     * @param req
     * @
     * @throws
     */
    @PostMapping("/pull_order")
    @ResponseBody
    public AjaxResult pullOrder(@RequestBody PullRequest req) throws Exception {
        log.info("=========拉取订单：{}", JSONObject.toJSONString(req));
        if (req.getShopId() == null || req.getShopId() <= 0) {
            return AjaxResult.error( "缺少参数：shopId");
        }
        if(req.getOrderTime() == null) return AjaxResult.error("缺少参数：下单时间");
        String startTimeStr = req.getOrderTime()[0];
        String endTimeStr = req.getOrderTime()[1];

        if(StringUtils.hasText(startTimeStr)) {
            // 判断时间格式
            Matcher matcher = DATE_FORMAT.matcher(startTimeStr);
            boolean b = matcher.find();
            if (!b) {
                return AjaxResult.error("开始时间格式错误");
            }
            if (StringUtils.hasText(endTimeStr)) {
                Matcher matcher1 = DATE_FORMAT.matcher(endTimeStr);
                boolean b1 = matcher1.find();
                if (!b1) {
                    return AjaxResult.error("结束时间格式错误");
                }
            }
            // 判断开始时间，结束时间 是不是一天
            if(!startTimeStr.equals(endTimeStr)){
                return AjaxResult.error("开始时间-结束时间不能超过1天");
            }
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        var checkResult = shopApiCommon.checkBefore(req.getShopId());
        if (checkResult.getCode() != HttpStatus.SUCCESS) {
            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(),checkResult.getData());
        }
        String accessToken = checkResult.getData().getAccessToken();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();
        Long shopId = checkResult.getData().getShopId();
        int shopType = checkResult.getData().getShopType();
        // 获取最后更新时间
        LocalDateTime startTime = LocalDateTime.parse(startTimeStr + " 00:00:01", formatter);;
        LocalDateTime  endTime = LocalDateTime.parse(startTimeStr + " 23:59:59", formatter);;

        String pullParams = "{startTime:"+startTime.format(formatter)+",endTime:"+endTime.format(formatter)+"}";

        Long startTimestamp = startTime.toEpochSecond(ZoneOffset.ofHours(8));
        Long endTimestamp = endTime.toEpochSecond(ZoneOffset.ofHours(8));

        int apiResponseCode = 0;
        String apiResponseMsg = "";

        int insertSuccess = 0;//新增成功的订单
        int totalError = 0;
        int hasExistOrder = 0;//已存在的订单数

        if(shopType==EnumShopType.PDD.getIndex()) {
            log.info("=============拉取PDD店铺订单。开始时间：{} 结束时间：{}",startTime.format(formatter),endTime.format(formatter));
            //获取
            ApiResultVo<OrderListResultVo> upResult = PddOrderApiHelper.pullOrderList(appKey, appSecret, accessToken, startTimestamp.intValue(), endTimestamp.intValue(), 1, 20);
            apiResponseCode = upResult.getCode();
            apiResponseMsg = upResult.getMsg();
            if(apiResponseCode==0) {
                //循环插入订单数据到数据库
                for (var trade : upResult.getData().getOrderList()) {
                    log.info("==========转换PDD订单");
                    OOrder oOrder = ShopOrderTransform.transformPddOrder(trade);
                    oOrder.setShopId(shopId);
                    oOrder.setShopType(shopType);

                    //插入订单数据
                    var result = orderService.saveShopOrder(oOrder);
                    if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                        //已经存在
                        log.info("=============主动更新pdd订单：开始更新数据库：" + trade.getOrderSn() + "存在、更新");
                        hasExistOrder++;
                    } else if (result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
                        log.info("============主动更新pdd订单：开始更新数据库：" + trade.getOrderSn() + "不存在、新增");

                        insertSuccess++;
                    } else {
                        log.info("===============主动更新pdd订单：开始更新数据库：" + trade.getOrderSn() + "报错:{}", result.getMsg());
                        totalError++;
                    }
                }
            }
        } else return AjaxResult.error("暂不支持");


        if(apiResponseCode !=0 ){
            OShopPullLogs logs = new OShopPullLogs();
            logs.setShopId(req.getShopId());
            logs.setShopType(shopType);
            logs.setPullType("ORDER");
            logs.setPullWay("主动拉取订单");
            logs.setPullParams(pullParams);
            logs.setPullResult(apiResponseMsg);
            logs.setPullTime(currDateTime);
            logs.setDuration(System.currentTimeMillis() - beginTime);
            pullLogsService.save(logs);
            return AjaxResult.error(apiResponseMsg);
        }


        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        OShopPullLogs logs = new OShopPullLogs();
        logs.setShopType(EnumShopType.PDD.getIndex());
        logs.setShopId(req.getShopId());
        logs.setPullType("ORDER");
        logs.setPullWay("主动拉取订单");
        logs.setPullParams(pullParams);
        logs.setPullResult("{insert:"+insertSuccess+",update:"+hasExistOrder+",fail:"+totalError+"}");
        logs.setPullTime(currDateTime);
        logs.setDuration(System.currentTimeMillis() - beginTime);
        pullLogsService.save(logs);

        String msg = "成功{startTime:"+startTime.format(df)+",endTime:"+endTime.format(df)+"}，新增：" + insertSuccess + "条，添加错误：" + totalError + "条，更新：" + hasExistOrder + "条";
        log.info("/**************主动更新pdd订单：END：" + msg + "****************/");
        return AjaxResult.success(msg);
    }

    /**
     * 更新单个订单
     *
     * @param
     * @return
     * @throws
     */
    @RequestMapping("/pull_order_detail")
    @ResponseBody
    public AjaxResult getOrderPullDetail(@RequestBody PullRequest req) throws Exception {
        log.info("/**************主动更新pdd订单by number****************/");
        if (req.getShopId() == null || req.getShopId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }
        if (StringUtils.isEmpty(req.getOrderId())) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，缺少orderId");
        }

        var checkResult = shopApiCommon.checkBefore(req.getShopId());
        if (checkResult.getCode() != HttpStatus.SUCCESS) {
            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
        }
        String accessToken = checkResult.getData().getAccessToken();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();
        Long shopId = checkResult.getData().getShopId();
        int shopType = checkResult.getData().getShopType();

        var resultVo = PddOrderApiHelper.pullOrderDetail(appKey, appSecret, accessToken,req.getOrderId());
        if (resultVo.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
            OOrder oOrder = ShopOrderTransform.transformPddOrder(resultVo.getData());
            oOrder.setShopId(shopId);
            oOrder.setShopType(shopType);

            var result = orderService.saveShopOrder(oOrder);
            if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                //已经存在
                log.info("============主动更新PDD订单：开始更新数据库：" + resultVo.getData().getOrderSn() + "存在、更新");
            } else if (result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
                log.info("============主动更新PDD订单：开始更新数据库：" + resultVo.getData().getOrderSn() + "不存在、新增");
            }
            else {
                log.info("===============主动更新pdd订单：开始更新数据库：" + resultVo.getData().getOrderSn() + "报错:{}", result.getMsg());
            }
            return AjaxResult.success();
        } else {
            return AjaxResult.error(resultVo.getCode(), resultVo.getMsg());
        }
    }
}
