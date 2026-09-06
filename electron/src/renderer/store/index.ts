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

  // 登录（token 可能在顶层也可能在 data 内）
  async function login(username: string, password: string) {
    const res: any = await http.post('/sys-api/login', { username, password })
    const t = res.token || res.data?.token
    token.value = t
    localStorage.setItem('token', t)
    await getUserInfo()
    return res
  }

  // 获取用户信息（user 可能在顶层也可能在 data 内）
  async function getUserInfo() {
    if (!token.value) return null
    const res: any = await http.get('/sys-api/getInfo')
    const user = res.user || res.data?.user
    userInfo.value = user
    return res
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
