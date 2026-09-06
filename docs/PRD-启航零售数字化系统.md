# 启航零售数字化系统 — 产品需求文档（PRD）

| 项 | 内容 |
|---|---|
| 文档版本 | v4.0 |
| 创建日期 | 2026-07-22 |
| 更新日期 | 2026-09-06 |
| 产品代号 | qihang-retail |
| 文档状态 | 已发布 |
| 适用范围 | 开源版（Java版 + Electron桌面端） |

> **修订说明（v4.0）**：基于团队技术栈现状，重新定义双客户端架构。Electron桌面端定位为**纯前端壳**，只负责UI渲染和硬件驱动，所有业务逻辑由Java后端统一处理。

---

## 一、项目背景与目标

### 1.1 项目背景

线下零售门店（商超、便利、母婴、生鲜、烟酒、文具、3C数码等）正经历数字化转型。消费者对即时零售（美团闪购、淘宝闪购、京东到家、抖音小时达）的需求持续增长，但门店日常经营仍以**线下POS收银**为绝对核心。多数中小门店当前面临：

- 老旧收银系统功能单一、对账困难、不支持现代支付方式
- 商品/库存手工账，与即时零售平台库存割裂，频繁超卖
- 会员资产沉淀在收银本上，无法跨店跨渠道使用
- 即时零售平台订单依赖人工切换后台处理，漏单率高
- SaaS系统年费高、数据不在自己手里、被平台锁定

### 1.2 产品目标

打造一套**开源、可下载即用、功能完整**的零售数字化系统，覆盖：

- **线下POS全场景**：收银、会员、营销、财务、报表
- **即时零售**：对接美团闪购、淘宝闪购、京东到家、抖音小时达，订单/库存/商品统一管理

开源版面向**单店 / 连锁小店**，下载即用、零年费；企业版面向**连锁型大企业**，扩展加盟体系、业财一体、开放API。

---

## 二、产品定位与版本划分

### 2.1 核心定位

本产品基于 **Spring Boot 4.1 + Vue 3 + MySQL 8 + Redis 7** 架构，提供两个前端形态：

- **Vue Web端**：浏览器访问，管理后台 + POS收银
- **Electron桌面端**：本地安装，管理后台 + POS收银 + 硬件驱动

**核心原则**：所有业务逻辑由Java后端统一处理，Electron只做前端壳。

### 2.2 用户画像

**开源版用户**
- 单店经营 / 3-5家小店的连锁（超市、便利、生鲜、母婴、烟酒、3C、文具）
- 对数据自有、零年费有强诉求
- 业主自己或1-2名店员操作

**企业版用户**
- 5-500家门店的连锁品牌
- 直营+加盟混合业态
- 有总部IT/运营团队
- 需要与ERP/财务系统对接

### 2.3 版本功能矩阵

| 功能模块 | 开源版 | 企业版 |
|---|:---:|:---:|
| 商品/库存/采购/供应商（复用现有） | ✓ | ✓ |
| POS收银 | ✓ | ✓ |
| 会员/储值/积分 | ✓ | ✓ |
| 营销促销/优惠券 | ✓ | ✓ |
| 财务对账/数据报表 | ✓ | ✓ |
| Vue Web端（浏览器访问） | ✓ | ✓ |
| Electron桌面端（本地安装+硬件） | ✓ | ✓ |
| 即时零售对接（4平台） | ✓ | ✓ |
| 多门店连锁 | ✓ | ✓ |
| 加盟体系/分账 | ✗ | ✓ |
| 中心仓/智能调拨 | ✗ | ✓ |
| 业财一体化（凭证） | ✗ | ✓ |
| 跨店会员全域通用 | ✗ | ✓ |
| 私域商城对接 | ✗ | ✓ |
| AI智能补货/寻源 | ✗ | ✓ |
| 开放API/多租户SaaS | ✗ | ✓ |
| SLA与专属支持 | ✗ | ✓ |

---

## 三、系统总体设计

### 3.1 技术栈

| 层 | 技术 | 说明 |
|---|---|---|
| 后端 | Spring Boot 4.1 + MyBatis-Plus + Java 17 | 业务逻辑核心 |
| 数据库 | MySQL 8 + Redis 7 | 数据存储 |
| 安全 | Spring Security 7 + JWT | 认证授权 |
| Web前端 | Vue 3.5 + TypeScript + Vite 8 + Element Plus + Pinia | 管理后台+POS |
| 桌面端 | Electron 30 + Vue 3.5 | 本地安装应用 |

### 3.2 双客户端架构

```
┌─────────────────────────────────────────────────────────────┐
│                    客户端层                                  │
│  ┌──────────────────┐  ┌──────────────────────────────┐    │
│  │ Vue Web端        │  │ Electron桌面端               │    │
│  │ (Vue3 + 浏览器)  │  │ (Vue3 + Electron)            │    │
│  │                  │  │                              │    │
│  │ · 管理后台       │  │ · 管理后台（完整功能）       │    │
│  │ · POS收银        │  │ · POS收银（完整功能）        │    │
│  │                  │  │ · 硬件驱动（打印机/扫码枪）   │    │
│  └────────┬─────────┘  └──────────────┬───────────────┘    │
└───────────┼───────────────────────────┼─────────────────────┘
            │  HTTP + JWT              │  HTTP + JWT
┌───────────▼───────────────────────────▼─────────────────────┐
│  后端API层 (Spring Boot) - 业务逻辑唯一核心                  │
│  ┌────────┬────────┬────────┬────────┬────────┬───────┐   │
│  │  sys   │ goods  │  pos   │ member │ market │finance│   │
│  ├────────┼────────┼────────┼────────┼────────┼───────┤   │
│  │inventory│purchase│ store  │ report │  oms   │channel│   │
│  └────────┴────────┴────────┴────────┴────────┴───────┘   │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────┐
│  数据层: MySQL 8 + Redis 7                                  │
└─────────────────────────────────────────────────────────────┘
```

### 3.3 核心设计原则

| 原则 | 说明 |
|------|------|
| **业务逻辑统一** | 所有业务逻辑由Java后端处理，Electron不做业务 |
| **前端代码复用** | Vue组件在Web端和Electron端完全复用 |
| **硬件驱动独立** | Electron只负责硬件驱动（打印机/扫码枪/钱箱） |
| **API统一** | 两个客户端调用同一套Java API |
| **数据一致** | 所有数据存储在MySQL，无本地数据库 |

### 3.4 Electron桌面端职责

```
Electron桌面端
├── ✅ UI渲染（复用Vue组件）
├── ✅ 硬件驱动（打印机/扫码枪/钱箱/电子秤）
├── ✅ IPC通信（硬件操作转发）
├── ❌ 不做业务逻辑（全部转发给Java后端）
├── ❌ 不做本地数据库（所有数据存储在MySQL）
└── ❌ 不做数据缓存（实时调用Java API）
```

### 3.5 后端模块划分

基于现有 `cn.qihangerp` 包结构，**新增 `pos/` 业务包**，不动现有电商ERP代码。

```
erp-api/src/main/java/cn/qihangerp/
├── erp/                    (现有：电商ERP后台，保持不变)
├── sys/                    (现有：系统管理，保持不变)
└── pos/                    (新增：零售POS业务)
    ├── controller/
    │   ├── cashier/        POS收银（CashierController/ShiftController/RefundController）
    │   ├── member/         会员（MemberController）
    │   ├── marketing/      营销（PromotionController）
    │   ├── store/          门店组织（StoreController/EmployeeController）
    │   ├── finance/        财务（ReconcileController）
    │   ├── report/         报表（ReportController）
    │   └── hardware/       硬件代理（PrinterController/ScaleController）
    └── config/
```

---

## 四、Electron桌面端详细设计

### 4.1 架构设计

#### 4.1.1 进程架构

```
Electron应用
├── 主进程（Main Process）
│   ├── index.ts                    # 入口
│   ├── hardware/                   # 硬件驱动
│   │   ├── printer.ts              # 打印机驱动（ESC/POS）
│   │   ├── scanner.ts              # 扫码枪驱动（HID）
│   │   ├── drawer.ts               # 钱箱驱动
│   │   └── scale.ts                # 电子秤驱动（RS232）
│   └── ipc/                        # IPC通信
│       └── handlers.ts             # 硬件操作处理器
│
├── 渲染进程（Renderer Process）
│   ├── views/                      # 页面组件（复用Vue）
│   │   ├── login/                  # 登录页
│   │   ├── dashboard/              # 首页看板
│   │   ├── goods/                  # 商品管理
│   │   ├── inventory/              # 库存管理
│   │   ├── member/                 # 会员管理
│   │   ├── order/                  # 订单管理
│   │   ├── purchase/               # 采购管理
│   │   ├── pos/                    # POS收银
│   │   └── system/                 # 系统设置
│   │
│   ├── api/                        # API调用
│   │   ├── http.ts                 # HTTP客户端（调用Java后端）
│   │   └── index.ts                # API封装
│   │
│   ├── components/                 # 通用组件（复用Vue）
│   ├── router/                     # 路由配置
│   ├── store/                      # 状态管理
│   └── utils/                      # 工具函数
│
└── preload.ts                      # 预加载脚本（IPC桥接）
```

#### 4.1.2 数据流

```
用户操作
    ↓
Vue组件处理UI事件
    ↓
调用API（http.ts）
    ↓
HTTP请求发送到Java后端
    ↓
Java后端处理业务逻辑
    ↓
返回JSON响应
    ↓
Vue组件更新UI

硬件操作（打印/扫码）
    ↓
Vue组件调用IPC
    ↓
主进程处理硬件操作
    ↓
返回结果给渲染进程
```

### 4.2 目录结构

```
electron/
├── src/
│   ├── main/
│   │   ├── index.ts                # 主进程入口
│   │   ├── hardware/
│   │   │   ├── printer.ts          # 打印机驱动
│   │   │   ├── scanner.ts          # 扫码枪驱动
│   │   │   ├── drawer.ts           # 钱箱驱动
│   │   │   └── scale.ts            # 电子秤驱动
│   │   └── ipc/
│   │       └── handlers.ts         # IPC处理器
│   │
│   ├── renderer/
│   │   ├── views/
│   │   │   ├── login/
│   │   │   │   └── index.vue
│   │   │   ├── dashboard/
│   │   │   │   └── index.vue
│   │   │   ├── goods/
│   │   │   │   ├── index.vue
│   │   │   │   └── components/
│   │   │   ├── inventory/
│   │   │   │   └── index.vue
│   │   │   ├── member/
│   │   │   │   └── index.vue
│   │   │   ├── order/
│   │   │   │   └── index.vue
│   │   │   ├── purchase/
│   │   │   │   └── index.vue
│   │   │   ├── pos/
│   │   │   │   ├── index.vue       # 收银台主界面
│   │   │   │   └── components/
│   │   │   └── system/
│   │   │       └── index.vue
│   │   │
│   │   ├── api/
│   │   │   ├── http.ts             # HTTP客户端
│   │   │   ├── login.ts            # 登录API
│   │   │   ├── goods.ts            # 商品API
│   │   │   ├── inventory.ts        # 库存API
│   │   │   ├── member.ts           # 会员API
│   │   │   ├── order.ts            # 订单API
│   │   │   ├── pos.ts              # POS API
│   │   │   └── system.ts           # 系统API
│   │   │
│   │   ├── components/
│   │   │   ├── Layout/
│   │   │   └── common/
│   │   │
│   │   ├── router/
│   │   │   └── index.ts
│   │   │
│   │   ├── store/
│   │   │   └── index.ts
│   │   │
│   │   ├── styles/
│   │   │   └── index.scss
│   │   │
│   │   ├── utils/
│   │   │   ├── request.ts
│   │   │   └── auth.ts
│   │   │
│   │   ├── App.vue
│   │   └── main.ts
│   │
│   └── preload.ts
│
├── electron-builder.yml            # 打包配置
├── package.json
├── tsconfig.json
├── vite.config.ts
└── README.md
```

### 4.3 硬件驱动设计

#### 4.3.1 打印机驱动

```typescript
// electron/src/main/hardware/printer.ts
import { SerialPort } from 'serialport'
import { BrowserWindow } from 'electron'

export class PrinterDriver {
  private port: SerialPort | null = null

  // 连接打印机
  async connect(port: string, baudRate: number = 9600) {
    this.port = new SerialPort({ path: port, baudRate })
  }

  // 打印小票
  async printReceipt(data: ReceiptData) {
    if (!this.port) throw new Error('打印机未连接')

    const commands = this.buildESCPOSCommands(data)
    this.port.write(commands)
  }

  // 构建ESC/POS指令
  private buildESCPOSCommands(data: ReceiptData): Buffer {
    // ESC/POS指令集
    const commands: number[] = []
    
    // 初始化
    commands.push(0x1B, 0x40)
    
    // 居中
    commands.push(0x1B, 0x61, 0x01)
    
    // 打印门店名
    const storeName = this.textToBytes(data.storeName)
    commands.push(...storeName)
    commands.push(0x0A) // 换行
    
    // 左对齐
    commands.push(0x1B, 0x61, 0x00)
    
    // 打印商品列表
    for (const item of data.items) {
      const line = `${item.name}  x${item.quantity}  ¥${item.price}`
      commands.push(...this.textToBytes(line))
      commands.push(0x0A)
    }
    
    // 分割线
    commands.push(...this.textToBytes('-----------------------------'))
    commands.push(0x0A)
    
    // 合计
    const total = `合计: ¥${data.totalAmount}`
    commands.push(...this.textToBytes(total))
    commands.push(0x0A)
    
    // 切纸
    commands.push(0x1D, 0x56, 0x00)
    
    return Buffer.from(commands)
  }

  private textToBytes(text: string): number[] {
    // 简化处理，实际需要GBK编码
    return Array.from(Buffer.from(text, 'utf-8'))
  }
}
```

#### 4.3.2 扫码枪驱动

```typescript
// electron/src/main/hardware/scanner.ts
import { HID } from 'node-hid'

export class ScannerDriver {
  private device: HID.HID | null = null

  // 连接扫码枪
  async connect(vendorId?: number, productId?: number) {
    const devices = HID.devices()
    const targetDevice = devices.find(d => 
      (!vendorId || d.vendorId === vendorId) &&
      (!productId || d.productId === productId)
    )
    
    if (targetDevice) {
      this.device = new HID.HID(targetDevice.path)
    }
  }

  // 读取扫码数据
  onData(callback: (barcode: string) => void) {
    if (!this.device) return

    this.device.on('data', (data) => {
      // 解析HID数据为条码字符串
      const barcode = this.parseHIDData(data)
      callback(barcode)
    })
  }

  private parseHIDData(data: Buffer): string {
    // HID键盘模式数据解析
    // 实际实现需要根据扫码枪型号调整
    return data.toString('utf-8').replace(/\0/g, '')
  }
}
```

#### 4.3.3 IPC通信

```typescript
// electron/src/main/ipc/handlers.ts
import { ipcMain } from 'electron'
import { PrinterDriver } from '../hardware/printer'
import { ScannerDriver } from '../hardware/scanner'

const printer = new PrinterDriver()
const scanner = new ScannerDriver()

export function registerIPCHandlers() {
  // 打印小票
  ipcMain.handle('hardware:print', async (event, data) => {
    try {
      await printer.printReceipt(data)
      return { success: true }
    } catch (error) {
      return { success: false, error: error.message }
    }
  })

  // 连接打印机
  ipcMain.handle('hardware:printer:connect', async (event, port) => {
    try {
      await printer.connect(port)
      return { success: true }
    } catch (error) {
      return { success: false, error: error.message }
    }
  })

  // 打开钱箱
  ipcMain.handle('hardware:drawer:open', async () => {
    // 钱箱通过打印机pulse信号控制
    // ESC/POS指令: 0x1B 0x70 0x00 0x19 0xFA
    return { success: true }
  })

  // 读取电子秤重量
  ipcMain.handle('hardware:scale:read', async () => {
    // 通过串口读取电子秤数据
    return { success: true, weight: 0 }
  })
}
```

### 4.4 API调用设计

#### 4.4.1 HTTP客户端

```typescript
// electron/src/renderer/api/http.ts
import axios from 'axios'
import { ElMessage } from 'element-plus'

const http = axios.create({
  baseURL: 'http://localhost:8088',
  timeout: 10000
})

// 请求拦截器
http.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => Promise.reject(error)
)

// 响应拦截器
http.interceptors.response.use(
  response => {
    const { code, msg, data } = response.data
    if (code === 200) {
      return data
    } else {
      ElMessage.error(msg || '请求失败')
      return Promise.reject(new Error(msg))
    }
  },
  error => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token')
      window.location.href = '/login'
    }
    ElMessage.error('网络错误')
    return Promise.reject(error)
  }
)

export default http
```

#### 4.4.2 API封装示例

```typescript
// electron/src/renderer/api/goods.ts
import http from './http'

export function getGoodsList(params: any) {
  return http.get('/api/goods/list', { params })
}

export function getGoodsById(id: number) {
  return http.get(`/api/goods/${id}`)
}

export function addGoods(data: any) {
  return http.post('/api/goods/add', data)
}

export function updateGoods(data: any) {
  return http.put('/api/goods/edit', data)
}

export function deleteGoods(id: number) {
  return http.delete(`/api/goods/del`, { params: { id } })
}
```

```typescript
// electron/src/renderer/api/pos.ts
import http from './http'

export function searchGoodsByBarcode(barcode: string) {
  return http.get(`/pos-api/goods/barcode/${barcode}`)
}

export function submitOrder(data: any) {
  return http.post('/pos-api/cashier/submit', data)
}

export function getOrderList(params: any) {
  return http.get('/pos-api/cashier/order/list', { params })
}
```

### 4.5 功能模块

#### 4.5.1 登录模块

| 功能 | 说明 |
|------|------|
| 账号密码登录 | 调用Java后端 `/api/sys-api/login` |
| Token存储 | localStorage |
| 自动登录 | 启动时检查Token有效性 |

#### 4.5.2 首页看板

| 功能 | 说明 |
|------|------|
| 今日销售额 | 调用Java API |
| 今日订单数 | 调用Java API |
| 会员统计 | 调用Java API |
| 库存预警 | 调用Java API |

#### 4.5.3 商品管理

| 功能 | 说明 |
|------|------|
| 商品列表 | 调用Java API |
| 商品新增/编辑/删除 | 调用Java API |
| SKU管理 | 调用Java API |
| 分类管理 | 调用Java API |
| 品牌管理 | 调用Java API |
| 批量导入/导出 | 调用Java API |

#### 4.5.4 库存管理

| 功能 | 说明 |
|------|------|
| 库存查询 | 调用Java API |
| 入库管理 | 调用Java API |
| 出库管理 | 调用Java API |
| 库存盘点 | 调用Java API |
| 库存预警 | 调用Java API |

#### 4.5.5 会员管理

| 功能 | 说明 |
|------|------|
| 会员列表 | 调用Java API |
| 会员新增/编辑 | 调用Java API |
| 积分管理 | 调用Java API |
| 储值管理 | 调用Java API |

#### 4.5.6 订单管理

| 功能 | 说明 |
|------|------|
| 订单列表 | 调用Java API |
| 订单详情 | 调用Java API |
| 退货退款 | 调用Java API |

#### 4.5.7 POS收银

| 功能 | 说明 |
|------|------|
| 收银台 | 扫码枪/键盘输入，调用Java API查询商品 |
| 购物车管理 | 前端状态管理 |
| 支付 | 调用Java API提交订单 |
| 小票打印 | 调用本地打印机驱动 |
| 退货 | 调用Java API |
| 班次管理 | 调用Java API |

#### 4.5.8 系统设置

| 功能 | 说明 |
|------|------|
| 用户管理 | 调用Java API |
| 角色管理 | 调用Java API |
| 字典管理 | 调用Java API |
| 硬件配置 | 本地配置（打印机/扫码枪端口） |

### 4.6 打包配置

```yaml
# electron-builder.yml
appId: com.qihang.retail
productName: 启航零售ERP
directories:
  output: dist
files:
  - dist/**/*
  - package.json
win:
  target: nsis
  icon: build/icon.ico
mac:
  target: dmg
  icon: build/icon.icns
linux:
  target: AppImage
  icon: build/icon.png
nsis:
  oneClick: false
  allowToChangeInstallationDirectory: true
  createDesktopShortcut: true
  createStartMenuShortcut: true
```

---

## 五、第一期：线下零售场景功能需求

### 5.1 POS收银模块

#### 5.1.1 收银台（F-CASHIER-001）

**功能点**：
- 商品添加：扫码枪扫码（HID模式）、键盘输入条码、按名称模糊搜索
- 数量调整：±按钮、键盘输入、计件/称重
- 整单操作：挂单、取单、清空
- 折扣应用：调用Java后端折扣规则引擎
- 会员应用：扫码/手机号识别
- 支付：现金/微信/支付宝/银行卡/会员余额/组合支付

**业务规则**：
- 单笔订单最大商品行数：200
- 挂单超过24小时自动作废
- 抹零精度支持1元/0.1元/0.01元配置

#### 5.1.2 退货退款（F-CASHIER-002）

**功能点**：
- 整单退货/部分退货
- 退款方式：原路退回、现金退款
- 退货原因（可配置字典）
- 金额>阈值需店长审核

#### 5.1.3 班次管理（F-CASHIER-003）

**功能点**：
- 开班：收银员登录后开班
- 交班：统计当班期间所有交易（按支付方式汇总）
- 班次对账单：实收 vs 应收，差异预警
- 班次历史查询

#### 5.1.4 小票打印（F-CASHIER-004）

**功能点**：
- 打印机支持：USB小票机（ESC/POS）、网口小票机
- 小票内容：门店名/商品列表/优惠明细/支付明细/会员积分
- 58mm/80mm纸张规格
- 打印失败自动重试2次

### 5.2 商品管理模块

#### 5.2.1 商品档案（F-GOODS-001）

**功能点**：
- SPU/SKU模型
- 必填字段：商品名称、分类、单位、零售价、条码
- 批量Excel导入/导出
- 批量上下架

### 5.3 库存管理模块

#### 5.3.1 实时库存查询（F-STOCK-001）

#### 5.3.2 入库管理（F-STOCK-002）

#### 5.3.3 出库管理（F-STOCK-003）

#### 5.3.4 库存盘点（F-STOCK-004）

### 5.4 会员管理模块

#### 5.4.1 会员档案（F-MEMBER-001）

#### 5.4.2 会员等级（F-MEMBER-002）

#### 5.4.3 储值管理（F-MEMBER-003）

#### 5.4.4 积分管理（F-MEMBER-004）

### 5.5 营销促销模块

#### 5.5.1 促销活动（F-MKT-001）

### 5.6 门店与组织模块

#### 5.6.1 门店档案（F-STORE-001）

#### 5.6.2 营业员管理（F-STORE-002）

### 5.7 数据报表模块

| 报表 | 数据源 |
|---|---|
| 销售日报/月报 | erp_sales_order + o_shop_daily |
| 商品销售排行 | erp_sales_order_item |
| 库存报表 | o_goods_inventory |
| 员工业绩 | erp_sales_order + erp_sales_person |

### 5.8 系统管理模块（复用现有）

复用 `sys/` 现有功能：用户、角色、菜单、字典、参数配置、操作日志、登录日志、部门。

---

## 六、第二期：即时零售对接功能需求

### 6.1 平台店铺授权

**扩展**：在 `o_shop_platform` 中新增4条记录
- 1100 美团闪购
- 1200 淘宝闪购（饿了么零售）
- 1300 京东到家
- 1400 抖音小时达

### 6.2 商品同步

### 6.3 订单管理

---

## 七、企业版进阶功能

### 7.1 加盟体系（F-ENT-001）
### 7.2 中心仓与智能调拨（F-ENT-002）
### 7.3 业财一体化（F-ENT-003）
### 7.4 跨店会员全域通用（F-ENT-004）
### 7.5 私域商城对接（F-ENT-005）
### 7.6 AI能力（F-ENT-006）
### 7.7 开放API与多租户SaaS（F-ENT-007）

---

## 八、非功能性需求

### 8.1 性能
- POS收银响应：扫码到显示商品 < 200ms
- 收银提交到小票打印 < 1秒
- 后端API平均响应 < 500ms

### 8.2 可用性
- 服务端99.5%可用性
- 数据每日自动备份

### 8.3 安全
- JWT Token认证
- 按钮级权限控制
- 敏感操作日志

### 8.4 兼容性
- Electron桌面端：Windows 10+/macOS 10.15+/Linux
- Web后台：Chrome 90+/Edge 90+/Safari 14+
- 数据库：MySQL 8.0+
- Redis：7.0+

---

## 九、实施计划与里程碑

### 9.1 第一期：线下POS全场景

**MVP版本（4周）**
- Electron桌面端基础框架
- 登录 + 权限
- POS收银台（核心流程）
- 小票打印

**Beta版本（再4周）**
- 商品管理
- 库存管理
- 会员管理
- 订单管理

**Release版本（再4周）**
- 采购管理
- 报表统计
- 系统设置
- 硬件驱动完善

### 9.2 第二期：即时零售对接

---

## 十、风险与依赖

### 10.1 技术风险

| 风险 | 影响 | 缓解措施 |
|---|---|---|
| Electron跨平台兼容性 | 中 | 优先支持Windows，macOS/Linux后续 |
| 硬件驱动适配 | 中 | 支持主流打印机型号，提供配置界面 |

### 10.2 外部依赖

- 微信支付/支付宝支付商户号（商家自行申请）

---

## 十一、附录

### 11.1 术语表

| 术语 | 说明 |
|---|---|
| POS | Point of Sale，销售点收银系统 |
| SPU | Standard Product Unit，标准化产品单元 |
| SKU | Stock Keeping Unit，库存量单位 |
| OMS | Order Management System，订单管理系统 |
| IPC | Inter-Process Communication，进程间通信 |
| ESC/POS | 热敏打印机控制指令集 |

### 11.2 修订记录

| 版本 | 日期 | 修订内容 | 作者 |
|---|---|---|---|
| v1.0 | 2026-07-22 | 初始版本 | - |
| v2.0 | 2026-07-22 | 基于现有SQL表结构重新设计 | - |
| v3.0 | 2026-07-22 | 零新增表方案 | - |
| v4.0 | 2026-09-06 | 重新定义双客户端架构，Electron定位为纯前端壳 | - |
