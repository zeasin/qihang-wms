package cn.qihangerp.api.controller.oms;

import cn.qihangerp.api.request.StockOutEntryGenerateBo;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.service.service.OOrderService;
import cn.qihangerp.security.common.BaseController;
import com.alibaba.fastjson2.JSON;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/ship")
public class OrderShipController extends BaseController {

    private final OOrderService orderService;


    /**
     * 生成出库单
     */
    @PostMapping("/generate_stock_out_entry")
    public AjaxResult generateStockOutEntry(@RequestBody StockOutEntryGenerateBo bo)
    {
        log.info("============生成出库单========={}", JSON.toJSONString(bo));

        if(bo.getId()==null||bo.getId()==0) return AjaxResult.error("缺少参数：id");
        var result = orderService.generateStockOutEntryByShipOrderId(bo.getId());
        if(result.getCode()==0) return AjaxResult.success();
        else return AjaxResult.error(result.getMsg());
//        int result = stockOutEntryService.generateStockOutEntryForOrderItem(bo);
//        if(result == -1) return AjaxResult.error("参数错误：orderItemIds为空");
//        if(result == -2) return AjaxResult.error("参数错误：没有要添加的");
//        else if(result == -1001) return AjaxResult.error("存在错误的orderItemId：状态不对不能生成出库单");
//        else if(result == -1002) return AjaxResult.error("存在错误的订单数据：名单明细中没有skuId请修改！");
//        //wmsStockOutEntryService.insertWmsStockOutEntry(wmsStockOutEntry)
//        return toAjax(1);
    }



}
