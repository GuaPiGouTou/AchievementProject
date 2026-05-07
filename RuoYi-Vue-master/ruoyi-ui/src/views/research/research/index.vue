<template>
  <div class="app-container">
     <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="项目名称" prop="projectName">
        <el-input v-model.trim="queryParams.projectName" placeholder="请输入项目名称关键词" clearable />
      </el-form-item>
      <el-form-item label="项目类别" prop="projectCategory">
        <el-select v-model="queryParams.projectCategory" placeholder="请选择项目类别" clearable filterable>
          <el-option
            v-for="item in projectCategorys"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="项目级别" prop="projectLevel">
        <el-select v-model="queryParams.projectLevel" placeholder="请选择项目级别" clearable filterable>
          <el-option
            v-for="item in projectLevels"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
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
          v-hasPermi="['research:research:add']"
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
          v-hasPermi="['research:research:edit']"
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
          v-hasPermi="['research:research:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['research:research:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="researchList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="项目编号" align="center" prop="projectNumber" />
      <el-table-column label="项目类别" align="center" prop="projectCategory" />
      <el-table-column label="项目级别" align="center" prop="projectLevel" />
      <el-table-column label="项目类型" align="center" prop="projectType" />
      <el-table-column label="项目名称" align="center" prop="projectName" />
      <el-table-column label="负责人" align="center" prop="principal" />
      <el-table-column label="参与人" align="center" prop="participants" />
      <el-table-column label="立项单位" align="center" prop="organizingUnit" />
      <el-table-column label="总经费" align="center" prop="totalFunding" />
      <el-table-column label="已到账经费" align="center" prop="receivedFunding" />
      <el-table-column label="经费拨款单位" align="center" prop="fundingUnit" />
      <el-table-column label="开始时间" align="center" prop="startDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结束时间" align="center" prop="endDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="实际结题时间" align="center" prop="actualEndDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.actualEndDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="项目状态" align="center" prop="projectStatus" />
      <el-table-column label="研究领域" align="center" prop="researchField" />
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
            v-hasPermi="['research:research:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['research:research:remove']"
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

    <!-- 添加或修改项目成果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
        <el-form-item label="项目编号" prop="projectNumber">
          <el-input v-model="form.projectNumber" placeholder="请输入项目编号（字母、数字、横线）" />
        </el-form-item>

        <el-form-item label="项目类别" prop="projectCategory">
          <el-select v-model="form.projectCategory" placeholder="请选择项目类别" style="width: 100%">
            <el-option
              v-for="item in projectCategorys"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <!-- 修复点：prop 改为 projectLevel，之前写成了 projectCategory -->
        <el-form-item label="项目级别" prop="projectLevel">
          <el-select v-model="form.projectLevel" placeholder="请选择项目级别" style="width: 100%">
            <el-option
              v-for="item in projectLevels"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="项目类型" prop="projectType">
          <el-input v-model="form.projectType" placeholder="请输入项目类型" />
        </el-form-item>

        <!-- 修复点：prop 改为 projectStatus，之前写成了 projectCategory -->
        <el-form-item label="项目状态" prop="projectStatus">
          <el-select v-model="form.projectStatus" placeholder="请选择项目状态" style="width: 100%">
            <el-option
              v-for="item in projectStatuss"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="项目名称" prop="projectName">
          <el-input v-model="form.projectName" type="textarea" placeholder="请输入项目名称（支持中英文、数字及常用标点）" />
        </el-form-item>

        <el-form-item label="负责人" prop="principal">
          <el-input v-model="form.principal" placeholder="请输入负责人姓名（支持中英文）" />
        </el-form-item>

        <el-form-item label="参与人" prop="participants">
          <el-input v-model="form.participants" placeholder="请输入参与人信息" />
        </el-form-item>

        <el-form-item label="立项单位" prop="organizingUnit">
          <el-input v-model="form.organizingUnit" placeholder="请输入立项单位全称" />
        </el-form-item>

        <el-row>
          <el-col :span="12">
            <el-form-item label="总经费" prop="totalFunding">
              <el-input v-model="form.totalFunding" placeholder="例: 10.50">
                <template slot="append">万元</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="已到账经费" prop="receivedFunding">
              <el-input v-model="form.receivedFunding" placeholder="例: 5.00">
                <template slot="append">万元</template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="经费拨款单位" prop="fundingUnit">
          <el-input v-model="form.fundingUnit" placeholder="请输入经费拨款单位" />
        </el-form-item>

        <el-row>
          <el-col :span="12">
            <el-form-item label="开始时间" prop="startDate">
              <el-date-picker clearable
                style="width: 100%"
                v-model="form.startDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择开始时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="结束时间" prop="endDate">
              <el-date-picker clearable
                style="width: 100%"
                v-model="form.endDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择结束时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="实际结题时间" prop="actualEndDate">
          <el-date-picker clearable
            style="width: 100%"
            v-model="form.actualEndDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择实际结题时间">
          </el-date-picker>
        </el-form-item>

        <el-form-item label="研究领域" prop="researchField">
          <el-input v-model="form.researchField" placeholder="请输入研究领域" />
        </el-form-item>

        <el-form-item v-if="showArchivalTypeField" label="归档类别" prop="archivalType">
          <el-select v-model="form.archivalType" placeholder="请选择归档类别" style="width: 100%">
            <el-option
              v-for="item in archivalTypes"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="上传文件">
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
        attachment-type="research"
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
            <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.label}}</el-checkbox>
          </el-checkbox-group>
          <el-badge :value="idsCount==0?researchList.length:idsCount" class="item"  >
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
          <el-button @click="Excelopen = false">取 消</el-button>
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
import AttachmentManagement from "@/components/AttManage/AttachmentManagement.vue"
import { listResearch, getResearch, delResearch, addResearch, updateResearch } from "@/api/research/research"
import Cookies from "js-cookie"
export default {
  name: "Research",
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
          //上传文件组件
          files:[],
          //附件弹窗参数
          currentPaperId:null,
          currentPaper:"",
          attachmentTitle:"",
          attachmentVisible:false,
          //导出弹窗
          Exceltitle:"选择导出的字段",
          Excelopen:false,
          //导出选择字段
          checkList: [
          {
            value: 'projectNumber',
            label: '项目编号'
          },
          {
            value: 'projectCategory',
            label: '项目类别'
          },
          {
            value: 'projectLevel',
            label: '项目级别'
          },
          {
            value: 'projectType',
            label: '项目类型'
          },
          {
            value: 'projectName',
            label: '项目名称'
          },
          {
            value: 'principal',
            label: '负责人'
          },
          {
            value: 'participants',
            label: '参与人'
          },
          {
            value: 'organizingUnit',
            label: '立项单位'
          },
          {
            value: 'totalFunding',
            label: '总经费'
          },
          {
            value: 'receivedFunding',
            label: '已到账经费'
          },
          {
            value: 'fundingUnit',
            label: '经费拨款单位'
          },
          {
            value: 'startDate',
            label: '开始时间'
          },
          {
            value: 'endDate',
            label: '结束时间'
          },
          {
            value: 'actualEndDate',
            label: '实际结题时间'
          },
          {
            value: 'projectStatus',
            label: '项目状态'
          },
          {
            value: 'researchField',
            label: '研究领域'
          },
          {
        value:'archivalType',
        label:'归档类别'
      }, {
            value: 'auditStatus',
            label: '审核状态'
          },],
          selectClist:[],
      archivalTypes: [
        { label: "教育教学改革", value: "teachingCategory" },
        { label: "课程设计", value: "researchOriented" }
      ],
       // 1. 项目类别 (对应数据库 enum: '纵向项目','横向项目')
        projectCategorys: [
          { label: "纵向项目", value: "纵向项目" },
          { label: "横向项目", value: "横向项目" }
        ],

        // 2. 项目级别 (对应数据库 enum: '国家级','省部级','市厅级','校级','企业级','国际合作')
        projectLevels: [
          { label: "国家级", value: "国家级" },
          { label: "省部级", value: "省部级" },
          { label: "市厅级", value: "市厅级" },
          { label: "校级", value: "校级" },
          { label: "企业级", value: "企业级" },
          { label: "国际合作", value: "国际合作" }
        ],

        // 3. 项目状态 (对应数据库 enum: '在研','已结题','延期','终止','验收中','申报中')
        projectStatuss: [
          { label: "在研", value: "在研" },
          { label: "已结题", value: "已结题" },
          { label: "延期", value: "延期" },
          { label: "终止", value: "终止" }
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
      // 项目成果表格数据
      researchList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        researchId: null,
        projectNumber: null,
        projectName: null,
        projectCategory: null,
        projectLevel: null,
        principal: null,
        totalFunding: null,
        projectStatus: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        projectNumber: [
          { required: true, message: "项目编号不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          {
            pattern: /^[A-Za-z0-9\-_]+$/,
            message: "项目编号仅支持字母、数字、下划线及中划线",
            trigger: "blur"
          }
        ],
        projectCategory: [
          { required: true, message: "请选择归档类别", trigger: "change" }
        ],
        projectLevel: [
          { required: true, message: "请选择项目级别", trigger: "change" }
        ],
        projectType: [
          { required: true, message: "项目类型不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
        projectStatus: [
          { required: true, message: "项目状态不能为空", trigger: "change" }
        ],
        projectName: [
          { required: true, message: "项目名称不能为空", trigger: "blur" },
          { max: 500, message: "长度不能超过 500 个字符", trigger: "blur" },
          {
            // 允许中文、英文、数字、括号、书名号、破折号等常用符号
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\_\s\.]+$/,
            message: "项目名称包含非法字符",
            trigger: "blur"
          }
        ],
        principal: [
          { required: true, message: "负责人不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          {
            pattern: /^[\u4e00-\u9fa5a-zA-Z\.\·\s]+$/,
            message: "负责人姓名仅支持中文、英文、点和空格",
            trigger: "blur"
          }
        ],
        participants: [
          { required: false, message: "请输入参与人", trigger: "blur" },
          { max: 2000, message: "内容过长", trigger: "blur" }
        ],
        organizingUnit: [
          { required: true, message: "立项单位不能为空", trigger: "blur" },
          { max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
          {
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\-\s]+$/,
            message: "单位名称格式不正确",
            trigger: "blur"
          }
        ],
        totalFunding: [
          { required: true, message: "总经费不能为空", trigger: "blur" },
          {
            pattern: /^(([1-9]\d*)|\d)(\.\d{1,2})?$/,
            message: "请输入正确的金额，最多保留两位小数",
            trigger: "blur"
          }
        ],
        receivedFunding: [
          { required: false, message: "请输入已到账经费", trigger: "blur" },
          {
            pattern: /^(([1-9]\d*)|\d)(\.\d{1,2})?$/,
            message: "请输入正确的金额，最多保留两位小数",
            trigger: "blur"
          }
        ],
        fundingUnit: [
          { required: false, message: "请输入经费拨款单位", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
        startDate: [
          { required: true, message: "开始时间不能为空", trigger: "blur" }
        ],
        endDate: [
          { required: true, message: "结束时间不能为空", trigger: "blur" }
        ],
        researchField: [
          { required: false, message: "请输入研究领域", trigger: "blur" },
          { max: 200, message: "长度不能超过 200 个字符", trigger: "blur" }
        ]
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
	      const recordIdField = query.recordIdField || "researchId"
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
      console.log(res)
      this.SelectQueryParamsValue = null;
      if(res=="updatedAt"||res=="createdAt"||res=="competitionTime"||res=="awardDate")
      {
        if(res=="awardDate")
        {
          this.TimeFormat = "yyyy-MM-dd"
          this.TimeType = "date"
        }else{
           this.TimeFormat = "yyyy-MM-ddTHH:mm:ss"
           this.TimeType = "datetime"
        }
        console.log(this.TimeFormat)
        this.TimeFlag = true
      }else{
         this.TimeFlag = false
      }
    },
    /*审核提交*/
    EditAudios(audis)
    {
      if (this.form.researchId != null) {
        this.form.auditStatus = audis
        updateResearch(this.form).then(response => {
          if(response.researchId!=null)
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
       const researchId = row.researchId || this.ids
       getResearch(researchId).then(response => {
         this.form = response.data
         this.AudisVisible=true
       })
    },
    /** 查询项目成果列表 */
    getList() {
      this.loading = true
      listResearch(this.queryParams).then(response => {
        this.researchList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    checkProjectNumberUnique() {
      const projectNumber = this.form.projectNumber
      if (!projectNumber) {
        return Promise.resolve(true)
      }
      return listResearch({
        pageNum: 1,
        pageSize: 10,
        projectNumber
      }).then(response => {
        const rows = response.rows || []
        const currentId = this.form.researchId == null ? null : String(this.form.researchId)
        const duplicate = rows.some(item => {
          return item.projectNumber === projectNumber &&
            (currentId === null || String(item.researchId) !== currentId)
        })
        if (duplicate) {
          this.$modal.msgError(`项目编号“${projectNumber}”已存在，请更换后再提交`)
          return false
        }
        return true
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
        researchId: null,
        userId: null,
        deptId: null,
        projectNumber: null,
        projectCategory: null,
        projectLevel: null,
        projectType: null,
        projectName: null,
        principal: null,
        participants: null,
        organizingUnit: null,
        totalFunding: null,
        receivedFunding: null,
        fundingUnit: null,
        startDate: null,
        endDate: null,
        actualEndDate: null,
        projectStatus: null,
        researchField: null,
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
      this.queryParams.researchId = null
      this.queryParams.projectName = null
      this.queryParams.projectCategory = null
      this.queryParams.projectLevel = null
      this.queryParams.auditStatus = null
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.researchId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加项目成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const researchId = row.researchId || this.ids
      getResearch(researchId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改项目成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.checkProjectNumberUnique().then(unique => {
            if (!unique) {
              return
            }
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
            if (this.form.researchId != null) {
              updateResearch(this.form).then(response => {
                if(response.researchId!=null)
                {
                   this.$refs.file.submitUpload(response.researchId,"research");
                   this.$modal.msgSuccess("修改成功")
                }else{
                    this.$modal.msgSuccess("修改成功,上传文件失败")
                }
                this.open = false
                this.getList()
              })
            } else {
              addResearch(this.form).then(response => {
                if(response.researchId!=null)
                {
                   this.$refs.file.submitUpload(response.researchId,"research");
                   this.$modal.msgSuccess("新增成功")
                }else{
                    this.$modal.msgSuccess("新增成功,上传文件失败")
                }
                this.open = false
                this.getList()
              })
            }
          })
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const researchIds = row.researchId || this.ids
      this.$modal.confirm('是否确认删除项目成果编号为"' + researchIds + '"的数据项？').then(function() {
        return delResearch(researchIds)
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
          this.currentPaperId = row.researchId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.projectName|| '项目'}`
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
        if(this.ids.length==0)
          {
            this.ids = this.researchList.map(item=>item.researchId)
          }
         const requestData = {
          idList:this.ids,
           showColumns: this.selectClist || [],
           data: {
             ...this.queryParams
           }
          };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('research/research/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
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
