import axios from 'axios'
import { getToken, removeToken } from '@/utils/auth'
import { ElMessage, ElMessageBox } from 'element-plus'
import router from '@/router'

// 创建 Axios 实例
const service = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API, // 从环境变量获取基础URL
  timeout: 15000, // 超时时间
  headers: {
    'Content-Type': 'application/json;charset=UTF-8'
  }
})

// 请求拦截器
service.interceptors.request.use(
  config => {
  
    // 1. 添加认证 token
    if (getToken()) {
      config.headers['Authorization'] = `Bearer ${getToken()}`
    }
    
    // 2. 添加请求唯一标识
    config.requestId = `${config.method}_${config.url}_${Date.now()}`
    
    // 3. 记录请求开始时间
    config.startTime = new Date().getTime()
    
    // 4. 请求参数处理
    if (config.method === 'get' && config.params) {
      let url = config.url
      url += '?'
      const keys = Object.keys(config.params)
      for (const key of keys) {
        if (config.params[key] !== undefined && config.params[key] !== null) {
          url += `${key}=${encodeURIComponent(config.params[key])}&`
        }
      }
      url = url.substring(0, url.length - 1)
      config.params = {}
      config.url = url
    }
    
    return config
  },
  error => {
    // 错误处理
    console.error('Request Error:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    // 1. 计算请求耗时
    const endTime = new Date().getTime()
    const duration = endTime - response.config.startTime
    console.log(`请求 ${response.config.url} 耗时: ${duration}ms`)
    
    // 2. 统一处理响应数据格式
    const res = response.data
    
    // 3. 根据业务状态码处理不同情况
    if (res.code !== 200) {
      // 401: 未授权/登录过期
      if (res.code === 401) {
        ElMessageBox.confirm('登录状态已过期，请重新登录', '提示', {
          confirmButtonText: '重新登录',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          // 移除 token 并刷新页面
          removeToken()
          location.reload()
        })
        return Promise.reject(new Error(res.message || 'Error'))
      }
      
      // 403: 权限不足
      if (res.code === 403) {
        ElMessage({
          message: res.message || '权限不足，无法访问',
          type: 'error',
          duration: 5 * 1000
        })
        return Promise.reject(new Error(res.message || 'Error'))
      }
      
      // 其他错误
      ElMessage({
        message: res.message || '请求错误',
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(new Error(res.message || 'Error'))
    }
    
    // 4. 返回实际数据
    return res.data
  },
  error => {
    // 1. 处理响应错误
    console.error('Response Error:', error)
    
    // 2. 处理超时
    if (error.code === 'ECONNABORTED' && error.message.indexOf('timeout') !== -1) {
      ElMessage({
        message: '请求超时，请检查网络连接',
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(error)
    }
    
    // 3. 处理网络错误
    if (!window.navigator.onLine) {
      ElMessage({
        message: '网络连接已断开，请检查网络',
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(error)
    }
    
    // 4. 处理 HTTP 状态码
    if (error.response) {
      switch (error.response.status) {
        case 400:
          error.message = '请求参数错误'
          break
        case 401:
          error.message = '未授权，请重新登录'
          removeToken()
          router.push('/login')
          break
        case 403:
          error.message = '拒绝访问'
          break
        case 404:
          error.message = `请求地址出错: ${error.response.config.url}`
          break
        case 408:
          error.message = '请求超时'
          break
        case 500:
          error.message = '服务器内部错误'
          break
        case 501:
          error.message = '服务未实现'
          break
        case 502:
          error.message = '网关错误'
          break
        case 503:
          error.message = '服务不可用'
          break
        case 504:
          error.message = '网关超时'
          break
        case 505:
          error.message = 'HTTP版本不受支持'
          break
        default:
          error.message = `未知错误: ${error.response.status}`
      }
    }
    
    // 5. 显示错误消息
    ElMessage({
      message: error.message || '服务器错误',
      type: 'error',
      duration: 5 * 1000
    })
    
    return Promise.reject(error)
  }
)

// 请求取消相关功能
const pendingRequests = new Map()

/**
 * 添加请求到取消队列
 * @param {Object} config 请求配置
 */
const addPendingRequest = (config) => {
  const requestId = config.requestId
  if (pendingRequests.has(requestId)) {
    pendingRequests.get(requestId)('取消重复请求')
  }
  config.cancelToken = new axios.CancelToken(cancel => {
    pendingRequests.set(requestId, cancel)
  })
}

/**
 * 从取消队列中移除请求
 * @param {Object} config 请求配置
 */
const removePendingRequest = (config) => {
  const requestId = config.requestId
  if (pendingRequests.has(requestId)) {
    pendingRequests.delete(requestId)
  }
}

// 添加请求取消拦截器
service.interceptors.request.use(config => {
  removePendingRequest(config) // 先移除之前的相同请求
  addPendingRequest(config)    // 添加当前请求到队列
  return config
})

service.interceptors.response.use(response => {
  removePendingRequest(response.config) // 请求完成后移除
  return response
}, error => {
  if (axios.isCancel(error)) {
    console.log('请求已取消:', error.message)
    return Promise.reject(error)
  }
  removePendingRequest(error.config || {}) // 出错时也移除
  return Promise.reject(error)
})

/**
 * 取消所有进行中的请求
 */
export const cancelAllRequests = () => {
  for (const [requestId, cancel] of pendingRequests) {
    cancel(`取消请求: ${requestId}`)
  }
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
   * @param {String} url 请求地址
   * @param {Object} params 请求参数
   * @param {Object} config 额外配置
   * @returns {Promise}
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
   * @param {String} url 请求地址
   * @param {Object} data 请求数据
   * @param {Object} config 额外配置
   * @returns {Promise}
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
   * @param {String} url 请求地址
   * @param {Object} data 请求数据
   * @param {Object} config 额外配置
   * @returns {Promise}
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
   * @param {String} url 请求地址
   * @param {Object} params 请求参数
   * @param {Object} config 额外配置
   * @returns {Promise}
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
   * @param {String} url 上传地址
   * @param {FormData} formData 表单数据
   * @param {Function} onProgress 上传进度回调
   * @param {Object} config 额外配置
   * @returns {Promise}
   */
  upload(url, formData, onProgress = null, config = {}) {
    return service({
      method: 'post',
      url,
      data: formData,
      headers: {
        'Content-Type': 'multipart/form-data'
      },
      onUploadProgress: progressEvent => {
        if (onProgress && typeof onProgress === 'function') {
          const percent = Math.round(
            (progressEvent.loaded * 100) / progressEvent.total
          )
          onProgress(percent)
        }
      },
      ...config
    })
  },
  
  /**
   * 文件下载
   * @param {String} url 下载地址
   * @param {String} filename 下载文件名
   * @param {Object} params 请求参数
   * @param {Object} config 额外配置
   */
  download(url, filename, params = {}, config = {}) {
    return service({
      method: 'get',
      url,
      params,
      responseType: 'blob',
      ...config
    }).then(response => {
      const blob = new Blob([response.data])
      const link = document.createElement('a')
      link.href = window.URL.createObjectURL(blob)
      link.download = filename
      link.click()
      window.URL.revokeObjectURL(link.href)
    })
  },
  
  /**
   * 并发请求
   * @param {Array} requests 请求数组
   * @returns {Promise}
   */
  all(requests) {
    return axios.all(requests)
  },
  
  /**
   * 创建自定义请求
   * @param {Object} config 请求配置
   * @returns {Promise}
   */
  request(config) {
    return service(config)
  },
  
  // 暴露取消请求方法
  cancelAllRequests,
  cancelRequest
}