package cn.qihangerp.erp.controller.pos;

import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.common.TableDataInfo;
import cn.qihangerp.model.entity.OGoodsInventory;
import cn.qihangerp.model.entity.OOrder;
import cn.qihangerp.model.vo.PosDashboardStatsVo;
import cn.qihangerp.model.vo.SalesDailyVo;
import cn.qihangerp.request.OrderSearchRequest;
import cn.qihangerp.security.common.BaseController;
import cn.qihangerp.service.OGoodsInventoryService;
import cn.qihangerp.service.OOrderService;
import cn.qihangerp.service.OmsShopMemberService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

/**
 * POS订单查询Controller
 * 数据源：o_order（order_source = POS）
 */
@AllArgsConstructor
@RestController
@RequestMapping("/pos-api/order")
public class PosOrderController extends BaseController {

    private final OOrderService orderService;
    private final OmsShopMemberService memberService;
    private final OGoodsInventoryService goodsInventoryService;

    /**
     * 查询POS订单列表（仅 order_source = POS）
     */
    @GetMapping("/list")
    public TableDataInfo list(OrderSearchRequest bo, PageQuery pageQuery) {
        bo.setOrderSource("POS");
        PageResult<OOrder> pageList = orderService.queryPageList(bo, pageQuery);
        return getDataTable(pageList);
    }

    /**
     * 查询POS订单详情（含明细）
     */
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        OOrder order = orderService.queryDetailById(id);
        if (order == null) {
            return AjaxResult.error("订单不存在");
        }
        return success(order);
    }

    /**
     * 首页看板统计：今日销售/订单数/会员数/库存预警/近7天趋势/最近订单
     */
    @GetMapping("/today")
    public AjaxResult todayStats(@RequestParam(required = false) Long shopId) {
        PosDashboardStatsVo stats = new PosDashboardStatsVo();

        // 今日销售
        try {
            SalesDailyVo today = orderService.getTodaySalesDaily(null);
            if (today != null) {
                stats.setTodaySalesAmount(today.getAmount() == null ? 0d : today.getAmount());
                stats.setTodayOrderCount(today.getCount() == null ? 0L : today.getCount().longValue());
            }
        } catch (Exception e) {
            logger.error("获取今日销售统计异常", e);
            stats.setTodaySalesAmount(0d);
            stats.setTodayOrderCount(0L);
        }

        // 会员总数
        try {
            stats.setMemberCount(memberService.count());
        } catch (Exception e) {
            logger.error("获取会员总数异常", e);
            stats.setMemberCount(0L);
        }

        // 库存预警（去掉 is_delete 过滤，直接按可用库存查）
        try {
            long lowStock = goodsInventoryService.count(new LambdaQueryWrapper<OGoodsInventory>()
                    .le(OGoodsInventory::getAvailableQuantity, 10));
            stats.setLowStockCount(lowStock);
        } catch (Exception e) {
            logger.error("获取库存预警异常", e);
            stats.setLowStockCount(0L);
        }

        // 近7天趋势
        try {
            List<SalesDailyVo> daily = orderService.salesDaily();
            if (daily != null) {
                if (daily.size() > 7) {
                    daily = daily.subList(0, 7);
                }
                Collections.reverse(daily);
            }
            stats.setSalesTrend(daily);
        } catch (Exception e) {
            logger.error("获取销售趋势异常", e);
            stats.setSalesTrend(Collections.emptyList());
        }

        // 最近POS订单
        try {
            List<OOrder> recent = orderService.list(new LambdaQueryWrapper<OOrder>()
                    .eq(OOrder::getOrderSource, "POS")
                    .orderByDesc(OOrder::getCreateTime)
                    .last("LIMIT 5"));
            stats.setRecentOrders(recent);
        } catch (Exception e) {
            logger.error("获取最近订单异常", e);
            stats.setRecentOrders(Collections.emptyList());
        }

        return success(stats);
    }

    /**
     * 查询销售日报
     */
    @GetMapping("/daily")
    public AjaxResult dailyReport(@RequestParam String date) {
        // TODO: 实现销售日报（基于 o_order order_source=POS）
        return success("日报功能待实现");
    }
}
