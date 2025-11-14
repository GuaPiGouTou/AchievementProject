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
          <span>{{ parseTime(scope.row.competitionTime, '{y}-{m}-{d}') }}</span>
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
      <el-table-column label="指导的学生参赛" align="center" prop="studentParticipants" />
      <el-table-column label="获奖证书编号" align="center" prop="awardCertificateNo" />
      <el-table-column label="竞赛官网" align="center" prop="competitionWebsite" />
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

    <!-- 添加或修改竞赛成果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="竞赛名称" prop="competitionName">
          <el-input v-model="form.competitionName" placeholder="请输入竞赛名称" />
        </el-form-item>
        <el-form-item label="竞赛类型" prop="competitionType">
          <el-input v-model="form.competitionType" placeholder="请输入竞赛类型" />
        </el-form-item>
        <el-form-item label="竞赛时间" prop="competitionTime">
          <el-date-picker clearable
            v-model="form.competitionTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择竞赛时间">
          </el-date-picker>
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
          <el-input v-model="form.organizer" placeholder="请输入主办单位" />
        </el-form-item>
        <el-form-item label="团队人数" prop="teamSize">
          <el-input v-model="form.teamSize" placeholder="请输入团队人数" />
        </el-form-item>
        <el-form-item label="团队名称" prop="teamName">
          <el-input v-model="form.teamName" placeholder="请输入团队名称" />
        </el-form-item>
        <el-form-item label="指导的学生参赛" prop="studentParticipants">
          <el-input v-model="form.studentParticipants" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="获奖证书编号" prop="awardCertificateNo">
          <el-input v-model="form.awardCertificateNo" placeholder="请输入获奖证书编号" />
        </el-form-item>
        <el-form-item label="竞赛官网" prop="competitionWebsite">
          <el-input v-model="form.competitionWebsite" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listCompetition, getCompetition, delCompetition, addCompetition, updateCompetition } from "@/api/competition/competition"

export default {
  name: "Competition",
  data() {
    return {
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
          { required: true, message: "竞赛名称不能为空", trigger: "blur" }
        ],
        competitionLevel: [
          { required: true, message: "竞赛级别不能为空", trigger: "change" }
        ],
        competitionTime: [
          { required: true, message: "竞赛时间不能为空", trigger: "blur" }
        ],
        organizer: [
          { required: true, message: "主办单位不能为空", trigger: "blur" }
        ],
        competitionCategory: [
          { required: true, message: "竞赛类别不能为空", trigger: "change" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
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
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addCompetition(this.form).then(response => {
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
      const competitionIds = row.competitionId || this.ids
      this.$modal.confirm('是否确认删除竞赛成果编号为"' + competitionIds + '"的数据项？').then(function() {
        return delCompetition(competitionIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('competition/competition/export', {
        ...this.queryParams
      }, `competition_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
