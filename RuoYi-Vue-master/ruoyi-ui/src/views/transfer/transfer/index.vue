<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="转化金额" prop="transferAmount">
        <el-input
          v-model="queryParams.transferAmount"
          placeholder="请输入转化金额"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="联系人" prop="contactPerson">
        <el-input
          v-model="queryParams.contactPerson"
          placeholder="请输入联系人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="联系电话" prop="contactPhone">
        <el-input
          v-model="queryParams.contactPhone"
          placeholder="请输入联系电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建时间" prop="createdAt">
        <el-date-picker clearable
          v-model="queryParams.createdAt"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择创建时间">
        </el-date-picker>
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
      <el-table-column label="转化id" align="center" prop="transferId" />
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
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="成果名称" prop="achievementName">
          <el-input v-model="form.achievementName" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="成果类型" prop="achievementType">
          <el-select v-model="form.achievementType" placeholder="请选择">
              <el-option
                v-for="item in achievementTypes"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="转化方式" prop="transferMethod">
          <el-select v-model="form.transferMethod" placeholder="请选择">
              <el-option
                v-for="item in transferMethods"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="转化状态" prop="transferStatus">
          <el-select v-model="form.transferStatus" placeholder="请选择">
              <el-option
                v-for="item in transferStatuss"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="成果编号" prop="achievementNumber">
          <el-input v-model="form.achievementNumber" placeholder="请输入成果编号" />
        </el-form-item>
        <el-form-item label="合作企业" prop="partnerEnterprise">
          <el-input v-model="form.partnerEnterprise" placeholder="请输入合作企业" />
        </el-form-item>
        <el-form-item label="转化金额" prop="transferAmount">
          <el-input v-model="form.transferAmount" placeholder="请输入转化金额" />
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
          <el-input v-model="form.transferDescription" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="有效期限" prop="validityPeriod">
          <el-input v-model="form.validityPeriod" placeholder="请输入有效期限" />
        </el-form-item>
        <el-form-item label="地域范围" prop="territoryRange">
          <el-input v-model="form.territoryRange" placeholder="请输入地域范围" />
        </el-form-item>
        <el-form-item label="支付方式" prop="paymentMethod">
          <el-input v-model="form.paymentMethod" placeholder="请输入支付方式" />
        </el-form-item>
        <el-form-item label="是否独占许可" prop="isExclusive">
          <el-input v-model="form.isExclusive" placeholder="请输入是否独占许可" />
        </el-form-item>
        <el-form-item label="经济效益" prop="economicBenefits">
          <el-input v-model="form.economicBenefits" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="社会效益" prop="socialBenefits">
          <el-input v-model="form.socialBenefits" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="联系人" prop="contactPerson">
          <el-input v-model="form.contactPerson" placeholder="请输入联系人" />
        </el-form-item>
        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="创建时间" prop="createdAt">
          <el-date-picker clearable
            v-model="form.createdAt"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择创建时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="更新时间" prop="updatedAt">
          <el-date-picker clearable
            v-model="form.updatedAt"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择更新时间">
          </el-date-picker>
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
  </div>
</template>

<script>
import { listTransfer, getTransfer, delTransfer, addTransfer, updateTransfer } from "@/api/transfer/transfer"

export default {
  name: "Transfer",
  data() {
    return {
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
        },
        {
          value: 'createdAt',
          label: '创建时间'
        },
        {
          value: 'updatedAt',
          label: '更新时间'
        }
      ],
      selectClist:[],
// 1. 成果类型 (对应数据库 achievement_type)
      achievementTypes: [
        { label: "论文", value: "论文" },
        { label: "专利", value: "专利" },
        { label: "软件著作权", value: "软件著作权" },
        { label: "技术秘密", value: "技术秘密" },
        { label: "其他", value: "其他" }
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
          // 允许：中文、英文、数字、中英文括号、书名号、横杠、下划线、空格
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\_\s]+$/, message: "成果名称包含非法字符", trigger: "blur" }
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
          // 允许：中文、英文、数字、括号（如：腾讯(深圳)有限公司）、点（如：Co., Ltd.）
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+$/, message: "企业名称格式不正确", trigger: "blur" }
        ],
        transferAmount: [
          { required: true, message: "转化金额不能为空", trigger: "blur" },
          // 核心校验：必须是正数，允许整数或最多2位小数。防止输入 001 或 1.2.3
          // 示例通过: 100, 100.5, 0.5, 100.55
          { pattern: /^(([1-9]\d*)|\d)(\.\d{1,2})?$/, message: "请输入有效的金额（最多保留两位小数）", trigger: "blur" }
        ],
        transferDate: [
          { required: true, message: "转化时间不能为空", trigger: "blur" }
        ],
        // --- 以下是基于您数据库字段补充的建议校验 ---
        contactPerson: [
          { required: false, message: "请输入联系人", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z\s\.]+$/, message: "联系人只能包含中英文或点", trigger: "blur" }
        ],
        contactPhone: [
          { required: false, message: "请输入联系电话", trigger: "blur" },
          // 兼容手机号(11位) 和 座机号(带区号)
          { pattern: /^((0\d{2,3}-\d{7,8})|(1[3-9]\d{9}))$/, message: "请输入正确的手机号或座机号", trigger: "blur" }
        ],
        achievementNumber: [
          { required: false, message: "请输入成果编号", trigger: "blur" },
          // 编号通常只允许字母、数字、横杠、下划线
          { pattern: /^[a-zA-Z0-9\-\_]+$/, message: "编号格式不正确", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
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
          if (this.form.transferId != null) {
            updateTransfer(this.form).then(response => {
              if(response.transferId!=null)
              {
                 this.$refs.file.submitUpload(response.transferId,"transfer");
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addTransfer(this.form).then(response => {
              if(response.transferId!=null)
              {
                 this.$refs.file.submitUpload(response.transferId,"transfer");
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
          this.currentPaperId = row.competitionId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.competitionName || '转化'}`
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
           this.exceldownload('transfer/transfer/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       }
  }
}
</script>
