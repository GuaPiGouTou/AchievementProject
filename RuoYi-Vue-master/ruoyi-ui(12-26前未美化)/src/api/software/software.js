import request from '@/utils/request'

// 查询软著成果列表
export function listSoftware(query) {
  return request({
    url: '/software/software/list',
    method: 'get',
    params: query
  })
}

// 查询软著成果详细
export function getSoftware(softwareId) {
  return request({
    url: '/software/software/' + softwareId,
    method: 'get'
  })
}

// 新增软著成果
export function addSoftware(data) {
  return request({
    url: '/software/software',
    method: 'post',
    data: data
  })
}

// 修改软著成果
export function updateSoftware(data) {
  return request({
    url: '/software/software',
    method: 'put',
    data: data
  })
}

// 删除软著成果
export function delSoftware(softwareId) {
  return request({
    url: '/software/software/' + softwareId,
    method: 'delete'
  })
}
