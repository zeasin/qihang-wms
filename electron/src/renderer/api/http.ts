import axios from 'axios'
import { ElMessage } from 'element-plus'
import router from '@/router'

const http = axios.create({
  baseURL: 'http://localhost:8088',
  timeout: 15000
})

// 请求拦截器
http.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// 响应拦截器
http.interceptors.response.use(
  (response) => {
    const { code, msg, data } = response.data
    if (code === 200) {
      return data
    } else if (code === 401) {
      localStorage.removeItem('token')
      router.push('/login')
      ElMessage.error('登录已过期，请重新登录')
      return Promise.reject(new Error(msg || '登录已过期'))
    } else {
      ElMessage.error(msg || '请求失败')
      return Promise.reject(new Error(msg))
    }
  },
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token')
      router.push('/login')
      ElMessage.error('登录已过期，请重新登录')
    } else if (error.response?.status === 500) {
      ElMessage.error('服务器错误')
    } else if (error.message?.includes('timeout')) {
      ElMessage.error('请求超时')
    } else if (error.message?.includes('Network Error')) {
      ElMessage.error('网络错误，请检查网络连接')
    } else {
      ElMessage.error(error.message || '请求失败')
    }
    return Promise.reject(error)
  }
)

export default http
