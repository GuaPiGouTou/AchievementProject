import request from '@/utils/request'

// 查询成果转化列表
export function listTransfer(query) {
  return request({
    url: '/transfer/transfer/list',
    method: 'get',
    params: query
  })
}

// 查询成果转化详细
export function getTransfer(transferId) {
  return request({
    url: '/transfer/transfer/' + transferId,
    method: 'get'
  })
}

// 新增成果转化
export function addTransfer(data) {
  return request({
    url: '/transfer/transfer',
    method: 'post',
    data: data
  })
}

// 修改成果转化
export function updateTransfer(data) {
  return request({
    url: '/transfer/transfer',
    method: 'put',
    data: data
  })
}

// 删除成果转化
export function delTransfer(transferId) {
  return request({
    url: '/transfer/transfer/' + transferId,
    method: 'delete'
  })
}
