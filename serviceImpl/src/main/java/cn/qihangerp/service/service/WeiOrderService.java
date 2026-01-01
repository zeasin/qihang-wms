package cn.qihangerp.service.service;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.model.entity.WeiOrder;
import cn.qihangerp.model.bo.WeiOrderConfirmBo;
import com.baomidou.mybatisplus.extension.service.IService;


/**
* @author TW
* @description 针对表【oms_wei_order】的数据库操作Service
* @createDate 2024-06-03 16:48:31
*/
public interface WeiOrderService extends IService<WeiOrder> {
    PageResult<WeiOrder> queryPageList(WeiOrder bo, PageQuery pageQuery);
    ResultVo<Integer> saveOrder(Long shopId, WeiOrder order);
    WeiOrder queryDetailById(Long id);
    WeiOrder queryDetailByOrderId(String orderId);
    ResultVo<Long> confirmOrder(WeiOrderConfirmBo confirmBo);
}
