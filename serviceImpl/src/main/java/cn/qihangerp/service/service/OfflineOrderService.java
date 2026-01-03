package cn.qihangerp.service.service;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;

import cn.qihangerp.common.ResultVo;
import cn.qihangerp.model.entity.OfflineOrder;
import cn.qihangerp.model.bo.OfflineOrderCreateBo;
import cn.qihangerp.model.bo.OfflineOrderShipBo;
import com.baomidou.mybatisplus.extension.service.IService;

import cn.qihangerp.model.request.OrderSearchRequest;


/**
* @author qilip
* @description 针对表【offline_order(线下渠道订单表)】的数据库操作Service
* @createDate 2024-07-27 23:03:38
*/
public interface OfflineOrderService extends IService<OfflineOrder> {

    /**
     * 手动添加订单
     * @param bo
     * @return
     */
    ResultVo<Long> insertOfflineOrder(OfflineOrderCreateBo bo, String createBy);

}
