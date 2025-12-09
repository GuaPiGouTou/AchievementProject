<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="出版时间" prop="publishDate">
        <el-date-picker clearable
          v-model="queryParams.publishDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择出版时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="学科分类" prop="subjectCategory">
        <el-input
          v-model="queryParams.subjectCategory"
          placeholder="请输入学科分类"
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
          v-hasPermi="['monograph:monograph:add']"
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
          v-hasPermi="['monograph:monograph:edit']"
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
          v-hasPermi="['monograph:monograph:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['monograph:monograph:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="monographList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="专著id" align="center" prop="monographId" />
      <el-table-column label="专著名称" align="center" prop="monographTitle" />
      <el-table-column label="作者角色" align="center" prop="authorRole" />
      <el-table-column label="出版社" align="center" prop="pressName" />
      <el-table-column label="ISBN号" align="center" prop="isbnNumber" />
      <el-table-column label="出版时间" align="center" prop="publishDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="专著类型" align="center" prop="monographType" />
      <el-table-column label="版次" align="center" prop="edition" />
      <el-table-column label="字数" align="center" prop="wordCount" />
      <el-table-column label="页数" align="center" prop="pageCount" />
      <el-table-column label="著作语言" align="center" prop="language" />
      <el-table-column label="学科分类" align="center" prop="subjectCategory" />
      <el-table-column label="是否被收录" align="center" prop="isIncluded" />
      <el-table-column label="收录数据库" align="center" prop="includedDatabase" />
      <el-table-column label="获奖情况" align="center" prop="awardSituation" />
      <el-table-column label="合著者信息" align="center" prop="coAuthors" />
      <el-table-column label="国际标准书号" align="center" prop="internationalStandardBookNumber" />
      <el-table-column label="中国分类号" align="center" prop="chinaClassificationNumber" />
      <el-table-column label="审核状态" align="center" prop="auditStatus" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updatedAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updatedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="附件列表" align="center" width="100">
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-paperclip"
                @click="handleAttachment(scope.row)"
              >
                附件
              </el-button>
            </template>
          </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['monograph:monograph:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['monograph:monograph:remove']"
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
    <AttachmentManagement
      :visible="attachmentVisible"
      :title="attachmentTitle"
      :resource-id="currentPaperId"
      attachment-type="monograph"
      @update:visible="attachmentVisible = $event"
      @close="handleAttachmentClose"
      @load-success="handleAttachmentLoadSuccess"
      @download-success="handleDownloadSuccess"
      @delete-success="handleDeleteSuccess"
    />
    <!-- 添加或修改成果专著对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="专著名称" prop="monographTitle">
          <el-input v-model="form.monographTitle" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="出版社" prop="pressName">
          <el-input v-model="form.pressName" placeholder="请输入出版社" />
        </el-form-item>
        <el-form-item label="ISBN号" prop="isbnNumber">
          <el-input v-model="form.isbnNumber" placeholder="请输入ISBN号" />
        </el-form-item>
		<el-form-item label="作者角色" prop="authorRole">
		  <el-select v-model="form.authorRole" placeholder="请选择">
		      <el-option
		        v-for="item in authorRoles"
		        :key="item.value"
		        :label="item.label"
		        :value="item.value">
		      </el-option>
		    </el-select>
        </el-form-item>
        <el-form-item label="出版时间" prop="publishDate">
          <el-date-picker clearable
            v-model="form.publishDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择出版时间">
          </el-date-picker>
        </el-form-item>
		<el-form-item label="专著类型" prop="monographType">
		  <el-select v-model="form.monographType" placeholder="请选择">
		      <el-option
		        v-for="item in monographTypes"
		        :key="item.value"
		        :label="item.label"
		        :value="item.value">
		      </el-option>
		    </el-select>
		</el-form-item>
		<el-form-item label="著作语言" prop="language">
		  <el-select v-model="form.language" placeholder="请选择">
		      <el-option
		        v-for="item in languages"
		        :key="item.value"
		        :label="item.label"
		        :value="item.value">
		      </el-option>
		    </el-select>
		</el-form-item>
        <el-form-item label="版次" prop="edition">
          <el-input v-model="form.edition" placeholder="请输入版次" />
        </el-form-item>
        <el-form-item label="字数" prop="wordCount">
          <el-input v-model="form.wordCount" placeholder="请输入字数" />
        </el-form-item>
        <el-form-item label="页数" prop="pageCount">
          <el-input v-model="form.pageCount" placeholder="请输入页数" />
        </el-form-item>
        <el-form-item label="学科分类" prop="subjectCategory">
          <el-input v-model="form.subjectCategory" placeholder="请输入学科分类" />
        </el-form-item>
        <el-form-item label="是否被收录" prop="isIncluded">
          <el-input v-model="form.isIncluded" placeholder="请输入是否被收录" />
        </el-form-item>
        <el-form-item label="收录数据库" prop="includedDatabase">
          <el-input v-model="form.includedDatabase" placeholder="请输入收录数据库" />
        </el-form-item>
        <el-form-item label="获奖情况" prop="awardSituation">
          <el-input v-model="form.awardSituation" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="合著者信息" prop="coAuthors">
          <el-input v-model="form.coAuthors" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="国际标准书号" prop="internationalStandardBookNumber">
          <el-input v-model="form.internationalStandardBookNumber" placeholder="请输入国际标准书号" />
        </el-form-item>
        <el-form-item label="中国分类号" prop="chinaClassificationNumber">
          <el-input v-model="form.chinaClassificationNumber" placeholder="请输入中国分类号" />
        </el-form-item>
		<el-form-item label="上传文件" prop="updatedAt">
			<file-upload ref="file" v-model="files"></file-upload>
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
import AttachmentManagement from "@/components/AttManage/AttachmentManagement.vue"
import { listMonograph, getMonograph, delMonograph, addMonograph, updateMonograph } from "@/api/monograph/monograph"

export default {
  name: "Monograph",
  data() {
    return {
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      //导出选择字段
      checkList: [
              {
                value: 'monographId',
                label: '专著ID'
              }, {
                value: 'monographTitle',
                label: '专著名称'
              }, {
                value: 'authorRole',
                label: '作者角色'
              }, {
                value: 'pressName',
                label: '出版社'
              }, {
                value: 'isbnNumber',
                label: 'ISBN号'
              }, {
                value: 'publishDate',
                label: '出版时间'
              }, {
                value: 'monographType',
                label: '专著类型'
              }, {
                value: 'edition',
                label: '版次'
              }, {
                value: 'wordCount',
                label: '字数(万字)'
              }, {
                value: 'pageCount',
                label: '页数'
              }, {
                value: 'language',
                label: '著作语言'
              }, {
                value: 'subjectCategory',
                label: '学科分类'
              }, {
                value: 'isIncluded',
                label: '是否被收录'
              }, {
                value: 'includedDatabase',
                label: '收录数据库'
              }, {
                value: 'awardSituation',
                label: '获奖情况'
              }, {
                value: 'coAuthors',
                label: '合著者信息'
              }, {
                value: 'internationalStandardBookNumber',
                label: '国际标准书号'
              }, {
                value: 'chinaClassificationNumber',
                label: '中国分类号'
              }, {
                value: 'auditStatus',
                label: '审核状态'
              }, {
                value: 'createTime',
                label: '创建时间'
              }, {
                value: 'updateTime',
                label: '更新时间'
              }
            ],
      selectClist:[],
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
		//上传文件组件
		files:[],
	// 1. 作者角色 (对应数据库 author_role)
		authorRoles: [
		  { label: "独著", value: "独著" },
		  { label: "主编", value: "主编" },
		  { label: "副主编", value: "副主编" },
		  { label: "参编", value: "参编" },
		  { label: "译者", value: "译者" },
		  { label: "编者", value: "编者" }
		],

		// 2. 专著类型 (对应数据库 monograph_type)
		monographTypes: [
		  { label: "学术专著", value: "学术专著" },
		  { label: "教材", value: "教材" },
		  { label: "译著", value: "译著" },
		  { label: "编著", value: "编著" },
		  { label: "科普著作", value: "科普著作" },
		  { label: "工具书", value: "工具书" },
		  { label: "论文集", value: "论文集" }
		],

		// 3. 著作语言 (对应数据库 language)
		languages: [
		  { label: "中文", value: "中文" },
		  { label: "英文", value: "英文" },
		  { label: "其他", value: "其他" }
		],
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
      // 成果专著表格数据
      monographList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        monographTitle: null,
        authorRole: null,
        publishDate: null,
        monographType: null,
        subjectCategory: null,
        auditStatus: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        monographTitle: [
          { required: true, message: "专著名称不能为空", trigger: "blur" },
          { min: 1, max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
          // 允许中文、英文、数字、书名号、括号、冒号、横杠、空格
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9《》\(\)（）\：:\-\s]+$/, message: "专著名称包含非法字符", trigger: "blur" }
        ],
        authorRole: [
          { required: true, message: "作者角色不能为空", trigger: "change" }
        ],
        pressName: [
          { required: true, message: "出版社不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          // 允许常规出版社名称格式
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+$/, message: "出版社名称格式不正确", trigger: "blur" }
        ],
        isbnNumber: [
          { required: true, message: "ISBN号不能为空", trigger: "blur" },
          // ISBN 10位或13位校验，允许横杠或空格分隔
          { pattern: /^[0-9\-\s]{9,17}[0-9xX]$/, message: "ISBN格式不正确 (如: 978-7-123-45678-9)", trigger: "blur" }
        ],
        publishDate: [
          { required: true, message: "出版时间不能为空", trigger: "blur" }
        ],
        monographType: [
          { required: true, message: "专著类型不能为空", trigger: "change" }
        ],
        edition: [
          { required: false, message: "请输入版次", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
          // 允许 "第1版", "First Edition", "revised" 等
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s\.]+$/, message: "版次格式不正确", trigger: "blur" }
        ],
        wordCount: [
          { required: false, message: "请输入字数", trigger: "blur" },
          // 允许整数或小数 (如 25.5 万字)
          { pattern: /^\d+(\.\d{1,4})?$/, message: "请输入有效的数字", trigger: "blur" }
        ],
        pageCount: [
          { required: false, message: "请输入页数", trigger: "blur" },
          // 必须是正整数
          { pattern: /^[1-9]\d*$/, message: "页数必须为正整数", trigger: "blur" }
        ],
        language: [
          { required: false, message: "请选择著作语言", trigger: "change" }
        ],
        subjectCategory: [
          { required: false, message: "请输入学科分类", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" }
        ],
        includedDatabase: [
          { required: false, message: "请输入收录数据库", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
        coAuthors: [
          { required: false, message: "请输入合著者信息", trigger: "blur" },
          // 允许输入多人姓名，用逗号或分号分隔
          { pattern: /^[\u4e00-\u9fa5a-zA-Z\s,;，；\.]+$/, message: "多个合著者请用逗号分隔", trigger: "blur" }
        ],
        chinaClassificationNumber: [
          { required: false, message: "请输入中国分类号", trigger: "blur" },
          // 中图分类号通常是 字母+数字/点，例如 TP311.5
          { pattern: /^[A-Z][A-Z0-9\.]*$/, message: "分类号格式错误 (例如: TP311)", trigger: "blur" }
        ],
        internationalStandardBookNumber: [
          { required: false, message: "请输入国际标准书号", trigger: "blur" },
          // 如果与 isbnNumber 逻辑一致，使用相同的正则
          { pattern: /^[0-9\-\s]{9,17}[0-9xX]$/, message: "标准书号格式不正确", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询成果专著列表 */
    getList() {
      this.loading = true
      listMonograph(this.queryParams).then(response => {
        this.monographList = response.rows
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
        monographId: null,
        userId: null,
        deptId: null,
        monographTitle: null,
        authorRole: null,
        pressName: null,
        isbnNumber: null,
        publishDate: null,
        monographType: null,
        edition: null,
        wordCount: null,
        pageCount: null,
        language: null,
        subjectCategory: null,
        isIncluded: null,
        includedDatabase: null,
        awardSituation: null,
        coAuthors: null,
        internationalStandardBookNumber: null,
        chinaClassificationNumber: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null
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
      this.ids = selection.map(item => item.monographId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加成果专著"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const monographId = row.monographId || this.ids
      getMonograph(monographId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改成果专著"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.monographId != null) {
            updateMonograph(this.form).then(response => {
				if(response.monographId!=null)
				{
				   this.$refs.file.submitUpload(response.monographId,"monograph");
				}else{
				    this.$modal.msgSuccess("上传文件失败")
				}
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMonograph(this.form).then(response => {
              if(response.monographId!=null)
              {
                 this.$refs.file.submitUpload(response.monographId,"monograph");
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }
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
      const monographIds = row.monographId || this.ids
      this.$modal.confirm('是否确认删除成果专著编号为"' + monographIds + '"的数据项？').then(function() {
        return delMonograph(monographIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
       this.Excelopen = true
    },
    /*
    附件弹窗方法
    */
      handleAttachment(row) {
          this.currentPaperId = row.competitionId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.competitionName || '专著'}`
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
      },
      /*导出*/
      async DowExcel(){
          const requestData = {
           showColumns: this.selectClist || [],
           data: {
             ...this.queryParams
           }
          };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('monograph/monograph/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       },

  }
}
</script>
