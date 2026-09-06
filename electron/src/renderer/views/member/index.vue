<template>
  <div class="page-container">
    <div class="card">
      <div class="search-bar">
        <el-input
          v-model="searchForm.phone"
          placeholder="手机号"
          clearable
          @keyup.enter="handleSearch"
        />
        <el-input
          v-model="searchForm.name"
          placeholder="会员姓名"
          clearable
          @keyup.enter="handleSearch"
        />
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
            <el-icon><Plus /></el-icon>新增会员
          </el-button>
        </div>
      </div>
      
      <div class="table-container">
        <el-table :data="tableData" border stripe v-loading="loading">
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="name" label="姓名" width="100" />
          <el-table-column prop="phone" label="手机号" width="130" />
          <el-table-column prop="levelName" label="等级" width="100" />
          <el-table-column prop="points" label="积分" width="80" />
          <el-table-column prop="storedBalance" label="储值余额" width="100">
            <template #default="{ row }">
              <span class="amount">¥{{ row.storedBalance?.toFixed(2) || '0.00' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="totalConsumption" label="累计消费" width="100">
            <template #default="{ row }">
              <span class="amount">¥{{ row.totalConsumption?.toFixed(2) || '0.00' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="visitCount" label="消费次数" width="90" />
          <el-table-column label="操作" width="150" fixed="right">
            <template #default="{ row }">
              <el-button link type="primary" @click="handleEdit(row)">编辑</el-button>
              <el-button link type="primary" @click="handleView(row)">详情</el-button>
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
  phone: '',
  name: ''
})

const pagination = reactive({
  page: 1,
  size: 10,
  total: 0
})

const handleSearch = () => {
  console.log('搜索会员', searchForm)
}

const handleReset = () => {
  searchForm.phone = ''
  searchForm.name = ''
  handleSearch()
}

const handleAdd = () => {
  console.log('新增会员')
}

const handleEdit = (row: any) => {
  console.log('编辑会员', row)
}

const handleView = (row: any) => {
  console.log('查看会员', row)
}
</script>
