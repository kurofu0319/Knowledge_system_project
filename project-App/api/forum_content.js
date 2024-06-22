import request from '@/utils/request'
import { getToken } from '@/utils/auth';

// 保存文件信息方法
export function saveFileInfo(fileName, fileUrl) {
  const data = {
    fileName,
    fileUrl
  }
  return request({
    url: '/forumContent/files/save',
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + getToken()
    },
    data: data
  })
}

// 获取所有上传的文件方法
export function getAllFiles() {
  return request({
    url: '/forumContent/files/all',
    method: 'get',
    headers: {
      Authorization: 'Bearer ' + getToken()
    }
  })
}

export function uploadnewFiles() {
  return request({
    url: '/forumContent/files/upload',
    method: 'get',
    headers: {
      Authorization: 'Bearer ' + getToken()
    }
  })
}

export function deleteFile(fileUrl, fileName) {
  const data = {
    fileName,
    fileUrl
  }
  return request({
    url: '/forumContent/files/delete',
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + getToken()
    },
    data: data
  })
}
