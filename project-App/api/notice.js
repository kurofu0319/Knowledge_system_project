import request from '@/utils/request'

// 获取通知公告列表
export function listNotices(query) {
  return request({
    url: '/system/notice/list',
    method: 'get',
    params: query
  })
}

// 获取通知公告详细信息
export function getNotice(noticeId) {
  return request({
    url: '/system/notice/' + noticeId,
    method: 'get'
  })
}

// 新增通知公告
export function addNotice(data) {
  return request({
    url: '/system/notice',
    method: 'post',
    data: data
  })
}

// 修改通知公告
export function updateNotice(data) {
  return request({
    url: '/system/notice',
    method: 'put',
    data: data
  })
}

// 删除通知公告
export function deleteNotice(noticeIds) {
  return request({
    url: '/system/notice/' + noticeIds,
    method: 'delete'
  })
}
