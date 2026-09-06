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
        <el-select v-model="searchForm.categoryId" placeholder="商品分类" clearable>
          <el-option label="全部分类" :value="undefined" />
        </el-select>
        <el-button type="primary" @click="handleSearch">
          <el-icon><Search /></el-icon>搜索
        </el-button>
        <el-button @click="handleReset">
          <el-icon><Refresh /></el-icon>重置
        </el-button>
      </div>
      
      <div class="table-toolbar">
        <div class="toolbar-left">
          <el-button type="primary" @click="handleAdd">
            <el-icon><Plus /></el-icon>新增商品
          </el-button>
          <el-button type="success" plain>
            <el-icon><Upload /></el-icon>导入
          </el-button>
          <el-button type="warning" plain>
            <el-icon><Download /></el-icon>导出
          </el-button>
        </div>
      </div>
      
      <div class="table-container">
        <el-table :data="tableData" border stripe v-loading="loading">
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="name" label="商品名称" min-width="150" show-overflow-tooltip />
          <el-table-column prop="barCode" label="条码" width="140" />
          <el-table-column prop="categoryName" label="分类" width="120" />
          <el-table-column prop="retailPrice" label="零售价" width="100">
            <template #default="{ row }">
              <span class="amount">¥{{ row.retailPrice?.toFixed(2) || '0.00' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="stock" label="库存" width="80" />
          <el-table-column prop="status" label="状态" width="80">
            <template #default="{ row }">
              <el-tag :type="row.status === 1 ? 'success' : 'info'">
                {{ row.status === 1 ? '上架' : '下架' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="150" fixed="right">
            <template #default="{ row }">
              <el-button link type="primary" @click="handleEdit(row)">编辑</el-button>
              <el-button link type="primary" @click="handleView(row)">查看</el-button>
              <el-button link type="danger" @click="handleDelete(row)">删除</el-button>
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
  categoryId: undefined
})

const pagination = reactive({
  page: 1,
  size: 10,
  total: 0
})

const handleSearch = () => {
  // TODO: 调用Java API获取商品列表
  console.log('搜索商品', searchForm)
}

const handleReset = () => {
  searchForm.keyword = ''
  searchForm.categoryId = undefined
  handleSearch()
}

const handleAdd = () => {
  console.log('新增商品')
}

const handleEdit = (row: any) => {
  console.log('编辑商品', row)
}

const handleView = (row: any) => {
  console.log('查看商品', row)
}

const handleDelete = (row: any) => {
  console.log('删除商品', row)
}
</script>
