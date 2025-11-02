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
// 引入接口（与教师共用同一接口文件）
import { getUserInfo, updateUserInfo, uploadAvatar } from '@/utils/api.js'

// 状态管理
const isEditing = ref(false)
const showAvatarDialog = ref(false)
const tempAvatar = ref('') // 临时头像预览
const uploadAvatarUrl = ref('') // 服务器返回的头像URL
const userInfo = reactive({}) // 接口返回的学生信息
const formData = reactive({}) // 编辑表单数据
const originalData = ref({}) // 原始数据备份
const loading = ref(false) // 加载状态

// 页面挂载时获取学生信息（替换模拟数据为接口请求）
onMounted(async () => {
  await fetchStudentInfo()
})

// 从接口获取学生信息（核心：字段映射 + 登录态验证）
const fetchStudentInfo = async () => {
  loading.value = true
  try {
    // 从本地存储获取登录态（登录时已存储）
    const username = localStorage.getItem('username')
    if (!username) {
      ElMessage.error('未检测到登录状态，请重新登录')
      return
    }

    // 调用接口获取学生信息（isTeacherIdentity固定为false）
    const { data } = await getUserInfo({
      username,
      isTeacherIdentity: false
    })

    // 字段映射：接口返回字段 → 组件内字段（严格对应接口文档）
    Object.assign(userInfo, {
      name: data.name,
      studentId: data.student_no, // 接口：student_no → 组件：studentId
      idCard: data.id_card, // 接口：id_card → 组件：idCard
      createTime: formatTime(data.created_at), // 接口：created_at → 组件：createTime（格式化时间）
      updateTime: formatTime(data.updated_at), // 接口：updated_at → 组件：updateTime（格式化时间）
      gender: data.gender,
      grade: data.grade, // 接口：grade → 组件：grade
      department: data.department, // 接口：department → 组件：department
      major: data.major, // 接口：major → 组件：major
      schoolYear: data.semester, // 接口：semester（学期）→ 组件：schoolYear（学年，适配组件显示）
      enrollmentStatus: data.student_status, // 接口：student_status → 组件：enrollmentStatus
      phone: data.phone, // 接口：phone → 组件：phone
      email: data.email, // 接口：email → 组件：email
      birthDate: data.birth_date, // 接口：birth_date → 组件：birthDate
      homeAddress: data.address, // 接口：address → 组件：homeAddress
      politicalStatus: data.political_status || '群众', // 接口若有则用，无则默认
      avatarUrl: data.avatar || '@/assets/imgs/njp9mnwLp9.png' // 头像URL，默认备用图
    })

    // 初始化表单数据和原始备份
    Object.assign(formData, userInfo)
    Object.assign(originalData.value, userInfo)
  } catch (error) {
    console.error('获取学生信息失败：', error)
    ElMessage.error('获取信息失败，请重试')
  } finally {
    loading.value = false
  }
}

// 时间格式化（将接口的ISO时间转为本地格式）
const formatTime = (isoTime) => {
  if (!isoTime) return ''
  const date = new Date(isoTime)
  return date.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  }).replace(/\//g, '-')
}

// 身份证号脱敏（保留原有逻辑）
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

// 保存编辑信息（核心：对接updateUserInfo接口）
const saveInfo = async () => {
  // 表单验证（保留原有逻辑）
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
      isTeacherIdentity: false, // 固定为学生身份
      updateData: {
        // 通用字段
        name: formData.name,
        phone: formData.phone,
        email: formData.email,
        avatar: formData.avatarUrl,
        gender: formData.gender,
        birth_date: formData.birthDate,
        address: formData.homeAddress, // 组件：homeAddress → 接口：address
        // 学生特有字段
        grade: formData.grade,
        department: formData.department,
        major: formData.major,
        semester: formData.schoolYear, // 组件：schoolYear → 接口：semester
        student_status: formData.enrollmentStatus,
        political_status: formData.politicalStatus // 政治面貌（若接口支持）
      }
    }

    // 调用接口更新信息
    await updateUserInfo(submitData)

    // 刷新本地数据（与接口同步）
    await fetchStudentInfo()
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

// 自定义头像上传（对接头像上传接口）
const customAvatarUpload = async (options) => {
  const file = options.file
  const formData = new FormData()
  formData.append('avatarFile', file) // 接口接收的文件字段名

  try {
    // 调用头像上传接口（返回服务器头像URL）
    const { data } = await uploadAvatar(formData)
    uploadAvatarUrl.value = data.avatarUrl
    ElMessage.success('头像上传成功')
    options.onSuccess() // 通知Element Plus上传成功
  } catch (error) {
    console.error('头像上传失败：', error)
    ElMessage.error('头像上传失败，请重试')
    options.onError() // 通知Element Plus上传失败
  }
}

// 保存头像修改（同步到用户信息）
const saveAvatar = async () => {
  if (!uploadAvatarUrl.value && !tempAvatar.value) return

  // 优先使用服务器返回的URL，无则用本地Base64（临时方案）
  const avatarUrl = uploadAvatarUrl.value || tempAvatar.value

  try {
    // 更新表单头像字段，调用保存接口同步
    formData.avatarUrl = avatarUrl
    await saveInfo()

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