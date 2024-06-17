import request from '@/utils/request'

// 获取用户列表
export function listUsers(query) {
  return request({
    url: '/system/user/list',
    method: 'get',
    params: query
  })
}

// 获取用户详细信息
export function getUser(userId) {
  return request({
    url: '/system/user/' + userId,
    method: 'get'
  })
}

// 新增用户
export function addUser(data) {
  return request({
    url: '/system/user',
    method: 'post',
    data: data
  })
}

// 修改用户
export function updateUser(data) {
  return request({
    url: '/system/user',
    method: 'put',
    data: data
  })
}

// 删除用户
export function deleteUser(userIds) {
  return request({
    url: '/system/user/' + userIds,
    method: 'delete'
  })
}

// 重置密码
export function resetUserPwd(data) {
  return request({
    url: '/system/user/resetPwd',
    method: 'put',
    data: data
  })
}

// 修改用户状态
export function changeUserStatus(data) {
  return request({
    url: '/system/user/changeStatus',
    method: 'put',
    data: data
  })
}

// 获取用户授权角色
export function getUserRoles(userId) {
  return request({
    url: '/system/user/authRole/' + userId,
    method: 'get'
  })
}

// 用户授权角色
export function setUserRoles(data) {
  return request({
    url: '/system/user/authRole',
    method: 'put',
    data: data
  })
}
