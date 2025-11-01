import axios from 'axios'
import { getToken, removeToken } from '@/utils/auth'
import { ElMessage, ElMessageBox } from 'element-plus'
import router from '@/router'

// 创建 Axios 实例
const service = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API, // 从环境变量获取服务器地址
  timeout: 15000, // 超时时间
  headers: {
    'Content-Type': 'application/json;charset=UTF-8'
  }
})

// 请求取消相关功能
const pendingRequests = new Map()

/**
 * 添加请求到取消队列
 * @param {Object} config 请求配置
 */
const addPendingRequest = (config) => {
  const requestId = `${config.method}_${config.url}_${Date.now()}`
  config.requestId = requestId
  
  if (pendingRequests.has(requestId)) {
    pendingRequests.get(requestId)('取消重复请求')
  }
  config.cancelToken = new axios.CancelToken(cancel => {
    pendingRequests.set(requestId, cancel)
  })
  
  return requestId
}

/**
 * 从取消队列中移除请求
 * @param {Object} config 请求配置
 */
const removePendingRequest = (config) => {
  const requestId = config.requestId
  if (requestId && pendingRequests.has(requestId)) {
    pendingRequests.delete(requestId)
  }
}

// 请求拦截器
service.interceptors.request.use(
  config => {
    // 添加请求到取消队列
    addPendingRequest(config)
    
    // 记录请求开始时间
    config.startTime = new Date().getTime()
    
    // 打印完整的请求信息（开发环境）
    if (import.meta.env.MODE === 'development') {
      console.log('=== 请求开始 ===')
      console.log('请求URL:', config.url)
      console.log('请求方法:', config.method?.toUpperCase())
      console.log('完整URL:', config.baseURL + config.url)
      console.log('请求头:', JSON.stringify(config.headers, null, 2))
      
      if (config.method?.toLowerCase() === 'get' && config.params) {
        console.log('GET请求参数:', JSON.stringify(config.params, null, 2))
      }
      
      if (['post', 'put', 'patch'].includes(config.method?.toLowerCase()) && config.data) {
        if (config.data instanceof FormData) {
          console.log('请求体类型: FormData')
          const formDataObj = {}
          for (const pair of config.data.entries()) {
            formDataObj[pair[0]] = pair[1]
          }
          console.log('FormData内容:', JSON.stringify(formDataObj, null, 2))
        } else {
          console.log('请求体类型: JSON')
          console.log('请求体数据:', JSON.stringify(config.data, null, 2))
        }
      }
      console.log('=== 请求结束 ===')
    }
    
    // 添加认证 token
    const token = getToken()
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    
    // GET 请求参数处理（保持原有逻辑，但建议使用默认的 params 序列化）
    if (config.method === 'get' && config.params) {
      const params = new URLSearchParams()
      Object.keys(config.params).forEach(key => {
        if (config.params[key] !== undefined && config.params[key] !== null) {
          params.append(key, config.params[key])
        }
      })
      const queryString = params.toString()
      if (queryString) {
        config.url += (config.url.includes('?') ? '&' : '?') + queryString
      }
      // 清空 params，避免 axios 重复添加
      config.params = {}
    }
    
    return config
  },
  error => {
    console.error('Request Error:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    // 从取消队列中移除请求
    removePendingRequest(response.config)
    
    // 计算请求耗时
    const endTime = new Date().getTime()
    const duration = endTime - response.config.startTime
    console.log(`请求 ${response.config.url} 耗时: ${duration}ms`)
    
    // 统一处理响应数据格式
    const res = response.data
    
    // 开发环境打印响应数据
    if (import.meta.env.MODE === 'development') {
      console.log('响应数据:', res)
    }
	
	// 将 code 转换为数字类型
	const code = typeof res.code === 'string' ? parseInt(res.code, 10) : res.code
		
    // 根据业务状态码处理不同情况
    if (code !== 200 && code !== undefined) {
      // 401: 未授权/登录过期
      if (code === 401) {
        ElMessageBox.confirm('登录状态已过期，请重新登录', '提示', {
          confirmButtonText: '重新登录',
          cancelButtonText: '取消',
          type: 'warning',
          showClose: false,
          closeOnClickModal: false,
          closeOnPressEscape: false
        }).then(() => {
          removeToken()
          router.push('/login')
        }).catch(() => {
          removeToken()
          router.push('/login')
        })
        return Promise.reject(new Error(res.msg || '未授权访问'))
      }
      
      // 403: 权限不足
      if (code === 403) {
        ElMessage({
          message: res.msg || '权限不足，无法访问',
          type: 'error',
          duration: 5 * 1000
        })
        return Promise.reject(new Error(res.msg || '权限不足'))
      }
      
      // 其他业务错误
      ElMessage({
        message: res.msg || '请求错误',
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(new Error(res.msg || '业务错误'))
    }
    
    // 返回实际数据（根据后端数据结构调整）
    // 如果后端返回的数据结构是 { code, msg, data }，则返回 res.data
    // 如果后端返回的数据结构是 { code, msg, ... }，则返回 res
    return res.data !== undefined ? res.data : res
  },
  error => {
    // 从取消队列中移除请求
    if (error.config) {
      removePendingRequest(error.config)
    }
    
    // 如果是取消请求的错误，不显示消息
    if (axios.isCancel(error)) {
      console.log('请求已取消:', error.message)
      return Promise.reject(error)
    }
    
    console.error('Response Error:', error)
    
    // 处理超时
    if (error.code === 'ECONNABORTED' && error.message.indexOf('timeout') !== -1) {
      ElMessage({
        message: '请求超时，请检查网络连接',
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(error)
    }
    
    // 处理网络错误
    if (!window.navigator.onLine) {
      ElMessage({
        message: '网络连接已断开，请检查网络',
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(error)
    }
    
    // 处理 HTTP 状态码
    if (error.response) {
      let message = '服务器错误'
      
      switch (error.response.status) {
        case 400:
          message = '请求参数错误'
          break
        case 401:
          message = '未授权，请重新登录'
          removeToken()
          setTimeout(() => {
            router.push('/login')
          }, 1500)
          break
        case 403:
          message = '拒绝访问'
          break
        case 404:
          message = `请求地址出错: ${error.response.config.url}`
          break
        case 408:
          message = '请求超时'
          break
        case 500:
          message = '服务器内部错误'
          break
        case 501:
          message = '服务未实现'
          break
        case 502:
          message = '网关错误'
          break
        case 503:
          message = '服务不可用'
          break
        case 504:
          message = '网关超时'
          break
        case 505:
          message = 'HTTP版本不受支持'
          break
        default:
          message = `未知错误: ${error.response.status}`
      }
      
      ElMessage({
        message: message,
        type: 'error',
        duration: 5 * 1000
      })
    } else {
      // 其他错误
      ElMessage({
        message: error.message || '网络错误，请检查网络连接',
        type: 'error',
        duration: 5 * 1000
      })
    }
    
    return Promise.reject(error)
  }
)

/**
 * 取消所有进行中的请求
 */
export const cancelAllRequests = () => {
  pendingRequests.forEach((cancel, requestId) => {
    cancel(`取消请求: ${requestId}`)
  })
  pendingRequests.clear()
}

/**
 * 取消指定请求
 * @param {String} requestId 请求ID
 */
export const cancelRequest = (requestId) => {
  if (pendingRequests.has(requestId)) {
    pendingRequests.get(requestId)(`取消请求: ${requestId}`)
    pendingRequests.delete(requestId)
  }
}

// 封装常用请求方法
export default {
  /**
   * GET 请求
   */
  get(url, params = {}, config = {}) {
    return service({
      method: 'get',
      url,
      params,
      ...config
    })
  },
  
  /**
   * POST 请求
   */
  post(url, data = {}, config = {}) {
    return service({
      method: 'post',
      url,
      data,
      ...config
    })
  },
  
  /**
   * PUT 请求
   */
  put(url, data = {}, config = {}) {
    return service({
      method: 'put',
      url,
      data,
      ...config
    })
  },
  
  /**
   * DELETE 请求
   */
  delete(url, params = {}, config = {}) {
    return service({
      method: 'delete',
      url,
      params,
      ...config
    })
  },
  
  /**
   * 文件上传
   */
  upload(url, formData, onProgress = null, config = {}) {
    return service({
      method: 'post',
      url,
      data: formData,
      headers: {
        'Content-Type': 'multipart/form-data',
        ...config.headers
      },
      onUploadProgress: progressEvent => {
        if (onProgress && typeof onProgress === 'function') {
          const percent = Math.round(
            (progressEvent.loaded * 100) / progressEvent.total
          )
          onProgress(percent, progressEvent)
        }
      },
      ...config
    })
  },
  
  /**
   * 文件下载
   */
  download(url, filename, params = {}, config = {}) {
    return service({
      method: 'get',
      url,
      params,
      responseType: 'blob',
      ...config
    }).then(response => {
      // 创建 blob 链接
      const blob = new Blob([response.data])
      const downloadUrl = window.URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = downloadUrl
      link.download = filename
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      window.URL.revokeObjectURL(downloadUrl)
    })
  },
  
  /**
   * 并发请求
   */
  all(requests) {
    return axios.all(requests)
  },
  
  /**
   * 创建自定义请求
   */
  request(config) {
    return service(config)
  },
  
  // 暴露取消请求方法
  cancelAllRequests,
  cancelRequest
}