<template>
  <el-row class="login-page">
    <el-col :span="8" :offset="8">
      <el-card class="login-card">
        <div slot="header" class="login-header">
          <h2>用户登录</h2>
        </div>

        <!-- 错误提示 -->
      <!--  <el-alert
            v-if="errorMessage"
            :title="errorMessage"
            type="error"
            show-icon
            :closable="false"
            class="error-alert"
			:duration="5000"
        /> -->

        <el-form ref="loginForm" :model="form" class="login-form">
          <!-- 用户名输入 -->
          <el-form-item>
            <el-input
                v-model="form.username"
                placeholder="请输入学号|工号"
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

			  <!-- 验证码输入 -->
			          <el-form-item class="captcha-item">
			            <div class="captcha-container">
			              <el-input
			                  v-model="captcha"
			                  placeholder="请输入验证码"
			                  prefix-icon="Key"
			                  :disabled="loading"
			                  @input="clearError"
			                  class="captcha-input"
			                  maxlength="4"
			              />
			              <div class="captcha-image-container">
			                <img 
			                  :src="captchaImageUrl" 
			                  alt="验证码" 
			                  class="captcha-image"
			                  @click="refreshCaptcha"
			                  title="点击刷新验证码"
			                />
			                <div class="captcha-refresh" @click="refreshCaptcha">
			                  <el-icon><Refresh /></el-icon>
			                </div>
			              </div>
			            </div>
			          </el-form-item>

			
          <!-- 记住密码选项 -->
          <el-form-item class="remember-item">
            <el-checkbox v-model="form.remember" :disabled="loading">
              记住密码
            </el-checkbox>
			<!-- 身份选项 -->
			<el-checkbox v-model="form.isTeacherIdentity"  >
			  老师登录
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
import { rsaEncrypt,PUBLIC_KEY } from '@/utils/encrypt'
import {login,getCodeUrl,verifyCodeUrl} from '@/utils/api'
import {setToken} from '@/utils/auth'
const router = useRouter()

// 表单数据
const form = ref({
  username: '',
  password: '',
  remember: false  ,// 记住密码开关
  isTeacherIdentity:false //默认学生身份，选择为老师身份
})

// 状态管理
const errorMessage = ref('')
const loading = ref(false)

//验证码数据
const captchaImageUrl= ref("")
const captcha = ref('')

//错误显示方法
const showErrorMsg =(msg)=>{
	ElMessage.error({
	  message: msg,
	  duration: 3000,
	})
}

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

//验证码刷新
const refreshCaptcha=async ()=>{
	try {
		const resCode =await getCodeUrl();
		captchaImageUrl.value = res.data
		console.log(res.data)
	} catch (error) {
		//TODO handle the exception
		showErrorMsg("验证码刷新失败")
	}
	
	
}

// 登录提交
const submit = async () => {
  // 清除之前的错误
  clearError()

  // 表单验证
  if (!form.value.username ||!form.value.username.trim()==='') {
	  
    showErrorMsg('请输入用户名')
    return
  }
  if (!form.value.password || !form.value.password.trim()==='') {
    showErrorMsg('请输入密码')
    return
  }
 /*
  if(!captcha.value||!captcha.value.trim()==='')
  {
	  showErrorMsg('请输入验证码')
	  return
  }
  if(!captchaImageUrl.value||!captchaImageUrl.value.trim()==='')
  {
  	  showErrorMsg('请获取验证码')
  	  return
  }
  if(captcha.value.length<4)
  {
	  showErrorMsg('验证码长度不够')
	  return
  }

	//开始验证验证码
	const ifcode =await verifyCodeUrl(captcha.value,captchaImageUrl.value)
	if(!ifcode)
	{
		showErrorMsg('验证码错误')
		return
	}
  //开始加密密码
   const temppass =form.value.password
   const encryptedPassword = rsaEncrypt(temppass, PUBLIC_KEY)
*/
  
  // 开始登录流程
  loading.value = true
  // 创建新用户
	try {
		
		if(encryptedPassword!=false){
			// const res =await login(form,encryptedPassword)
			const res =await login(form.value,form.value.password)
			setToken(res.token)
			localStorage.setItem('initial',res.initial)
			localStorage.setItem('username',form.value.username)
			router.push({ name: 'home'})
			console.log(res.token)
		}else{
			loading.value = true
			showErrorMsg('密码加密失败')
		}
		
	} catch (error) {
		//TODO handle the exception
		//结束登录
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
  margin-top: 100px;
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
  width: 88%;
  margin: 0 30px 15px;
  background-color: #fff1f0;
}

.captcha-item {
  margin-bottom: 20px;
}

.captcha-container {
  display: flex;
  align-items: center;
  gap: 10px;
}

.captcha-input {
  flex: 1;
}

.captcha-image-container {
  position: relative;
  width: 100px;
  height: 40px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  cursor: pointer;
  overflow: hidden;
}

.captcha-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.captcha-refresh {
  position: absolute;
  top: 0;
  right: 0;
  width: 20px;
  height: 100%;
  background: rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 12px;
  opacity: 0;
  transition: opacity 0.3s;
}

.captcha-image-container:hover .captcha-refresh {
  opacity: 1;
}
</style>