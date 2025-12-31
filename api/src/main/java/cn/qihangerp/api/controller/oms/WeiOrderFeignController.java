package cn.qihangerp.api.controller.oms;

import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.module.open.wei.domain.WeiOrder;
import cn.qihangerp.module.open.wei.service.WeiOrderService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/api/open-api/wei/order")
public class WeiOrderFeignController  {
    private final WeiOrderService orderService;
    @GetMapping(value = "/get_detail")
    public AjaxResult getInfo(String orderId)
    {
        WeiOrder order = orderService.queryDetailByOrderId(orderId);
        if(order==null) return AjaxResult.error(404,"没有找到订单");
        else return AjaxResult.success(order);
    }
}
