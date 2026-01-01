package cn.qihangerp.service.service;

import cn.qihangerp.model.entity.WeiGoods;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author qilip
* @description 针对表【oms_wei_goods】的数据库操作Service
* @createDate 2024-09-21 15:09:54
*/
public interface WeiGoodsService extends IService<WeiGoods> {
    int saveAndUpdateGoods(Long shopId, WeiGoods goods);
}
