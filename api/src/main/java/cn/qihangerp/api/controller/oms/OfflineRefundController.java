package cn.qihangerp.api.controller.oms;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.TableDataInfo;
import cn.qihangerp.module.order.service.OfflineRefundService;
import cn.qihangerp.model.request.RefundSearchRequest;
import cn.qihangerp.security.common.BaseController;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/offline_refund")
public class OfflineRefundController extends BaseController {

    private final OfflineRefundService refundService;
    /**
     * 查询店铺订单列表
     */
    @GetMapping("/list")
    public TableDataInfo list(RefundSearchRequest bo, PageQuery pageQuery)
    {
        var pageList = refundService.queryPageList(bo,pageQuery);
        return getDataTable(pageList);
    }
}
