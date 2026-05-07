<template>
  <el-dialog
    :title="dialogTitle"
    :visible.sync="dialogVisible"
    width="700px"
    append-to-body
    :close-on-click-modal="false"
    @close="handleClose"
  >
    <!-- 文件列表展示 -->
    <div class="file-list-container">
      <el-table
        :data="fileList"
        empty-text="暂无附件"
        v-loading="loading"
        style="width: 100%"
      >
        <el-table-column
          prop="fileName"
          label="文件名"
          min-width="300"
          show-overflow-tooltip
        >
          <template slot-scope="{ row }">
            <div class="file-name-cell">
              <i :class="getFileIcon(row.fileExtension)" class="file-icon"></i>
              <span class="file-name-text">
                {{ row.fileName || '未命名文件' }}
              </span>
              <span class="file-extension" v-if="row.fileExtension">.{{ row.fileExtension }}</span>
            </div>
          </template>
        </el-table-column>

        <el-table-column
          prop="fileSize"
          label="大小"
          width="100"
          align="right"
        >
          <template slot-scope="{ row }">
            {{ formatFileSize(row.fileSize) }}
          </template>
        </el-table-column>

        <el-table-column
          label="操作"
          width="180"
          align="center"
        >
          <template slot-scope="{ row }">
            <el-button
              size="mini"
              type="text"
              @click="handleDownload(row)"
              :loading="row.downloadLoading"
            >
              下载
            </el-button>
            <el-button
              v-if="$auth.hasPermi('attachment:attachment:remove')"
              size="mini"
              type="text"
              @click="handleDelete(row)"
              :loading="row.deleteLoading"
              style="color: #f56c6c;"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="handleClose">关闭</el-button>
        <el-button
          type="primary"
          @click="handleRefresh"
          :loading="loading"
          icon="el-icon-refresh"
        >
          刷新
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script>
import { listAttachmentidAndType, delAttachment, DowAttachmentcheck } from "@/api/attachment/attachment"

export default {
  name: "AttachmentManagement",
  props: {
    // 弹窗是否显示
    visible: {
      type: Boolean,
      default: false
    },
    // 弹窗标题
    title: {
      type: String,
      default: '附件管理'
    },
    // 资源ID（如论文ID）
    resourceId: {
      type: [String, Number,null],
      required: false,
      default: null
    },
    // 附件类型
    attachmentType: {
      type: String,
      default: 'paper'
    },
    // 是否显示文件图标
    showFileIcon: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {
      dialogVisible: false,
      fileList: [],
      loading: false
    }
  },
  computed: {
    dialogTitle() {
      return this.title
    }
  },
  watch: {
    visible: {
      immediate: true,
      handler(newVal) {
        this.dialogVisible = newVal
        if (newVal) {
          this.loadAttachments()
        }
      }
    }
  },
  methods: {
    /** 加载附件列表 */
    async loadAttachments() {
      if (!this.resourceId) {
        this.$message.warning('资源ID不能为空')
        return
      }

      this.loading = true
      try {
        const params = {

          // userId: this.resourceId,
          resourceId: this.resourceId,
          attachmentType: this.attachmentType
        }

        const response = await listAttachmentidAndType(params)
        this.fileList = Array.isArray(response.data) ? response.data : []

        this.$emit('load-success', this.fileList)
      } catch (error) {
        console.error('加载附件列表失败:', error)
        this.$emit('load-error', error)
        this.$message.error('加载附件列表失败')
      } finally {
        this.loading = false
      }
    },

    /** 格式化文件大小 */
    formatFileSize(bytes) {
      if (!bytes || bytes === 0) return '0 B'
      const k = 1024
      const sizes = ['B', 'KB', 'MB', 'GB']
      const i = Math.floor(Math.log(bytes) / Math.log(k))
      return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
    },

    /** 获取文件图标 */
    getFileIcon(fileExtension) {
      if (!fileExtension) return 'el-icon-document'

      const iconMap = {
        pdf: 'el-icon-document',
        doc: 'el-icon-document',
        docx: 'el-icon-document',
        xls: 'el-icon-document',
        xlsx: 'el-icon-document',
        ppt: 'el-icon-document',
        pptx: 'el-icon-document',
        txt: 'el-icon-document',
        zip: 'el-icon-folder',
        rar: 'el-icon-folder',
        jpg: 'el-icon-picture',
        jpeg: 'el-icon-picture',
        png: 'el-icon-picture',
        gif: 'el-icon-picture'
      }

      return iconMap[fileExtension.toLowerCase()] || 'el-icon-document'
    },

    /** 下载文件 */
    async handleDownload(row) {
      this.$set(row, 'downloadLoading', true)

      try {
        const url = row.filePath
        await DowAttachmentcheck({ resource: url })
        this.$download.resource(url)
        this.$message.success('下载文件成功')
        this.$emit('download-success', row)
      } catch (error) {
        console.error('下载文件失败:', error)
        this.$message.error('下载文件失败')
        this.$emit('download-error', error, row)
      } finally {
        this.$set(row, 'downloadLoading', false)
      }
    },

    /** 删除文件 */
    async handleDelete(row) {
      try {
        await this.$confirm('确定要删除这个文件吗？', '提示', {
          type: 'warning',
          confirmButtonText: '确定',
          cancelButtonText: '取消'
        })

        this.$set(row, 'deleteLoading', true)

        await delAttachment(row.attachmentId)
        await this.$download.delete(row.filePath)

        this.$message.success('删除成功')
        this.$emit('delete-success', row)

        // 重新加载列表
        await this.loadAttachments()

      } catch (error) {
        if (error !== 'cancel') {
          console.error('删除文件失败:', error)
          this.$message.error('删除文件失败')
          this.$emit('delete-error', error, row)
        }
      } finally {
        this.$set(row, 'deleteLoading', false)
      }
    },

    /** 刷新列表 */
    handleRefresh() {
      this.loadAttachments()
    },

    /** 关闭弹窗 */
    handleClose() {
      this.dialogVisible = false
      this.$emit('update:visible', false)
      this.$emit('close')
    }
  }
}
</script>

<style scoped>
.file-list-container {
  max-height: 400px;
  overflow-y: auto;
}

.file-name-cell {
  display: flex;
  align-items: center;
  gap: 8px;
}

.file-icon {
  font-size: 16px;
  color: #409EFF;
}

.file-name-text {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.file-extension {
  color: #909399;
  font-size: 12px;
}

.dialog-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .file-name-cell {
    flex-direction: column;
    align-items: flex-start;
    gap: 4px;
  }
}
</style>
