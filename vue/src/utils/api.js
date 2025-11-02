import request from '@/utils/request'

/**
 * 修改用户密码（修正参数：identity → isTeacherIdentity，对齐后端接口）
 * @param {Object} formData 密码修改表单数据
 * @param {String} formData.username 学号/工号
 * @param {String} formData.password 旧密码
 * @param {String} formData.newpassword 新密码
 * @param {Boolean} formData.isTeacherIdentity 是否为教师身份
 * @returns {Promise}
 */
export function updatePassword(formData) {
  return request.post('/api/updatePassword', {
    username: formData.username,
    password: formData.password,
    newpassword: formData.newpassword,
    isTeacherIdentity: formData.isTeacherIdentity // 修正：与后端接口字段一致
  })
}

/**
 * 用户登录
 * @param {Object} formData 登录表单数据
 * @param {String} formData.username 学号/工号
 * @param {String} encryptedPassword 加密后的密码
 * @param {Boolean} formData.isTeacherIdentity 是否为教师身份
 * @returns {Promise}
 */
export function login(formData, encryptedPassword) {
  return request.post('/api/login', {
    username: formData.username,
    password: encryptedPassword,
    isTeacherIdentity: formData.isTeacherIdentity
  })
}

/**
 * 获取验证码URL
 * @returns {Promise} 包含验证码URL的响应
 */
export function getCodeUrl() {
  return request.get('/api/getCodeUrl')
}

/**
 * 验证验证码（修正注释：与参数实际含义对齐）
 * @param {String} code 输入的验证码
 * @param {String} url 验证码图片的URL
 * @returns {Promise} 验证结果响应
 */
export function verifyCodeUrl(code, url) {
  return request.post('/api/verifyCodeUrl', {
    correct_verification_code: code,
    verification_code_ip: url
  })
}

/**
 * 获取用户信息（学生/教师）
 * @param {Object} params 请求参数
 * @param {String} params.username 账号（学号/工号）
 * @param {Boolean} params.isTeacherIdentity 是否为教师身份（默认false）
 * @returns {Promise} 包含用户信息的响应
 */
export function getUserInfo(params) {
  return request({
    url: '/api/getUserInfo',
    method: 'GET',
    params // GET参数自动拼接至URL
  })
}

/**
 * 统一更新用户信息（支持学生/教师，核心补充接口）
 * @param {Object} data 请求参数
 * @param {String} data.username 账号（学号/工号，用于身份验证）
 * @param {Boolean} data.isTeacherIdentity 是否为教师身份
 * @param {Object} data.updateData 待更新的用户信息（根据身份动态变化）
 * @returns {Promise} 更新结果响应
 */
export function updateUserInfo(data) {
  return request.post('/api/updateUserInfo', {
    username: data.username,
    isTeacherIdentity: data.isTeacherIdentity,
    updateData: data.updateData // 动态更新字段（学生/教师特有字段在此对象中）
  })
}

/**
 * 上传头像（核心补充接口，FormData格式）
 * @param {FormData} formData 头像文件FormData
 * @param {File} formData.avatarFile 头像文件（字段名需与后端一致）
 * @returns {Promise} 上传结果响应（含服务器头像URL）
 */
export function uploadAvatar(formData) {
  return request({
    url: '/api/uploadAvatar', // 假设后端头像上传接口为该地址，需与后端确认
    method: 'POST',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data' // 上传文件必须指定该请求头
    }
  })
}