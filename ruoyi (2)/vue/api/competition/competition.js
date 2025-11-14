import request from '@/utils/request'

// 查询竞赛成果列表
export function listCompetition(query) {
  return request({
    url: '/competition/competition/list',
    method: 'get',
    params: query
  })
}

// 查询竞赛成果详细
export function getCompetition(competitionId) {
  return request({
    url: '/competition/competition/' + competitionId,
    method: 'get'
  })
}

// 新增竞赛成果
export function addCompetition(data) {
  return request({
    url: '/competition/competition',
    method: 'post',
    data: data
  })
}

// 修改竞赛成果
export function updateCompetition(data) {
  return request({
    url: '/competition/competition',
    method: 'put',
    data: data
  })
}

// 删除竞赛成果
export function delCompetition(competitionId) {
  return request({
    url: '/competition/competition/' + competitionId,
    method: 'delete'
  })
}
