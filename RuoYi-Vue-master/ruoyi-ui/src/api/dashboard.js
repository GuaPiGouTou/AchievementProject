import request from '@/utils/request'

// 查询首页成果可视化统计
export function getAchievementOverview() {
  return request({
    url: '/dashboard/achievement/overview',
    method: 'get'
  })
}
