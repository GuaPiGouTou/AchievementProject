/**
 * 获取 Token
 * @returns {String|null} Token 值
 */
export function getToken() {
  return localStorage.getItem('token')
}

/**
 * 设置 Token
 * @param {String} token Token 值
 */
export function setToken(token) {
  localStorage.setItem('token', token)
}

/**
 * 移除 Token
 */
export function removeToken() {
  localStorage.removeItem('token')
}

/**
 * 检查 Token 是否存在
 * @returns {Boolean} 是否存在
 */
export function hasToken() {
  return !!localStorage.getItem('token')
}