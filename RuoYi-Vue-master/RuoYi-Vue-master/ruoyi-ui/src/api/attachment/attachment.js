import request from '@/utils/request'

// 查询成果附件列表
export function listAttachment(query) {
  return request({
    url: '/attachment/attachment/list',
    method: 'get',
    params: query
  })
}

// 查询成果附件详细
export function getAttachment(attachmentId) {
  return request({
    url: '/attachment/attachment/' + attachmentId,
    method: 'get'
  })
}

// 新增成果附件
export function addAttachment(data) {
  return request({
    url: '/attachment/attachment',
    method: 'post',
    data: data
  })
}

// 修改成果附件
export function updateAttachment(data) {
  return request({
    url: '/attachment/attachment',
    method: 'put',
    data: data
  })
}

// 删除成果附件
export function delAttachment(attachmentId) {
  return request({
    url: '/attachment/attachment/' + attachmentId,
    method: 'delete'
  })
}
