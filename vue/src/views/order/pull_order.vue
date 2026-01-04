<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" v-show="showSearch" label-width="100px">
      <el-form-item label="店铺" prop="shopId">
        <el-select v-model="queryParams.shopId" placeholder="请选择店铺" clearable @change="handleQuery">
         <el-option
            v-for="item in shopList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
           <span style="float: left">{{ item.name }}</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 500">微信小店</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 200">京东POP</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 280">京东自营</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 100">淘宝天猫</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 300">拼多多</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 400">抖店</span>
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="下单时间" prop="orderTime">
        <el-date-picker clearable
                        v-model="orderTime" value-format="yyyy-MM-dd"
                        type="daterange"
                        range-separator="至"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期">
        </el-date-picker>
      </el-form-item>

    </el-form>

    <el-row :gutter="10" class="mb8">

      <el-col :span="1.5">
        <el-button
          :loading="pullLoading"
          type="primary"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handlePull"
        >API拉取订单</el-button>
      </el-col>
      <el-col :span="1.5">
      <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="lists" >
<!--      <el-table-column type="selection" width="55" align="center" />-->
<!--      <el-table-column label="ID" align="center" prop="id" />-->
      <el-table-column label="店铺" align="center" prop="shopId" >
        <template slot-scope="scope">
          <span>{{ shopList.find(x=>x.id === scope.row.shopId).name  }}</span>
        </template>
      </el-table-column>
      <el-table-column label="平台" align="center" prop="shopType" >
        <template slot-scope="scope">
          <el-tag size="small" v-if="scope.row.shopType === 1">天猫</el-tag>
          <el-tag size="small" v-if="scope.row.shopType === 2">京东</el-tag>
          <el-tag size="small" v-if="scope.row.shopType === 3">抖店</el-tag>
          <el-tag size="small" v-if="scope.row.shopType === 4">拼多多</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="类型" align="center" prop="pullType" >
        <template slot-scope="scope">
          <el-tag size="small" v-if="scope.row.pullType === 'GOODS'">拉取商品</el-tag>
          <el-tag size="small" v-if="scope.row.pullType === 'ORDER'">拉取订单</el-tag>
          <el-tag size="small" v-if="scope.row.pullType === 'REFUND'">拉取退款</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="方式" align="center" prop="pullWay" />

      <el-table-column label="参数" align="center" prop="pullParams" />
      <el-table-column label="结果" align="center" prop="pullResult" />
      <el-table-column label="耗时（ms）" align="center" prop="duration" />
      <el-table-column label="时间" align="center" prop="pullTime" >
        <template slot-scope="scope">
          {{ parseTime(scope.row.pullTime) }}
        </template>
      </el-table-column>

    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />


  </div>
</template>

<script>
import {listShop, listShopPullLogs} from "@/api/shop/shop";
import {pullOrder} from "@/api/shop/order";
import {MessageBox} from "element-ui";
import {isRelogin} from "@/utils/request";

export default {
  name: "Order",
  data() {
    return {
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 遮罩层
      loading: true,
      lists:[],
      orderTime:null,
      shopList:[],
      skuList:[],
      // 是否显示弹出层
      detailOpen:false,
      pullLoading:false,
      skuListLoading:false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        pullType: 'ORDER'
      },
      // 表单参数
      form: {
        erpGoodsSkuId:null,
        id:null
      },
      rules: {
        id: [
          { required: true, message: "不能为空", trigger: "blur" }
        ],
        erpGoodsSkuId: [
          { required: true, message: "不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    listShop({}).then(response => {
        this.shopList = response.rows;
      });
    this.getList();
  },
  mounted() {
    if(this.$route.query.shopId){
        this.queryParams.shopId = this.$route.query.shopId
    }
  },
  methods: {
    /** 查询淘宝订单列表 */
    getList() {
      this.loading = true;
      listShopPullLogs(this.queryParams).then(response => {
        this.lists = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.pullLoading = false
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handlePull() {
      if (this.queryParams.shopId) {
        this.pullLoading = true
        pullOrder({shopId:this.queryParams.shopId,orderTime:this.orderTime}).then(response => {
          console.log('拉取店铺订单接口返回=====',response)
          if(response.code === 1401) {
            MessageBox.confirm('Token已过期，需要重新授权！请前往店铺列表重新获取授权！', '系统提示', { confirmButtonText: '前往授权', cancelButtonText: '取消', type: 'warning' }).then(() => {
              this.$router.push({path:"/sales/shop_list"})
            }).catch(() => {
              isRelogin.show = false;
            });
          }else{
            this.$modal.msgSuccess(JSON.stringify(response));
            this.getList()
            this.pullLoading = false
          }
          this.pullLoading = false
        })
      } else {
        this.$modal.msgSuccess("请先选择店铺");
      }
    }
  }
};
</script>
