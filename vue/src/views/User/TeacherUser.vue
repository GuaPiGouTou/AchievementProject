<template>
  <div class="personal-center">
    <!-- 页面标题 -->
    <div class="page-title">
      <h2>教师个人中心</h2>
      <p>管理个人职业信息与账户设置</p>
    </div>

    <!-- 头像与基础信息区 -->
    <div class="profile-header">
      <div class="avatar-container">
        <el-avatar :size="120" class="user-avatar">
          <img :src="teacherInfo.avatarUrl" alt="教师头像" />
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
              <span class="info-value uneditable">{{ teacherInfo.name }}</span>
            </div>
            <div class="info-item">
              <label class="info-label">教师工号</label>
              <span class="info-value uneditable">{{ teacherInfo.teacherId }}</span>
            </div>
            <div class="info-item">
              <label class="info-label">身份证号</label>
              <span class="info-value uneditable">{{ formatIdCard(teacherInfo.idCard) }}</span>
            </div>
            <div class="info-item">
              <label class="info-label">出生日期</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.birthDate }}</span>
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
              <label class="info-label">入职日期</label>
              <span class="info-value uneditable">{{ teacherInfo.hireDate }}</span>
            </div>
          </div>
        </div>

        <!-- 职业信息区（可修改） -->
        <div class="info-section">
          <h3 class="section-title">职业信息</h3>
          <div class="info-grid">
            <div class="info-item">
              <label class="info-label">性别</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.gender }}</span>
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
              <label class="info-label">职称</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.title }}</span>
              <el-select
                  v-else
                  v-model="formData.title"
                  size="small"
                  class="edit-select"
              >
                <el-option label="教授" value="教授" />
                <el-option label="副教授" value="副教授" />
                <el-option label="讲师" value="讲师" />
                <el-option label="助教" value="助教" />
                <el-option label="研究员" value="研究员" />
                <el-option label="副研究员" value="副研究员" />
              </el-select>
            </div>
            <div class="info-item">
              <label class="info-label">所属院系</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.department }}</span>
              <el-input
                  v-else
                  v-model="formData.department"
                  size="small"
                  class="edit-input"
              />
            </div>
            <div class="info-item">
              <label class="info-label">研究方向</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.researchArea }}</span>
              <el-input
                  v-else
                  v-model="formData.researchArea"
                  size="small"
                  class="edit-input"
              />
            </div>
            <div class="info-item">
              <label class="info-label">办公室位置</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.officeLocation }}</span>
              <el-input
                  v-else
                  v-model="formData.officeLocation"
                  size="small"
                  class="edit-input"
              />
            </div>
          </div>
        </div>

        <!-- 联系方式区（可修改） -->
        <div class="info-section">
          <h3 class="section-title">联系方式</h3>
          <div class="info-grid">
            <div class="info-item">
              <label class="info-label">办公电话</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.officePhone }}</span>
              <el-input
                  v-else
                  v-model="formData.officePhone"
                  size="small"
                  class="edit-input"
              />
            </div>
            <div class="info-item">
              <label class="info-label">手机号码</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.phone }}</span>
              <el-input
                  v-else
                  v-model="formData.phone"
                  size="small"
                  class="edit-input"
              />
            </div>
            <div class="info-item">
              <label class="info-label">电子邮箱</label>
              <span v-if="!isEditing" class="info-value">{{ teacherInfo.email }}</span>
              <el-input
                  v-else
                  v-model="formData.email"
                  size="small"
                  class="edit-input"
              />
            </div>
          </div>
        </div>

        <!-- 职业背景区（可修改） -->
        <div class="info-section">
          <h3 class="section-title">职业背景</h3>
          <div class="info-textarea-group">
            <div class="info-textarea-item">
              <label class="info-label">教育背景</label>
              <span v-if="!isEditing" class="info-text">{{ teacherInfo.educationBackground }}</span>
              <el-input
                  v-else
                  v-model="formData.educationBackground"
                  type="textarea"
                  rows="4"
                  class="edit-textarea"
                  placeholder="请输入教育背景，每行一项"
              />
            </div>
            <div class="info-textarea-item">
              <label class="info-label">工作经历</label>
              <span v-if="!isEditing" class="info-text">{{ teacherInfo.workExperience }}</span>
              <el-input
                  v-else
                  v-model="formData.workExperience"
                  type="textarea"
                  rows="4"
                  class="edit-textarea"
                  placeholder="请输入工作经历，每行一项"
              />
            </div>
            <div class="info-textarea-item">
              <label class="info-label">学术成果概述</label>
              <span v-if="!isEditing" class="info-text">{{ teacherInfo.academicAchievements }}</span>
              <el-input
                  v-else
                  v-model="formData.academicAchievements"
                  type="textarea"
                  rows="4"
                  class="edit-textarea"
                  placeholder="请输入学术成果概述"
              />
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
            :http-request="customAvatarUpload"
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
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElLoading } from 'element-plus'
import { Edit, Plus } from '@element-plus/icons-vue'
// 引入接口（需确保接口文件已按之前的文档封装）
import { getUserInfo, updateUserInfo, uploadAvatar } from '@/utils/api.js'

// 状态管理
const isEditing = ref(false)
const showAvatarDialog = ref(false)
const tempAvatar = ref('') // 临时头像预览
const uploadAvatarUrl = ref('') // 上传后获取的服务器头像URL
const teacherInfo = reactive({}) // 接口返回的教师信息
const formData = reactive({}) // 编辑表单数据
const originalData = ref({}) // 原始数据备份
const loading = ref(false) // 加载状态

// 页面挂载时获取教师信息
onMounted(async () => {
  await fetchTeacherInfo()
})

// 从接口获取教师信息（字段映射：接口字段 → 组件字段）
const fetchTeacherInfo = async () => {
  loading.value = true
  try {
    // 从本地存储获取登录态（登录时已存储）
    const username = localStorage.getItem('username')
    if (!username) {
      ElMessage.error('未检测到登录状态，请重新登录')
      return
    }

    // 调用接口获取教师信息（isTeacherIdentity固定为true）
    const { data } = await getUserInfo({
      username,
      isTeacherIdentity: true
    })

    // 字段映射：接口返回字段 → 组件内使用的字段
    Object.assign(teacherInfo, {
      name: data.name,
      teacherId: data.teacher_no, // 接口：teacher_no → 组件：teacherId
      idCard: data.id_card, // 接口：id_card → 组件：idCard
      hireDate: data.hire_date, // 接口：hire_date → 组件：hireDate
      gender: data.gender,
      title: data.title,
      department: data.department,
      researchArea: data.research_direction, // 接口：research_direction → 组件：researchArea
      officePhone: data.phone, // 接口：phone → 组件：officePhone
      phone: data.mobile, // 接口：mobile → 组件：phone（教师手机号）
      email: data.email,
      officeLocation: data.office_location, // 接口：office_location → 组件：officeLocation
      birthDate: data.birth_date, // 接口：birth_date → 组件：birthDate
      educationBackground: data.education_background, // 接口：education_background → 组件：educationBackground
      workExperience: data.work_experience, // 接口：work_experience → 组件：workExperience
      academicAchievements: data.academic_achievements, // 接口：academic_achievements → 组件：academicAchievements
      avatarUrl: data.avatar || '@/assets/imgs/njp9mnwLp9.png' // 接口头像URL，默认备用图
    })

    // 初始化表单数据和原始备份
    Object.assign(formData, teacherInfo)
    Object.assign(originalData.value, teacherInfo)
  } catch (error) {
    console.error('获取教师信息失败：', error)
    ElMessage.error('获取信息失败，请重试')
  } finally {
    loading.value = false
  }
}

// 身份证号脱敏处理（保留原有逻辑）
const formatIdCard = (idCard) => {
  if (!idCard) return ''
  return idCard.replace(/(\d{6})(\d{8})(\d{4})/, '$1********$3')
}

// 进入编辑模式（保留原有逻辑）
const handleEdit = () => {
  isEditing.value = true
}

// 取消编辑（保留原有逻辑）
const cancelEdit = () => {
  Object.assign(formData, originalData.value)
  isEditing.value = false
}

// 保存编辑信息（核心：替换本地保存为接口提交）
const saveInfo = async () => {
  // 表单验证（保留原有逻辑）
  if (!formData.title) {
    ElMessage.error('请选择职称')
    return
  }
  if (!formData.department) {
    ElMessage.error('请填写所属院系')
    return
  }
  if (!formData.phone) {
    ElMessage.error('请填写手机号码')
    return
  }
  if (!formData.email) {
    ElMessage.error('请填写电子邮箱')
    return
  }

  loading.value = true
  try {
    const username = localStorage.getItem('username')
    if (!username) {
      ElMessage.error('登录状态失效，请重新登录')
      return
    }

    // 构造接口要求的提交格式（组件字段 → 接口字段）
    const submitData = {
      username,
      isTeacherIdentity: true,
      updateData: {
        // 通用字段
        name: formData.name,
        phone: formData.officePhone, // 组件：officePhone → 接口：phone（办公电话）
        email: formData.email,
        avatar: formData.avatarUrl, // 头像URL
        gender: formData.gender,
        birth_date: formData.birthDate, // 组件：birthDate → 接口：birth_date
        // 教师特有字段
        title: formData.title,
        department: formData.department,
        research_direction: formData.researchArea, // 组件：researchArea → 接口：research_direction
        office_location: formData.officeLocation, // 组件：officeLocation → 接口：office_location
        mobile: formData.phone, // 组件：phone → 接口：mobile（手机号）
        education_background: formData.educationBackground, // 组件：educationBackground → 接口：education_background
        work_experience: formData.workExperience, // 组件：workExperience → 接口：work_experience
        academic_achievements: formData.academicAchievements // 组件：academicAchievements → 接口：academic_achievements
      }
    }

    // 调用接口更新信息
    await updateUserInfo(submitData)

    // 刷新本地数据（确保与接口同步）
    await fetchTeacherInfo()
    isEditing.value = false
    ElMessage.success('信息修改成功')
  } catch (error) {
    console.error('信息提交失败：', error)
    ElMessage.error('修改失败，请重试')
  } finally {
    loading.value = false
  }
}

// 头像上传预览（保留原有逻辑）
const handleAvatarChange = (file) => {
  const reader = new FileReader()
  reader.onload = (e) => {
    tempAvatar.value = e.target.result
  }
  reader.readAsDataURL(file.raw)
}

// 头像上传前验证（保留原有逻辑）
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

// 自定义头像上传（核心：对接头像上传接口）
const customAvatarUpload = async (options) => {
  const file = options.file
  const formData = new FormData()
  formData.append('avatarFile', file) // 接口接收的文件字段名

  try {
    // 调用头像上传接口（假设后端有专门的头像上传接口，返回URL）
    const { data } = await uploadAvatar(formData)
    uploadAvatarUrl.value = data.avatarUrl // 存储上传后的服务器URL
    ElMessage.success('头像上传成功')
  } catch (error) {
    console.error('头像上传失败：', error)
    ElMessage.error('头像上传失败，请重试')
    options.onError() // 通知Element Plus上传失败
  }
}

// 保存头像修改（核心：更新头像URL到用户信息）
const saveAvatar = async () => {
  if (!uploadAvatarUrl.value && !tempAvatar.value) return

  // 若已上传到服务器，用服务器URL；否则用本地Base64（临时方案）
  const avatarUrl = uploadAvatarUrl.value || tempAvatar.value

  try {
    // 直接更新表单的头像字段，调用保存接口同步
    formData.avatarUrl = avatarUrl
    await saveInfo() // 复用信息保存接口，同步更新头像

    // 重置状态
    showAvatarDialog.value = false
    tempAvatar.value = ''
    uploadAvatarUrl.value = ''
  } catch (error) {
    console.error('头像保存失败：', error)
    ElMessage.error('头像更换失败，请重试')
  }
}
</script>

<style scoped>
/* 样式部分无需修改，保留原有逻辑 */
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

/* 多行文本区域样式 */
.info-textarea-group {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.info-textarea-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.info-text {
  white-space: pre-line; /* 保留换行符 */
  font-size: 15px;
  color: #333;
  line-height: 1.6;
  padding: 6px 0;
}

.edit-textarea {
  width: 100%;
  min-width: 100%;
  max-width: 100%;
}

/* 标签与值样式 */
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

  .info-item, .info-textarea-item {
    align-items: center;
  }

  .info-text {
    text-align: left;
    max-width: 100%;
  }
}
</style>