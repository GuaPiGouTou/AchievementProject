import request from '@/utils/request'

/**
 * 修改用户密码
 * @param {String} student_no 学号
 * @param {String} password 旧密码
 * @param {String} newpassword 新密码
 * @returns {Promise}
 */
export function updatePassword(student_no, password, newpassword) {
  return request.post('/api/updatePassword', {
    student_no,
    password,
    newpassword
  })
}