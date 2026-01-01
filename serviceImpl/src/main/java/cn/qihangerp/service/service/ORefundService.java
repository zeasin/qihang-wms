package cn.qihangerp.service.service;


import cn.qihangerp.model.entity.ORefund;
import cn.qihangerp.model.bo.RefundProcessingBo;
import cn.qihangerp.model.bo.RefundSearchBo;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;


import java.util.List;


/**
* @author qilip
* @description 针对表【o_refund(退换货表)】的数据库操作Service
* @createDate 2024-03-10 16:23:12
*/
public interface ORefundService extends IService<ORefund> {
    ResultVo<Integer> jdRefundMessage(String serviceId, JSONObject refundDetail);
    ResultVo<Integer> jdvcRefundMessage(String returnId,JSONObject refundDetail);
    ResultVo<Integer> taoRefundMessage(String refundId,JSONObject refundDetail);
    ResultVo<Integer> pddRefundMessage(String refundId,JSONObject refundDetail);
    ResultVo<Integer> douRefundMessage(String refundId,JSONObject refundDetail);
    ResultVo<Integer> weiRefundMessage(String refundId,JSONObject refundDetail);
    List<ORefund> selectList(ORefund refund);

    PageResult<ORefund> queryPageList(RefundSearchBo bo, PageQuery pageQuery);

    /**
     * 获取待推送到ERP的退款列表
     * @param pageQuery
     * @return
     */
    PageResult<ORefund> queryPageWaitPushErpList( PageQuery pageQuery);
    ORefund selectById(Long id);

    /**
     * 售后处理
     * @param processingBo
     * @return
     */
    ResultVo<Long> refundProcessing(RefundProcessingBo processingBo, String createBy);
}
