package cn.qihangerp.api.controller;

import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.ResultVo;
import cn.qihangerp.common.TableDataInfo;
import cn.qihangerp.model.entity.ErpStockIn;
import cn.qihangerp.model.request.StockInCreateRequest;
import cn.qihangerp.model.request.StockInRequest;
import cn.qihangerp.service.service.ErpStockInService;
import cn.qihangerp.security.common.BaseController;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor
@RestController
@RequestMapping("/erp-api/stockIn")
public class StockInController extends BaseController {
    private final ErpStockInService stockInService;
    @GetMapping("/list")
    public TableDataInfo list(ErpStockIn bo, PageQuery pageQuery)
    {
        // 🔍 调试点1: 检查请求参数
        System.out.println("=== 调试信息 ===");
        System.out.println("请求参数 bo: " + bo);
        System.out.println("分页参数 pageQuery: " + pageQuery);
        
        // 在这里设置断点 - 可以检查输入参数
        var pageList = stockInService.queryPageList(bo,pageQuery);
        
        // 🔍 调试点2: 检查查询结果
        System.out.println("查询结果数量: " + (pageList != null ? pageList.getRecords().size() : 0));
        
        return getDataTable(pageList);
    }

    @PostMapping("/create")
    public AjaxResult createEntry(@RequestBody StockInCreateRequest request)
    {
        // 🔍 调试点3: 检查创建入库单请求
        System.out.println("=== 创建入库单调试 ===");
        System.out.println("用户ID: " + getUserId());
        System.out.println("用户名: " + getUsername());
        System.out.println("请求数据: " + request);
        
        // 在这里设置断点 - 可以检查用户信息和请求数据
        ResultVo<Long> resultVo = stockInService.createEntry(getUserId(), getUsername(), request);
        
        // 🔍 调试点4: 检查业务处理结果
        System.out.println("业务处理结果码: " + resultVo.getCode());
        System.out.println("业务处理消息: " + resultVo.getMsg());
        
        if(resultVo.getCode()==0)
            return AjaxResult.success();
        else return AjaxResult.error(resultVo.getMsg());
    }

    @PostMapping("/in")
    public AjaxResult in(@RequestBody StockInRequest request)
    {
        ResultVo<Long> resultVo = stockInService.stockIn(getUserId(), getUsername(), request);
        if(resultVo.getCode()==0)
            return AjaxResult.success();
        else return AjaxResult.error(resultVo.getMsg());
    }

    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        // 🔍 调试点5: 检查路径参数
        System.out.println("=== 获取入库单详情调试 ===");
        System.out.println("入库单ID: " + id);
        
        // 在这里设置断点 - 可以检查ID参数
        ErpStockIn entry = stockInService.getDetailAndItemById(id);
        
        // 🔍 调试点6: 检查查询到的数据
        System.out.println("查询到的入库单: " + (entry != null ? entry.toString() : "null"));

        return success(entry);
    }

}
