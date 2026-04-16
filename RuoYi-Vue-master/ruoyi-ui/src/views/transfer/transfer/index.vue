<template>
  <div class="app-container">
     <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="成果名称" prop="achievementName">
        <el-input v-model.trim="queryParams.achievementName" placeholder="请输入成果名称关键词" clearable />
      </el-form-item>
      <el-form-item label="成果类型" prop="achievementType">
        <el-select v-model="queryParams.achievementType" placeholder="请选择成果类型" clearable filterable>
          <el-option
            v-for="item in achievementTypes"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="转化状态" prop="transferStatus">
        <el-select v-model="queryParams.transferStatus" placeholder="请选择转化状态" clearable filterable>
          <el-option
            v-for="item in transferStatuss"
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
          v-hasPermi="['transfer:transfer:add']"
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
          v-hasPermi="['transfer:transfer:edit']"
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
          v-hasPermi="['transfer:transfer:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['transfer:transfer:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="transferList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="成果名称" align="center" prop="achievementName" />
      <el-table-column label="成果类型" align="center" prop="achievementType" />
      <el-table-column label="成果编号" align="center" prop="achievementNumber" />
      <el-table-column label="转化方式" align="center" prop="transferMethod" />
      <el-table-column label="合作企业" align="center" prop="partnerEnterprise" />
      <el-table-column label="转化金额" align="center" prop="transferAmount" />
      <el-table-column label="转化时间" align="center" prop="transferDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.transferDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="转化内容描述" align="center" prop="transferDescription" />
      <el-table-column label="有效期限" align="center" prop="validityPeriod" />
      <el-table-column label="地域范围" align="center" prop="territoryRange" />
      <el-table-column label="支付方式" align="center" prop="paymentMethod" />
      <el-table-column label="转化状态" align="center" prop="transferStatus" />
      <el-table-column label="是否独占许可" align="center" prop="isExclusive" />
      <el-table-column label="经济效益" align="center" prop="economicBenefits" />
      <el-table-column label="社会效益" align="center" prop="socialBenefits" />
      <el-table-column label="联系人" align="center" prop="contactPerson" />
      <el-table-column label="联系电话" align="center" prop="contactPhone" />
            <el-table-column v-if="showArchivalTypeField" label="归档类别" align="center" prop="archivalType" />
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
            v-hasPermi="['transfer:transfer:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['transfer:transfer:remove']"
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

    <!-- 添加或修改成果转化对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
          <el-form ref="form" :model="form" :rules="rules" text-align: right label-width="100px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
            <el-form-item label="成果名称" prop="achievementName">
              <el-input v-model="form.achievementName"  placeholder="请输入成果名称（支持书名号《》及括号）" />
            </el-form-item>
            <el-form-item label="成果类型" prop="achievementType">
              <el-select v-model="form.achievementType" placeholder="请选择成果类型">
                  <el-option
                    v-for="item in achievementTypes"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="转化方式" prop="transferMethod">
              <el-select v-model="form.transferMethod" placeholder="请选择转化方式">
                  <el-option
                    v-for="item in transferMethods"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="转化状态" prop="transferStatus">
              <el-select v-model="form.transferStatus" placeholder="请选择转化状态">
                  <el-option
                    v-for="item in transferStatuss"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="成果编号" prop="achievementNumber">
              <el-input v-model="form.achievementNumber" placeholder="请输入成果编号 (字母、数字、横杠)" />
            </el-form-item>
            <el-form-item label="合作企业" prop="partnerEnterprise">
              <el-input v-model="form.partnerEnterprise" placeholder="请输入合作企业全称" />
            </el-form-item>
            <el-form-item label="转化金额" prop="transferAmount">
              <el-input v-model="form.transferAmount" placeholder="请输入转化金额 (万元，支持两位小数)" />
            </el-form-item>
            <el-form-item label="转化时间" prop="transferDate">
              <el-date-picker clearable
                v-model="form.transferDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择转化时间">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="转化内容描述" prop="transferDescription">
              <el-input v-model="form.transferDescription"  placeholder="请输入转化内容描述" />
            </el-form-item>
            <el-form-item label="有效期限" prop="validityPeriod">
              <el-input v-model="form.validityPeriod" placeholder="请输入有效期限 (如: 5年)" />
            </el-form-item>
            <el-form-item label="地域范围" prop="territoryRange">
              <el-input v-model="form.territoryRange" placeholder="请输入地域范围" />
            </el-form-item>
            <el-form-item label="支付方式" prop="paymentMethod">
              <el-input v-model="form.paymentMethod" placeholder="请输入支付方式" />
            </el-form-item>
            <el-form-item label="是否独占" prop="isExclusive">
               <el-select v-model="form.isExclusive" placeholder="请选择 (1=独占, 0=非独占)">
                  <el-option label="是 (独占许可)" :value="1"></el-option>
                  <el-option label="否 (非独占许可)" :value="0"></el-option>
               </el-select>
            </el-form-item>
            <el-form-item label="经济效益" prop="economicBenefits">
              <el-input v-model="form.economicBenefits"  placeholder="请输入预期经济效益" />
            </el-form-item>
            <el-form-item label="社会效益" prop="socialBenefits">
              <el-input v-model="form.socialBenefits"  placeholder="请输入预期社会效益" />
            </el-form-item>
            <el-form-item label="联系人" prop="contactPerson">
              <el-input v-model="form.contactPerson" placeholder="请输入联系人姓名" />
            </el-form-item>
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入联系电话 (手机或座机)" />
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
  <!--  <el-dialog
      :title="Exceltitle"
      :visible.sync="Excelopen"
      width="600px"
      append-to-body
      :close-on-click-modal="false">
       <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.label}}</el-checkbox>
        </el-checkbox-group>
        <el-badge :value="idsCount==0?transferList.length:idsCount" class="item"  >
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
    <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="transferId"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />

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
import { listTransfer, getTransfer, delTransfer, addTransfer, updateTransfer } from "@/api/transfer/transfer"
import Cookies from "js-cookie"
export default {
  name: "Transfer",
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
      // 导出选择字段
      checkList: [
        {
          value: 'transferId',
          label: '转化id'
        },
        {
          value: 'userId',
          label: '用户ID'
        },
        {
          value: 'deptId',
          label: '部门ID'
        },
        {
          value: 'achievementName',
          label: '成果名称'
        },
        {
          value: 'achievementType',
          label: '成果类型'
        },
        {
          value: 'archivalType',
          label: '归档类别'
        },
        {
          value: 'achievementNumber',
          label: '成果编号'
        },
        {
          value: 'transferMethod',
          label: '转化方式'
        },
        {
          value: 'partnerEnterprise',
          label: '合作企业'
        },
        {
          value: 'transferAmount',
          label: '转化金额(万元)'
        },
        {
          value: 'transferDate',
          label: '转化时间'
        },
        {
          value: 'transferDescription',
          label: '转化内容描述'
        },
        {
          value: 'validityPeriod',
          label: '有效期限'
        },
        {
          value: 'territoryRange',
          label: '地域范围'
        },
        {
          value: 'paymentMethod',
          label: '支付方式'
        },
        {
          value: 'transferStatus',
          label: '转化状态'
        },
        {
          value: 'isExclusive',
          label: '是否独占许可'
        },
        {
          value: 'economicBenefits',
          label: '经济效益'
        },
        {
          value: 'socialBenefits',
          label: '社会效益'
        },
        {
          value: 'contactPerson',
          label: '联系人'
        },
        {
          value: 'contactPhone',
          label: '联系电话'
        },
        {
          value: 'auditStatus',
          label: '审核状态'
        },],
      selectClist:[],
// 1. 成果类型 (对应数据库 achievement_type)
      achievementTypes: [
        { label: "论文", value: "论文" },
        { label: "专利", value: "专利" },
        { label: "软件著作权", value: "软件著作权" },
        { label: "技术秘密", value: "技术秘密" },
        { label: "其他", value: "其他" }
      ],
      archivalTypes: [
        { label: "教育教学改革", value: "教育教学改革" },
        { label: "课程设计", value: "课程设计" }
      ],

      // 2. 转化方式 (对应数据库 transfer_method)
      transferMethods: [
        { label: "转让", value: "转让" },
        { label: "许可", value: "许可" },
        { label: "作价入股", value: "作价入股" },
        { label: "合作开发", value: "合作开发" },
        { label: "技术服务", value: "技术服务" },
        { label: "技术咨询", value: "技术咨询" }
      ],

      // 3. 转化状态 (对应数据库 transfer_status)
      // 注意：变量名 transferStatuss 对应了您模板中的写法
      transferStatuss: [
        { label: "洽谈中", value: "洽谈中" },
        { label: "已签约", value: "已签约" },
        { label: "执行中", value: "执行中" },
        { label: "已完成", value: "已完成" },
        { label: "终止", value: "终止" },
        { label: "违约", value: "违约" }
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
      // 成果转化表格数据
      transferList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        achievementName: null,
        achievementType: null,
        transferAmount: null,
        transferStatus: null,
        contactPerson: null,
        contactPhone: null,
        auditStatus: null,
        createdAt: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        achievementName: [
          { required: true, message: "成果名称不能为空", trigger: "blur" },
          { min: 1, max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
          {
            // 允许：中文、英文、数字、书名号《》、括号、横杠、下划线
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\_\s]+$/,
            message: "成果名称格式错误（仅允许中英文、数字、书名号《》、括号等）",
            trigger: "blur"
          }
        ],
        achievementType: [
          { required: true, message: "成果类型不能为空", trigger: "change" }
        ],
        transferMethod: [
          { required: true, message: "转化方式不能为空", trigger: "change" }
        ],
        partnerEnterprise: [
          { required: true, message: "合作企业不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+$/, message: "企业名称格式错误（仅允许中英文、数字、括号及点号）", trigger: "blur" }
        ],
        transferAmount: [
          { required: true, message: "转化金额不能为空", trigger: "blur" },
          { pattern: /^(([1-9]\d*)|\d)(\.\d{1,2})?$/, message: "金额格式错误，请输入有效的数字（最多保留两位小数）", trigger: "blur" }
        ],
        transferDate: [
          { required: true, message: "转化时间不能为空", trigger: "blur" }
        ],
        isExclusive: [
          { required: true, message: "请选择是否独占许可", trigger: "change" }
        ],
        contactPerson: [
          { required: false, message: "请输入联系人", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z\s\.]+$/, message: "联系人格式错误（仅允许中英文或点号）", trigger: "blur" }
        ],
        contactPhone: [
          { required: false, message: "请输入联系电话", trigger: "blur" },
          { pattern: /^((0\d{2,3}-\d{7,8})|(1[3-9]\d{9}))$/, message: "电话格式错误，请输入正确的手机号或座机号", trigger: "blur" }
        ],
        achievementNumber: [
          { required: false, message: "请输入成果编号", trigger: "blur" },
          { pattern: /^[a-zA-Z0-9\-\_]+$/, message: "编号格式错误（仅允许字母、数字、横杠及下划线）", trigger: "blur" }
        ]
      }
    }
  },
  created() {
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
    initUserRoleScope() {
      const roleKeys = (this.$store.getters.roles || []).map(item => String(item))
      this.isStudentUser = roleKeys.includes("student") || roleKeys.includes("studentAdministrator")
    },
    /*查询输入字段验证时间组件*/
    changeQueryParams(res){
      this.SelectQueryParamsValue = null;
      if(res=="updatedAt"||res=="createdAt"||res=="transferDate")
      {
        if(res=="transferDate")
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
      if (this.form.transferId != null) {
        this.form.auditStatus = audis
        updateTransfer(this.form).then(response => {
          if(response.transferId!=null)
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
       const transferId = row.transferId || this.ids
       getTransfer(transferId).then(response => {
         this.form = response.data
         this.AudisVisible=true
       })
    },
    /** 查询成果转化列表 */
    getList() {
      this.loading = true
      listTransfer(this.queryParams).then(response => {
        this.transferList = response.rows
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
        transferId: null,
        userId: null,
        deptId: null,
        achievementName: null,
        achievementType: null,
        achievementNumber: null,
        transferMethod: null,
        partnerEnterprise: null,
        transferAmount: null,
        transferDate: null,
        transferDescription: null,
        validityPeriod: null,
        territoryRange: null,
        paymentMethod: null,
        transferStatus: null,
        isExclusive: null,
        economicBenefits: null,
        socialBenefits: null,
        contactPerson: null,
        contactPhone: null,
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
      this.queryParams.achievementName = null
      this.queryParams.achievementType = null
      this.queryParams.transferStatus = null
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.transferId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加成果转化"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const transferId = row.transferId || this.ids
      getTransfer(transferId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改成果转化"
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
          if (this.form.transferId != null) {
            updateTransfer(this.form).then(response => {
              if(response.transferId!=null)
              {
                 this.$refs.file.submitUpload(response.transferId,"transfer");
                 this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("修改成功,上传文件失败")
              }
              this.open = false
              this.getList()
            })
          } else {
            addTransfer(this.form).then(response => {
              if(response.transferId!=null)
              {
                 this.$refs.file.submitUpload(response.transferId,"transfer");
                 this.$modal.msgSuccess("新增成功")
              }else{
                 this.$modal.msgSuccess("修改成功,上传文件失败")
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
      const transferIds = row.transferId || this.ids
      this.$modal.confirm('是否确认删除成果转化编号为"' + transferIds + '"的数据项？').then(function() {
        return delTransfer(transferIds)
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
          this.currentPaperId = row.transferId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.achievementName || '转化'}`
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
             this.ids = this.transferList.map(item=>item.transferId)
           }
          const requestData = {
           idList:this.ids,
           showColumns: this.selectClist || [],
           data: {
             ...this.queryParams
           }
          };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('transfer/transfer/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
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
