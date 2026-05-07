<template>
  <div class="app-container">
     <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="奖项名称" prop="awardName">
        <el-input v-model.trim="queryParams.awardName" placeholder="请输入奖项名称关键词" clearable />
      </el-form-item>
      <el-form-item label="奖项级别" prop="awardLevel">
        <el-select v-model="queryParams.awardLevel" placeholder="请选择奖项级别" clearable filterable>
          <el-option
            v-for="item in awardLevels"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="奖项类别" prop="awardCategory">
        <el-input v-model.trim="queryParams.awardCategory" placeholder="请输入奖项类别关键词" clearable />
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
          v-hasPermi="['award:award:add']"
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
          v-hasPermi="['award:award:edit']"
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
          v-hasPermi="['award:award:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['award:award:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="awardList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="奖项名称" align="center" prop="awardName" />
      <el-table-column label="获奖人" align="center" prop="awardWinner" />
      <el-table-column label="颁奖单位" align="center" prop="awardUnit" />
      <el-table-column label="获奖时间" align="center" prop="awardDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.awardDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="奖项级别" align="center" prop="awardLevel" />
      <el-table-column label="奖项类别" align="center" prop="awardCategory" />
      <el-table-column label="获奖等次" align="center" prop="awardRanking" />
            <el-table-column v-if="showArchivalTypeField" label="归档类别" align="center" prop="archivalType" :formatter="formatArchivalType" />
<el-table-column label="审核状态" align="center" prop="auditStatus" />
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

          <el-table-column v-if="adminFlag" label="审核" align="center" width="100">
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
            v-hasPermi="['award:award:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['award:award:remove']"
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
    <!-- 附件管理 -->
      <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="award"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />
    <!-- 添加或修改获奖成果对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
          <el-form ref="form" :model="form" :rules="rules" text-align: right label-width="100px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
            <el-form-item label="奖项名称" prop="awardName">
              <el-input v-model="form.awardName" placeholder="请输入奖项名称，支持书名号《》" />
            </el-form-item>

            <!-- 修改了 placeholder -->
            <el-form-item label="获奖人" prop="awardWinner">
              <el-input v-model="form.awardWinner" placeholder="请输入获奖人，多人请用逗号或分号分隔 (如: 张三;李四)" />
            </el-form-item>

            <!-- 修改了 placeholder -->
            <el-form-item label="颁奖单位" prop="awardUnit">
              <el-input v-model="form.awardUnit" placeholder="请输入颁奖单位，多个单位请用逗号或分号分隔" />
            </el-form-item>

            <!-- 其他字段保持不变... -->
            <el-form-item label="获奖时间" prop="awardDate">
              <el-date-picker clearable
                v-model="form.awardDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择获奖时间">
              </el-date-picker>
            </el-form-item>
           <el-form-item label="奖项级别" prop="awardLevel">
               <el-select v-model="form.awardLevel" placeholder="请选择">
                   <el-option
                     v-for="item in awardLevels"
                     :key="item.value"
                     :label="item.label"
                     :value="item.value">
                   </el-option>
                 </el-select>
            </el-form-item>


            <el-form-item label="奖项类别" prop="awardCategory">
              <el-input v-model="form.awardCategory" placeholder="请输入奖项类别" />
            </el-form-item>
            <el-form-item label="获奖等次" prop="awardRanking">
              <el-input v-model="form.awardRanking" placeholder="请输入获奖等次" />
            </el-form-item>
            <el-form-item v-if="showArchivalTypeField" label="归档类别" prop="archivalType">
              <el-select v-model="form.archivalType" placeholder="请选择归档类别">
                  <el-option
                    v-for="item in archivalTypes"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
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
<!--    <el-dialog
      :title="Exceltitle"
      :visible.sync="Excelopen"
      width="600px"
      append-to-body
      :close-on-click-modal="false">
       <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.lable}}</el-checkbox>
        </el-checkbox-group>
              <el-badge :value="idsCount==0?awardList.length:idsCount" class="item"  >
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
import { listAward, getAward, delAward, addAward, updateAward } from "@/api/award/award"
import Cookies from "js-cookie"
export default {
  name: "Award",
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
      isStudentUser: false,
      //导出记录
      idsCount:0,
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      // //导出选择字段
      checkList:[
      {
        "value": "awardId",
        "label": "奖项ID"
      },
      {
        "value": "userId",
        "label": "用户ID"
      },
      {
        "value": "deptId",
        "label": "部门ID"
      },
      {
        "value": "awardName",
        "label": "奖项名称"
      },
      {
        "value": "awardWinner",
        "label": "获奖人"
      },
      {
        "value": "awardUnit",
        "label": "颁奖单位"
      },
      {
        "value": "awardDate",
        "label": "获奖时间"
      },
      {
        "value": "awardLevel",
        "label": "奖项级别"
      },
      {
        "value": "awardCategory",
        "label": "奖项类别"
      },
      {
        "value": "awardRanking",
        "label": "获奖等次"
      },
      {
        "value": "archivalType",
        "label": "归档类别"
      },
      {
        "value": "auditStatus",
        "label": "审核状态"
      },],
      selectClist:[],
      archivalTypes: [
        { label: "教育教学改革", value: "teachingCategory" },
        { label: "课程设计", value: "researchOriented" }
      ],
      //上传文件组件
      files:[],
      //奖项级别
      awardLevels:[
        {
          value:'国家级',
          label:'国家级'
        },{
          value:'省级',
          label:'省级'
        },{
          value:'市级',
          label:'市级'
        },{
          value:'校级',
          label:'校级'
        },{
          value:'行业级',
          label:'行业级'
        },{
          value:'国际级',
          label:'国际级'
        },{
          value:'其他',
          label:'其他'
        }
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
      // 获奖成果表格数据
      awardList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        awardId: null,
        awardName: null,
        awardWinner: null,
        awardDate: null,
        awardLevel: null,
        awardCategory: null,
        awardRanking: null,
        auditStatus: null,
        createdAt: null,
      },
      // 表单参数
      form: {},
      // 表单校验
            rules: {
              awardName: [
                { required: true, message: "奖项名称不能为空", trigger: "blur" },
                { min: 1, max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
                // 允许中文、英文、数字、括号（中英文）、书名号、横杠、冒号、空格
                { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\：:\s]+$/, message: "奖项名称格式错误，仅允许包含中英文、数字、书名号及括号等", trigger: "blur" }
              ],
              awardWinner: [
                { required: true, message: "获奖人不能为空", trigger: "blur" },
                { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
                {
                  // 正则：允许单人或多人，分隔符支持中英文逗号、分号
                  pattern: /^[\u4e00-\u9fa5a-zA-Z\s\.]+([,;，；][\u4e00-\u9fa5a-zA-Z\s\.]+)*$/,
                  // 提示信息优化
                  message: "格式错误，多人请用逗号(,)或分号(;)分隔，例如：张三;李四",
                  trigger: "blur"
                }
              ],
              awardUnit: [
                { required: true, message: "颁奖单位不能为空", trigger: "blur" },
                { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
                {
                  // 正则：允许单个单位或多个单位，分隔符支持中英文逗号、分号
                  pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+([,;，；][\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+)*$/,
                  // 提示信息优化
                  message: "格式错误，多个单位请用逗号(,)或分号(;)分隔，例如：教育部;科技部",
                  trigger: "blur"
                }
              ],
              awardDate: [
                { required: true, message: "获奖时间不能为空", trigger: "blur" }
              ],
              awardLevel: [
                { required: true, message: "奖项级别不能为空", trigger: "change" }
              ],
              awardCategory: [
                { required: true, message: "奖项类别不能为空", trigger: "blur" },
                { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
                { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s]+$/, message: "奖项类别只能包含中英文及数字", trigger: "blur" }
              ],
              awardRanking: [
                { required: false, message: "请输入获奖等次", trigger: "blur" },
                { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
                { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\-\s]+$/, message: "获奖等次格式不正确（如：一等奖, 1st）", trigger: "blur" }
              ],
              
            }
    }
  },
	  created() {
	    this.applyRouteQuery()
	    this.getList()
	    this.initUserRoleScope()
    /*管理权限标识符验证 显示隐藏组件*/
    const flag = Cookies.get("adminFlag")
    if(flag =="true")
    {
      this.adminFlag = true
    }
  },
  computed: {
    showArchivalTypeField() {
      return !this.isStudentUser
    },
    searchCheckList() {
      return this.checkList.filter((item) => {
        if (/id$/i.test(item.value)) {
          return false
        }
        if (item.value === "archivalType" && this.isStudentUser) {
          return false
        }
        if ((item.value === "updatedAt" || item.value === "createdAt") && !this.adminFlag) {
          return false
        }
        return true
      })
    }
  },
	  methods: {
	    applyRouteQuery() {
	      const query = this.$route.query || {}
	      const recordIdField = query.recordIdField || "awardId"
	      if (query.recordId && Object.prototype.hasOwnProperty.call(this.queryParams, recordIdField)) {
	        this.queryParams[recordIdField] = query.recordId
	      }
	      if (query.auditStatus) {
	        this.queryParams.auditStatus = query.auditStatus
	      }
	    },
	    formatArchivalType(row, column, value) {
      const item = this.archivalTypes.find(option => option.value === value)
      return item ? item.label : value
    },
    initUserRoleScope() {
      const roleKeys = (this.$store.getters.roles || []).map(item => String(item))
      this.isStudentUser = roleKeys.includes("student") || roleKeys.includes("studentAdministrator")
    },
    /*查询输入字段验证时间组件*/
    changeQueryParams(res){
      this.SelectQueryParamsValue = null;
      if(res=="updatedAt"||res=="createdAt")
      {
        this.TimeFormat = "yyyy-MM-ddTHH:mm:ss"
        this.TimeType = "datetime"
        this.TimeFlag = true
      }else{
         this.TimeFlag = false
      }
    },
    /*审核提交*/
    EditAudios(audis)
    {
      if (this.form.awardId != null) {
        this.form.auditStatus = audis
        updateAward(this.form).then(response => {
          if(response.awardId!=null)
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
       const awardId = row.awardId || this.ids
       getAward(awardId).then(response => {
         this.form = response.data
         this.AudisVisible=true
       })
    },
    /** 查询获奖成果列表 */
    getList() {
      this.loading = true
      listAward(this.queryParams).then(response => {
        this.awardList = response.rows
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
        awardId: null,
        userId: null,
        deptId: null,
        awardName: null,
        awardWinner: null,
        awardUnit: null,
        awardDate: null,
        awardLevel: null,
        awardCategory: null,
        awardRanking: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null,
        archivalType: null
      }
      this.files = []; // 清空绑定的文件数组
      this.resetForm("form")
    },
    clearCurrentSearch() {
      if (this.SelectQueryParams) {
        this.queryParams[this.SelectQueryParams] = null
      }
      this.SelectQueryParamsValue = null
      this.TimeFlag = false
    },

  /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.queryParams.awardId = null
      this.queryParams.awardName = null
      this.queryParams.awardLevel = null
      this.queryParams.awardCategory = null
      this.queryParams.auditStatus = null
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.awardId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加获奖成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const awardId = row.awardId || this.ids
      getAward(awardId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改获奖成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (!this.showArchivalTypeField) {
            this.form.archivalType = null
          } else {
            if (!this.form.archivalType) {
              this.$modal.msgError("归档类别为必填项")
              return
            }
            if (!this.archivalTypes.find(item => item.value === this.form.archivalType)) {
              this.$modal.msgError("归档类别无效，请重新选择")
              return
            }
          }
           const msg = ""
          if (this.form.awardId != null) {
            updateAward(this.form).then(response => {
              if(response.awardId!=null)
              {
                 this.$refs.file.submitUpload(response.awardId,"award");
                 this.$modal.msgSuccess("修改成功")
              }else{
                this.$modal.msgSuccess("修改成功,文件上传失败")
              }

              this.open = false
              this.getList()
            })
          } else {
            addAward(this.form).then(response => {

              if(response.awardId!=null)
              {
                 this.$refs.file.submitUpload(response.awardId,"award");
                 this.$modal.msgSuccess("新增成功")
              }else{
                this.$modal.msgSuccess("新增成功,文件上传失败")
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
      const awardIds = row.awardId || this.ids
      this.$modal.confirm('是否确认删除获奖成果编号为"' + awardIds + '"的数据项？').then(function() {
        return delAward(awardIds)
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
        this.currentPaperId = row.awardId
        this.currentPaper = row
        this.attachmentTitle = `附件管理 - ${row.awardName || '竞赛'}`
        this.attachmentVisible = true
      },

    /** 附件弹窗关闭 */
    handleAttachmentClose() {
      this.currentPaperId = null
      this.currentPaper = null
    },

    /** 附件加载成功 */
    handleAttachmentLoadSuccess(fileList) {
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
         this.ids = this.awardList.map(item=>item.awardId)
       }
      const requestData = {
         idList:this.ids,
         showColumns: this.selectClist || [],
         data: {
           ...this.queryParams
         }
       };
       const jsonRequestBody = JSON.stringify(requestData);
       this.exceldownload('award/award/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`);
    },
    //
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
