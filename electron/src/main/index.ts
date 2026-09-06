import { app, BrowserWindow, shell } from 'electron'
import { join } from 'path'
import { registerIPCHandlers } from './ipc/handlers'

let mainWindow: BrowserWindow | null = null

// 开发模式判断
const isDev = process.env.ELECTRON_RENDERER_URL

function createWindow(): void {
  mainWindow = new BrowserWindow({
    width: 1400,
    height: 900,
    minWidth: 1200,
    minHeight: 700,
    title: '启航零售ERP',
    icon: join(__dirname, '../../public/favicon.ico'),
    webPreferences: {
      preload: join(__dirname, '../preload/index.js'),
      nodeIntegration: false,
      contextIsolation: true,
      sandbox: false
    }
  })

  // 开发模式加载Vite开发服务器
  if (isDev) {
    mainWindow.loadURL(process.env.ELECTRON_RENDERER_URL!)
    mainWindow.webContents.openDevTools()
  } else {
    mainWindow.loadFile(join(__dirname, '../renderer/index.html'))
  }

  // 打开外部链接时使用系统浏览器
  mainWindow.webContents.setWindowOpenHandler(({ url }) => {
    shell.openExternal(url)
    return { action: 'deny' }
  })

  mainWindow.on('closed', () => {
    mainWindow = null
  })
}

// 注册IPC处理器
registerIPCHandlers()

// 应用准备就绪
app.whenReady().then(() => {
  createWindow()

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow()
    }
  })
})

// 所有窗口关闭时退出应用
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

// 导出mainWindow供其他模块使用
export { mainWindow }
