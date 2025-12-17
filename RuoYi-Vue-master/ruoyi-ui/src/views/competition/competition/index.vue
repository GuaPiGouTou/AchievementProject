<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="竞赛名称" prop="competitionName">
        <el-input
          v-model="queryParams.competitionName"
          placeholder="请输入竞赛名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="竞赛类型" prop="competitionType">
        <el-input
          v-model="queryParams.competitionType"
          placeholder="请输入竞赛类型"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="竞赛时间" prop="competitionTime">
        <el-date-picker clearable
          v-model="queryParams.competitionTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择竞赛时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="获奖日期" prop="awardDate">
        <el-date-picker clearable
          v-model="queryParams.awardDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择获奖日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="团队名称" prop="teamName">
        <el-input
          v-model="queryParams.teamName"
          placeholder="请输入团队名称"
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
          v-hasPermi="['competition:competition:add']"
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
          v-hasPermi="['competition:competition:edit']"
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
          v-hasPermi="['competition:competition:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['competition:competition:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="competitionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="竞赛id" align="center" prop="competitionId" />
      <el-table-column label="竞赛名称" align="center" prop="competitionName" />
      <el-table-column label="竞赛级别" align="center" prop="competitionLevel" />
      <el-table-column label="竞赛类型" align="center" prop="competitionType" />
      <el-table-column label="竞赛时间" align="center" prop="competitionTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.competitionTime, '{y}-{m}-{d}-{h}:{m}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="角色类型" align="center" prop="roleType" />
      <el-table-column label="获奖等级" align="center" prop="awardLevel" />
      <el-table-column label="获奖日期" align="center" prop="awardDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.awardDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="主办单位" align="center" prop="organizer" />
      <el-table-column label="竞赛类别" align="center" prop="competitionCategory" />
      <el-table-column label="团队人数" align="center" prop="teamSize" />
      <el-table-column label="团队名称" align="center" prop="teamName" />
      <el-table-column label="参赛队员" align="center" prop="studentParticipants" />
      <el-table-column label="获奖证书编号" align="center" prop="awardCertificateNo" />
      <el-table-column label="竞赛官网" align="center" prop="competitionWebsite" />
      <el-table-column label="审核状态" align="center" prop="auditStatus" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}-{h}:{m}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updatedAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updatedAt, '{y}-{m}-{d}-{h}:{m}:{s}') }}</span>
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
            v-hasPermi="['competition:competition:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['competition:competition:remove']"
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
        attachment-type="competition"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />
    <!-- 添加或修改竞赛成果对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
          <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-form-item label="竞赛名称" prop="competitionName">
              <el-input v-model="form.competitionName" placeholder="请输入竞赛名称（包含中英文、数字、括号及横杠）" />
            </el-form-item>
            <el-form-item label="竞赛级别" prop="competitionLevel">
              <el-select v-model="form.competitionLevel" placeholder="请选择竞赛级别">
                  <el-option
                    v-for="item in competitionLevels"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="竞赛类型" prop="competitionType">
              <el-input v-model="form.competitionType" placeholder="请输入竞赛类型 (仅限中英文和数字)" />
            </el-form-item>
            <el-form-item label="竞赛时间" prop="competitionTime">
              <el-date-picker clearable
                v-model="form.competitionTime"
                type="datetime"
                value-format="yyyy-MM-ddTHH:mm:ss"
                placeholder="请选择竞赛时间">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="角色类型" prop="roleType">
              <el-select v-model="form.roleType" placeholder="请选择角色类型">
                  <el-option
                    v-for="item in roleTypes"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="获奖等级" prop="awardLevel">
              <el-select v-model="form.awardLevel" placeholder="请选择获奖等级">
                  <el-option
                    v-for="item in awardLevels"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="获奖日期" prop="awardDate">
              <el-date-picker clearable
                v-model="form.awardDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择获奖日期">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="主办单位" prop="organizer">
              <el-input v-model="form.organizer" placeholder="请输入主办单位（包含中英文、数字、括号及点）" />
            </el-form-item>
            <el-form-item label="竞赛类别" prop="competitionCategory">
              <el-select v-model="form.competitionCategory" placeholder="请选择竞赛类别">
                  <el-option
                    v-for="item in competitionCategorys"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="团队人数" prop="teamSize">
              <el-input v-model="form.teamSize" placeholder="请输入团队人数（1-999之间的整数）" />
            </el-form-item>
            <el-form-item label="团队名称" prop="teamName">
              <el-input v-model="form.teamName" placeholder="请输入团队名称（包含中英文、数字、下划线及横杠）" />
            </el-form-item>
            <el-form-item label="参赛队员" prop="studentParticipants">
              <el-input v-model="form.studentParticipants" type="textarea" placeholder="请输入参赛队员姓名，多人请用逗号分隔" />
            </el-form-item>
            <el-form-item label="获奖证书编号" prop="awardCertificateNo">
              <el-input v-model="form.awardCertificateNo" placeholder="请输入获奖证书编号（包含字母、数字、横杠、下划线及点）" />
            </el-form-item>
            <el-form-item label="竞赛官网" prop="competitionWebsite">
              <el-input v-model="form.competitionWebsite" type="textarea" placeholder="请输入竞赛官网地址 (如: https://www.example.com)" />
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
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.lable}}</el-checkbox>
        </el-checkbox-group>
        <el-badge :value="idsCount==0?competitionList.length:idsCount" class="item"  >
          <el-button @click="DowExcel()" >导出</el-button>
        </el-badge>
    </el-dialog>
  </div>
</template>

<script>
import AttachmentManagement from "@/components/AttManage/AttachmentManagement.vue"
import { listCompetition, getCompetition, delCompetition, addCompetition, updateCompetition } from "@/api/competition/competition"

export default {
  name: "Competition",
  data() {
    return {
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
      checkList:[
        {
          value:'competitionId',
          lable:'竞赛id'
        },{
          value:'competitionName',
          lable:'竞赛名称'
        },{
          value:'competitionLevel',
          lable:'竞赛级别'
        },{
          value:'competitionType',
          lable:'竞赛类型'
        },{
          value:'competitionTime',
          lable:'竞赛时间'
        },{
          value:'roleType',
          lable:'角色类型'
        },{
          value:'awardLevel',
          lable:'获奖等级'
        },{
          value:'awardDate',
          lable:'获奖日期'
        },{
          value:'organizer',
          lable:'主办单位'
        },{
          value:'competitionCategory',
          lable:'竞赛类别'
        },{
          value:'teamSize',
          lable:'团队人数'
        },{
          value:'teamName',
          lable:'团队名称'
        },{
          value:'studentParticipants',
          lable:'指导的学生参赛'
        },{
          value:'awardCertificateNo',
          lable:'获奖证书编号'
        },{
          value:'competitionWebsite',
          lable:'竞赛官网'
        },{
          value:'auditStatus',
          lable:'审核状态'
        },{
          value:'createdAt',
          lable:'创建时间'
        },{
          value:'updatedAt',
          lable:'更新时间'
        }
      ],
      selectClist:[],
      //竞赛类别
      competitionCategorys:[{
        value:'学科竞赛',
        lable:'学科竞赛'
      },{
        value:'科技创新',
        lable:'科技创新'
      },{
        value:'教学竞赛',
        lable:'教学竞赛'
      },{
        value:'科研竞赛',
        lable:'科研竞赛'
      },{
      value:'技能竞赛',
      lable:'技能竞赛'
      },{
        value:'综合类竞赛',
        lable:'综合类竞赛'
      },{
        value:'创业竞赛',
        lable:'创业竞赛'
      }],
      //获奖等级
      awardLevels:[{
        value:'特等奖',
        lable:'特等奖'
      },{
        value:'一等奖',
        lable:'一等奖'
      },{
        value:'二等奖',
        lable:'二等奖'
      },{
        value:'三等奖',
        lable:'三等奖'
      },{
        value:'优秀奖',
        lable:'优秀奖'
      },{
        value:'参与奖',
        lable:'参与奖'
      },{
        value:'组织奖',
        lable:'组织奖'
      },{
        value:'指导奖',
        lable:'指导奖'
      },{
        value:'金奖',
        lable:'金奖'
      },{
        value:'银奖',
        lable:'银奖'
      },{
        value:'铜奖',
        lable:'铜奖'
      }],
      //角色类型
      roleTypes:[{
        value:'参赛者',
        lable:'参赛者'
      },{
        value:'队长',
        lable:'队长'
      },{
        value:'队员',
        lable:'队员'
      },{
        value:'指导老师',
        lable:'指导老师'
      },{
        value:'评委',
        lable:'评委'
      },{
        value:'组织者',
        lable:'组织者'
      }],
      //竞赛级别
      competitionLevels:[{
          value: '国际级',
          label: '国际级'
        }, {
          value: '国家级',
          label: '国家级'
        }, {
          value: '省级',
          label: '省级'
        }, {
          value: '校级',
          label: '校级'
        }, {
          value: '院级',
          label: '院级'
        }, {
          value: '市级',
          label: '市级'
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
      // 竞赛成果表格数据
      competitionList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        competitionName: null,
        competitionLevel: null,
        competitionType: null,
        competitionTime: null,
        awardLevel: null,
        awardDate: null,
        competitionCategory: null,
        teamName: null,
        studentParticipants: null,
        auditStatus: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        competitionName: [
          { required: true, message: "竞赛名称不能为空", trigger: "blur" },
          { min: 1, max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\-\s]+$/, message: "竞赛名称格式错误（仅允许中英文、数字、括号及横杠）", trigger: "blur" }
        ],
        competitionLevel: [
          { required: true, message: "竞赛级别不能为空", trigger: "change" }
        ],
        competitionType: [
          { required: false, message: "请输入竞赛类型", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9]+$/, message: "竞赛类型格式错误（仅允许中英文和数字）", trigger: "blur" }
        ],
        competitionTime: [
          { required: true, message: "竞赛时间不能为空", trigger: "blur" }
        ],
        roleType: [
          { required: true, message: "角色类型不能为空", trigger: "change" }
        ],
        awardLevel: [
          { required: true, message: "获奖等级不能为空", trigger: "change" }
        ],
        awardDate: [
          { required: false, message: "请选择获奖日期", trigger: "blur" }
        ],
        organizer: [
          { required: true, message: "主办单位不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+$/, message: "主办单位格式错误（仅允许中英文、数字、括号及点）", trigger: "blur" }
        ],
        competitionCategory: [
          { required: true, message: "竞赛类别不能为空", trigger: "change" }
        ],
        teamSize: [
          { required: false, message: "请输入团队人数", trigger: "blur" },
          { pattern: /^[1-9]\d{0,2}$/, message: "请输入有效的团队人数（1-999之间的整数）", trigger: "blur" }
        ],
        teamName: [
          { required: false, message: "请输入团队名称", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\-\_\s]+$/, message: "团队名称格式错误（仅允许中英文、数字、下划线及横杠）", trigger: "blur" }
        ],
        studentParticipants: [
          { required: false, message: "请输入参赛队员", trigger: "blur" },
          { max: 500, message: "内容过长，请精简", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z\s,;，；]+$/, message: "格式错误，请只输入姓名，多个姓名请用逗号分隔", trigger: "blur" }
        ],
        awardCertificateNo: [
          { required: false, message: "请输入获奖证书编号", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          {
            pattern: /^[a-zA-Z0-9\-\_\.]+$/,
            message: "证书编号格式错误（仅允许字母、数字、横杠、下划线或点）",
            trigger: "blur"
          }
        ],
        competitionWebsite: [
          { required: false, message: "请输入竞赛官网", trigger: "blur" },
          { max: 255, message: "网址长度不能超过 255 个字符", trigger: "blur" },
          { pattern: /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/, message: "请输入正确的网址格式，如 https://www.example.com", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /**/

    /** 查询竞赛成果列表 */
    getList() {
      this.loading = true
      listCompetition(this.queryParams).then(response => {

        this.competitionList = response.rows
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
        competitionId: null,
        userId: null,
        deptId: null,
        competitionName: null,
        competitionLevel: null,
        competitionType: null,
        competitionTime: null,
        roleType: null,
        awardLevel: null,
        awardDate: null,
        organizer: null,
        competitionCategory: null,
        teamSize: null,
        teamName: null,
        studentParticipants: null,
        awardCertificateNo: null,
        competitionWebsite: null,
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
      this.ids = selection.map(item => item.competitionId)
      this.single = selection.length!==1
      this.multiple = !selection.length
      this.idsCount = selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加竞赛成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const competitionId = row.competitionId || this.ids
      getCompetition(competitionId).then(response => {
          console.log("竞赛详细信息")
          console.log(response.data[0])
        this.form = response.data
        this.open = true
        this.title = "修改竞赛成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {

        if (valid) {
          if (this.form.competitionId != null) {
            updateCompetition(this.form).then(response => {
              if(response.competitionId!=null)
              {
                 this.$refs.file.submitUpload(response.competitionId,"competition");
                 this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("修改成功，上传文件失败")
              }

              this.open = false
              this.getList()
            })
          } else {
            console.log("竞赛新增")
            console.log(this.form)
            addCompetition(this.form).then(response => {


              if(response.competitionId!=null)
              {
                 this.$refs.file.submitUpload(response.competitionId,"competition");
                 this.$modal.msgSuccess("新增成功")
              }else{
                  this.$modal.msgSuccess("新增成功,上传文件失败")
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
      const competitionIds = row.competitionId || this.ids
      this.$modal.confirm('是否确认删除竞赛成果编号为"' + competitionIds + '"的数据项？').then(function() {
        return delCompetition(competitionIds)
      }).then((res) => {
        console.log("竞赛删除")
        console.log(res)
        this.$modal.msgSuccess("删除成功")
        this.getList()

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
          this.attachmentTitle = `附件管理 - ${row.competitionName || '竞赛'}`
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
          this.ids = this.competitionList.map(item=>item.competitionId)
        }
          const requestData = {
           idList:this.ids,
           showColumns: this.selectClist || [],
           data: {
             ...this.queryParams
           }
          };
           const jsonRequestBody = JSON.stringify(requestData);
           console.log(requestData);
           this.exceldownload('competition/competition/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       }
  }
}
</script>
<style>



  .el-checkbox__label{
    font-size: 18px;
  }

</style>
