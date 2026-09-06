import { contextBridge, ipcRenderer } from 'electron'

// 暴露安全的API给渲染进程
contextBridge.exposeInMainWorld('electronAPI', {
  // 系统信息
  system: {
    getVersion: () => ipcRenderer.invoke('system:version'),
    getPlatform: () => ipcRenderer.invoke('system:platform'),
    getName: () => ipcRenderer.invoke('system:name')
  },

  // 窗口控制
  window: {
    minimize: () => ipcRenderer.invoke('window:minimize'),
    maximize: () => ipcRenderer.invoke('window:maximize'),
    close: () => ipcRenderer.invoke('window:close')
  },

  // 打印机（后续实现）
  printer: {
    connect: (config: any) => ipcRenderer.invoke('hardware:printer:connect', config),
    disconnect: () => ipcRenderer.invoke('hardware:printer:disconnect'),
    print: (data: any) => ipcRenderer.invoke('hardware:print', data),
    test: () => ipcRenderer.invoke('hardware:printer:test')
  },

  // 钱箱（后续实现）
  drawer: {
    open: () => ipcRenderer.invoke('hardware:drawer:open')
  }
})
