import request from '@/utils/request'

// 查询教材著作列表
export function listTextbook(query) {
  return request({
    url: '/textbook/textbook/list',
    method: 'get',
    params: query
  })
}

// 查询教材著作详细
export function getTextbook(textbookId) {
  return request({
    url: '/textbook/textbook/' + textbookId,
    method: 'get'
  })
}

// 新增教材著作
export function addTextbook(data) {
  return request({
    url: '/textbook/textbook',
    method: 'post',
    data: data
  })
}

// 修改教材著作
export function updateTextbook(data) {
  return request({
    url: '/textbook/textbook',
    method: 'put',
    data: data
  })
}

// 删除教材著作
export function delTextbook(textbookId) {
  return request({
    url: '/textbook/textbook/' + textbookId,
    method: 'delete'
  })
}
