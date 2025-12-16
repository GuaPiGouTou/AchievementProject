import request from '@/utils/request'

// 查询项目成果列表
export function listResearch(query) {
  return request({
    url: '/research/research/list',
    method: 'get',
    params: query
  })
}

// 查询项目成果详细
export function getResearch(researchId) {
  return request({
    url: '/research/research/' + researchId,
    method: 'get'
  })
}

// 新增项目成果
export function addResearch(data) {
  return request({
    url: '/research/research',
    method: 'post',
    data: data
  })
}

// 修改项目成果
export function updateResearch(data) {
  return request({
    url: '/research/research',
    method: 'put',
    data: data
  })
}

// 删除项目成果
export function delResearch(researchId) {
  return request({
    url: '/research/research/' + researchId,
    method: 'delete'
  })
}
