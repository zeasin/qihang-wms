<template>
  <div class="page-container">
    <div class="welcome-card card">
      <h2>欢迎使用启航零售ERP</h2>
      <p>桌面收银端 v1.0.0</p>
    </div>
    
    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stat-row">
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background-color: #409eff">
            <el-icon :size="28"><Money /></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-value">¥0.00</div>
            <div class="stat-label">今日销售额</div>
          </div>
        </div>
      </el-col>
      
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background-color: #67c23a">
            <el-icon :size="28"><Document /></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-value">0</div>
            <div class="stat-label">今日订单数</div>
          </div>
        </div>
      </el-col>
      
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background-color: #e6a23c">
            <el-icon :size="28"><User /></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-value">0</div>
            <div class="stat-label">会员总数</div>
          </div>
        </div>
      </el-col>
      
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background-color: #f56c6c">
            <el-icon :size="28"><Warning /></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-value">0</div>
            <div class="stat-label">库存预警</div>
          </div>
        </div>
      </el-col>
    </el-row>
    
    <!-- 快捷操作 -->
    <div class="card">
      <h3 class="card-title">快捷操作</h3>
      <div class="quick-actions">
        <el-button type="primary" size="large" @click="$router.push('/pos')">
          <el-icon><Money /></el-icon>
          <span>POS收银</span>
        </el-button>
        <el-button type="success" size="large" @click="$router.push('/goods')">
          <el-icon><Goods /></el-icon>
          <span>商品管理</span>
        </el-button>
        <el-button type="warning" size="large" @click="$router.push('/inventory')">
          <el-icon><Box /></el-icon>
          <span>库存查询</span>
        </el-button>
        <el-button type="info" size="large" @click="$router.push('/member')">
          <el-icon><User /></el-icon>
          <span>会员管理</span>
        </el-button>
      </div>
    </div>
    
    <!-- 系统信息 -->
    <div class="card">
      <h3 class="card-title">系统信息</h3>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="系统版本">v1.0.0</el-descriptions-item>
        <el-descriptions-item label="运行环境">Electron Desktop</el-descriptions-item>
        <el-descriptions-item label="后端地址">http://localhost:8088</el-descriptions-item>
        <el-descriptions-item label="数据库">MySQL 8</el-descriptions-item>
      </el-descriptions>
    </div>
  </div>
</template>

<script setup lang="ts">
// 首页看板
</script>

<style lang="scss" scoped>
.welcome-card {
  h2 {
    margin: 0 0 8px 0;
    color: #303133;
    font-size: 24px;
  }
  
  p {
    margin: 0;
    color: #909399;
    font-size: 14px;
  }
}

.stat-row {
  margin-bottom: 20px;
}

.stat-card {
  display: flex;
  align-items: center;
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  
  .stat-icon {
    width: 56px;
    height: 56px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    margin-right: 16px;
  }
  
  .stat-info {
    flex: 1;
    
    .stat-value {
      font-size: 24px;
      font-weight: 600;
      color: #303133;
      margin-bottom: 4px;
    }
    
    .stat-label {
      font-size: 14px;
      color: #909399;
    }
  }
}

.card-title {
  margin: 0 0 16px 0;
  font-size: 16px;
  font-weight: 500;
  color: #303133;
}

.quick-actions {
  display: flex;
  gap: 16px;
  
  .el-button {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 120px;
    height: 80px;
    
    .el-icon {
      margin-bottom: 8px;
    }
  }
}
</style>
