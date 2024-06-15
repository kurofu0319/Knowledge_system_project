import request from '@/utils/request'
import { saveAs } from 'file-saver'
import { getToken } from '@/utils/auth'

// 上传文件
export function uploadFile(formData) {
  return request({
    url: '/common/upload',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data',
      'Authorization': `Bearer ${getToken()}` // 需要传递token
    }
  })
}

// 下载文件
export function downloadFile(fileName) {
  return request({
    url: '/common/download',
    method: 'get',
    params: { fileName },
    responseType: 'blob',  // 需要将响应类型设置为blob
    headers: { 'Authorization': `Bearer ${getToken()}` }
  }).then((response) => {
    // 提取文件名
    const contentDisposition = response.headers['content-disposition'];
    let actualFileName = fileName;
    if (contentDisposition && contentDisposition.indexOf('attachment') !== -1) {
      const matches = contentDisposition.match(/filename="(.+)"/);
      if (matches && matches[1]) {
        actualFileName = decodeURIComponent(matches[1]);
      }
    }

    // 将blob转换为可下载的文件
    const blob = new Blob([response.data]);
    // 使用 file-saver 库保存文件
    saveAs(blob, actualFileName);
  }).catch((error) => {
    console.error('下载文件时出错：', error);
  });
}

// 下载资源文件
export function downloadResource(resource) {
  return request({
    url: '/common/download/resource',
    method: 'get',
    params: { resource },
    responseType: 'blob',  // 需要将响应类型设置为blob
    headers: { 'Authorization': `Bearer ${getToken()}` }
  }).then((response) => {
    // 提取文件名
    const contentDisposition = response.headers['content-disposition'];
    let actualFileName = resource;
    if (contentDisposition && contentDisposition.indexOf('attachment') !== -1) {
      const matches = contentDisposition.match(/filename="(.+)"/);
      if (matches && matches[1]) {
        actualFileName = decodeURIComponent(matches[1]);
      }
    }

    // 将blob转换为可下载的文件
    const blob = new Blob([response.data]);
    // 使用 file-saver 库保存文件
    saveAs(blob, actualFileName);
  }).catch((error) => {
    console.error('下载文件时出错：', error);
  });
}
