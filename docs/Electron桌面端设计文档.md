# 启航零售ERP — Electron桌面端设计文档

| 项 | 内容 |
|---|---|
| 文档版本 | v1.0 |
| 创建日期 | 2026-09-06 |
| 产品代号 | qihang-retail-electron |
| 文档状态 | 已发布 |

---

## 一、概述

### 1.1 产品定位

Electron桌面端是启航零售ERP的**本地安装版本**，提供完整的管理后台和POS收银功能。作为纯前端壳，所有业务逻辑调用Java后端API，Electron只负责UI渲染和硬件驱动对接。

### 1.2 核心原则

| 原则 | 说明 |
|------|------|
| **业务逻辑统一** | 所有业务逻辑由Java后端处理，Electron不做业务 |
| **前端代码复用** | Vue组件在Web端和Electron端完全复用 |
| **硬件驱动独立** | Electron只负责硬件驱动（打印机/扫码枪/钱箱） |
| **API统一** | 两个客户端调用同一套Java API |
| **数据一致** | 所有数据存储在MySQL，无本地数据库 |

### 1.3 与Vue Web端对比

| 维度 | Vue Web端 | Electron桌面端 |
|------|----------|---------------|
| 功能 | 完整（管理+POS） | 完整（管理+POS） |
| 部署 | 浏览器访问 | 本地安装 |
| 硬件 | 无 | 打印机/扫码枪/钱箱 |
| 网络 | 需要网络 | 需要网络 |
| 后端 | Java | Java（同一套） |
| 前端代码 | Vue | Vue（复用） |
| 本地存储 | 无 | 无 |

---

## 二、架构设计

### 2.1 整体架构

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

### 2.2 Electron进程架构

```
Electron应用
├── 主进程（Main Process）- Node.js环境
│   ├── index.ts                    # 入口
│   ├── window.ts                   # 窗口管理
│   ├── hardware/                   # 硬件驱动
│   │   ├── printer.ts              # 打印机驱动（ESC/POS）
│   │   ├── scanner.ts              # 扫码枪驱动（HID）
│   │   ├── drawer.ts               # 钱箱驱动
│   │   └── scale.ts                # 电子秤驱动（RS232）
│   └── ipc/                        # IPC通信
│       └── handlers.ts             # 硬件操作处理器
│
├── 渲染进程（Renderer Process）- Chromium环境
│   ├── views/                      # 页面组件（复用Vue）
│   ├── api/                        # API调用
│   ├── components/                 # 通用组件（复用Vue）
│   ├── router/                     # 路由配置
│   ├── store/                      # 状态管理
│   └── utils/                      # 工具函数
│
└── preload.ts                      # 预加载脚本（IPC桥接）
```

### 2.3 数据流

```
┌─────────────────────────────────────────────────────────────┐
│                    渲染进程（Renderer Process）               │
│  ┌─────────────┐                                           │
│  │  Vue组件    │ ─── 用户交互 ───→ 触发API调用             │
│  └─────────────┘                                           │
│        │                                                    │
│        ↓                                                    │
│  ┌─────────────┐                                           │
│  │  API层      │ ─── HTTP请求 ───→ Java后端               │
│  └─────────────┘                                           │
│        │                                                    │
│        ↓                                                    │
│  ┌─────────────┐                                           │
│  │  IPC调用    │ ─── 硬件操作 ───→ 主进程                 │
│  └─────────────┘                                           │
└─────────────────────────────────────────────────────────────┘
                          │
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    主进程（Main Process）                    │
│  ┌─────────────┐                                           │
│  │  IPC处理器  │ ─── 接收调用 ───→ 执行硬件操作           │
│  └─────────────┘                                           │
│        │                                                    │
│        ↓                                                    │
│  ┌─────────────┐                                           │
│  │  硬件驱动  │ ─── 串口/USB ───→ 打印机/扫码枪          │
│  └─────────────┘                                           │
└─────────────────────────────────────────────────────────────┘
                          │
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    Java后端（Spring Boot）                  │
│  ┌─────────────┐                                           │
│  │  Controller │ ─── 接收请求 ───→ 业务逻辑处理           │
│  └─────────────┘                                           │
│        │                                                    │
│        ↓                                                    │
│  ┌─────────────┐                                           │
│  │  Service    │ ─── 业务处理 ───→ 数据库操作             │
│  └─────────────┘                                           │
│        │                                                    │
│        ↓                                                    │
│  ┌─────────────┐                                           │
│  │  Mapper     │ ─── SQL执行 ───→ MySQL                   │
│  └─────────────┘                                           │
└─────────────────────────────────────────────────────────────┘
```

---

## 三、目录结构

### 3.1 项目结构

```
qihang-retail/
│
├── vue/                          # Web前端（保持不变）
│   └── src/
│       ├── views/                # 页面组件
│       ├── api/                  # API接口
│       ├── components/           # 通用组件
│       └── ...
│
├── electron/                     # Electron桌面端（新增）
│   ├── src/
│   │   ├── main/                 # 主进程
│   │   │   ├── index.ts          # 入口
│   │   │   ├── window.ts         # 窗口管理
│   │   │   ├── hardware/         # 硬件驱动
│   │   │   │   ├── printer.ts    # 打印机驱动
│   │   │   │   ├── scanner.ts    # 扫码枪驱动
│   │   │   │   ├── drawer.ts     # 钱箱驱动
│   │   │   │   └── scale.ts      # 电子秤驱动
│   │   │   └── ipc/              # IPC通信
│   │   │       └── handlers.ts   # IPC处理器
│   │   │
│   │   ├── renderer/             # 渲染进程
│   │   │   ├── views/            # 页面组件（复用vue）
│   │   │   │   ├── login/
│   │   │   │   ├── dashboard/
│   │   │   │   ├── goods/
│   │   │   │   ├── inventory/
│   │   │   │   ├── member/
│   │   │   │   ├── order/
│   │   │   │   ├── purchase/
│   │   │   │   ├── pos/
│   │   │   │   └── system/
│   │   │   │
│   │   │   ├── api/              # API调用
│   │   │   │   ├── http.ts       # HTTP客户端
│   │   │   │   ├── login.ts
│   │   │   │   ├── goods.ts
│   │   │   │   ├── inventory.ts
│   │   │   │   ├── member.ts
│   │   │   │   ├── order.ts
│   │   │   │   ├── pos.ts
│   │   │   │   └── system.ts
│   │   │   │
│   │   │   ├── components/       # 通用组件（复用vue）
│   │   │   ├── router/           # 路由配置
│   │   │   ├── store/            # 状态管理
│   │   │   ├── styles/           # 样式
│   │   │   ├── utils/            # 工具函数
│   │   │   ├── App.vue
│   │   │   └── main.ts
│   │   │
│   │   └── preload.ts            # 预加载脚本
│   │
│   ├── public/                   # 静态资源
│   ├── build/                    # 构建资源（图标等）
│   ├── electron-builder.yml      # 打包配置
│   ├── package.json
│   ├── tsconfig.json
│   ├── vite.config.ts
│   └── README.md
│
├── erp-api/                      # Java后端（保持不变）
├── common/
├── security/
├── model/
├── mapper/
├── service/
└── README.md
```

### 3.2 核心文件说明

| 文件 | 说明 |
|------|------|
| `main/index.ts` | 主进程入口，初始化应用 |
| `main/window.ts` | 窗口创建和管理 |
| `main/hardware/*.ts` | 硬件驱动（打印机/扫码枪/钱箱/电子秤） |
| `main/ipc/handlers.ts` | IPC通信处理器 |
| `preload.ts` | 预加载脚本，暴露安全的API给渲染进程 |
| `renderer/api/http.ts` | HTTP客户端，调用Java后端 |
| `renderer/views/` | 页面组件，复用Vue代码 |

---

## 四、硬件驱动设计

### 4.1 打印机驱动

#### 4.1.1 功能说明

支持USB/串口/网口热敏打印机，使用ESC/POS指令集。

#### 4.1.2 实现代码

```typescript
// electron/src/main/hardware/printer.ts
import { SerialPort } from 'serialport'
import net from 'net'

export interface PrinterConfig {
  type: 'serial' | 'usb' | 'network'
  port?: string          // 串口：COM3, /dev/ttyUSB0
  baudRate?: number      // 波特率：9600, 19200, 38400, 115200
  host?: string          // 网口：192.168.1.100
  printPort?: number     // 网口：9100
}

export interface ReceiptData {
  storeName: string
  storeAddress?: string
  storePhone?: string
  orderNo: string
  items: ReceiptItem[]
  totalAmount: number
  payMethod: string
  payAmount: number
  change?: number
  memberName?: string
  memberPoints?: number
  createTime: string
  cashier?: string
}

export interface ReceiptItem {
  name: string
  spec?: string
  quantity: number
  price: number
  subtotal: number
}

export class PrinterDriver {
  private serialPort: SerialPort | null = null
  private tcpSocket: net.Socket | null = null
  private config: PrinterConfig | null = null

  // 连接打印机
  async connect(config: PrinterConfig): Promise<void> {
    this.config = config

    if (config.type === 'serial' || config.type === 'usb') {
      this.serialPort = new SerialPort({
        path: config.port || 'COM3',
        baudRate: config.baudRate || 9600
      })
    } else if (config.type === 'network') {
      this.tcpSocket = net.createConnection(
        config.printPort || 9100,
        config.host || '192.168.1.100'
      )
    }
  }

  // 断开连接
  disconnect(): void {
    if (this.serialPort) {
      this.serialPort.close()
      this.serialPort = null
    }
    if (this.tcpSocket) {
      this.tcpSocket.destroy()
      this.tcpSocket = null
    }
  }

  // 打印小票
  async printReceipt(data: ReceiptData): Promise<void> {
    const commands = this.buildReceiptCommands(data)
    await this.send(commands)
  }

  // 构建小票指令
  private buildReceiptCommands(data: ReceiptData): Buffer {
    const lines: string[] = []

    // 初始化
    lines.push('\x1B\x40')  // ESC @

    // 门店信息（居中）
    lines.push('\x1B\x61\x01')  // 居中对齐
    lines.push('\x1B\x21\x10')  // 放大字体
    lines.push(data.storeName)
    lines.push('\x1B\x21\x00')  // 恢复正常
    lines.push('\x1B\x61\x00')  // 左对齐

    if (data.storeAddress) {
      lines.push(data.storeAddress)
    }
    if (data.storePhone) {
      lines.push(`电话: ${data.storePhone}`)
    }

    lines.push('─'.repeat(32))

    // 订单信息
    lines.push(`订单号: ${data.orderNo}`)
    lines.push(`时间: ${data.createTime}`)
    if (data.cashier) {
      lines.push(`收银员: ${data.cashier}`)
    }

    lines.push('─'.repeat(32))

    // 商品列表
    for (const item of data.items) {
      const name = item.name.length > 16 
        ? item.name.substring(0, 16) 
        : item.name
      lines.push(`${name}`)
      lines.push(`  ${item.spec || ''} x${item.quantity}  ¥${item.subtotal.toFixed(2)}`)
    }

    lines.push('─'.repeat(32))

    // 合计
    lines.push(`\x1B\x21\x10合计: ¥${data.totalAmount.toFixed(2)}\x1B\x21\x00`)

    // 支付信息
    lines.push(`支付方式: ${data.payMethod}`)
    lines.push(`实收: ¥${data.payAmount.toFixed(2)}`)
    if (data.change !== undefined && data.change > 0) {
      lines.push(`找零: ¥${data.change.toFixed(2)}`)
    }

    // 会员信息
    if (data.memberName) {
      lines.push('─'.repeat(32))
      lines.push(`会员: ${data.memberName}`)
      if (data.memberPoints !== undefined) {
        lines.push(`获得积分: ${data.memberPoints}`)
      }
    }

    lines.push('')
    lines.push('')
    lines.push('')

    // 切纸
    lines.push('\x1D\x56\x00')

    return Buffer.from(lines.join('\n'), 'utf-8')
  }

  // 发送数据
  private async send(data: Buffer): Promise<void> {
    return new Promise((resolve, reject) => {
      if (this.serialPort && this.serialPort.isOpen) {
        this.serialPort.write(data, (err) => {
          if (err) reject(err)
          else resolve()
        })
      } else if (this.tcpSocket) {
        this.tcpSocket.write(data, (err) => {
          if (err) reject(err)
          else resolve()
        })
      } else {
        reject(new Error('打印机未连接'))
      }
    })
  }

  // 测试打印
  async testPrint(): Promise<void> {
    const testData: ReceiptData = {
      storeName: '启航零售',
      orderNo: 'TEST001',
      items: [
        { name: '测试商品', quantity: 1, price: 10.00, subtotal: 10.00 }
      ],
      totalAmount: 10.00,
      payMethod: '现金',
      payAmount: 10.00,
      createTime: new Date().toLocaleString('zh-CN')
    }
    await this.printReceipt(testData)
  }
}
```

### 4.2 扫码枪驱动

#### 4.2.1 功能说明

支持USB HID模式扫码枪（键盘模式），自动识别条码输入。

#### 4.2.2 实现代码

```typescript
// electron/src/main/hardware/scanner.ts
import { BrowserWindow } from 'electron'

export class ScannerDriver {
  private buffer: string = ''
  private lastTime: number = 0
  private timeout: NodeJS.Timeout | null = null

  // 初始化扫码枪监听
  init(window: BrowserWindow): void {
    // 大多数扫码枪使用键盘模式（HID）
    // 直接在渲染进程的input元素中监听即可
    // 此处提供辅助功能
  }

  // 解析扫码数据（用于非键盘模式的扫码枪）
  parseData(data: Buffer): string | null {
    // 检查数据有效性
    if (data.length === 0) return null

    // 尝试不同编码
    const encodings = ['utf-8', 'ascii', 'gbk']
    
    for (const encoding of encodings) {
      try {
        const text = data.toString(encoding as BufferEncoding)
        if (text && text.length > 0) {
          return text.trim()
        }
      } catch {
        continue
      }
    }

    return null
  }

  // 验证条码格式
  validateBarcode(barcode: string): boolean {
    // 常见条码格式验证
    const patterns = [
      /^\d{12,13}$/,     // EAN-13
      /^\d{8}$/,         // EAN-8
      /^\d{14}$/,        // GTIN-14
      /^\d+$/,           // 纯数字
      /^[A-Z0-9]+$/i     // 字母数字
    ]

    return patterns.some(p => p.test(barcode))
  }
}
```

### 4.3 钱箱驱动

#### 4.3.1 功能说明

通过打印机的pulse信号控制钱箱打开。

#### 4.3.2 实现代码

```typescript
// electron/src/main/hardware/drawer.ts
import { PrinterDriver } from './printer'

export class DrawerDriver {
  private printer: PrinterDriver

  constructor(printer: PrinterDriver) {
    this.printer = printer
  }

  // 打开钱箱
  async open(): Promise<void> {
    // ESC/POS指令：0x1B 0x70 0x00 0x19 0xFA
    // 0x1B 0x70 - Pulse drawer
    // 0x00 - 端口0
    // 0x19 - ON时间 (25 * 2ms = 50ms)
    // 0xFA - OFF时间 (250 * 2ms = 500ms)
    const command = Buffer.from([0x1B, 0x70, 0x00, 0x19, 0xFA])
    
    // 通过打印机发送指令
    await (this.printer as any).send(command)
  }
}
```

### 4.4 电子秤驱动

#### 4.4.1 功能说明

通过RS232串口读取电子秤重量数据。

#### 4.4.2 实现代码

```typescript
// electron/src/main/hardware/scale.ts
import { SerialPort } from 'serialport'
import { ReadlineParser } from '@serialport/parser-readline'

export interface ScaleConfig {
  port: string
  baudRate: number
}

export interface WeightData {
  weight: number
  unit: string
  stable: boolean
}

export class ScaleDriver {
  private port: SerialPort | null = null
  private parser: ReadlineParser | null = null

  // 连接电子秤
  async connect(config: ScaleConfig): Promise<void> {
    this.port = new SerialPort({
      path: config.port,
      baudRate: config.baudRate
    })

    this.parser = this.port.pipe(new ReadlineParser({ delimiter: '\r\n' }))
  }

  // 读取重量
  onData(callback: (weight: WeightData) => void): void {
    if (!this.parser) return

    this.parser.on('data', (line: string) => {
      const weight = this.parseWeight(line)
      if (weight) {
        callback(weight)
      }
    })
  }

  // 解析重量数据
  private parseWeight(line: string): WeightData | null {
    // 常见电子秤协议格式：
    // ST,GS,+  0.123 kg
    // S,  0.123 kg
    // +0.123 kg
    
    const patterns = [
      /([+-]?\d+\.?\d*)\s*(kg|g|斤)/i,
      /ST,[A-Z],([+-]?\d+\.?\d*)\s*(kg|g|斤)/i
    ]

    for (const pattern of patterns) {
      const match = line.match(pattern)
      if (match) {
        return {
          weight: parseFloat(match[1]),
          unit: match[2] || 'kg',
          stable: line.includes('ST')
        }
      }
    }

    return null
  }

  // 断开连接
  disconnect(): void {
    if (this.port) {
      this.port.close()
      this.port = null
    }
  }
}
```

### 4.5 IPC通信

#### 4.5.1 预加载脚本

```typescript
// electron/src/preload.ts
import { contextBridge, ipcRenderer } from 'electron'

contextBridge.exposeInMainWorld('electronAPI', {
  // 打印机
  printer: {
    connect: (config: any) => ipcRenderer.invoke('hardware:printer:connect', config),
    disconnect: () => ipcRenderer.invoke('hardware:printer:disconnect'),
    print: (data: any) => ipcRenderer.invoke('hardware:print', data),
    test: () => ipcRenderer.invoke('hardware:printer:test')
  },
  
  // 钱箱
  drawer: {
    open: () => ipcRenderer.invoke('hardware:drawer:open')
  },
  
  // 电子秤
  scale: {
    connect: (config: any) => ipcRenderer.invoke('hardware:scale:connect', config),
    disconnect: () => ipcRenderer.invoke('hardware:scale:disconnect'),
    read: () => ipcRenderer.invoke('hardware:scale:read')
  },
  
  // 系统信息
  system: {
    getVersion: () => ipcRenderer.invoke('system:version'),
    getPlatform: () => ipcRenderer.invoke('system:platform')
  }
})
```

#### 4.5.2 IPC处理器

```typescript
// electron/src/main/ipc/handlers.ts
import { ipcMain } from 'electron'
import { PrinterDriver } from '../hardware/printer'
import { DrawerDriver } from '../hardware/drawer'
import { ScaleDriver } from '../hardware/scale'
import { app } from 'electron'

const printer = new PrinterDriver()
const drawer = new DrawerDriver(printer)
const scale = new ScaleDriver()

export function registerIPCHandlers(): void {
  // 打印机
  ipcMain.handle('hardware:printer:connect', async (event, config) => {
    try {
      await printer.connect(config)
      return { success: true }
    } catch (error: any) {
      return { success: false, error: error.message }
    }
  })

  ipcMain.handle('hardware:printer:disconnect', async () => {
    try {
      printer.disconnect()
      return { success: true }
    } catch (error: any) {
      return { success: false, error: error.message }
    }
  })

  ipcMain.handle('hardware:print', async (event, data) => {
    try {
      await printer.printReceipt(data)
      return { success: true }
    } catch (error: any) {
      return { success: false, error: error.message }
    }
  })

  ipcMain.handle('hardware:printer:test', async () => {
    try {
      await printer.testPrint()
      return { success: true }
    } catch (error: any) {
      return { success: false, error: error.message }
    }
  })

  // 钱箱
  ipcMain.handle('hardware:drawer:open', async () => {
    try {
      await drawer.open()
      return { success: true }
    } catch (error: any) {
      return { success: false, error: error.message }
    }
  })

  // 电子秤
  ipcMain.handle('hardware:scale:connect', async (event, config) => {
    try {
      await scale.connect(config)
      return { success: true }
    } catch (error: any) {
      return { success: false, error: error.message }
    }
  })

  ipcMain.handle('hardware:scale:disconnect', async () => {
    try {
      scale.disconnect()
      return { success: true }
    } catch (error: any) {
      return { success: false, error: error.message }
    }
  })

  ipcMain.handle('hardware:scale:read', async () => {
    return new Promise((resolve) => {
      scale.onData((weight) => {
        resolve({ success: true, weight })
      })
      
      // 超时处理
      setTimeout(() => {
        resolve({ success: false, error: '读取超时' })
      }, 3000)
    })
  })

  // 系统信息
  ipcMain.handle('system:version', () => {
    return app.getVersion()
  })

  ipcMain.handle('system:platform', () => {
    return process.platform
  })
}
```

---

## 五、前端代码复用

### 5.1 复用策略

直接复制Vue组件，在Electron中复用：

```
vue/src/views/goods/      →  electron/src/renderer/views/goods/
vue/src/views/inventory/  →  electron/src/renderer/views/inventory/
vue/src/views/member/     →  electron/src/renderer/views/member/
vue/src/views/order/      →  electron/src/renderer/views/order/
vue/src/views/pos/        →  electron/src/renderer/views/pos/
vue/src/views/system/     →  electron/src/renderer/views/system/
vue/src/components/       →  electron/src/renderer/components/
vue/src/styles/           →  electron/src/renderer/styles/
```

### 5.2 API适配

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

### 5.3 硬件API封装

```typescript
// electron/src/renderer/api/hardware.ts
export const hardwareAPI = {
  // 打印机
  printer: {
    connect: (config: any) => (window as any).electronAPI.printer.connect(config),
    disconnect: () => (window as any).electronAPI.printer.disconnect(),
    print: (data: any) => (window as any).electronAPI.printer.print(data),
    test: () => (window as any).electronAPI.printer.test()
  },
  
  // 钱箱
  drawer: {
    open: () => (window as any).electronAPI.drawer.open()
  },
  
  // 电子秤
  scale: {
    connect: (config: any) => (window as any).electronAPI.scale.connect(config),
    disconnect: () => (window as any).electronAPI.scale.disconnect(),
    read: () => (window as any).electronAPI.scale.read()
  }
}
```

---

## 六、打包配置

### 6.1 package.json

```json
{
  "name": "qihang-retail-electron",
  "version": "1.0.0",
  "description": "启航零售ERP - 桌面收银端",
  "main": "dist/main/index.js",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build && tsc -p tsconfig.main.json",
    "build:win": "npm run build && electron-builder --win",
    "build:mac": "npm run build && electron-builder --mac",
    "build:linux": "npm run build && electron-builder --linux",
    "preview": "vite preview"
  },
  "dependencies": {
    "axios": "^1.6.0",
    "element-plus": "^2.4.0",
    "vue": "^3.5.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "serialport": "^12.0.0",
    "node-hid": "^3.0.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@vitejs/plugin-vue": "^5.0.0",
    "electron": "^30.0.0",
    "electron-builder": "^24.0.0",
    "typescript": "^5.3.0",
    "vite": "^5.0.0",
    "vue-tsc": "^1.8.0"
  },
  "build": {
    "appId": "com.qihang.retail",
    "productName": "启航零售ERP",
    "directories": {
      "output": "dist"
    },
    "files": [
      "dist/**/*"
    ],
    "win": {
      "target": "nsis",
      "icon": "build/icon.ico"
    },
    "mac": {
      "target": "dmg",
      "icon": "build/icon.icns"
    },
    "linux": {
      "target": "AppImage",
      "icon": "build/icon.png"
    },
    "nsis": {
      "oneClick": false,
      "allowToChangeInstallationDirectory": true,
      "createDesktopShortcut": true,
      "createStartMenuShortcut": true
    }
  }
}
```

### 6.2 electron-builder.yml

```yaml
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
  artifactName: "${productName}-${version}-win.${ext}"
mac:
  target: dmg
  icon: build/icon.icns
  artifactName: "${productName}-${version}-mac.${ext}"
linux:
  target: AppImage
  icon: build/icon.png
  artifactName: "${productName}-${version}-linux.${ext}"
nsis:
  oneClick: false
  allowToChangeInstallationDirectory: true
  createDesktopShortcut: true
  createStartMenuShortcut: true
  shortcutName: 启航零售ERP
  uninstallDisplayName: 启航零售ERP
  uninstallIcon: build/icon.ico
```

---

## 七、功能模块

### 7.1 登录模块

| 功能 | 说明 |
|------|------|
| 账号密码登录 | 调用Java后端 `/api/sys-api/login` |
| Token存储 | localStorage |
| 自动登录 | 启动时检查Token有效性 |

### 7.2 首页看板

| 功能 | 说明 |
|------|------|
| 今日销售额 | 调用Java API |
| 今日订单数 | 调用Java API |
| 会员统计 | 调用Java API |
| 库存预警 | 调用Java API |

### 7.3 商品管理

| 功能 | 说明 |
|------|------|
| 商品列表 | 调用Java API |
| 商品新增/编辑/删除 | 调用Java API |
| SKU管理 | 调用Java API |
| 分类管理 | 调用Java API |
| 品牌管理 | 调用Java API |
| 批量导入/导出 | 调用Java API |

### 7.4 库存管理

| 功能 | 说明 |
|------|------|
| 库存查询 | 调用Java API |
| 入库管理 | 调用Java API |
| 出库管理 | 调用Java API |
| 库存盘点 | 调用Java API |
| 库存预警 | 调用Java API |

### 7.5 会员管理

| 功能 | 说明 |
|------|------|
| 会员列表 | 调用Java API |
| 会员新增/编辑 | 调用Java API |
| 积分管理 | 调用Java API |
| 储值管理 | 调用Java API |

### 7.6 订单管理

| 功能 | 说明 |
|------|------|
| 订单列表 | 调用Java API |
| 订单详情 | 调用Java API |
| 退货退款 | 调用Java API |

### 7.7 POS收银

| 功能 | 说明 |
|------|------|
| 收银台 | 扫码枪/键盘输入，调用Java API查询商品 |
| 购物车管理 | 前端状态管理 |
| 支付 | 调用Java API提交订单 |
| 小票打印 | 调用本地打印机驱动 |
| 退货 | 调用Java API |
| 班次管理 | 调用Java API |

### 7.8 系统设置

| 功能 | 说明 |
|------|------|
| 用户管理 | 调用Java API |
| 角色管理 | 调用Java API |
| 字典管理 | 调用Java API |
| 硬件配置 | 本地配置（打印机/扫码枪端口） |

---

## 八、实施计划

### 8.1 第一阶段：基础框架（1-2周）

- [ ] Electron项目初始化
- [ ] 主进程框架搭建
- [ ] 渲染进程框架搭建
- [ ] IPC通信机制
- [ ] 登录功能
- [ ] 路由配置

### 8.2 第二阶段：核心功能（2-3周）

- [ ] POS收银台
- [ ] 商品管理
- [ ] 库存管理
- [ ] 会员管理
- [ ] 订单管理

### 8.3 第三阶段：硬件驱动（1-2周）

- [ ] 打印机驱动
- [ ] 扫码枪适配
- [ ] 钱箱驱动
- [ ] 电子秤驱动（可选）

### 8.4 第四阶段：完善和发布（1-2周）

- [ ] 打包配置
- [ ] 安装包制作
- [ ] 测试和修复
- [ ] 文档编写
- [ ] 发布v1.0

---

## 九、注意事项

### 9.1 安全性

- 不要在渲染进程中直接访问Node.js API
- 通过preload.ts暴露安全的API
- Token存储在localStorage，注意XSS防护

### 9.2 性能

- 避免在主进程中执行耗时操作
- 使用Web Worker处理复杂计算
- 合理使用缓存减少API调用

### 9.3 兼容性

- 优先支持Windows 10+
- macOS 10.15+支持
- Linux（Ubuntu 20.04+）

### 9.4 硬件适配

- 支持主流热敏打印机（EPSON兼容）
- 扫码枪使用键盘模式（HID）
- 电子秤协议需要根据实际情况调整

---

## 十、附录

### 10.1 ESC/POS指令参考

| 指令 | 说明 |
|------|------|
| `0x1B 0x40` | 初始化打印机 |
| `0x1B 0x61 0x00` | 左对齐 |
| `0x1B 0x61 0x01` | 居中对齐 |
| `0x1B 0x61 0x02` | 右对齐 |
| `0x1B 0x21 0x00` | 正常字体 |
| `0x1B 0x21 0x10` | 放大字体 |
| `0x1B 0x21 0x20` | 加粗 |
| `0x1D 0x56 0x00` | 切纸 |
| `0x1B 0x70 0x00 0x19 0xFA` | 开钱箱 |

### 10.2 修订记录

| 版本 | 日期 | 修订内容 | 作者 |
|---|---|---|---|
| v1.0 | 2026-09-06 | 初始版本 | - |
