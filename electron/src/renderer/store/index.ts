import { defineStore } from 'pinia'
import { ref } from 'vue'
import http from '@/api/http'

interface UserInfo {
  id: number
  username: string
  nickname: string
  avatar?: string
}

export const useUserStore = defineStore('user', () => {
  const token = ref<string>(localStorage.getItem('token') || '')
  const userInfo = ref<UserInfo | null>(null)

  // 登录
  async function login(username: string, password: string) {
    const data = await http.post('/api/sys-api/login', { username, password })
    token.value = data.token
    localStorage.setItem('token', data.token)
    await getUserInfo()
    return data
  }

  // 获取用户信息
  async function getUserInfo() {
    if (!token.value) return null
    const data = await http.get('/api/sys-api/getInfo')
    userInfo.value = data.user
    return data
  }

  // 退出登录
  function logout() {
    token.value = ''
    userInfo.value = null
    localStorage.removeItem('token')
  }

  return {
    token,
    userInfo,
    login,
    getUserInfo,
    logout
  }
})

export const useAppStore = defineStore('app', () => {
  const sidebarCollapsed = ref(false)
  const loading = ref(false)

  function toggleSidebar() {
    sidebarCollapsed.value = !sidebarCollapsed.value
  }

  function setLoading(value: boolean) {
    loading.value = value
  }

  return {
    sidebarCollapsed,
    loading,
    toggleSidebar,
    setLoading
  }
})
