import JSEncrypt from 'jsencrypt'

// 从后端获取公钥的 API
export async function fetchPublicKey() {
  try {
    const response = await fetch('/api/publickey')
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return await response.text()
  } catch (error) {
    console.error('获取公钥失败:', error)
    return DEFAULT_PUBLIC_KEY // 失败时使用默认公钥
  }
}

// RSA加密方法
export function rsaEncrypt(data, publicKey) {
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
    const encryptor = new JSEncrypt()
    encryptor.setPublicKey(publicKey)
    const result = encryptor.encrypt(data)
    if (result === false) {
      console.error('JSEncrypt 加密返回 false')
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

// 默认公钥 PKCS#8标准 2048位 
const DEFAULT_PUBLIC_KEY =`-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1yxvpIsbuwKBoYRze0R7
iCKZSAq87Qt/sGN81CerFBvyfWvnvV+fu/Ugm0VzXY+7yTsQxG3ijQdoizw7CLJI
SXw+BCUCrM7ret94xgARXr65l68TxnVw1yzJbez/k5Vl04t0Baj56iSlnQGKPzBX
L+9+lAMkIzW5SYl5uKNaCVkqsw00l4wM6op+7uaneLVhInBVrjn+f57HVmJK3jHx
BPisM9MDn1QbUYeABbVmS4zXCTTyN6SJgmqw0gTiKobTgiKKjZM5enPTmgJQit4f
WKm6FxcKYUj2QGR68JQegG4Y1XZCPWanhXury9FvRO72/NwNrjQaoIsOTPsWmV0D
jwIDAQAB
-----END PUBLIC KEY-----`
/*
私钥
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDXLG+kixu7AoGh
hHN7RHuIIplICrztC3+wY3zUJ6sUG/J9a+e9X5+79SCbRXNdj7vJOxDEbeKNB2iL
PDsIskhJfD4EJQKszut633jGABFevrmXrxPGdXDXLMlt7P+TlWXTi3QFqPnqJKWd
AYo/MFcv736UAyQjNblJiXm4o1oJWSqzDTSXjAzqin7u5qd4tWEicFWuOf5/nsdW
YkreMfEE+Kwz0wOfVBtRh4AFtWZLjNcJNPI3pImCarDSBOIqhtOCIoqNkzl6c9Oa
AlCK3h9YqboXFwphSPZAZHrwlB6AbhjVdkI9ZqeFe6vL0W9E7vb83A2uNBqgiw5M
+xaZXQOPAgMBAAECggEAAr3TMlJ/aPOQOUGZwxFNTZ+7OjrAy3hhCRtLZNyYhmoQ
vd5ZFoWYYGmwH6pT3PZO2zKAdTA9ObTFdTiwO90hpKYLmDvse80rHOaqAEPR9NYT
QUZ+xwGKDYPJkTf6zaOSp45YTRYpEP2kioqRe1qfUcIIZ9ReaoBtuu0geuTB6eqN
7V1/0rBZfcbfpptRZA75GObpHo3h5QCx1RQ0aaSo9hgLmvSNkvAUaBkEk8tf/CPK
BpB1IcM+FAE90xyD0sJxMfXyqCx5t4otrvrHdulORkA/II7lsGX/cihpwB8FGiWj
rf9FdBMUnlq5NlsmoAMeNW6S/VoUqDqsZlywwDFWAQKBgQD6nsS5XE4er33bx4Ok
bw9c6DVQmeXEfpT0HHDpfjgVXf1/zBIOZ2Gznj6hMqXAIweXmdjFnW2nEpyI3ia9
R1Oz+Qe5bgyhpMkyNVsT1udfmyNQgLKxc5z/8jynGe6ebdYbmpksJ9bu1C+P5ZtU
zFNeSsna1ORA6Qiezi9F4Zy/AQKBgQDbyuDMHNY/vnaV0sdEOavLPZm/pfUMDR8H
uNvEwXLGREIWVLJi034aYtQpE3WA50lporfv1Khe1cz7Y6r20LkdkpCp175s6GZ/
7T/H/QCAuCdBLYgkaVJ8iucqcFEe1VsIEmjAcMK1fkyMZGnsIGO63V3L2744DPIl
mNQO/aBSjwKBgGlFF0zkwMuS20Ld4yXGoKVdxEc+3YxTvy1qZOMu6U/QUxLDHTJ/
qkJQTe5X39d830uGi881+UEcSDQVXCBVPYtzJxN0bknXdctpLgB/XGCEQakm5egz
r9ayYVevRNO3PyAJKB2r/lQDPJcs0rojuUD6GR+aHOZG/B/4a1LnGXgBAoGBAMxb
0y4VNePo7IubgmleEeyT5wt5e+FrpclhSP2lPFk6iBQJRh97M4nHECrtC9kBs5GD
mPBmUvJyaffnkMOSCDyF1PoGPek3IG6boi0JgVktYFpKwoXQY8Cmyg78hYBcshpM
O5eKgI+N0hDLIG1LJE9PmfF87F1jNBZfBfS2P0XjAoGALi8xQ0HfxHcIu1qpV1ue
m5esWHBchIQDlTNRR9HuSbj2qnd2CVnHuTm4T8cxVZoMHU5HdCvRWn5Ph83RB/Ix
snPp78FbMzuVQ4RdyZBJSaNluXdOGX5EudUAXSMXjSBpib0beDTyHhvWOLIPOGgy
6Jg8wPLgwJbfHZxVmwHFg4U=
-----END PRIVATE KEY-----
*/
export const PUBLIC_KEY = DEFAULT_PUBLIC_KEY

