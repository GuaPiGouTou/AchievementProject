import request from '@/utils/request'

// 查询成果专著列表
export function listMonograph(query) {
  return request({
    url: '/monograph/monograph/list',
    method: 'get',
    params: query
  })
}

// 查询成果专著详细
export function getMonograph(monographId) {
  return request({
    url: '/monograph/monograph/' + monographId,
    method: 'get'
  })
}

// 新增成果专著
export function addMonograph(data) {
  return request({
    url: '/monograph/monograph',
    method: 'post',
    data: data
  })
}

// 修改成果专著
export function updateMonograph(data) {
  return request({
    url: '/monograph/monograph',
    method: 'put',
    data: data
  })
}

// 删除成果专著
export function delMonograph(monographId) {
  return request({
    url: '/monograph/monograph/' + monographId,
    method: 'delete'
  })
}
