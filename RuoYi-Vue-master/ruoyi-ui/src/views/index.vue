<template>
  <div class="app-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h1>成果管理系统</h1>
    </div>

    <!-- 统计卡片区域 -->
    <div class="statistics-card">
      <el-row :gutter="20">
        <!-- 今日新增成果 -->
        <el-col :span="8">
          <div class="card">
            <div class="card-body">
              <div class="pull-left">
                <p class="text-muted">今日新增成果</p>
                <h3 class="m-t-0 m-b-5">42 <small class="text-gray">项</small></h3>
                <p class="text-success"><i class="fa fa-arrow-up"></i> 较昨日增长 18.6%</p>
                <div class="detail-tags">
                  <el-tag size="mini" type="info">学术论文 18</el-tag>
                  <el-tag size="mini" type="primary">发明专利 11</el-tag>
                  <el-tag size="mini" type="success">横向项目 7</el-tag>
                  <el-tag size="mini" type="warning">软件著作权 4</el-tag>
                  <el-tag size="mini" type="danger">实用新型专利 2</el-tag>
                </div>
              </div>
              <div class="pull-right">
                <div class="chart-circle" data-percent="82">
                  <div class="chart-circle__inner">
                    <i class="fa fa-file-text-o text-primary text-2xl"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </el-col>

        <!-- 本月成果总数 -->
        <el-col :span="8">
          <div class="card">
            <div class="card-body">
              <div class="pull-left">
                <p class="text-muted">本月成果总数</p>
                <h3 class="m-t-0 m-b-5">328 <small class="text-gray">项</small></h3>
                <p class="text-success"><i class="fa fa-arrow-up"></i> 较上月增长 12.3%</p>
                <div class="detail-tags">
                  <el-tag size="mini" type="info">工学 156</el-tag>
                  <el-tag size="mini" type="primary">理学 89</el-tag>
                  <el-tag size="mini" type="success">文学 42</el-tag>
                  <el-tag size="mini" type="warning">医学 25</el-tag>
                  <el-tag size="mini" type="danger">农学 16</el-tag>
                </div>
              </div>
              <div class="pull-right">
                <div class="chart-circle" data-percent="88">
                  <div class="chart-circle__inner">
                    <i class="fa fa-bar-chart text-info text-2xl"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </el-col>

        <!-- 成果转化率 -->
        <el-col :span="8">
          <div class="card">
            <div class="card-body">
              <div class="pull-left">
                <p class="text-muted">成果转化率</p>
                <h3 class="m-t-0 m-b-5">72.8%</h3>
                <p class="text-danger"><i class="fa fa-arrow-down"></i> 较上季度下降 1.8%</p>
                <div class="detail-tags">
                  <el-tag size="mini" type="success">技术转让 89 项</el-tag>
                  <el-tag size="mini" type="warning">合作开发 67 项</el-tag>
                  <el-tag size="mini" type="info">专利许可 42 项</el-tag>
                  <el-tag size="mini" type="danger">转化金额 865 万</el-tag>
                </div>
              </div>
              <div class="pull-right">
                <div class="chart-circle" data-percent="73">
                  <div class="chart-circle__inner">
                    <i class="fa fa-exchange text-danger text-2xl"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </el-col>
      </el-row>
    </div>

    <!-- 核心内容区域：通知与待办并排 -->
    <div class="content-grid">
      <el-row :gutter="20">
        <!-- 左侧：通知模块 -->
        <el-col :span="12">
          <div class="card card--fixed-size">
            <div class="card-header">
              <i class="fa fa-bell-o"></i> 系统通知
              <div class="card-header-actions">
                <a href="#" class="btn btn-sm btn-primary">查看更多</a>
              </div>
            </div>
            <div class="card-body">
              <el-scrollbar height="380px" class="notice-scrollbar">
                <ul class="list-group list-group-unbordered">
                  <li class="list-group-item" v-for="(notice, index) in notices" :key="index">
                    <div class="notice-item">
                      <i class="fa fa-circle text-xs" :class="{
                        'text-primary': notice.type === 'info',
                        'text-warning': notice.type === 'warning',
                        'text-success': notice.type === 'success',
                        'text-danger': notice.type === 'error'
                      }"></i>
                      <span class="notice-title">{{ notice.title }}</span>
                      <span class="notice-time pull-right">{{ notice.time }}</span>
                    </div>
                    <!-- 新增通知详情 -->
                    <div class="notice-desc" v-if="notice.desc">
                      {{ notice.desc }}
                    </div>
                  </li>
                </ul>
              </el-scrollbar>
            </div>
          </div>
        </el-col>

        <!-- 右侧：待办事项模块 -->
        <el-col :span="12">
          <div class="card card--fixed-size">
            <div class="card-header">
              <i class="fa fa-tasks"></i> 待办事项
              <div class="card-header-actions">
                <a href="javascript:;" class="btn btn-sm btn-success"><i class="fa fa-plus"></i> 新增</a>
              </div>
            </div>
            <div class="card-body">
              <el-scrollbar height="380px" class="todo-scrollbar">
                <div class="todo-list">
                  <div class="todo-item" v-for="(todo, index) in todos" :key="index">
                    <el-checkbox v-model="todo.completed" class="todo-checkbox">
                      <span :class="{'todo-completed': todo.completed}">{{ todo.content }}</span>
                    </el-checkbox>
                    <div class="todo-meta">
                      <span class="todo-date">{{ todo.date }}</span>
                      <el-tag size="mini" :type="getPriorityTagType(todo.priority)">{{ getPriorityText(todo.priority) }}</el-tag>
                      <div class="todo-progress">
                        <el-progress :percentage="todo.progress" :stroke-width="6" :show-text="false"
                                     :color="getProgressColor(todo.progress)"></el-progress>
                      </div>
                    </div>
                    <!-- 新增待办详情 -->
                    <div class="todo-desc" v-if="todo.desc">
                      {{ todo.desc }}
                    </div>
                  </div>
                </div>
              </el-scrollbar>
            </div>
          </div>
        </el-col>
      </el-row>
    </div>

    <!-- 数据可视化预留区域：简单空白卡片 -->
    <div class="chart-placeholder-area">
      <div class="card">
        <div class="card-header">
          <i class="fa fa-bar-chart"></i> 成果数据统计
        </div>
        <div class="card-body">
          <!-- 未来集成图表的空白区域 -->
          <p>此处将集成成果趋势分析、转化效率对比、学科分布等可视化图表</p>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { ref } from 'vue';

export default {
  name: 'Dashboard',
  setup() {
    // 系统通知数据（20条，更丰富的场景和详情）
    const notices = ref([
      {
        title: '您的成果《基于深度学习的工业缺陷检测研究》已通过审核',
        time: '2024-05-28 09:30',
        type: 'success',
        desc: '该成果将纳入2024年校级优秀成果候选名单，可登录系统查看详细审核意见'
      },
      {
        title: '有8项新提交的科研成果需您在本周内完成审核',
        time: '2024-05-27 14:20',
        type: 'warning',
        desc: '其中包含5篇学术论文、2项发明专利、1项软件著作权，逾期将影响成果入库进度'
      },
      {
        title: '系统将于5月30日22:00-次日02:00进行版本升级，期间暂停使用',
        time: '2024-05-27 10:05',
        type: 'info',
        desc: '升级内容：新增成果转化跟踪模块、优化审核流程、修复数据导出bug'
      },
      {
        title: '您提交的《智能医疗大数据分析平台》成果缺少查新报告，需补充后重新提交',
        time: '2024-05-26 08:45',
        type: 'error',
        desc: '查新报告需由学校科技查新中心出具，截止补充时间：2024-06-05 17:00'
      },
      {
        title: '2024年第二季度成果申报截止日期提醒：6月15日17:00',
        time: '2024-05-25 16:10',
        type: 'warning',
        desc: '本季度重点征集人工智能、生物医药、新材料领域的高水平成果，申报需提交完整证明材料'
      },
      {
        title: '2024年度校级优秀科研成果评选工作正式启动，申报截止6月20日',
        time: '2024-05-24 11:20',
        type: 'info',
        desc: '评选类别：自然科学奖、技术发明奖、科技进步奖、人文社科奖，可在线提交申报材料'
      },
      {
        title: '您的发明专利《一种新型光伏储能装置》已完成公示，可领取证书',
        time: '2024-05-23 15:30',
        type: 'success',
        desc: '证书领取地点：行政楼208室，领取时间：工作日9:00-17:00，需携带经办人身份证'
      },
      {
        title: '5月成果转化数据核对通知：请各部门于5月31日前完成数据确认',
        time: '2024-05-22 09:15',
        type: 'info',
        desc: '需核对的数据包括：转化项目数量、合同金额、到账金额、转化方式等，确认后不可修改'
      },
      {
        title: '您的《乡村振兴大数据平台》软著申请材料格式不符合要求，需修改',
        time: '2024-05-21 14:40',
        type: 'error',
        desc: '问题：源代码文档未按要求排版、权属证明缺少公章，修改指南可在系统下载中心获取'
      },
      {
        title: '成果管理系统操作培训通知：5月29日下午14:00在行政楼301室举办',
        time: '2024-05-20 10:30',
        type: 'info',
        desc: '培训内容：新功能使用、成果分类规范、数据统计分析，建议各部门至少1人参加'
      },
      {
        title: '2024年4月成果转化奖金已发放，可在个人中心查看明细',
        time: '2024-05-19 16:25',
        type: 'success',
        desc: '奖金发放至工资卡，计税方式按照科研成果转化奖励相关政策执行，如有疑问可联系财务处'
      },
      {
        title: '提醒：您有3项成果即将超过维护期限，请及时更新相关信息',
        time: '2024-05-18 09:50',
        type: 'warning',
        desc: '成果名称：《新能源电池管理系统》《智能交通调度算法》《环境监测传感器》，维护截止6月10日'
      },
      {
        title: '新增功能上线：成果数据支持一键导出PDF格式报表',
        time: '2024-05-17 11:45',
        type: 'info',
        desc: '导出路径：成果列表-批量操作-导出PDF，支持自定义导出字段和报表模板'
      },
      {
        title: '您参与的《碳中和技术研发》横向项目成果已完成验收',
        time: '2024-05-16 15:10',
        type: 'success',
        desc: '验收结论：优秀，项目形成专利3项、论文5篇、技术报告1份，可在系统下载验收报告'
      },
      {
        title: '关于开展2024年成果转化专项审计的通知，请配合提供相关材料',
        time: '2024-05-15 08:30',
        type: 'info',
        desc: '审计范围：2023年度所有成果转化项目，需提供合同、发票、银行流水等证明材料'
      },
      {
        title: '校外专家评审安排：6月5日对12项重大成果进行现场评审',
        time: '2024-05-14 14:20',
        type: 'info',
        desc: '评审地点：学术交流中心3楼会议室，需提前准备成果汇报PPT和相关证明材料'
      },
      {
        title: '您的《工业互联网安全防护系统》成果被推荐参评省级科技进步奖',
        time: '2024-05-13 10:15',
        type: 'success',
        desc: '推荐单位：科技处，需在5月30日前补充完善省级奖项申报材料'
      },
      {
        title: '警告：您提交的2篇论文成果存在重复申报嫌疑，请核实说明',
        time: '2024-05-12 16:40',
        type: 'error',
        desc: '论文标题：《机器学习在故障诊断中的应用》《基于ML的工业故障诊断研究》，需在5月20日前提交情况说明'
      },
      {
        title: '成果库数据清理工作通知：请清理2019年前的无效成果信息',
        time: '2024-05-11 09:30',
        type: 'warning',
        desc: '清理范围：已撤销的专利、未发表的论文、终止的项目，清理截止时间：6月15日'
      },
      {
        title: '校企合作成果转化对接会通知：6月8日与高新区企业进行成果对接',
        time: '2024-05-10 11:25',
        type: 'info',
        desc: '参会要求：携带可转化成果清单、技术白皮书，有意向的教师请于5月25日前报名'
      }
    ]);

    // 待办事项数据（15条，增加优先级和详情）
    const todos = ref([
      {
        content: '审核张教授提交的《基于AI的图像识别算法优化研究》学术论文',
        completed: false,
        date: '2024-05-29',
        progress: 75,
        priority: 'high',
        desc: '重点审核创新性、学术价值和成果归属，需填写详细审核意见，该论文拟申报省级优秀论文'
      },
      {
        content: '整理2024年第一季度各学院成果申报清单并汇总上报',
        completed: false,
        date: '2024-06-02',
        progress: 40,
        priority: 'medium',
        desc: '需按学科分类统计，包含申报数量、审核通过数量、驳回数量，制作可视化汇总表'
      },
      {
        content: '参加成果转化研讨会，准备《校企合作成果转化模式》汇报材料',
        completed: false,
        date: '2024-05-30',
        progress: 25,
        priority: 'high',
        desc: '汇报时长15分钟，需包含我校转化现状、典型案例、存在问题、改进建议四部分内容'
      },
      {
        content: '导出2024年1-4月成果转化数据报表并提交至科技处',
        completed: false,
        date: '2024-05-31',
        progress: 10,
        priority: 'medium',
        desc: '报表需包含转化类型、金额、合作单位、转化效率等维度，要求数据准确、格式规范'
      },
      {
        content: '核对《智能制造专利池》中32项专利的法律状态信息',
        completed: true,
        date: '2024-05-27',
        progress: 100,
        priority: 'low',
        desc: '已完成全部专利状态核对，其中5项专利即将到期，需提醒相关负责人办理续费'
      },
      {
        content: '更新成果库中“人工智能”领域的86项成果的分类标签',
        completed: false,
        date: '2024-06-05',
        progress: 15,
        priority: 'medium',
        desc: '按照新的分类标准（GB/T 35774-2017）进行标签更新，确保检索准确性'
      },
      {
        title: '邀请校外专家对12项重点成果进行评审，确认评审时间和名单',
        content: '邀请校外专家对12项重点成果进行评审，确认评审时间和名单',
        completed: false,
        date: '2024-06-01',
        progress: 30,
        priority: 'high',
        desc: '重点成果包括8项发明专利、4项技术发明，需邀请5位以上同行专家，评审费标准参照校级评审规定'
      },
      {
        content: '整理2024年优秀成果表彰大会的获奖名单和颁奖流程',
        completed: false,
        date: '2024-06-10',
        progress: 50,
        priority: 'medium',
        desc: '表彰类别：一等奖10项、二等奖20项、三等奖30项，颁奖流程需包含领导致辞、颁奖、代表发言'
      },
      {
        content: '审核15项横向项目成果的合同备案材料',
        completed: false,
        date: '2024-05-28',
        progress: 60,
        priority: 'high',
        desc: '重点审核合同金额、成果归属、转化收益分配等条款，确保符合学校科研管理规定'
      },
      {
        content: '完成5月成果管理系统使用情况的统计分析报告',
        completed: true,
        date: '2024-05-26',
        progress: 100,
        priority: 'low',
        desc: '报告已完成，系统月活用户增长15%，主要问题集中在成果审核流程耗时较长'
      },
      {
        content: '对接财务处，确认8项成果转化的税费核算方式',
        completed: false,
        date: '2024-06-03',
        progress: 20,
        priority: 'medium',
        desc: '需确认增值税、所得税减免政策适用情况，形成税费核算说明文档'
      },
      {
        content: '指导新入职人员完成成果登记、审核流程的实操培训',
        completed: false,
        date: '2024-05-30',
        progress: 45,
        priority: 'low',
        desc: '培训材料已准备完毕，计划培训时长2小时，包含系统操作演示和实操练习'
      },
      {
        content: '起草《2024-2025年成果转化工作计划》并提交审议',
        completed: false,
        date: '2024-06-15',
        progress: 10,
        priority: 'high',
        desc: '计划需包含工作目标、重点任务、保障措施、考核指标，参考兄弟院校先进经验'
      },
      {
        content: '更新成果转化案例库，补充10个2024年成功转化案例',
        completed: false,
        date: '2024-06-08',
        progress: 35,
        priority: 'medium',
        desc: '案例需包含成果简介、转化方式、合作单位、经济效益、经验总结等内容'
      },
      {
        content: '配合审计部门完成成果转化资金使用情况的核查工作',
        completed: false,
        date: '2024-05-31',
        progress: 25,
        priority: 'high',
        desc: '需提供2023年度转化资金收支凭证、使用明细、相关合同等材料，核查时间5月28-30日'
      }
    ]);

    // 获取优先级标签类型
    const getPriorityTagType = (priority) => {
      const map = {
        high: 'danger',
        medium: 'warning',
        low: 'info'
      };
      return map[priority] || 'info';
    };

    // 获取优先级文本
    const getPriorityText = (priority) => {
      const map = {
        high: '高优先级',
        medium: '中优先级',
        low: '低优先级'
      };
      return map[priority] || '普通';
    };

    // 获取进度条颜色
    const getProgressColor = (progress) => {
      if (progress >= 80) return '#67c23a';
      if (progress >= 50) return '#409eff';
      if (progress >= 20) return '#e6a23c';
      return '#f56c6c';
    };

    return {
      notices,
      todos,
      getPriorityTagType,
      getPriorityText,
      getProgressColor
    };
  }
};
</script>

<style scoped>
/* 整体布局 */
.app-container {
  padding: 20px;
  background-color: #f2f3f5;
  min-height: calc(100vh - 120px);
}

/* 页面标题 */
.page-header h1 {
  font-size: 24px;
  color: #333;
  margin-bottom: 20px;
}

/* 统计卡片区域 */
.statistics-card {
  margin-bottom: 20px;
}
.card {
  background-color: #fff;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
  margin-bottom: 20px;
}
.card-header {
  padding: 15px 20px;
  border-bottom: 1px solid #ebeef5;
  background-color: #fff;
  border-radius: 4px 4px 0 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.card-header i {
  font-size: 16px;
  color: #409eff;
  margin-right: 8px;
}
.card-body {
  padding: 20px;
  display: flex;
  align-items: center;
}

/* 核心内容区域：通知与待办 */
.content-grid {
  margin-bottom: 20px;
}

/* 固定尺寸的卡片 */
.card--fixed-size {
  height: 500px; /* 固定卡片总高度 */
  display: flex;
  flex-direction: column;
}
.card--fixed-size .card-body {
  flex: 1; /* 让 body 部分占满剩余空间 */
  display: flex;
  flex-direction: column;
  overflow: hidden; /* 确保内容不会超出 */
  padding-top: 15px;
}

/* 通知模块 */
.notice-scrollbar {
  width: 100%;
  flex: 1; /* 让滚动区域占满 body */
}
.list-group-unbordered { border: none; }
.list-group-item {
  border: none;
  padding: 15px 0;
  border-bottom: 1px dashed #f0f0f0;
  line-height: 1.6;
}
.list-group-item:last-child { border-bottom: none; }
.notice-item {
  display: flex;
  align-items: flex-start;
  margin-bottom: 5px;
}
.notice-title {
  flex: 1;
  margin-left: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  font-size: 14px;
  font-weight: 500;
}
.notice-time {
  font-size: 12px;
  color: #999;
  white-space: nowrap;
}
/* 通知详情样式 */
.notice-desc {
  font-size: 12px;
  color: #666;
  line-height: 1.5;
  margin-left: 18px;
  margin-top: 4px;
  padding-top: 4px;
  border-top: 1px dotted #eee;
}

/* 待办事项模块 */
.todo-scrollbar {
  width: 100%;
  flex: 1; /* 让滚动区域占满 body */
}
.todo-item {
  padding: 15px 0;
  border-bottom: 1px dashed #f0f0f0;
  line-height: 1.6;
}
.todo-item:last-child { border-bottom: none; }
.todo-checkbox .el-checkbox__label {
  font-size: 14px;
  font-weight: 500;
}
.todo-completed {
  text-decoration: line-through;
  color: #999;
}
.todo-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 8px;
  font-size: 12px;
  color: #666;
  gap: 10px;
}
.todo-date {
  flex-shrink: 0;
}
.todo-progress {
  width: 120px;
  flex-shrink: 0;
}
/* 待办详情样式 */
.todo-desc {
  font-size: 12px;
  color: #666;
  line-height: 1.5;
  margin-left: 22px;
  margin-top: 8px;
  padding-top: 8px;
  border-top: 1px dotted #eee;
}

/* 数据可视化预留区域 */
.chart-placeholder-area .card {
  background-color: #f9f9f9;
  border-color: #e9ecef;
}
.chart-placeholder-area .card-body {
  min-height: 200px; /* 给一个最小高度，使其不塌陷 */
  display: flex;
  justify-content: center;
  align-items: center;
  color: #86909c;
  font-size: 14px;
}

/* 其他样式 */
.detail-tags {
  margin-top: 10px;
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
}
.text-gray { color: #666; font-size: 14px; font-weight: normal; }
.chart-circle {
  width: 80px;
  height: 80px;
  position: relative;
}
.chart-circle__inner {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* 颜色样式补充 */
.text-primary { color: #409eff !important; }
.text-warning { color: #e6a23c !important; }
.text-success { color: #67c23a !important; }
.text-danger { color: #f56c6c !important; }
.text-xs { font-size: 8px !important; }

/* 响应式调整 */
@media (max-width: 1200px) {
  .el-col { width: 100% !important; flex: none !important; }
  .card-body { flex-direction: column; align-items: flex-start; }
  .pull-right { margin-top: 15px; align-self: center; }
  .todo-meta {
    flex-wrap: wrap;
    justify-content: flex-start;
  }
  .todo-progress {
    width: 100%;
    margin-top: 5px;
  }
}
</style>
