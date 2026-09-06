/// <reference types="vite/client" />

declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  const component: DefineComponent<{}, {}, any>
  export default component
}

// Electron API类型定义
interface ElectronAPI {
  system: {
    getVersion: () => Promise<string>
    getPlatform: () => Promise<string>
    getName: () => Promise<string>
  }
  window: {
    minimize: () => Promise<void>
    maximize: () => Promise<void>
    close: () => Promise<void>
  }
  printer: {
    connect: (config: any) => Promise<{ success: boolean; error?: string }>
    disconnect: () => Promise<{ success: boolean; error?: string }>
    print: (data: any) => Promise<{ success: boolean; error?: string }>
    test: () => Promise<{ success: boolean; error?: string }>
  }
  drawer: {
    open: () => Promise<{ success: boolean; error?: string }>
  }
}

interface Window {
  electronAPI: ElectronAPI
}
