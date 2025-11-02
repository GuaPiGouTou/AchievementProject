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
import { ElMessage } from 'element-plus'
import { Edit, Plus } from '@element-plus/icons-vue'

// 初始教师信息（可从接口获取）
const teacherInfo = reactive({
  // 不可修改字段
  name: '李教授',
  teacherId: 'T2023001',
  idCard: '110101198005201234',
  hireDate: '2005-09-01',

  // 可修改字段
  gender: '男',
  title: '教授',
  department: '计算机科学与技术学院',
  researchArea: '人工智能、机器学习、计算机视觉',
  officePhone: '010-12345678',
  phone: '13987654321',
  email: 'lijiaoshou@example.com',
  officeLocation: '计算机楼305室',
  birthDate: '1980-05-20',
  educationBackground: '2000-2005 清华大学 计算机科学与技术 博士\n1996-2000 北京大学 计算机科学与技术 本科',
  workExperience: '2005-至今 某某大学 计算机学院 教师\n2008-2010 美国斯坦福大学 访问学者',
  academicAchievements: '主持国家自然科学基金项目3项，发表SCI论文30余篇，获省部级科技进步奖2项，授权发明专利10项。',
  avatarUrl: '@/assets/imgs/njp9mnwLp9.png'
})

// 编辑表单数据
const formData = reactive({ ...teacherInfo })
const originalData = ref({ ...teacherInfo }) // 原始数据备份

// 状态管理
const isEditing = ref(false) // 是否处于编辑模式
const showAvatarDialog = ref(false) // 更换头像弹窗显示状态
const tempAvatar = ref('') // 临时头像地址

onMounted(() => {
  // 实际项目中可在此处调用接口获取教师信息
  // 锁定不可修改字段
  formData.name = teacherInfo.name
  formData.teacherId = teacherInfo.teacherId
  formData.idCard = teacherInfo.idCard
  formData.hireDate = teacherInfo.hireDate
})

// 身份证号脱敏处理
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

  // 保存数据（实际项目中需调用接口提交）
  Object.assign(teacherInfo, formData)
  Object.assign(originalData.value, formData)

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
    teacherInfo.avatarUrl = tempAvatar.value
    showAvatarDialog.value = false
    tempAvatar.value = ''
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