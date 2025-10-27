<template>
  <div class="login-container">
    <el-card class="login-card">
      <div slot="header" class="login-header">
        <h2>系统登录</h2>
      <!--  <p>请输入账号密码登录</p> -->
      </div>

      <el-form
          ref="loginFormRef"
          :model="loginForm"
          :rules="loginRules"
          class="login-form"
          label-width="80px"
		  
      >
        <el-form-item label="账号" prop="username" class="hide-lable" label-width="40px" >
          <el-input
              v-model="loginForm.username"
              placeholder="请输入账号"
              prefix-icon="User"
              clearable
			  @input="loginForm.username = loginForm.username.replace(/[^\d]/g, '')"  
			
          />
		  <!--loginForm.username.replace(/[^\d]/g, '')" 正则表达式匹配数字  -->
        </el-form-item>

        <el-form-item label="密码" prop="password" class="hide-lable" label-width="40px">
          <el-input
              v-model="loginForm.password"
              type="password"
              placeholder="请输入密码"
              prefix-icon="Lock"
              :show-password="showPassword"
              @click:suffix="showPassword = !showPassword"
              clearable
          />
        </el-form-item>

        <el-form-item class="form-actions">
          <el-checkbox v-model="loginForm.remember" class="remember-checkbox">
            记住密码
          </el-checkbox>
          <el-link type="primary" class="forgot-link" @click="handleForgotPassword" underline="never">
            忘记密码?
          </el-link>
        </el-form-item>

        <el-form-item class="form-actions">
         <el-button
             type="primary"
             class="login-btn"
             @click="handleLogin"
             :loading="loginLoading"
         >
           登录
         </el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import {ref, reactive, onMounted} from 'vue'
import {ElMessage, ElMessageBox} from 'element-plus'

const loginFormRef = ref(null)

const loginLoading = ref(false)
const showPassword = ref(true)

const loginForm = reactive({
  username: '',
  password: '',
  remember: false
})

const loginRules = {
  username: [
    {required: true, message: '请输入用户名', trigger: 'blur'},
    {min: 3, max: 12, message: '用户名长度在 3-12 个字符之间', trigger: 'blur'}
  ],
  password: [
    {required: true, message: '请输入密码', trigger: 'blur'},
    {min: 6, max: 20, message: '密码长度在 6-20 个字符之间', trigger: 'blur'}
  ]
}

const handleLogin = async () => {
  const valid = await loginFormRef.value.validate()
  if (!valid) return

  loginLoading.value = true

  try {
    await new Promise(resolve => setTimeout(resolve, 1500))

    // 模拟登录成功
    if (loginForm.username === '24306010535' && loginForm.password === '123456') {
      // 记住密码逻辑
      if (loginForm.remember) {
        localStorage.setItem('username', loginForm.username)
        localStorage.setItem('password', loginForm.password)
      } else {
        localStorage.removeItem('username')
        localStorage.removeItem('password')
      }

      ElMessage.success('登录成功！')
      // 登录成功后跳转（实际项目中替换为路由跳转）
      setTimeout(() => {
        window.location.href = '/'
      }, 1000)
    } else {
      ElMessage.error('用户名或密码错误')
    }
  } catch (error) {
    ElMessage.error('登录失败，请重试')
  } finally {
    loginLoading.value = false
  }
}

const handleForgotPassword = () => {
  ElMessageBox.alert(
      '请联系管理员重置密码',
      '忘记密码',
      {confirmButtonText: '确定'}
  )
}


onMounted(() => {
  const savedUser = localStorage.getItem('username')
  const savedPwd = localStorage.getItem('password')
  if (savedUser && savedPwd) {
    loginForm.username = savedUser
    loginForm.password = savedPwd
    loginForm.remember = true
  }
})
</script>

<style scoped>
.hide-lable ::v-deep .el-form-item__label::before {
  display: none;
}

.login-container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: #f5f7fa;
  padding: 20px;
}

.login-card {
  width: 100%;
  max-width: 420px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

.login-header {
  text-align: center;
  padding: 20px 0;
}

.login-header h2 {
  margin: 0 0 10px 0;
  color: #7d807d;
}

.login-header p {
  margin: 0;
  color: #6b7280;
  font-size: 14px;
}

.login-form {
  padding: 0 30px ;
  
}

.el-form-item.form-actions :deep(.el-form-item__content) {
  display: flex;
  justify-content: center; 
  align-items: center;    
  margin-left: 0 !important; 
  width: 100%;
}

.remember-checkbox {
  font-size: 14px;
}

.forgot-link {
  font-size: 14px;
  margin-left: 55%;
}

.login-btn {
  width: 100%;
  padding: 12px 0;
  font-size: 16px;
}
</style>