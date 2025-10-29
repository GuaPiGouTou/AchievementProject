import request from '@/utils/request'

/**
 * 修改用户密码
 * @param {Object} formData 登录表单数据
 * @param {String} formData.student_no 学号
 * @param {String}formData.password 旧密码
 * @param {String} formData.newpassword 新密码
 * @returns {Promise}
 */
export function updatePassword(formData) {
  return request.post('/api/updatePassword', {
  username: formData.student_no,
  password: formData.password,
  newpassword: formData.newpassword,
  identity: formData.isTeacherIdentity
  })
}
/**
 * 用户登录
 * @param {Object} formData 登录表单数据
 * @param {String} formData.student_no 学号/工号
 * @param {String}encryptedPassword 加密密码
 * @param {Boolean} formData.isTeacherIdentity 是否为教师身份
 * @returns {Promise}
 */
export function login(formData,encryptedPassword) {
  return request.post('/api/login', {
    username: formData.student_no,
    password: encryptedPassword,
    identity: formData.isTeacherIdentity
  })
}
/**
 * 获取验证码URL
 * @returns {Promise} 包含验证码URL的Promise
 */
export function getCodeUrl() {
  return request.get('/api/getCodeUrl')
}
