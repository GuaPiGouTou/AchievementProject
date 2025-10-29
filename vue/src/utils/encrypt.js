import JSEncrypt from 'jsencrypt'

// 从后端获取公钥的 API
export async function fetchPublicKey() {
  try {
    const response = await fetch('/api/public_key')
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return await response.text()
  } catch (error) {
    console.error('获取公钥失败:', error)
    return DEFAULT_PUBLIC_KEY // 失败时使用默认公钥
  }
}

// RSA加密方法 - 增强错误处理
export function rsaEncrypt(data, publicKey) {
  console.log('开始加密过程...')
  
  // 验证输入数据
  if (typeof data !== 'string') {
    console.error('加密数据必须是字符串，当前类型:', typeof data)
    return false
  }
  
  if (data.trim() === '') {
    console.error('加密数据不能为空')
    return false
  }
  
  // 验证公钥
  if (typeof publicKey !== 'string') {
    console.error('公钥必须是字符串，当前类型:', typeof publicKey)
    return false
  }
  
  if (!publicKey.includes('BEGIN PUBLIC KEY')) {
    console.error('公钥格式不正确，缺少 BEGIN PUBLIC KEY')
    return false
  }
  
  try {
    console.log('创建 JSEncrypt 实例...')
    const encryptor = new JSEncrypt()
    
    console.log('设置公钥...')
    encryptor.setPublicKey(publicKey)
    
    console.log('开始加密数据...')
    const result = encryptor.encrypt(data)
    
    if (result === false) {
      console.error('JSEncrypt 加密返回 false')
      console.error('可能的原因:')
      console.error('1. 公钥格式不正确')
      console.error('2. 数据过长（RSA 有长度限制）')
      console.error('3. JSEncrypt 库存在问题')
      return false
    }
    
    if (result === null) {
      console.error('JSEncrypt 加密返回 null')
      return false
    }
    
    console.log('加密成功，结果长度:', result.length)
    return result
    
  } catch (error) {
    console.error('加密过程中发生错误:', error)
    return false
  }
}

// 测试加密函数
export function testEncryption() {
  const testData = 'test123'
  const result = rsaEncrypt(testData, DEFAULT_PUBLIC_KEY)
  console.log('加密测试结果:', result)
  return result !== false
}

// 默认公钥
const DEFAULT_PUBLIC_KEY =`-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu1SU1LfVLPHCozMxH2Mo
4lgOEePzNm0tRgeLezV6ffAt0gunVTLw7onLRnrq0/IzW7yWR7QkrmG7J3Rw0xRP
8JcpqFGqFeyYqL3hQb+1CQIDAQAB
-----END PUBLIC KEY-----`

export const PUBLIC_KEY = DEFAULT_PUBLIC_KEY