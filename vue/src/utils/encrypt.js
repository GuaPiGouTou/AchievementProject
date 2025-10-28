import JSEncrypt from 'jsencrypt'

// 从后端获取公钥的 API
export async function fetchPublicKey() {
  const response = await fetch('/api/public_key')
  return await response.text()
}

// RSA加密方法
export function rsaEncrypt(data, publicKey) {
  const encryptor = new JSEncrypt()
  encryptor.setPublicKey(publicKey)
  return encryptor.encrypt(data)
}

// 默认公钥
const DEFAULT_PUBLIC_KEY = `
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1K1c8dHh6eXp8f4CBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgQIDAQAB
-----END PUBLIC KEY-----
`

export const PUBLIC_KEY = DEFAULT_PUBLIC_KEY