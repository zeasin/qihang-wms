<template>
  <div class="page-container">
    <div class="card">
      <div class="search-bar">
        <el-input
          v-model="searchForm.keyword"
          placeholder="商品名称/条码"
          clearable
          @keyup.enter="handleSearch"
        />
        <el-select v-model="searchForm.warehouseId" placeholder="仓库" clearable>
          <el-option label="全部仓库" :value="undefined" />
        </el-select>
        <el-button type="primary" @click="handleSearch">
          <el-icon><Search /></el-icon>搜索
        </el-button>
        <el-button @click="handleReset">
          <el-icon><Refresh /></el-icon>重置
        </el-button>
      </div>
      
      <div class="table-container">
        <el-table :data="tableData" border stripe v-loading="loading">
          <el-table-column prop="goodsName" label="商品名称" min-width="150" show-overflow-tooltip />
          <el-table-column prop="skuCode" label="SKU编码" width="120" />
          <el-table-column prop="barCode" label="条码" width="140" />
          <el-table-column prop="warehouseName" label="仓库" width="120" />
          <el-table-column prop="quantity" label="库存数量" width="100" />
          <el-table-column prop="lockedQuantity" label="锁定数量" width="100" />
          <el-table-column prop="availableQuantity" label="可用数量" width="100">
            <template #default="{ row }">
              <span :class="{ 'text-danger': row.availableQuantity <= 0 }">
                {{ row.availableQuantity }}
              </span>
            </template>
          </el-table-column>
        </el-table>
      </div>
      
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="pagination.page"
          v-model:page-size="pagination.size"
          :page-sizes="[10, 20, 50, 100]"
          :total="pagination.total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSearch"
          @current-change="handleSearch"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'

const loading = ref(false)
const tableData = ref<any[]>([])

const searchForm = reactive({
  keyword: '',
  warehouseId: undefined
})

const pagination = reactive({
  page: 1,
  size: 10,
  total: 0
})

const handleSearch = () => {
  console.log('搜索库存', searchForm)
}

const handleReset = () => {
  searchForm.keyword = ''
  searchForm.warehouseId = undefined
  handleSearch()
}
</script>
