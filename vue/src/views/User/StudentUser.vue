<template>
  <div class="personal-center">
    <!-- 页面标题 -->
    <div class="page-title">
      <h2>学生个人中心</h2>
      <p>管理个人学籍信息与账户设置</p>
    </div>

    <!-- 头像与基础信息区 -->
    <div class="profile-header">
      <div class="avatar-container">
        <el-avatar :size="120" class="user-avatar">
          <img :src="userInfo.avatarUrl" alt="用户头像" />
        </el-avatar>
        <el-button
            type="primary"
            size="small"
            class="change-avatar-btn"
            @click="showAvatarDialog = true"
        >
          更换头像
        </el-button>
      </div>

      <div class="basic-info">
        <!-- 基础信息区（不可修改） -->
        <div class="info-section">
          <h3 class="section-title">基础信息</h3>
          <div class="info-grid">
            <div class="info-item">
              <label class="info-label">姓名</label>
              <span class="info-value uneditable">{{ userInfo.name }}</span>
            </div>
            <div class="info-item">
              <label class="info-label">学号</label>
              <span class="info-value uneditable">{{ userInfo.studentId }}</span>
            </div>
            <div class="info-item">
              <label class="info-label">身份证号</label>
              <span class="info-value uneditable">{{ formatIdCard(userInfo.idCard) }}</span>
            </div>
            <div class="info-item">
              <label class="info-label">创建时间</label>
              <span class="info-value uneditable">{{ userInfo.createTime }}</span>
            </div>
            <div class="info-item">
              <label class="info-label">更新时间</label>
              <span class="info-value uneditable">{{ userInfo.updateTime }}</span>
            </div>
          </div>
        </div>

        <!-- 学籍信息区（部分可修改） -->
        <div class="info-section">
          <h3 class="section-title">学籍信息</h3>
          <div class="info-grid">
            <div class="info-item">
              <label class="info-label">性别</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.gender }}</span>
              <el-select
                  v-else
                  v-model="formData.gender"
                  size="small"
                  class="edit-select"
              >
                <el-option label="男" value="男" />
                <el-option label="女" value="女" />
                <el-option label="其他" value="其他" />
              </el-select>
            </div>
            <div class="info-item">
              <label class="info-label">年级</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.grade }}</span>
              <el-input
                  v-else
                  v-model="formData.grade"
                  size="small"
                  class="edit-input"
                  placeholder="如：2023级"
              />
            </div>
            <div class="info-item">
              <label class="info-label">院系</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.department }}</span>
              <el-input
                  v-else
                  v-model="formData.department"
                  size="small"
                  class="edit-input"
              />
            </div>
            <div class="info-item">
              <label class="info-label">专业</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.major }}</span>
              <el-input
                  v-else
                  v-model="formData.major"
                  size="small"
                  class="edit-input"
              />
            </div>
            <div class="info-item">
              <label class="info-label">学年</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.schoolYear }}</span>
              <el-input
                  v-else
                  v-model="formData.schoolYear"
                  size="small"
                  class="edit-input"
                  placeholder="如：2023-2024"
              />
            </div>
            <div class="info-item">
              <label class="info-label">学籍状态</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.enrollmentStatus }}</span>
              <el-select
                  v-else
                  v-model="formData.enrollmentStatus"
                  size="small"
                  class="edit-select"
              >
                <el-option label="正常" value="正常" />
                <el-option label="休学" value="休学" />
                <el-option label="退学" value="退学" />
                <el-option label="毕业" value="毕业" />
                <el-option label="保留学籍" value="保留学籍" />
              </el-select>
            </div>
          </div>
        </div>

        <!-- 个人联系信息区（可修改） -->
        <div class="info-section">
          <h3 class="section-title">联系信息</h3>
          <div class="info-grid">
            <div class="info-item">
              <label class="info-label">手机号</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.phone }}</span>
              <el-input
                  v-else
                  v-model="formData.phone"
                  size="small"
                  class="edit-input"
                  placeholder="请输入手机号"
              />
            </div>
            <div class="info-item">
              <label class="info-label">电子邮箱</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.email }}</span>
              <el-input
                  v-else
                  v-model="formData.email"
                  size="small"
                  class="edit-input"
                  placeholder="请输入电子邮箱"
              />
            </div>
            <div class="info-item">
              <label class="info-label">出生日期</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.birthDate }}</span>
              <el-date-picker
                  v-else
                  v-model="formData.birthDate"
                  type="date"
                  size="small"
                  class="edit-input"
                  value-format="YYYY-MM-DD"
                  placeholder="选择出生日期"
              />
            </div>
            <div class="info-item">
              <label class="info-label">家庭住址</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.homeAddress }}</span>
              <el-input
                  v-else
                  v-model="formData.homeAddress"
                  size="small"
                  class="edit-input"
                  placeholder="请输入家庭住址"
              />
            </div>
            <div class="info-item">
              <label class="info-label">政治面貌</label>
              <span v-if="!isEditing" class="info-value">{{ userInfo.politicalStatus }}</span>
              <el-select
                  v-else
                  v-model="formData.politicalStatus"
                  size="small"
                  class="edit-select"
              >
                <el-option label="中共党员" value="中共党员" />
                <el-option label="中共预备党员" value="中共预备党员" />
                <el-option label="共青团员" value="共青团员" />
                <el-option label="群众" value="群众" />
                <el-option label="其他" value="其他" />
              </el-select>
            </div>
          </div>
        </div>

        <div class="action-buttons">
          <el-button
              type="primary"
              @click="handleEdit"
              v-if="!isEditing"
          >
            <el-icon><Edit /></el-icon> 编辑信息
          </el-button>
          <div v-else>
            <el-button type="primary" @click="saveInfo">保存</el-button>
            <el-button @click="cancelEdit">取消</el-button>
          </div>
        </div>
      </div>
    </div>

    <!-- 更换头像弹窗 -->
    <el-dialog title="更换头像" v-model="showAvatarDialog" width="400px">
      <div class="avatar-upload">
        <el-upload
            class="avatar-uploader"
            action=""
            :show-file-list="false"
            :on-change="handleAvatarChange"
            :before-upload="beforeAvatarUpload"
        >
          <img v-if="tempAvatar" :src="tempAvatar" class="avatar-preview" />
          <div v-else class="upload-placeholder">
            <el-icon><Plus /></el-icon>
            <div>点击上传头像</div>
          </div>
        </el-upload>
        <p class="upload-tip">支持JPG、PNG格式，大小不超过2MB，建议尺寸200x200px</p>
      </div>
      <template #footer>
        <el-button @click="showAvatarDialog = false">取消</el-button>
        <el-button type="primary" @click="saveAvatar">确认更换</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import {ref, reactive, onMounted} from 'vue'
import {ElMessage} from 'element-plus'
import {Edit, Plus} from '@element-plus/icons-vue'

// 初始学生信息（可从接口获取）
const userInfo = reactive({
  // 不可修改字段
  name: '张三',
  studentId: '2023001001',
  idCard: '110101200501154567',
  createTime: '2023-09-01 08:30:00',
  updateTime: '2023-10-20 14:25:00',

  // 可修改字段
  gender: '男',
  grade: '2023级',
  department: '计算机科学与技术学院',
  major: '计算机科学与技术',
  schoolYear: '2023-2024',
  enrollmentStatus: '正常',
  phone: '13812345678',
  email: 'zhangsan@example.com',
  birthDate: '2005-01-15',
  homeAddress: '北京市海淀区中关村大街1号',
  politicalStatus: '共青团员',
  avatarUrl: '@/assets/imgs/njp9mnwLp9.png'
})

// 编辑表单数据
const formData = reactive({...userInfo})
const originalData = ref({...userInfo}) // 原始数据备份

// 状态管理
const isEditing = ref(false) // 是否处于编辑模式
const showAvatarDialog = ref(false) // 更换头像弹窗显示状态
const tempAvatar = ref('') // 临时头像地址

onMounted(() => {
  // 实际项目中可在此处调用接口获取用户信息
  // 锁定不可修改字段
  formData.name = userInfo.name
  formData.studentId = userInfo.studentId
  formData.idCard = userInfo.idCard
  formData.createTime = userInfo.createTime
})

// 身份证号脱敏处理（保护隐私）
const formatIdCard = (idCard) => {
  if (!idCard) return ''
  return idCard.replace(/(\d{6})(\d{8})(\d{4})/, '$1********$3')
}

// 进入编辑模式
const handleEdit = () => {
  isEditing.value = true
}

// 取消编辑
const cancelEdit = () => {
  Object.assign(formData, originalData.value)
  isEditing.value = false
}

// 保存编辑信息
const saveInfo = () => {
  // 表单验证
  if (!formData.phone) {
    ElMessage.error('请填写手机号')
    return
  }
  if (!formData.email) {
    ElMessage.error('请填写电子邮箱')
    return
  }
  if (!formData.grade) {
    ElMessage.error('请填写年级信息')
    return
  }
  if (!formData.schoolYear) {
    ElMessage.error('请填写学年信息')
    return
  }

  // 保存数据（实际项目中需调用接口提交）
  Object.assign(userInfo, formData)
  Object.assign(originalData.value, formData)

  // 更新时间（实际应由后端返回）
  userInfo.updateTime = new Date().toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  }).replace(/\//g, '-')

  isEditing.value = false
  ElMessage.success('信息修改成功')
}

// 处理头像上传预览
const handleAvatarChange = (file) => {
  const reader = new FileReader()
  reader.onload = (e) => {
    tempAvatar.value = e.target.result
  }
  reader.readAsDataURL(file.raw)
}

// 头像上传前验证
const beforeAvatarUpload = (file) => {
  const isImage = file.type === 'image/jpeg' || file.type === 'image/png'
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isImage) {
    ElMessage.error('仅支持JPG、PNG格式的图片')
  }
  if (!isLt2M) {
    ElMessage.error('图片大小不能超过2MB')
  }
  return isImage && isLt2M
}

// 保存头像修改
const saveAvatar = () => {
  if (tempAvatar.value) {
    userInfo.avatarUrl = tempAvatar.value
    showAvatarDialog.value = false
    tempAvatar.value = ''

    // 更新时间
    userInfo.updateTime = new Date().toLocaleString('zh-CN', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    }).replace(/\//g, '-')

    ElMessage.success('头像更换成功')
  }
}
</script>

<style scoped>
.personal-center {
  padding: 20px;
  background-color: #e4edf1;
  min-height: calc(100vh - 60px);
}

/* 页面标题 */
.page-title {
  margin-bottom: 20px;
}

.page-title h2 {
  margin: 0 0 5px;
  color: #333;
  font-size: 18px;
  font-weight: 600;
}

.page-title p {
  margin: 0;
  color: #666;
  font-size: 14px;
}

/* 头像与基础信息区 */
.profile-header {
  background-color: #fff;
  border-radius: 6px;
  padding: 25px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: flex-start;
  gap: 30px;
}

.avatar-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 10px;
}

.user-avatar {
  border: 3px solid #f0f7ff;
  margin-bottom: 15px;
  transition: transform 0.3s ease;
}

.user-avatar:hover {
  transform: scale(1.05);
}

.change-avatar-btn {
  width: 100%;
  background-color: #2c82ff;
  border-color: #2c82ff;
}

.change-avatar-btn:hover {
  background-color: #1a66d5;
  border-color: #1a66d5;
}

/* 基础信息区域 */
.basic-info {
  flex: 1;
}

/* 信息分区样式 */
.info-section {
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 1px solid #f5f5f5;
}

.info-section:last-child {
  border-bottom: none;
  margin-bottom: 20px;
  padding-bottom: 0;
}

.section-title {
  font-size: 16px;
  color: #333;
  margin: 0 0 15px;
  padding-left: 5px;
  border-left: 3px solid #2c82ff;
}

/* 信息网格布局 */
.info-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px 15px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.info-label {
  font-size: 14px;
  color: #666;
  display: inline-block;
}

.info-value {
  font-size: 15px;
  color: #333;
  padding: 6px 0;
  line-height: 1.5;
}

/* 不可修改字段样式 */
.uneditable {
  color: #999;
  font-weight: normal;
}

/* 编辑组件样式 */
.edit-input, .edit-select {
  width: 80%;
}

/* 操作按钮区 */
.action-buttons {
  text-align: right;
  margin-top: 10px;
}

.action-buttons el-button + el-button {
  margin-left: 10px;
}

/* 头像上传弹窗 */
.avatar-upload {
  text-align: center;
  padding: 10px 0;
}

.avatar-preview {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  object-fit: cover;
  margin: 0 auto 15px;
  display: block;
}

.upload-placeholder {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  border: 1px dashed #ddd;
  margin: 0 auto 15px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #999;
}

.upload-tip {
  color: #999;
  font-size: 12px;
  margin: 0;
}

/* 响应式适配 */
@media (max-width: 1024px) {
  .info-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .profile-header {
    flex-direction: column;
    text-align: center;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .edit-input, .edit-select {
    width: 100%;
    margin: 0 auto;
  }

  .action-buttons {
    text-align: center;
  }

  .info-item {
    align-items: center;
  }
}
</style>