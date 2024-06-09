import upload from '@/utils/upload'
import request from '@/utils/request'

// 用户密码重置
export function updateUserPwd(oldPassword, newPassword) {
  const data = {
    oldPassword,
    newPassword
  }
  return request({
    url: '/system/user/profile/updatePwd',
    method: 'put',
    params: data
  })
}

// 查询用户个人信息
export function getUserProfile() {
  return request({
    url: '/system/user/profile',
    method: 'get'
  })
}

// 修改用户个人信息
export function updateUserProfile(data) {
  return request({
    url: '/system/user/profile',
    method: 'put',
    data: data
  })
}

// 用户头像上传
export function uploadAvatar(data) {
  return upload({
    url: '/system/user/profile/avatar',
    name: data.name,
    filePath: data.filePath
  })
}

// 调用 Ollama API 进行搜索
// export async function searchOllama(keyword) {
//   const response = await fetch('https://api.ollama.com/v1/search', {
//     method: 'POST',
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer YOUR_API_KEY' // 如果需要身份验证，替换为实际的API密钥
//     },
//     body: JSON.stringify({ prompt: keyword, model: 'llama2' }) // 根据 Ollama API 文档设置参数
//   });

//   if (!response.ok) {
//     throw new Error('搜索请求失败');
//   }

//   return response.json();
// }
