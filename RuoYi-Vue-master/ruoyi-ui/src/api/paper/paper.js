import request from '@/utils/request'

// 查询论文成果列表
export function listPaper(query) {
  return request({
    url: '/paper/paper/list',
    method: 'get',
    params: query
  })
}

// 查询论文成果详细
export function getPaper(paperId) {
  return request({
    url: '/paper/paper/' + paperId,
    method: 'get'
  })
}

// 新增论文成果
export function addPaper(data) {
  return request({
    url: '/paper/paper',
    method: 'post',
    data: data
  })
}

// 修改论文成果
export function updatePaper(data) {
  return request({
    url: '/paper/paper',
    method: 'put',
    data: data
  })
}

// 删除论文成果
export function delPaper(paperId) {
  return request({
    url: '/paper/paper/' + paperId,
    method: 'delete'
  })
}
