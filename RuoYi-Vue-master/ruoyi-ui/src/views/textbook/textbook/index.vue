<template>
  <div class="app-container">
     <el-form class="achievement-search-form textbook-search-form" :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="教材名称" prop="textbookName">
        <el-input v-model.trim="queryParams.textbookName" placeholder="请输入教材名称关键词" clearable />
      </el-form-item>
      <el-form-item label="作者角色" prop="authorRole">
        <el-select v-model="queryParams.authorRole" placeholder="请选择作者角色" clearable filterable>
          <el-option
            v-for="item in authorRoles"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="教材类型" prop="textbookType">
        <el-select v-model="queryParams.textbookType" placeholder="请选择教材类型" clearable filterable>
          <el-option
            v-for="item in textbookTypes"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="教材层次" prop="textbookLevel">
        <el-select v-model="queryParams.textbookLevel" placeholder="请选择教材层次" clearable filterable>
          <el-option
            v-for="item in textbookLevels"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="审核状态" prop="auditStatus">
        <el-select v-model="queryParams.auditStatus" placeholder="请选择审核状态" clearable filterable>
          <el-option
            v-for="item in audisItems"
            :key="item"
            :label="item"
            :value="item"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="出版时间">
        <el-date-picker
          v-model="publishDateRange"
          type="daterange"
          value-format="yyyy-MM-dd"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          clearable
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">清空</el-button>
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
          v-hasPermi="['textbook:textbook:add']"
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
          v-hasPermi="['textbook:textbook:edit']"
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
          v-hasPermi="['textbook:textbook:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport() "
          v-hasPermi="['textbook:textbook:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="textbookList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="教材名称" align="center" prop="textbookName" />
      <el-table-column label="作者角色" align="center" prop="authorRole" />
      <el-table-column label="出版社" align="center" prop="pressName" />
      <el-table-column label="ISBN号" align="center" prop="isbnNumber" />
      <el-table-column label="出版时间" align="center" prop="publishDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教材类型" align="center" prop="textbookType" />
      <el-table-column label="版次" align="center" prop="edition" />
      <el-table-column label="字数" align="center" prop="wordCount" />
      <el-table-column label="使用院校" align="center" prop="usingInstitutions" />
      <el-table-column label="适用专业" align="center" prop="applicableMajor" />
      <el-table-column label="教材层次" align="center" prop="textbookLevel" />
      <el-table-column label="批准文号" align="center" prop="approvalNumber" />
      <el-table-column label="审核状态" align="center" prop="auditStatus" />
      <el-table-column label="附件列表" align="center" width="100">
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-paperclip"
                @click="handleAttachment(scope.row)"
                v-hasPermi="['attachment:attachment:query']"
              >
                附件
              </el-button>
            </template>
          </el-table-column>

          <el-table-column v-if="$auth.hasPermi('textbook:textbook:edit')" label="审核" align="center" width="100">
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  type="text"
                  icon="el-icon-more"
                  @click="handleAudis(scope.row)"
                >
                  标注
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
            v-hasPermi="['textbook:textbook:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['textbook:textbook:remove']"
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

    <!-- 添加或修改教材著作对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
            <el-form-item label="教材名称" prop="textbookName">
              <el-input v-model="form.textbookName"  placeholder="请输入教材完整名称" />
            </el-form-item>
            <el-form-item label="作者角色" prop="authorRole">
              <el-select v-model="form.authorRole" placeholder="请选择作者角色"  style="width: 240px">
                  <el-option
                    v-for="item in authorRoles"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  />
                </el-select>
            </el-form-item>
            <el-form-item label="出版社" prop="pressName">
              <el-input v-model="form.pressName" placeholder="请输入出版社全称" />
            </el-form-item>
            <el-form-item label="ISBN号" prop="isbnNumber">
              <el-input v-model="form.isbnNumber" placeholder="请输入ISBN号 (如: 978-7-111-12345-6)" />
            </el-form-item>
            <el-form-item label="出版时间" prop="publishDate">
              <el-date-picker clearable
                v-model="form.publishDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择出版时间">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="教材类型" prop="textbookType">
              <el-select v-model="form.textbookType" placeholder="请选择教材类型"  style="width: 240px">
                  <el-option
                    v-for="item in textbookTypes"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  />
                </el-select>
            </el-form-item>
            <el-form-item label="版次" prop="edition">
              <el-input v-model="form.edition" placeholder="请输入版次 (如: 第3版第2次印刷（2025年修订版）)" />
            </el-form-item>
            <el-form-item label="字数" prop="wordCount">
              <el-input v-model="form.wordCount" placeholder="请输入字数 (万字)" />
            </el-form-item>
            <el-form-item label="使用院校" prop="usingInstitutions">
              <el-input v-model="form.usingInstitutions"  placeholder="请输入使用该教材的院校名称" />
            </el-form-item>
            <el-form-item label="适用专业" prop="applicableMajor">
              <el-input v-model="form.applicableMajor" placeholder="请输入适用专业" />
            </el-form-item>
            <el-form-item label="教材层次" prop="textbookLevel">
              <el-select v-model="form.textbookLevel" placeholder="请选择教材层次"  style="width: 240px">
                  <el-option
                    v-for="item in textbookLevels"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  />
                </el-select>
            </el-form-item>
            <el-form-item label="批准文号" prop="approvalNumber">
              <el-input v-model="form.approvalNumber" placeholder="请输入批准文号 (如: 国教材〔2023〕1号)" />
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
    <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="textbook"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />
<!--      <el-dialog
        :title="Exceltitle"
        :visible.sync="Excelopen"
        width="600px"
        append-to-body
        :close-on-click-modal="false">
         <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
            <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.lable}}</el-checkbox>
          </el-checkbox-group>
        <el-badge :value="idsCount==0?textbookList.length:idsCount" class="item"  >
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

      <!--审核弹窗  -->
          <el-dialog
            title="审核审批"
            :visible.sync="AudisVisible"
            width="720px"
            append-to-body
            :close-on-click-modal="false"
          >
            <el-radio-group v-model="AudisStatis">
              <el-radio v-for="item in audisItems" :key="item" :label="item">{{item}}</el-radio>
            </el-radio-group>

            <div slot="footer" class="export-dialog-footer">
              <el-button @click="AudisVisible = false">取 消</el-button>
              <el-button
                type="primary"
                icon="el-icon-edit"
                @click="EditAudios(AudisStatis)"
              >
                修改
              </el-button>
            </div>
          </el-dialog>
  </div>
</template>

<script>
import { listTextbook, getTextbook, delTextbook, addTextbook, updateTextbook } from "@/api/textbook/textbook"
import Cookies from "js-cookie"
import { buildChangedPayload, cloneForm } from "@/utils/achievementUpdate"
import { buildDateRangeQuery } from "@/utils/dateRangeQuery"
export default {
  name: "Textbook",
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
      publishDateRange: [],
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
      //导出选择字段
      selectClist:[],
      //导出选择字段列表
      checkList:[
      {
        value: 'textbookName',
        label: '教材名称'
      },{
        value: 'authorRole',
        label: '作者角色'
      },{
        value: 'pressName',
        label: '出版社'
      },{
        value: 'isbnNumber',
        label: 'ISBN号'
      },{
        value: 'publishDate',
        label: '出版时间'
      },{
        value: 'textbookType',
        label: '教材类型'
      },{
        value: 'edition',
        label: '版次'
      },{
        value: 'wordCount',
        label: '字数（万字）'
      },{
        value: 'usingInstitutions',
        label: '使用院校'
      },{
        value: 'applicableMajor',
        label: '适用专业'
      },{
        value: 'textbookLevel',
        label: '教材层次'
      },{
        value: 'approvalNumber',
        label: '批准文号'
      },{
        value: 'auditStatus',
        label: '审核状态'
      }
      ],
      //上传文件组件
      files:[],
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
      //教材层次
      textbookLevels:[{
        value:'本科',
        label:'本科'
      },{
        value:'专科',
        label:'专科'
      },{
        value:'研究生',
        label:'研究生'
      },{
        value:'职业教育',
        label:'职业教育'
      }],
      //教材类型
      textbookTypes:[{
        value:'规划教材',
        label:'规划教材'
      },{
        value:'校本教材',
        label:'校本教材'
      },{
        value:'国家级规划',
        label:'国家级规划'
      },{
        value:'省部级规划',
        label:'省部级规划'
      },{
        value:'行业规划',
        label:'行业规划'
      }],
      //作者角色
      authorRoles:[{
        value:'主编',
        label:'主编'
      },{
        value:'副主编',
        label:'副主编'
      },{
        value:'参编',
        label:'参编'
      },{
        value:'独著',
        label:'独著'
      }],
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
      // 教材著作表格数据
      textbookList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        textbookId: null,
        textbookName: null,
        authorRole: null,
        isbnNumber: null,
        publishDate: null,
        textbookType: null,
        textbookLevel: null,
        edition: null,
        usingInstitutions: null,
        auditStatus: null,
      },
      // 表单参数
      form: {},
      originalForm: {},
      // 表单校验
      rules: {
        textbookName: [
          { required: true, message: "教材名称不能为空", trigger: "blur" },
          { min: 1, max: 200, message: "长度不能超过 200 个字符", trigger: "blur" }
        ],
        authorRole: [
          { required: true, message: "作者角色不能为空", trigger: "change" }
        ],
        pressName: [
          { required: true, message: "出版社不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+$/, message: "出版社名称格式错误（仅允许中英文、数字、括号及点号）", trigger: "blur" }
        ],
        isbnNumber: [
          { required: true, message: "ISBN号不能为空", trigger: "blur" },
          // 校验 ISBN 格式
          { pattern: /^[0-9\-\s]{9,17}[0-9xX]$/, message: "ISBN格式错误，示例: 978-7-111-12345-6", trigger: "blur" }
        ],
        publishDate: [
          { required: true, message: "出版时间不能为空", trigger: "blur" }
        ],
        textbookType: [
          { required: true, message: "教材类型不能为空", trigger: "change" }
        ],
        edition: [
          { required: false, message: "请输入版次", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
          // 支持更复杂的版次描述，包含括号
          {
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s\.\(\)（）]+$/,
            message: "版次格式错误，示例：第3版第2次印刷（2025年修订版）",
            trigger: "blur"
          }
        ],
        wordCount: [
          { required: false, message: "请输入字数", trigger: "blur" },
          { pattern: /^\d+(\.\d{1,4})?$/, message: "请输入有效的数字（支持小数）", trigger: "blur" }
        ],
        usingInstitutions: [
          { required: false, message: "请输入使用院校", trigger: "blur" },
          { max: 500, message: "内容过长，请精简", trigger: "blur" }
        ],
        applicableMajor: [
          { required: false, message: "请输入适用专业", trigger: "blur" },
          { max: 200, message: "内容过长，请精简", trigger: "blur" }
        ],
        textbookLevel: [
          { required: false, message: "请选择教材层次", trigger: "change" }
        ],
        approvalNumber: [
          { required: false, message: "请输入批准文号", trigger: "blur" },
          // 支持六角括号等特殊字符
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\[\]〔〕\-\s\.]+$/, message: "批准文号格式错误，示例: 国教材〔2023〕1号", trigger: "blur" }
        ]
      }
    }
  },
	  created() {
	    this.applyRouteQuery()
	    this.getList()
    /*管理权限标识符验证 显示隐藏组件*/
    const flag = Cookies.get("adminFlag")
    if(flag =="true")
    {
      this.adminFlag = true
    }
  },
	  methods: {
	    applyRouteQuery() {
	      const query = this.$route.query || {}
	      const recordIdField = query.recordIdField || "textbookId"
	      if (query.recordId && Object.prototype.hasOwnProperty.call(this.queryParams, recordIdField)) {
	        this.queryParams[recordIdField] = query.recordId
	      }
	      if (query.auditStatus) {
	        this.queryParams.auditStatus = query.auditStatus
	      }
	    },
	    /*查询输入字段验证时间组件*/
    changeQueryParams(res){
      this.SelectQueryParamsValue = null;
      if(res=="updatedAt"||res=="createdAt"||res=="publishDate")
      {
        if(res=="publishDate")
        {
          this.TimeFormat = "yyyy-MM-dd"
          this.TimeType = "date"
        }else{
           this.TimeFormat = "yyyy-MM-ddTHH:mm:ss"
           this.TimeType = "datetime"
        }
        this.TimeFlag = true
      }else{
         this.TimeFlag = false
      }
    },
    /*审核提交*/
    EditAudios(audis)
    {
      if (this.form.textbookId != null) {
        this.form.auditStatus = audis
        updateTextbook({
          textbookId: this.form.textbookId,
          auditStatus: audis
        }).then(response => {
          if(response.textbookId!=null)
          {
             this.$modal.msgSuccess("修改成功")
          }else{
              this.$modal.msgSuccess("修改成功，上传文件失败")
          }

          this.AudisVisible = false
          this.getList()
        })
      }
    },
    /*审核批改*/
    handleAudis(row){
      this.AudisStatis=row.auditStatus
       this.reset()
       const textbookId = row.textbookId || this.ids
       getTextbook(textbookId).then(response => {
         this.form = response.data
         this.AudisVisible=true
       })
    },
    /** 查询教材著作列表 */
    getList() {
      this.loading = true
      listTextbook(this.buildQueryParams()).then(response => {
        this.textbookList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    buildQueryParams() {
      return buildDateRangeQuery(this.queryParams, {
        PublishDate: this.publishDateRange
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
        textbookId: null,
        userId: null,
        deptId: null,
        textbookName: null,
        authorRole: null,
        pressName: null,
        isbnNumber: null,
        publishDate: null,
        textbookType: null,
        edition: null,
        wordCount: null,
        usingInstitutions: null,
        applicableMajor: null,
        textbookLevel: null,
        approvalNumber: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null
      }
      this.originalForm = {}
      this.files = []; // 清空绑定的文件数组
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
      this.queryParams.textbookId = null
      this.queryParams.textbookName = null
      this.queryParams.authorRole = null
      this.queryParams.publishDate = null
      this.queryParams.textbookType = null
      this.queryParams.textbookLevel = null
      this.queryParams.auditStatus = null
      this.queryParams.params = {}
      this.publishDateRange = []
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.textbookId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加教材著作"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const textbookId = row.textbookId || this.ids
      getTextbook(textbookId).then(response => {
        this.form = response.data
        this.originalForm = cloneForm(response.data)
        this.open = true
        this.title = "修改教材著作"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.textbookId != null) {
            const updatePayload = buildChangedPayload(this.form, this.originalForm, "textbookId")
            if (Object.keys(updatePayload).length === 1) {
              this.$modal.msgWarning("没有检测到修改内容")
              return
            }
            updateTextbook(updatePayload).then(response => {
              if(response.textbookId!=null)
              {

                 this.$refs.file.submitUpload(response.textbookId,"textbook");
                  this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }

              this.open = false
              this.getList()
            })
          } else {
            addTextbook(this.form).then(response => {
              if(response.textbookId!=null)
              {
                 this.$refs.file.submitUpload(response.textbookId,"textbook");
                  this.$modal.msgSuccess("新增成功")
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }

              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const textbookIds = row.textbookId || this.ids
      this.$modal.confirm('是否确认删除教材著作编号为"' + textbookIds + '"的数据项？').then(function() {
        return delTextbook(textbookIds)
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
          this.currentPaperId = row.textbookId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.textbookName || '教材'}`
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
      /*导出方法*/
      DowExcel(){
      if(this.ids.length==0)
        {
          this.ids = this.textbookList.map(item=>item.textbookId)
        }
       const requestData = {
        idList:this.ids,
	          showColumns: this.selectClist || [],
	          data: {
	            ...this.buildQueryParams()
	          }
	         };
         const jsonRequestBody = JSON.stringify(requestData);
         this.exceldownload('textbook/textbook/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`);
      },
  }
}
</script>
<style scoped>

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
