<template>
  <div class="home-dashboard">
    <div class="metric-grid">
      <div class="metric-card blue">
        <div class="metric-icon">总</div>
        <div class="metric-label">成果总数</div>
        <div class="metric-value">{{ overview.total }}</div>
      </div>
      <div class="metric-card green">
        <div class="metric-icon">通</div>
        <div class="metric-label">已通过/已归档</div>
        <div class="metric-value">{{ overview.approved }}</div>
      </div>
      <div class="metric-card orange">
        <div class="metric-icon">待</div>
        <div class="metric-label">待处理</div>
        <div class="metric-value">{{ overview.pending }}</div>
      </div>
      <div class="metric-card purple">
        <div class="metric-icon">类</div>
        <div class="metric-label">成果类型</div>
        <div class="metric-value">{{ overview.typeData.length }}</div>
      </div>
    </div>

    <div class="dashboard-grid">
      <div class="panel chart-panel trend-panel" v-loading="loading">
        <div class="panel-title-row">
          <div class="panel-title">近 6 个月成果增长趋势</div>
          <span class="panel-subtitle">按创建时间聚合</span>
        </div>
        <div ref="lineChart" class="chart chart-large"></div>
      </div>

      <div class="panel notice-panel" v-loading="noticeLoading">
        <div class="panel-title-row">
          <div class="panel-title">通知公告</div>
          <span class="panel-subtitle">最近 6 条</span>
        </div>
        <div v-if="notices.length" class="notice-list">
          <div v-for="item in notices" :key="item.noticeId" class="notice-item" @click="openNotice(item)">
            <div class="notice-title">{{ item.noticeTitle }}</div>
            <div class="notice-meta">{{ formatNoticeType(item.noticeType) }} · {{ item.createTime || '暂无时间' }}</div>
          </div>
        </div>
        <el-empty v-else :image-size="80" description="暂无公告" />
      </div>

      <div class="panel chart-panel" v-loading="loading">
        <div class="panel-title-row">
          <div class="panel-title">成果类型占比</div>
        </div>
        <div ref="pieChart" class="chart"></div>
      </div>

      <div class="panel chart-panel" v-loading="loading">
        <div class="panel-title-row">
          <div class="panel-title">审核状态分布</div>
        </div>
        <div ref="barChart" class="chart"></div>
      </div>
    </div>

    <el-dialog :title="activeNotice.noticeTitle || '公告详情'" :visible.sync="noticeDialogOpen" width="640px" append-to-body>
      <div class="notice-detail-meta">
        {{ formatNoticeType(activeNotice.noticeType) }} · {{ activeNotice.createTime || '暂无时间' }}
      </div>
      <div class="notice-detail-content" v-html="activeNotice.noticeContent || '暂无内容'"></div>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="noticeDialogOpen = false">知道了</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import Cookies from 'js-cookie'
import request from '@/utils/request'
import { getUserProfile } from '@/api/system/user'

function getHomeNotices(query) {
  return request({
    url: '/dashboard/notices',
    method: 'get',
    params: query
  })
}

function getAchievementOverviewData() {
  return request({
    url: '/dashboard/achievement/overview',
    method: 'get'
  })
}

function getHomeNoticeDetail(noticeId) {
  return request({
    url: '/dashboard/notices/' + noticeId,
    method: 'get'
  })
}

const defaultOverview = {
  total: 0,
  approved: 0,
  pending: 0,
  typeData: [
    { name: '论文成果', value: 0 },
    { name: '获奖成果', value: 0 },
    { name: '竞赛成果', value: 0 },
    { name: '专利成果', value: 0 },
    { name: '科研项目', value: 0 },
    { name: '软著成果', value: 0 },
    { name: '教材成果', value: 0 },
    { name: '专著成果', value: 0 },
    { name: '成果转化', value: 0 }
  ],
  statusData: [
    { name: '暂无数据', value: 0 }
  ],
  monthLabels: [],
  monthData: []
}

export default {
  name: 'Index',
  data() {
    return {
      loading: false,
      noticeLoading: false,
      noticeDialogOpen: false,
      charts: {},
      notices: [],
      activeNotice: {},
      overview: this.buildDefaultOverview()
    }
  },
  created() {
    this.setAdminFlag()
    this.getNotices()
    this.getOverview()
  },
  mounted() {
    window.addEventListener('resize', this.resizeCharts)
    this.$nextTick(this.renderCharts)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.resizeCharts)
    Object.values(this.charts).forEach(chart => chart && chart.dispose())
  },
  methods: {
    setAdminFlag() {
      getUserProfile().then(res => {
        const hasAdmin = res.data.roles.some(item => item.roleId === 1 || item.roleId === 101)
        Cookies.set('adminFlag', hasAdmin)
      }).catch(() => {})
    },
    getNotices() {
      this.noticeLoading = true
      getHomeNotices({ pageNum: 1, pageSize: 6, status: '0' }).then(response => {
        this.notices = response.data || []
      }).catch(() => {
        this.notices = []
      }).finally(() => {
        this.noticeLoading = false
      })
    },
    getOverview() {
      this.loading = true
      getAchievementOverviewData().then(response => {
        this.overview = Object.assign(this.buildDefaultOverview(), response.data || {})
        this.$nextTick(this.renderCharts)
      }).catch(() => {
        this.overview = this.buildDefaultOverview()
        this.$nextTick(this.renderCharts)
      }).finally(() => {
        this.loading = false
      })
    },
    buildDefaultOverview() {
      const now = new Date()
      const monthLabels = []
      for (let i = 5; i >= 0; i--) {
        const date = new Date(now.getFullYear(), now.getMonth() - i, 1)
        const month = String(date.getMonth() + 1).padStart(2, '0')
        monthLabels.push(`${date.getFullYear()}-${month}`)
      }
      return Object.assign({}, defaultOverview, {
        typeData: defaultOverview.typeData.map(item => Object.assign({}, item)),
        statusData: defaultOverview.statusData.map(item => Object.assign({}, item)),
        monthLabels,
        monthData: monthLabels.map(() => 0)
      })
    },
    renderCharts() {
      this.renderLineChart()
      this.renderPieChart()
      this.renderBarChart()
    },
    getChart(refName) {
      if (!this.charts[refName]) {
        this.charts[refName] = echarts.init(this.$refs[refName])
      }
      return this.charts[refName]
    },
    renderLineChart() {
      const chart = this.getChart('lineChart')
      chart.setOption({
        tooltip: { trigger: 'axis' },
        grid: { left: 40, right: 24, top: 35, bottom: 35 },
        xAxis: { type: 'category', boundaryGap: false, data: this.overview.monthLabels },
        yAxis: { type: 'value' },
        series: [{
          name: '成果数量',
          type: 'line',
          smooth: true,
          areaStyle: { color: 'rgba(64, 158, 255, 0.16)' },
          lineStyle: { width: 3, color: '#409EFF' },
          itemStyle: { color: '#409EFF' },
          data: this.overview.monthData
        }]
      })
    },
    renderPieChart() {
      const chart = this.getChart('pieChart')
      chart.setOption({
        tooltip: { trigger: 'item' },
        color: ['#409eff', '#67c23a', '#e6a23c', '#f56c6c', '#9254de', '#36cfc9', '#597ef7', '#ff85c0', '#73d13d'],
        legend: {
          type: 'scroll',
          orient: 'vertical',
          right: 0,
          top: 18,
          bottom: 12,
          itemWidth: 10,
          itemHeight: 10,
          textStyle: { color: '#5e6c84', fontSize: 12 }
        },
        series: [{
          name: '成果类型',
          type: 'pie',
          radius: ['34%', '56%'],
          center: ['34%', '50%'],
          avoidLabelOverlap: true,
          data: this.overview.typeData,
          label: {
            position: 'inside',
            formatter: '{c}',
            color: '#fff',
            fontSize: 12,
            fontWeight: 700
          },
          labelLine: { show: false },
          itemStyle: {
            borderColor: '#fff',
            borderWidth: 3,
            borderRadius: 6
          }
        }]
      })
    },
    renderBarChart() {
      const chart = this.getChart('barChart')
      const source = this.overview.statusData || []
      chart.setOption({
        tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
        grid: { left: 40, right: 24, top: 35, bottom: 45 },
        xAxis: { type: 'category', data: source.map(item => item.name), axisLabel: { interval: 0 } },
        yAxis: { type: 'value' },
        series: [{
          name: '数量',
          type: 'bar',
          barWidth: 36,
          itemStyle: { color: '#67C23A', borderRadius: [6, 6, 0, 0] },
          data: source.map(item => item.value)
        }]
      })
    },
    resizeCharts() {
      Object.values(this.charts).forEach(chart => chart && chart.resize())
    },
    formatNoticeType(type) {
      return type === '2' ? '公告' : '通知'
    },
    openNotice(item) {
      this.activeNotice = item
      this.noticeDialogOpen = true
      if (!item.noticeId) {
        return
      }
      getHomeNoticeDetail(item.noticeId).then(response => {
        this.activeNotice = Object.assign({}, item, response.data || {})
      }).catch(() => {
        this.activeNotice = item
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.home-dashboard {
  min-height: calc(100vh - 84px);
  padding: 16px;
  background:
    radial-gradient(circle at 8% 8%, rgba(64, 158, 255, 0.14), transparent 28%),
    linear-gradient(135deg, #f6f9ff 0%, #eef4fb 100%);
}

.metric-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 12px;
  margin-bottom: 12px;
}

.metric-card,
.panel {
  border: 1px solid rgba(220, 230, 244, 0.9);
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.92);
  box-shadow: 0 12px 30px rgba(38, 63, 102, 0.08);
}

.metric-card {
  position: relative;
  overflow: hidden;
  padding: 14px 16px;
  min-height: 82px;
  border-top: 0;
  transition: transform 0.2s, box-shadow 0.2s;
}

.metric-card:hover {
  box-shadow: 0 16px 34px rgba(38, 63, 102, 0.12);
  transform: translateY(-2px);
}

.metric-card::after {
  content: "";
  position: absolute;
  right: -22px;
  bottom: -28px;
  width: 86px;
  height: 86px;
  border-radius: 50%;
  background: rgba(64, 158, 255, 0.1);
}

.metric-card.blue { background: linear-gradient(135deg, #ffffff 0%, #edf6ff 100%); }
.metric-card.green { background: linear-gradient(135deg, #ffffff 0%, #f0f9eb 100%); }
.metric-card.green::after { background: rgba(103, 194, 58, 0.11); }
.metric-card.orange { background: linear-gradient(135deg, #ffffff 0%, #fff7e8 100%); }
.metric-card.orange::after { background: rgba(230, 162, 60, 0.12); }
.metric-card.purple { background: linear-gradient(135deg, #ffffff 0%, #f7f0ff 100%); }
.metric-card.purple::after { background: rgba(146, 84, 222, 0.12); }

.metric-icon {
  position: absolute;
  top: 14px;
  right: 16px;
  z-index: 1;
  display: flex;
  width: 34px;
  height: 34px;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  color: #fff;
  font-size: 14px;
  font-weight: 700;
  background: linear-gradient(135deg, #409eff, #79bbff);
  box-shadow: 0 8px 16px rgba(64, 158, 255, 0.24);
}

.green .metric-icon { background: linear-gradient(135deg, #67c23a, #95d475); box-shadow: 0 8px 16px rgba(103, 194, 58, 0.22); }
.orange .metric-icon { background: linear-gradient(135deg, #e6a23c, #f3d19e); box-shadow: 0 8px 16px rgba(230, 162, 60, 0.24); }
.purple .metric-icon { background: linear-gradient(135deg, #9254de, #b37feb); box-shadow: 0 8px 16px rgba(146, 84, 222, 0.24); }

.metric-label {
  color: #6b778c;
  font-size: 13px;
}

.metric-value {
  margin-top: 6px;
  color: #172b4d;
  font-size: 28px;
  font-weight: 700;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 1.1fr 1.1fr 0.9fr;
  gap: 12px;
}

.panel {
  padding: 14px 16px;
  transition: box-shadow 0.2s, transform 0.2s;
}

.panel:hover {
  box-shadow: 0 16px 34px rgba(38, 63, 102, 0.11);
}

.trend-panel {
  grid-column: span 2;
}

.notice-panel {
  grid-row: span 2;
}

.panel-title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.panel-title {
  position: relative;
  padding-left: 10px;
  color: #172b4d;
  font-size: 15px;
  font-weight: 700;
}

.panel-title::before {
  content: "";
  position: absolute;
  left: 0;
  top: 3px;
  width: 4px;
  height: 14px;
  border-radius: 99px;
  background: linear-gradient(180deg, #409eff, #67c23a);
}

.panel-subtitle {
  color: #a0aec0;
  font-size: 12px;
}

.chart {
  width: 100%;
  height: 220px;
}

.chart-large {
  height: 250px;
}

.notice-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.notice-item {
  padding: 10px 12px;
  border: 1px solid #edf1f7;
  border-radius: 12px;
  background: #f8fbff;
  cursor: pointer;
  transition: all 0.2s;
}

.notice-item:hover {
  border-color: #409eff;
  box-shadow: 0 8px 18px rgba(64, 158, 255, 0.12);
  transform: translateY(-1px);
}

.notice-title {
  color: #172b4d;
  font-weight: 600;
}

.notice-meta {
  margin-top: 5px;
  color: #8492a6;
  font-size: 12px;
}

.notice-detail-meta {
  margin-bottom: 16px;
  color: #8492a6;
  font-size: 13px;
}

.notice-detail-content {
  min-height: 120px;
  line-height: 1.8;
  color: #303133;
}

@media (max-width: 768px) {
  .metric-grid,
  .dashboard-grid {
    grid-template-columns: 1fr;
  }

  .trend-panel,
  .notice-panel {
    grid-column: auto;
    grid-row: auto;
  }
}
</style>
