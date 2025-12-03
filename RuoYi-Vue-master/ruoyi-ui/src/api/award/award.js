import request from '@/utils/request'

// 查询获奖成果列表
export function listAward(query) {
  return request({
    url: '/award/award/list',
    method: 'get',
    params: query
  })
}

// 查询获奖成果详细
export function getAward(awardId) {
  return request({
    url: '/award/award/' + awardId,
    method: 'get'
  })
}

// 新增获奖成果
export function addAward(data) {
  return request({
    url: '/award/award',
    method: 'post',
    data: data
  })
}

// 修改获奖成果
export function updateAward(data) {
  return request({
    url: '/award/award',
    method: 'put',
    data: data
  })
}

// 删除获奖成果
export function delAward(awardId) {
  return request({
    url: '/award/award/' + awardId,
    method: 'delete'
  })
}
