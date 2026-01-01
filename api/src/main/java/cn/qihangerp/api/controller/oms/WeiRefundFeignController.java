package cn.qihangerp.api.controller.oms;

import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.model.entity.OmsWeiRefund;
import cn.qihangerp.service.service.WeiRefundService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/api/open-api/wei/refund")
public class WeiRefundFeignController {
    private final WeiRefundService refundService;
    @GetMapping(value = "/get_detail")
    public AjaxResult getInfo(String afterSaleOrderId)
    {
        List<OmsWeiRefund> refundList = refundService.list(new LambdaQueryWrapper<OmsWeiRefund>().eq(OmsWeiRefund::getAfterSaleOrderId,afterSaleOrderId));
        if(refundList==null) return AjaxResult.error(404,"没有找到退款单");
        else return AjaxResult.success(refundList.get(0));
    }
}
