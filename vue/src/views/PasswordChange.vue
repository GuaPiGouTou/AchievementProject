<template>
  <div class="password-change-container">
    <el-card class="password-card">
      <div slot="header" class="card-header">
        <h2>修改密码</h2>
        <p class="sub-title">请填写新密码完成修改</p>
      </div>

      <el-form
          ref="passwordForm"
          :model="form"
          :rules="formRules"
          label-width="120px"
          class="password-form"
      >
        <!-- 新密码输入 -->
        <el-form-item label="新密码" prop="newpassword">
          <el-input
              v-model="form.newpassword"
              type="password"
              placeholder="请设置新密码（8-20位，含字母和数字）"
              prefix-icon="Key"
              :disabled="loading"
              show-password
          />
          <el-tooltip
              effect="light"
              content="密码长度8-20位，必须包含字母和数字"
              placement="top"
          >
            <el-icon class="info-icon"><QuestionFilled /></el-icon>
          </el-tooltip>
        </el-form-item>

        <!-- 确认新密码 -->
        <el-form-item label="确认新密码" prop="confirmPassword">
          <el-input
              v-model="form.confirmPassword"
              type="password"
              placeholder="请再次输入新密码"
              prefix-icon="Key"
              :disabled="loading"
              show-password
          />
        </el-form-item>

        <!-- 操作按钮 -->
        <el-form-item class="form-actions">
          <el-button
              type="default"
              @click="resetForm"
              :disabled="loading"
          >
            重置
          </el-button>
          <el-button
              type="primary"
              @click="handleSubmit"
              :loading="loading"
          >
            确认修改
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useRouter } from 'vue-router'
import { rsaEncrypt, PUBLIC_KEY } from '@/utils/encrypt'
import { updatePassword } from '@/utils/api'
import { getToken, removeToken } from '@/utils/auth'

const router = useRouter()

// 表单数据（仅保留新密码相关字段）
const form = reactive({
  newpassword: '',
  confirmPassword: '' // 新增确认密码字段，增强安全性
})

// 表单引用（用于验证）
const passwordForm = ref(null)

// 状态管理
const loading = ref(false)
const rules = ref({
  newpassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度需在6-20位之间', trigger: 'blur' },
    {
      pattern: /^(?=.*[a-zA-Z])(?=.*\d).+$/,
      message: '密码需包含字母和数字',
      trigger: 'blur'
    }
  ],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        if (value !== form.newpassword) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
})

// 页面加载时验证登录状态
onMounted(() => {
  if (!getToken()) {
    ElMessage.warning('请先登录')
    router.push('/login')
  }
})

// 提交密码修改
const handleSubmit = async () => {
  // 1. 前端表单验证
  try {
    await passwordForm.value.validate()
  } catch (error) {
    return ElMessage.warning('请完善表单信息后重试')
  }

  // 2. 二次确认（防止误操作）
  try {
    await ElMessageBox.confirm(
        '确定要修改密码吗？修改后需要重新登录',
        '确认修改',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }
    )
  } catch (error) {
    return ElMessage.info('已取消修改')
  }

  // 3. 处理密码加密与请求
  loading.value = true
  try {
    const token = getToken()
    if (!token) {
      throw new Error('登录状态已失效，请重新登录')
    }

    // 对新密码进行加密处理
    const encryptedNewPassword = rsaEncrypt(form.newpassword.trim(), PUBLIC_KEY)
    if (!encryptedNewPassword) {
      throw new Error('密码加密失败，请重试')
    }

    // 调用修改密码接口
    const response = await updatePassword({
      newPassword: encryptedNewPassword // 仅传递加密后的新密码
    }, {
      headers: {
        'Authorization': `Bearer ${token}`, // 规范的Bearer Token格式
        'Content-Type': 'application/json'
      }
    })

    // 4. 处理成功响应
    if (response.data.success) {
      ElMessage.success('密码修改成功，请重新登录')
      removeToken() // 清除登录状态（使用工具函数）
      router.push('/login') // 跳转到登录页
    } else {
      ElMessage.error(response.data.message || '修改失败，请检查信息')
    }
  } catch (error) {
    console.error('修改密码失败:', error)
    // 精细化错误处理
    const errorMsg = error.response?.data?.message || error.message
    if (errorMsg.includes('登录状态已失效') || error.response?.status === 401) {
      ElMessage.error('登录已过期，请重新登录')
      removeToken()
      router.push('/login')
    } else if (error.response?.status === 400) {
      ElMessage.error('新密码不符合要求，请重新设置')
    } else if (error.response?.status === 404) {
      ElMessage.error('服务接口不存在，请联系管理员')
    } else {
      ElMessage.error(errorMsg || '网络异常，请稍后重试')
    }
  } finally {
    loading.value = false // 确保加载状态关闭
  }
}

// 重置表单
const resetForm = () => {
  passwordForm.value.resetFields()
}
</script>

<style scoped>
.password-change-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f0f2f5;
  padding: 20px;
}

.password-card {
  width: 100%;
  max-width: 550px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

.card-header {
  text-align: center;
  padding: 24px 0;
}

.sub-title {
  margin: 8px 0 0;
  color: #606266;
  font-size: 14px;
  font-weight: normal;
}

.password-form {
  padding: 0 30px 30px;
}

.info-icon {
  color: #409eff;
  margin-left: 8px;
  cursor: pointer;
  font-size: 16px;
}

.form-actions {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-top: 20px;
}
</style>