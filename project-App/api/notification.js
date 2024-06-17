import request from '@/utils/request'

// 获取用户的通知列表
export function listNotifications(userName) {
  return request({
    url: '/system/notification/list',
    method: 'get',
    params: { userName }
  })
}

// 标记通知为已读
export function markNotificationAsRead(notificationId) {
  return request({
    url: `/system/notification/read/${notificationId}`,
    method: 'post'
  })
}

// 删除通知
export function deleteNotification(notificationId) {
  return request({
    url: `/system/notification/${notificationId}`,
    method: 'delete'
  })
}
