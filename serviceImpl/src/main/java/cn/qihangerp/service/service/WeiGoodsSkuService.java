package cn.qihangerp.service.service;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.model.bo.LinkErpGoodsSkuBo;
import cn.qihangerp.model.entity.WeiGoodsSku;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author TW
* @description 针对表【oms_wei_goods_sku】的数据库操作Service
* @createDate 2024-06-03 16:51:29
*/
public interface WeiGoodsSkuService extends IService<WeiGoodsSku> {
    PageResult<WeiGoodsSku> queryPageList(WeiGoodsSku bo, PageQuery pageQuery);

    ResultVo linkErpGoodsSku(LinkErpGoodsSkuBo bo);
}
