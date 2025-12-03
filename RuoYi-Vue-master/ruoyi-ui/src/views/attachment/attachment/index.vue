<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关联子表ID" prop="resourceId">
        <el-input
          v-model="queryParams.resourceId"
          placeholder="请输入关联子表ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文件名称" prop="fileName">
        <el-input
          v-model="queryParams.fileName"
          placeholder="请输入文件名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文件大小" prop="fileSize">
        <el-input
          v-model="queryParams.fileSize"
          placeholder="请输入文件大小"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文件扩展名" prop="fileExtension">
        <el-input
          v-model="queryParams.fileExtension"
          placeholder="请输入文件扩展名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="上传时间" prop="uploadTime">
        <el-date-picker clearable
          v-model="queryParams.uploadTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择上传时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="上传用户ID" prop="uploadUserId">
        <el-input
          v-model="queryParams.uploadUserId"
          placeholder="请输入上传用户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="下载次数" prop="downloadCount">
        <el-input
          v-model="queryParams.downloadCount"
          placeholder="请输入下载次数"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['attachment:attachment:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['attachment:attachment:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['attachment:attachment:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['attachment:attachment:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="attachmentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="附件ID" align="center" prop="attachmentId" />
      <el-table-column label="关联子表ID" align="center" prop="userId" />
      <el-table-column label="附件类型" align="center" prop="attachmentType" />
      <el-table-column label="文件名称" align="center" prop="fileName" />
      <el-table-column label="文件路径" align="center" prop="filePath" />
      <el-table-column label="文件大小" align="center" prop="fileSize" />
      <el-table-column label="文件扩展名" align="center" prop="fileExtension" />
      <el-table-column label="文件分类" align="center" prop="fileCategory" />
      <el-table-column label="文件描述" align="center" prop="description" />
      <el-table-column label="上传时间" align="center" prop="uploadTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.uploadTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上传用户ID" align="center" prop="uploadUserId" />
      <el-table-column label="下载次数" align="center" prop="downloadCount" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['attachment:attachment:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['attachment:attachment:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改成果附件对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="关联子表ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入关联子表ID" />
        </el-form-item>
        <el-form-item label="文件名称" prop="fileName">
          <el-input v-model="form.fileName" placeholder="请输入文件名称" />
        </el-form-item>
        <el-form-item label="文件路径" prop="filePath">
          <el-input v-model="form.filePath" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="文件大小" prop="fileSize">
          <el-input v-model="form.fileSize" placeholder="请输入文件大小" />
        </el-form-item>
        <el-form-item label="文件扩展名" prop="fileExtension">
          <el-input v-model="form.fileExtension" placeholder="请输入文件扩展名" />
        </el-form-item>
        <el-form-item label="文件描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="上传时间" prop="uploadTime">
          <el-date-picker clearable
            v-model="form.uploadTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择上传时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="上传用户ID" prop="uploadUserId">
          <el-input v-model="form.uploadUserId" placeholder="请输入上传用户ID" />
        </el-form-item>
        <el-form-item label="下载次数" prop="downloadCount">
          <el-input v-model="form.downloadCount" placeholder="请输入下载次数" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <el-dialog
      :title="Exceltitle"
      :visible.sync="Excelopen"
      width="600px"
      append-to-body
      :close-on-click-modal="false">
       <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.label}}</el-checkbox>
        </el-checkbox-group>
        <el-button @click="DowExcel()" >导出</el-button>
    </el-dialog>
  </div>
</template>

<script>
import { listAttachment, getAttachment, delAttachment, addAttachment, updateAttachment } from "@/api/attachment/attachment"

export default {
  name: "Attachment",
  data() {
    return {
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      // 论文成果选择字段数组
      // 成果附件选择字段数组
      checkList: [
        {
          value: 'attachmentId',
          label: '附件ID'
        }, {
          value: 'resourceId',
          label: '关联子表ID'
        }, {
          value: 'attachmentType',
          label: '附件类型'
        }, {
          value: 'fileName',
          label: '文件名称'
        }, {
          value: 'filePath',
          label: '文件路径'
        }, {
          value: 'fileSize',
          label: '文件大小'
        }, {
          value: 'fileExtension',
          label: '文件扩展名'
        }, {
          value: 'fileCategory',
          label: '文件分类'
        }, {
          value: 'description',
          label: '文件描述'
        }, {
          value: 'uploadTime',
          label: '上传时间'
        }, {
          value: 'uploadUserId',
          label: '上传用户ID'
        }, {
          value: 'downloadCount',
          label: '下载次数'
        }, {
          value: 'createBy',
          label: '创建者'
        }, {
          value: 'createTime',
          label: '创建时间'
        }, {
          value: 'updateBy',
          label: '更新者'
        }, {
          value: 'updateTime',
          label: '更新时间'
        }
      ],
      //导出选择字段
      selectClist:[],
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 成果附件表格数据
      attachmentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        resourceId: null,
        attachmentType: null,
        fileName: null,
        filePath: null,
        fileSize: null,
        fileExtension: null,
        fileCategory: null,
        description: null,
        uploadTime: null,
        uploadUserId: null,
        downloadCount: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        resourceId: [
          { required: true, message: "关联子表ID不能为空", trigger: "blur" }
        ],
        attachmentType: [
          { required: true, message: "附件类型不能为空", trigger: "change" }
        ],
        fileName: [
          { required: true, message: "文件名称不能为空", trigger: "blur" }
        ],
        filePath: [
          { required: true, message: "文件路径不能为空", trigger: "blur" }
        ],
        fileSize: [
          { required: true, message: "文件大小不能为空", trigger: "blur" }
        ],
        fileExtension: [
          { required: true, message: "文件扩展名不能为空", trigger: "blur" }
        ],
        fileCategory: [
          { required: true, message: "文件分类不能为空", trigger: "blur" }
        ],
        uploadTime: [
          { required: true, message: "上传时间不能为空", trigger: "blur" }
        ],
        uploadUserId: [
          { required: true, message: "上传用户ID不能为空", trigger: "blur" }
        ],
        downloadCount: [
          { required: true, message: "下载次数不能为空", trigger: "blur" }
        ],
        createTime: [
          { required: true, message: "创建时间不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询成果附件列表 */
    getList() {
      this.loading = true
      listAttachment(this.queryParams).then(response => {
        this.attachmentList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        attachmentId: null,
        resourceId: null,
        attachmentType: null,
        fileName: null,
        filePath: null,
        fileSize: null,
        fileExtension: null,
        fileCategory: null,
        description: null,
        uploadTime: null,
        uploadUserId: null,
        downloadCount: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.attachmentId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加成果附件"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const attachmentId = row.attachmentId || this.ids
      getAttachment(attachmentId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改成果附件"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.attachmentId != null) {
            updateAttachment(this.form).then(response => {

              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addAttachment(this.form).then(response => {

              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const attachmentIds = row.attachmentId || this.ids
      this.$modal.confirm('是否确认删除成果附件编号为"' + attachmentIds + '"的数据项？').then(function() {
        return delAttachment(attachmentIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
     this.Excelopen = true
    },
    /*导出*/
    DowExcel(){
       const requestData = {
        showColumns: this.selectClist || [],
        data: {
          ...this.queryParams
        }
       };
      const jsonRequestBody = JSON.stringify(requestData);
      this.exceldownload('attachment/attachment/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
    },
    /*
    附件弹窗方法
    */
      handleAttachment(row) {
          this.currentPaperId = 1001
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.textbookName || '附件'}`
          this.attachmentVisible = true
        },

      /** 附件弹窗关闭 */
      handleAttachmentClose() {
        this.currentPaperId = null
        this.currentPaper = null
      },

      /** 附件加载成功 */
      handleAttachmentLoadSuccess(fileList) {
        console.log(`加载了 ${fileList.length} 个附件`)
        // 可以在这里更新论文的附件数量显示
        if (this.currentPaper) {
          this.$set(this.currentPaper, 'attachmentCount', fileList.length)
        }
      },

      /** 下载成功 */
      handleDownloadSuccess(file) {
        this.$message.success(`文件"${file.fileName}"下载成功`)
      },

      /** 删除成功 */
      handleDeleteSuccess(file) {
        this.$message.success(`文件"${file.fileName}"删除成功`)
      }

  }
}
</script>
