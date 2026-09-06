package cn.qihangerp.model.vo;

import cn.qihangerp.model.entity.OOrder;
import lombok.Data;

import java.util.List;

/**
 * POS首页看板统计
 */
@Data
public class PosDashboardStatsVo {
    /** 今日销售额 */
    private Double todaySalesAmount;
    /** 今日订单数 */
    private Long todayOrderCount;
    /** 会员总数 */
    private Long memberCount;
    /** 库存预警数（可用库存<=10） */
    private Long lowStockCount;
    /** 近7天销售趋势 */
    private List<SalesDailyVo> salesTrend;
    /** 最近POS订单 */
    private List<OOrder> recentOrders;
}
