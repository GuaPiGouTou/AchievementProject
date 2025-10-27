<template>
  <el-row class="login-page">
    <el-col :span="8" :offset="8">
      <el-card class="login-card">
        <div slot="header" class="login-header">
          <h2>用户登录</h2>
        </div>

        <!-- 错误提示 -->
        <el-alert
            v-if="errorMessage"
            :message="errorMessage"
            type="error"
            show-icon
            :closable="false"
            class="error-alert"
        />

        <el-form ref="loginForm" :model="form" class="login-form">
          <!-- 用户名输入 -->
          <el-form-item>
            <el-input
                v-model="form.username"
                placeholder="请输入用户名"
                prefix-icon="User"
                :disabled="loading"
                @input="clearError"
            />
          </el-form-item>

          <!-- 密码输入 -->
          <el-form-item>
            <el-input
                v-model="form.password"
                type="password"
                placeholder="请输入密码"
                prefix-icon="Lock"
                :disabled="loading"
                @input="clearError"
            />
          </el-form-item>

          <!-- 记住密码选项 -->
          <el-form-item class="remember-item">
            <el-checkbox v-model="form.remember" :disabled="loading">
              记住密码
            </el-checkbox>
          </el-form-item>

          <!-- 登录按钮 -->
          <el-form-item>
            <el-button
                type="primary"
                class="login-btn"
                @click="submit"
                :loading="loading"
                :disabled="loading"
            >
              登录
            </el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'

const router = useRouter()

// 表单数据
const form = ref({
  username: '',
  password: '',
  remember: false  // 记住密码开关
})

// 状态管理
const errorMessage = ref('')
const loading = ref(false)

// 页面加载时读取本地存储的账号密码
onMounted(() => {
  const savedUser = localStorage.getItem('savedUser')
  if (savedUser) {
    try {
      const userInfo = JSON.parse(savedUser)
      form.value.username = userInfo.username
      form.value.password = userInfo.password
      form.value.remember = true
    } catch (e) {
      console.error('读取保存的用户信息失败:', e)
      localStorage.removeItem('savedUser')
    }
  }
})

// 清除错误信息
const clearError = () => {
  errorMessage.value = ''
}

// 登录提交
const submit = async () => {
  // 清除之前的错误
  clearError()

  // 表单验证
  if (!form.value.username.trim()) {
    errorMessage.value = '请输入用户名'
    return
  }
  if (!form.value.password.trim()) {
    errorMessage.value = '请输入密码'
    return
  }

  // 开始登录流程
  loading.value = true
  try {
    const response = await axios.post('http://172.16.46.77:9095/api/login', {
      username: form.value.username.trim(),
      password: form.value.password.trim()
    })

    if (response.data.success) {
      // 处理记住密码
      if (form.value.remember) {
        // 保存到本地存储
        localStorage.setItem('savedUser', JSON.stringify({
          username: form.value.username.trim(),
          password: form.value.password.trim()
        }))
      } else {
        // 不记住密码则清除本地存储
        localStorage.removeItem('savedUser')
      }

      // 保存token
      localStorage.setItem('token', response.data.token)

      // 提示并跳转
      ElMessage.success('登录成功，即将跳转首页')
      // router.push('/home')
    } else {
      errorMessage.value = response.data.message || '登录失败，请检查账号密码'
    }
  } catch (err) {
    errorMessage.value = '网络异常，请稍后重试'
    console.error('登录请求失败：', err)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-page {
  min-height: 100vh;
  background-color: #f5f7fa;
  padding: 50px 0;
}

.login-card {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

.login-header {
  text-align: center;
  padding: 20px 0;
}

.login-header h2 {
  margin: 0;
  color: #303133;
  font-size: 24px;
}

.login-form {
  padding: 0 30px 30px;
}

.remember-item {
  display: flex;
  justify-content: flex-start;
  margin-bottom: 10px;
}

.login-btn {
  width: 100%;
  padding: 12px 0;
  font-size: 16px;
}

.error-alert {
  margin: 0 30px 15px;
  background-color: #fff1f0;
}
</style>