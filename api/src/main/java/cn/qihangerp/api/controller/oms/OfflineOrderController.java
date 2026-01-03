package cn.qihangerp.api.controller.oms;

import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.TableDataInfo;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.common.mq.MqMessage;
import cn.qihangerp.common.mq.MqType;
import cn.qihangerp.common.mq.MqUtils;
import cn.qihangerp.model.bo.OfflineOrderCreateBo;
import cn.qihangerp.model.bo.OfflineOrderPushBo;
import cn.qihangerp.service.service.OfflineOrderService;
import cn.qihangerp.model.request.OrderSearchRequest;
import cn.qihangerp.security.common.BaseController;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor
@RestController
@RequestMapping("/offline_order")
public class OfflineOrderController extends BaseController {
    private final OfflineOrderService orderService;
    private final MqUtils mqUtils;



    @PostMapping("/create")
    public AjaxResult add(@RequestBody OfflineOrderCreateBo order)
    {
        if(order.getGoodsAmount()==null)return new AjaxResult(1503,"请填写商品价格！");

        Long result = orderService.insertOfflineOrder(order,getUsername());
        if(result>0) {
            logger.info("渠道訂單添加成功");
            mqUtils.sendApiMessage(MqMessage.build(EnumShopType.OFFLINE, MqType.ORDER_MESSAGE, order.getOrderNum()));
        }
        else if(result == -1) return new AjaxResult(501,"订单号已存在！");
        else if(result == -2) return new AjaxResult(502,"请添加订单商品！");
        else if(result == -3) return new AjaxResult(503,"请完善订单商品明细！");
        else if(result == -4) return new AjaxResult(504,"请选择店铺！");
        return toAjax(1);
    }

}

