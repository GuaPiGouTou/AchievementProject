<template>
  <div class="app-container">
     <el-form class="achievement-search-form" :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
              <el-form-item label="搜索字段" prop="competitionName">
                <el-select v-model="SelectQueryParams" placeholder="请选择搜索字段" @change="changeQueryParams(SelectQueryParams)">
                    <el-option
                      v-for="item in checkList"
	                      :key="item.value"
	                      :label="item.label"
	                      :value="item.value"
	                      v-if="item.value=='updateTime'||item.value=='createTime'?adminFlag:true"
	                      >
                    </el-option>
                </el-select>

              </el-form-item>
              <el-form-item >
                <el-input v-if="!TimeFlag" v-model="SelectQueryParamsValue" placeholder="请输入搜索内容" />
                <el-date-picker v-else
                  clearable
                  v-model="SelectQueryParamsValue"
                  type="datetimerange"
                  value-format="yyyy-MM-ddTHH:mm:ss"
                  range-separator="至"
                  start-placeholder="开始时间"
                  end-placeholder="结束时间">
                </el-date-picker>
              </el-form-item>

              <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
              </el-form-item>
            </el-form>

    <el-row :gutter="10" class="mb8">
     <!-- <el-col :span="1.5">
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
        >修改</el-button> -->
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
      <el-table-column v-if="adminFlag" label="附件ID" align="center" prop="attachmentId" />
      <el-table-column v-if="adminFlag" label="关联子表ID" align="center" prop="userId" />
      <el-table-column label="附件类型" align="center" prop="attachmentType" />
      <el-table-column label="文件名称" align="center" prop="fileName" />
      <el-table-column v-if="adminFlag" label="文件路径" align="center" prop="filePath" />
      <el-table-column label="文件大小" align="center" prop="fileSize" />
      <el-table-column label="文件扩展名" align="center" prop="fileExtension" />
      <el-table-column label="文件分类" align="center" prop="fileCategory" />
      <el-table-column label="文件描述" align="center" prop="description" />
      <el-table-column v-if="adminFlag" label="上传时间" align="center" prop="uploadTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.uploadTime, '{y}-{m}-{d}-{h}:{m}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column v-if="adminFlag" label="上传用户ID" align="center" prop="uploadUserId" />
      <el-table-column label="下载次数" align="center" prop="downloadCount" />
      <el-table-column label="创建者" align="center" prop="createBy" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}-{h}:{m}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column  label="更新者" align="center" prop="updateBy" />
      <el-table-column  label="创建时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}-{h}:{m}:{s}') }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
         <!-- <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['attachment:attachment:edit']"
          >修改</el-button> -->
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
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
        <el-form-item label="关联子表ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入关联子表ID" />
        </el-form-item>
        <el-form-item label="文件名称" prop="fileName">
          <el-input v-model="form.fileName" placeholder="请输入文件名称" />
        </el-form-item>
        <el-form-item label="文件路径" prop="filePath">
          <el-input v-model="form.filePath" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="文件大小" prop="fileSize">
          <el-input v-model="form.fileSize" placeholder="请输入文件大小" />
        </el-form-item>
        <el-form-item label="文件扩展名" prop="fileExtension">
          <el-input v-model="form.fileExtension" placeholder="请输入文件扩展名" />
        </el-form-item>
        <el-form-item label="文件描述" prop="description">
          <el-input v-model="form.description" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="上传时间" prop="uploadTime">
          <el-date-picker clearable
            v-model="form.uploadTime"
            type="datetime"
            value-format="yyyy-MM-ddTHH:mm:ss"
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
<!--    <el-dialog
      :title="Exceltitle"
      :visible.sync="Excelopen"
      width="600px"
      append-to-body
      :close-on-click-modal="false">
       <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.label}}</el-checkbox>
        </el-checkbox-group>
         <el-badge :value="idsCount==0?attachmentList.length:idsCount" class="item"  >
           <el-button @click="DowExcel()" >导出</el-button>
         </el-badge>
    </el-dialog> -->

  <el-dialog
    :title="Exceltitle"
    :visible.sync="Excelopen"
    width="720px"
    append-to-body
    :close-on-click-modal="false"
  >
    <!-- 导出字段选择区 -->
    <div class="export-container">
      <el-checkbox-group
        v-model="selectClist"
        class="export-checkbox-group"
      >
        <!-- 修复1：item.lable → item.label -->
        <el-checkbox
          v-for="item in checkList"
          :key="item.value"
          :label="item.value"
          class="export-checkbox"
        >
          {{ item.label }}
        </el-checkbox>
      </el-checkbox-group>
    </div>

    <!-- 底部操作按钮（修复2：用 div 包裹 slot，避免样式冲突） -->
    <div slot="footer" class="export-dialog-footer">
      <el-button @click="Excelopen = false">取 消</el-button>
      <el-button
        type="primary"
        icon="el-icon-download"
        @click="DowExcel"
      >
        导 出
      </el-button>
    </div>
  </el-dialog>
  </div>
</template>

<script>
import { listAttachment, getAttachment, delAttachment, addAttachment, updateAttachment } from "@/api/attachment/attachment"
import Cookies from "js-cookie"
import { buildDateRangeQuery } from "@/utils/dateRangeQuery"
export default {
  name: "Attachment",
  data() {
    return {
      //日期选择类型
      TimeType:"datetime",
      TimeFormat:"yyyy-MM-ddTHH:mm:ss",
      //是否为时间字段
      TimeFlag:false,
      //搜索内容
      SelectQueryParamsValue:null,
      //搜索字段
      SelectQueryParams:null,
      lastSearchField: null,
      //审核选择项
      AudisStatis:"待审核",
      //审核选项列表 '通过','驳回','待审核','退回'
      audisItems: [
      '通过','驳回','待审核','退回'
      ],
      //审核弹窗
      AudisVisible:false,
      //管理员标识
      adminFlag:false,
      //导出记录
      idsCount:0,
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
          { required: true, message: "关联子表ID不能为空", trigger: "blur" },
          // ID 通常是纯数字
          { pattern: /^[0-9]+$/, message: "ID必须为纯数字", trigger: "blur" }
        ],
        fileName: [
          { required: true, message: "文件名称不能为空", trigger: "blur" },
          { max: 255, message: "文件名称长度不能超过 255 个字符", trigger: "blur" },
          // 核心校验：禁止文件名包含 Windows/Linux 系统非法字符 (\ / : * ? " < > |)
          { pattern: /^[^\\/:*?"<>|]+$/, message: "文件名不能包含 \\ / : * ? \" < > | 等特殊字符", trigger: "blur" }
        ],
        filePath: [
          { required: true, message: "文件路径不能为空", trigger: "blur" },
          { max: 500, message: "路径长度不能超过 500 个字符", trigger: "blur" }
          // 路径通常由系统生成，如果允许手动输入，建议不做过严的正则限制，防止误杀合法URL或绝对路径
        ],
        fileSize: [
          { required: true, message: "文件大小不能为空", trigger: "blur" },
          // 假设数据库存的是字节数(Byte)，校验是否为纯数字
          { pattern: /^[0-9]+$/, message: "文件大小必须为纯数字（单位：字节）", trigger: "blur" }
        ],
        fileExtension: [
          { required: true, message: "文件扩展名不能为空", trigger: "blur" },
          // 允许带点或不带点，纯字母数字。例如: .pdf, png, docx
          { pattern: /^\.?[a-zA-Z0-9]+$/, message: "格式错误，请填写如: pdf, .jpg, docx", trigger: "blur" },
          { max: 10, message: "扩展名过长", trigger: "blur" }
        ],
        fileCategory: [
          { required: true, message: "文件分类不能为空", trigger: "blur" },
          { max: 50, message: "分类名称不能超过 50 个字符", trigger: "blur" }
        ],
        description: [
          { required: false, message: "请输入文件描述", trigger: "blur" },
          { max: 500, message: "描述内容不能超过 500 个字符", trigger: "blur" }
        ],
        uploadTime: [
          { required: true, message: "上传时间不能为空", trigger: "change" }
        ],
        uploadUserId: [
          { required: true, message: "上传用户ID不能为空", trigger: "blur" },
          { pattern: /^[0-9]+$/, message: "用户ID必须为纯数字", trigger: "blur" }
        ],
        downloadCount: [
          { required: true, message: "下载次数不能为空", trigger: "blur" },
          // 必须是非负整数
          { pattern: /^(0|[1-9][0-9]*)$/, message: "下载次数必须为非负整数", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
    /*管理权限标识符验证 显示隐藏组件*/
    const flag = Cookies.get("adminFlag")
    if(flag =="true")
    {
      this.adminFlag = true
    }
  },
  methods: {
    /*查询输入字段验证时间组件*/
    changeQueryParams(res){
      this.clearCurrentSearch()
      this.SelectQueryParamsValue = null;
      if(res=="updateTime"||res=="createTime"||res=="uploadTime")
      {
        this.TimeFlag = true
      }else{
         this.TimeFlag = false
      }
    },
    /** 查询成果附件列表 */
    getList() {
      this.loading = true
      listAttachment(this.buildQueryParams()).then(response => {
        this.attachmentList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    buildQueryParams() {
      if (this.TimeFlag && this.SelectQueryParams) {
        const propName = this.SelectQueryParams.charAt(0).toUpperCase() + this.SelectQueryParams.slice(1)
        return buildDateRangeQuery(this.queryParams, {
          [propName]: this.SelectQueryParamsValue
        })
      }
      return buildDateRangeQuery(this.queryParams, {})
    },
    clearCurrentSearch() {
      const field = this.lastSearchField || this.SelectQueryParams
      if (field) {
        this.queryParams[field] = null
        const propName = field.charAt(0).toUpperCase() + field.slice(1)
        if (this.queryParams.params) {
          delete this.queryParams.params[`begin${propName}`]
          delete this.queryParams.params[`end${propName}`]
        }
      }
      this.queryParams.params = {}
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
     if(this.SelectQueryParams!=null&&this.SelectQueryParamsValue!=null)
     {
     this.clearCurrentSearch()
     if (!this.TimeFlag) {
       this.queryParams[this.SelectQueryParams] = this.SelectQueryParamsValue
     }
     this.lastSearchField = this.SelectQueryParams
     this.queryParams.pageNum = 1
     this.getList()
     }else{
       if(this.SelectQueryParams==null)
       {
         this.$message.error("搜索字段不能为空")
       }else{
         this.$message.error("搜索值不能为空")
       }

     }
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.clearCurrentSearch()
      this.SelectQueryParams = null
      this.SelectQueryParamsValue = null
      this.TimeFlag = false
      this.lastSearchField = null
      this.queryParams.pageNum = 1
      this.getList()
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
	          Ids:this.ids,
	          ...this.buildQueryParams()
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
<style scoped>
/* ================= 整体说明 ================= */
/* 该样式为导出功能弹窗的专属样式，使用 scoped 确保样式仅作用于当前组件
   基于 Element Plus 组件库的样式扩展，主要包含弹窗容器、复选框网格、底部按钮区样式
*/

/* ===== 导出弹窗主体容器 ===== */
.export-container {
  padding: 20px 24px;        /* 内边距：上下16px 左右20px，保证内容与边框间距 */
  background: #fafbfc;       /* 浅灰背景色，提升视觉层次感 */
  border-radius: 6px;        /* 圆角设计，统一产品视觉风格 */
  margin-bottom: 10px;       /* 新增：与底部按钮区分隔 */
}

/* ===== 复选框组 - 网格布局 ===== */
.export-checkbox-group {
  display: grid;                              /* 使用网格布局实现多列排列 */
  grid-template-columns: repeat(4, 1fr);      /* 平均分成4列，注释标注"4列最舒服"为视觉体验最优选择 */
  column-gap: 24px;                           /* 列之间的间距 24px，保证列间不拥挤 */
  row-gap: 14px;                              /* 行之间的间距 14px，平衡行高与紧凑度 */
}

/* ===== 单个复选框容器 ===== */
.export-checkbox {
  display: flex;               /* 弹性布局，使复选框与文字垂直居中对齐 */
  align-items: center;         /* 垂直居中，优化视觉对齐效果 */
  white-space: nowrap;         /* 文字不换行，避免标签文字被截断 */
}

/* 修复3：使用 ::v-deep 穿透 scoped（Vue2），Vue3 用 :deep() */
::v-deep .export-checkbox .el-checkbox__label {
  font-size: 14px;             /* 文字大小 14px，符合中台产品字体规范 */
  color: #303133;              /* 深灰色文字，保证可读性 */
  padding-left: 6px;           /* 与复选框保持6px间距，提升点击体验 */
}

/* ===== 弹窗底部按钮区域 ===== */
.export-dialog-footer {
  display: flex;               /* 弹性布局，控制按钮对齐方式 */
  justify-content: flex-end;   /* 按钮右对齐，符合弹窗交互习惯 */
  padding: 10px 20px;          /* 调整内边距，适配弹窗默认padding */
  border-top: 1px solid #ebeef5; /* 顶部分隔线，视觉区分内容区与操作区 */
  margin: 0 -20px -10px;       /* 抵消弹窗默认的padding，使分隔线全屏 */
}

/* ===== 主按钮（导出按钮）样式定制 ===== */
/* 修复4：提高优先级，覆盖Element默认样式 */
::v-deep .export-dialog-footer .el-button--primary {
  background-color: #409eff !important;   /* 定制主按钮背景色，统一品牌色调 */
  border-color: #409eff !important;       /* 定制边框色，与背景色一致 */
}

/* 主按钮 hover 状态 */
::v-deep .export-dialog-footer .el-button--primary:hover {
  background-color: #66b1ff !important;   /* hover 时浅化背景色，提供交互反馈 */
  border-color: #66b1ff !important;       /* 边框色同步变化 */
}

/* 主按钮 active 状态 */
::v-deep .export-dialog-footer .el-button--primary:active {
  background-color: #337ecc !important;   /* 点击时加深背景色，模拟按压效果 */
  border-color: #337ecc !important;       /* 边框色同步加深 */
}
</style>
