<template>
  <div class="base64-uploader">
    <!-- 文件选择区域 -->
    <div class="upload-area" v-if="!disabled">
      <el-upload
        ref="fileUpload"
        :auto-upload="false"
        :multiple="true"
        :file-list="internalFileList"
        :limit="limit"
        :on-exceed="handleExceed"
        :before-upload="handleBeforeUpload"
        :on-change="handleFileChange"
        :on-remove="handleFileRemove"
        :show-file-list="false"
        class="uploader"
        action="#"
      >
        <el-button size="small" type="primary">选择文件</el-button>
        <div slot="tip" class="el-upload__tip" v-if="showTip">
          请选择
          <template v-if="fileSize">大小不超过 <b>{{ fileSize }}MB</b></template>
          <template v-if="fileType">格式为 <b>{{ fileType.join('/') }}</b></template>
          的文件
        </div>
      </el-upload>

      <!-- 上传按钮 -->
      <el-button
        size="small"
        type="success"
        @click="submitUpload"
        :loading="uploading"
        :disabled="internalFileList.length === 0"
        class="upload-btn"
      >
        {{ uploading ? '上传中...' : '开始上传' }}
      </el-button>
    </div>

    <!-- 文件列表 -->
    <div class="file-list" v-if="internalFileList.length > 0">
      <div class="file-list-header">
        <span>已选择文件 ({{ internalFileList.length }}/{{ limit }})</span>
        <el-button
          v-if="!disabled"
          size="mini"
          type="text"
          @click="clearAll"
          :disabled="uploading"
        >
          清空全部
        </el-button>
      </div>

      <div class="file-items">
        <div
          v-for="(file, index) in internalFileList"
          :key="file.uid"
          class="file-item"
          :class="{ 'uploading': file.status === 'uploading', 'success': file.status === 'success', 'error': file.status === 'error' }"
        >
          <div class="file-info">
            <i class="el-icon-document"></i>
            <span class="file-name">{{ file.name }}</span>
            <span class="file-size">({{ formatFileSize(file.size) }})</span>
          </div>

          <div class="file-actions" v-if="!disabled">
            <!-- 上传状态指示 -->
            <span v-if="file.status === 'uploading'" class="status-text">
              <i class="el-icon-loading"></i> 上传中...
            </span>
            <span v-if="file.status === 'success'" class="status-text success">
              <i class="el-icon-check"></i> 上传成功
            </span>
            <span v-if="file.status === 'error'" class="status-text error">
              <i class="el-icon-close"></i> 上传失败
            </span>

            <!-- 删除按钮 -->
            <el-button
              size="mini"
              type="text"
              @click="removeFile(index)"
              :disabled="file.status === 'uploading'"
              class="delete-btn"
            >
              删除
            </el-button>
          </div>
        </div>
      </div>
    </div>

    <!-- 已上传文件列表（仅查看模式） -->
    <div class="uploaded-files" v-if="disabled && value && value.length > 0">
      <div class="file-list-header">已上传文件</div>
      <div class="file-items">
        <div v-for="(file, index) in uploadedFiles" :key="index" class="file-item success">
          <div class="file-info">
            <i class="el-icon-document"></i>
            <span class="file-name">{{ file.name }}</span>
            <el-link :href="file.url" target="_blank" type="primary" class="view-link">查看</el-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getToken } from "@/utils/auth"

export default {
  name: "Base64FileUpload",
  props: {
    // 绑定值，已上传的文件列表
    value: {
      type: [String, Array],
      default: () => []
    },
    // 上传接口地址
    action: {
      type: String,
      default: "/attupload/upload"
    },
    // 数量限制
    limit: {
      type: Number,
      default: 5
    },
    // 大小限制(MB)
    fileSize: {
      type: Number,
      default: 5
    },
    // 文件类型
    fileType: {
      type: Array,
      default: () => ["doc", "docx", "xls", "xlsx", "ppt", "pptx", "txt", "pdf", "jpg", "png", "jpeg"]
    },
    // 是否显示提示
    isShowTip: {
      type: Boolean,
      default: true
    },
    // 是否禁用（仅查看）
    disabled: {
      type: Boolean,
      default: false
    },
    // 额外参数
    data: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      internalFileList: [], // 内部维护的文件列表
      uploading: false, // 是否正在上传
      uploadUrl: process.env.VUE_APP_BASE_API + this.action,
      headers: {
        Authorization: "Bearer " + getToken(),
      }
    }
  },
  computed: {
    // 是否显示提示
    showTip() {
      return this.isShowTip && (this.fileType || this.fileSize)
    },
    // 已上传的文件列表（用于查看模式）
    uploadedFiles() {
      if (!this.value) return []

      if (Array.isArray(this.value)) {
        return this.value.map(item => {
          if (typeof item === 'string') {
            return { name: this.getFileName(item), url: item }
          }
          return item
        })
      }

      // 如果是逗号分隔的字符串
      return this.value.split(',').filter(item => item.trim()).map(item => {
        return { name: this.getFileName(item), url: item }
      })
    }
  },
  watch: {
    // 监听value变化，同步到内部文件列表（用于编辑已有文件）
    value: {
      handler(newVal) {
        if (this.disabled) return

        if (newVal && newVal.length > 0) {
          let temp = 1
          const list = Array.isArray(newVal) ? newVal : newVal.split(',')

          this.internalFileList = list.filter(item => item).map(item => {
            let fileObj
            if (typeof item === "string") {
              fileObj = { name: this.getFileName(item), url: item }
            } else {
              fileObj = { ...item }
            }
            fileObj.uid = fileObj.uid || new Date().getTime() + temp++
            fileObj.status = 'success'
            return fileObj
          })
        } else {
          this.internalFileList = []
        }
      },
      immediate: true
    }
  },
  methods: {
    // 提交上传
    async submitUpload(paperId) {
      if (this.internalFileList.length === 0) {
        this.$message.warning('请先选择要上传的文件')
        return
      }

      this.uploading = true
      let successCount = 0
      let errorCount = 0

      try {
        // 逐个上传文件
        for (let i = 0; i < this.internalFileList.length; i++) {
          const file = this.internalFileList[i]

          // 跳过已上传成功的文件
          if (file.status === 'success') continue

          // 设置上传状态
          file.status = 'uploading'

          try {
            const result = await this.uploadSingleFile(file, paperId)
            if (result.success) {
              file.status = 'success'
              file.url = result.fileName
              successCount++
            } else {
              file.status = 'error'
              errorCount++
              this.$message.error(`文件 "${file.name}" 上传失败: ${result.message}`)
            }
          } catch (error) {
            file.status = 'error'
            errorCount++
            this.$message.error(`文件 "${file.name}" 上传失败: ${error.message}`)
          }
        }

        // 上传完成处理
        if (successCount > 0) {
          this.$message.success(`成功上传 ${successCount} 个文件`)
          this.emitUpdate()
        }

        if (errorCount > 0) {
          this.$message.error(`${errorCount} 个文件上传失败`)
        }

      } catch (error) {
        this.$message.error('上传过程发生错误')
        console.error('上传错误:', error)
      } finally {
        this.uploading = false
      }
    },

    // 上传单个文件
    async uploadSingleFile(file, paperId) {
      try {
        // 转换为Base64
        const base64Data = await this.fileToBase64Data(file.raw || file)

        // 准备上传数据
        const formData = new FormData()
        formData.append('fileBase64', base64Data)
        formData.append('fileName', file.name)
        formData.append('paperId', paperId)

        // 添加额外参数
        Object.keys(this.data).forEach(key => {
          formData.append(key, this.data[key])
        })

        // 发送请求
        const response = await fetch(this.uploadUrl, {
          method: 'POST',
          headers: {
            'Authorization': this.headers.Authorization
          },
          body: formData
        })

        const result = await response.json()

        if (result.code === 200) {
          return { success: true, fileName: result.fileName }
        } else {
          return { success: false, message: result.msg || '上传失败' }
        }
      } catch (error) {
        console.error('文件上传错误:', error)
        return { success: false, message: error.message }
      }
    },

    // 文件选择变化
    handleFileChange(file, fileList) {
      this.internalFileList = fileList
    },

    // 文件移除
    handleFileRemove(file, fileList) {
      this.internalFileList = fileList
    },

    // 手动移除文件
    removeFile(index) {
      this.internalFileList.splice(index, 1)
    },

    // 清空所有文件
    clearAll() {
      this.internalFileList = []
    },

    // 上传前校验
    handleBeforeUpload(file) {
      // 校验文件类型
      if (this.fileType && this.fileType.length > 0) {
        const fileExt = file.name.split('.').pop().toLowerCase()
        const isTypeOk = this.fileType.map(type => type.toLowerCase()).includes(fileExt)
        if (!isTypeOk) {
          this.$message.error(`不支持的文件格式，请上传 ${this.fileType.join('/')} 格式文件`)
          return false
        }
      }

      // 校验文件大小
      if (this.fileSize) {
        const isLt = file.size / 1024 / 1024 < this.fileSize
        if (!isLt) {
          this.$message.error(`文件大小不能超过 ${this.fileSize}MB`)
          return false
        }
      }

      // 校验文件数量
      if (this.internalFileList.length >= this.limit) {
        this.$message.error(`最多只能上传 ${this.limit} 个文件`)
        return false
      }

      return true
    },

    // 文件超出限制
    handleExceed() {
      this.$message.error(`最多只能上传 ${this.limit} 个文件`)
    },

    // 触发更新事件
    emitUpdate() {
      const uploadedFiles = this.internalFileList
        .filter(file => file.status === 'success')
        .map(file => file.url || file.name)

      this.$emit('input', uploadedFiles)
      this.$emit('change', uploadedFiles)
    },

    // 文件转Base64
    fileToBase64Data(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader()
        reader.onload = (event) => {
          const base64String = event.target.result.split(',')[1]
          resolve(base64String)
        }
        reader.onerror = (error) => {
          reject(new Error(`文件读取失败: ${error}`))
        }
        reader.readAsDataURL(file)
      })
    },

    // 获取文件名
    getFileName(path) {
      if (path.lastIndexOf('/') > -1) {
        return path.slice(path.lastIndexOf('/') + 1)
      } else if (path.lastIndexOf('\\') > -1) {
        return path.slice(path.lastIndexOf('\\') + 1)
      } else {
        return path
      }
    },

    // 格式化文件大小
    formatFileSize(bytes) {
      if (bytes === 0) return '0 B'
      const k = 1024
      const sizes = ['B', 'KB', 'MB', 'GB']
      const i = Math.floor(Math.log(bytes) / Math.log(k))
      return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
    }
  }
}
</script>

<style scoped lang="scss">
.base64-uploader {
  width: 100%;
}

.upload-area {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  margin-bottom: 15px;

  .uploader {
    flex: 1;
  }

  .upload-btn {
    margin-top: 5px;
  }
}

.file-list, .uploaded-files {
  border: 1px solid #e4e7ed;
  border-radius: 4px;
  padding: 10px;
  margin-top: 10px;
}

.file-list-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  font-weight: 500;
  color: #606266;
}

.file-items {
  max-height: 200px;
  overflow-y: auto;
}

.file-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 10px;
  border-radius: 4px;
  margin-bottom: 5px;
  transition: background-color 0.3s;

  &:hover {
    background-color: #f5f7fa;
  }

  &.uploading {
    background-color: #f0f9ff;
  }

  &.success {
    background-color: #f0f9f4;
  }

  &.error {
    background-color: #fef0f0;
  }
}

.file-info {
  display: flex;
  align-items: center;
  flex: 1;

  .el-icon-document {
    margin-right: 8px;
    color: #909399;
  }

  .file-name {
    margin-right: 8px;
    max-width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .file-size {
    color: #909399;
    font-size: 12px;
  }

  .view-link {
    margin-left: 10px;
  }
}

.file-actions {
  display: flex;
  align-items: center;
  gap: 10px;

  .status-text {
    font-size: 12px;

    &.success {
      color: #67c23a;
    }

    &.error {
      color: #f56c6c;
    }
  }

  .delete-btn {
    color: #f56c6c;
  }
}

.el-upload__tip {
  margin-top: 7px;
  color: #909399;
  font-size: 12px;

  b {
    color: #f56c6c;
  }
}
</style>
