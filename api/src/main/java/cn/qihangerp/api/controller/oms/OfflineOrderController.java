package cn.qihangerp.api.controller.oms;

import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.ResultVo;
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
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
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

        ResultVo result = orderService.insertOfflineOrder(order,getUsername());
        if(result.getCode() == 0) {
            log.info("渠道訂單添加成功");
           return AjaxResult.success();
        }
        else return  AjaxResult.error(result.getMsg());
    }

}

