import request from '@/utils/request'

// 获取所有帖子
export function getAllPosts() {
  return request({
    url: '/forum/posts',
    method: 'get'
  })
}

// 获取指定帖子的详细信息
export function getPostById(postId) {
  return request({
    url: `/forum/post/${postId}`,
    method: 'get'
  })
}

// 创建新帖子
export function createPost(data) {
  return request({
    url: '/forum/post',
    method: 'post',
    data: data
  })
}

// 获取指定帖子的所有回复
export function getRepliesByPostId(postId) {
  return request({
    url: `/forum/replies/${postId}`,
    method: 'get'
  })
}

// 创建新回复
export function createReply(data) {
  return request({
    url: '/forum/reply',
    method: 'post',
    data: data
  })
}

// 删除帖子
export function deletePostById(id, userName) {
  return request({
    url: `/forum/post/${id}`,
    method: 'delete',
    params: { userName }
  });
}

// 点赞帖子
export function likePost(postId, userName) {
  return request({
    url: `/forum/post/${postId}/like`,
    method: 'post',
    params: { userName }
  });
}

// 取消点赞帖子
export function unlikePost(postId, userName) {
  return request({
    url: `/forum/post/${postId}/unlike`,
    method: 'delete',
    params: { userName }
  });
}

// 点赞回复
export function likeReply(replyId, userName) {
  return request({
    url: `/forum/reply/${replyId}/like`,
    method: 'post',
    params: { userName }
  });
}

// 取消点赞回复
export function unlikeReply(replyId, userName) {
  return request({
    url: `/forum/reply/${replyId}/unlike`,
    method: 'delete',
    params: { userName }
  });
}

// 获取用户的通知
export function getNotificationsByUserName(userName) {
  return request({
    url: `/forum/notifications/${userName}`,
    method: 'get'
  });
}

// 标记通知为已读
export function markNotificationAsRead(notificationId) {
  return request({
    url: `/forum/notification/${notificationId}/read`,
    method: 'post'
  });
}

// 删除回复
export function deleteReplyById(replyId) {
  return request({
    url: `/forum/reply/${replyId}`,
    method: 'delete'
  })
}

// 检查用户是否点赞帖子
export function checkUserLikeStatus(postId, userName) {
  return request({
    url: `/forum/post/${postId}/like-status`,
    method: 'get',
    params: { userName }
  })
}

// 检查用户是否点赞回复
export function checkUserReplyLikeStatus(replyId, userName) {
  return request({
    url: `/forum/reply/${replyId}/like-status`,
    method: 'get',
    params: { userName }
  })
}