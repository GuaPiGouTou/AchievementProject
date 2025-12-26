import request from '@/utils/request'

// 查询专利成果列表
export function listPatent(query) {
  return request({
    url: '/patent/patent/list',
    method: 'get',
    params: query
  })
}

// 查询专利成果详细
export function getPatent(patentId) {
  return request({
    url: '/patent/patent/' + patentId,
    method: 'get'
  })
}

// 新增专利成果
export function addPatent(data) {
  return request({
    url: '/patent/patent',
    method: 'post',
    data: data
  })
}

// 修改专利成果
export function updatePatent(data) {
  return request({
    url: '/patent/patent',
    method: 'put',
    data: data
  })
}

// 删除专利成果
export function delPatent(patentId) {
  return request({
    url: '/patent/patent/' + patentId,
    method: 'delete'
  })
}
