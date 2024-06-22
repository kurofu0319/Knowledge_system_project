import request from '@/utils/request';
import { getToken } from '@/utils/auth';
import axios from 'axios';
// 保存文件信息方法
export function saveFileInfo(userName, fileName, fileUrl) {
  const data = {
    userName,
    fileName,
    fileUrl
  };
  
  return request({
    url: '/userfiles/save',
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + getToken()
    },
    data: data
  });
}

// 获取所有上传的文件方法
export function getAllFiles(userName) {
  return request({
    url: '/userfiles/all',
    method: 'get',
    headers: {
      Authorization: 'Bearer ' + getToken()
    },
    params: {
      userName
    }
  });
}

export function uploadnewFiles(userName) {
  return request({
    url: '/userfiles/upload',
    method: 'get',
    headers: {
      Authorization: 'Bearer ' + getToken()
    },
    params: {
      userName
    }
  });
}

	  export async function getFileFromUrl(url, fileName) {
	    try {
	      const response = await axios({
	        method: 'get',
	        url: url,
	        responseType: 'blob', // 确保返回的是 Blob 对象
	      });
	  
	      // 将 Blob 对象转换为 File 对象
	      const file = new File([response.data], fileName, {
	        type: response.data.type,
	      });
	      return file;
	    } catch (error) {
	      console.error('获取文件失败：', error);
	      throw error;
	    }
	  }
	  
	export function deleteFile(userName, fileName, fileUrl) {
	  const data = {
	    userName,
	    fileName,
	    fileUrl
	  };
	  
	  return request({
	    url: '/userfiles/delete',
	    method: 'post',
	    headers: {
	      'Content-Type': 'application/json',
	      Authorization: 'Bearer ' + getToken()
	    },
	    data: data
	  });
	}


