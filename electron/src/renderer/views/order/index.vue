<template>
  <div class="page-container">
    <div class="card">
      <h3>订单管理</h3>
      <el-table :data="tableData" border stripe v-loading="loading">
        <el-table-column prop="id" label="订单号" width="150" />
        <el-table-column prop="createTime" label="下单时间" width="170" />
        <el-table-column prop="customerName" label="客户" width="120" />
        <el-table-column prop="totalAmount" label="金额" width="100">
          <template #default="{ row }">
            <span class="amount">¥{{ row.totalAmount?.toFixed(2) || '0.00' }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'">
              {{ row.status === 1 ? '已完成' : '待处理' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template #default="{ row }">
            <el-button link type="primary" @click="handleView(row)">详情</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const loading = ref(false)
const tableData = ref<any[]>([])

const handleView = (row: any) => {
  console.log('查看订单', row)
}
</script>
