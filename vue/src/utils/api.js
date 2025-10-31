import request from '@/utils/request'

/**
 * 修改用户密码
 * @param {Object} formData 登录表单数据
 * @param {String} formData.username 学号/工号
 * @param {String}formData.password 旧密码
 * @param {String} formData.newpassword 新密码
 * @returns {Promise}
 */
export function updatePassword(formData) {
  return request.post('/api/updatePassword', {
  username: formData.username,
  password: formData.password,
  newpassword: formData.newpassword,
  identity: formData.isTeacherIdentity
  })
}
/**
 * 用户登录
 * @param {Object} formData 登录表单数据
 * @param {String} formData.username 学号/工号
 * @param {String}encryptedPassword 加密密码
 * @param {Boolean} formData.isTeacherIdentity 是否为教师身份
 * @returns {Promise}
 */
export function login(formData,encryptedPassword) {
  return request.post('/api/login', {
    username: formData.username,
    password: encryptedPassword,
    isTeacherIdentity: formData.isTeacherIdentity
  })
}
/**
 * 获取验证码URL
 * @returns {Promise} 包含验证码URL的Promise
 */
export function getCodeUrl() {
  return request.get('/api/getCodeUrl')
}
/**
 * 验证验证码
 * @param {Object} formData 登录表单数据
 * @param {String} formData.username 学号/工号
 * @param {String}encryptedPassword 加密密码
 * @param {Boolean} formData.isTeacherIdentity 是否为教师身份
 * @returns {Promise}
 */
export function verifyCodeUrl(code,url) {
  return request.post('/api/verifyCodeUrl', {
    correct_verification_code: code,
    verification_code_ip: url
  })
}

/**
 * 获取用户信息
 * @param {Object} params - 请求参数
 * @param {String} params.username - 账号
 * @param {Boolean} params.isTeacherIdentity - 是否为教师身份（默认false）
 * @returns {Promise}
 */
export function getUserInfo(params) {
  return request({
    url: '/api/getUserInfo',
    method: 'GET',
    params // GET请求参数会自动拼接到URL
  })
}