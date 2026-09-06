import { ipcMain, app } from 'electron'

export function registerIPCHandlers(): void {
  // 系统信息
  ipcMain.handle('system:version', () => {
    return app.getVersion()
  })

  ipcMain.handle('system:platform', () => {
    return process.platform
  })

  ipcMain.handle('system:name', () => {
    return app.getName()
  })

  // 窗口控制（通过BrowserWindow实现）
  ipcMain.handle('window:minimize', (event) => {
    const { BrowserWindow } = require('electron')
    const window = BrowserWindow.fromWebContents(event.sender)
    window?.minimize()
  })

  ipcMain.handle('window:maximize', (event) => {
    const { BrowserWindow } = require('electron')
    const window = BrowserWindow.fromWebContents(event.sender)
    if (window?.isMaximized()) {
      window.unmaximize()
    } else {
      window?.maximize()
    }
  })

  ipcMain.handle('window:close', (event) => {
    const { BrowserWindow } = require('electron')
    const window = BrowserWindow.fromWebContents(event.sender)
    window?.close()
  })
}
