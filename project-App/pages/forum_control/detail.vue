<template>
  <div class="uploaded-files-container">
	<div class="title">
		<h1>上传的文件列表</h1>
		<uni-button class = "update-button" @click="updateDatabase()" type="primary">更新知识库</uni-button>
    </div>
	<table>
      <thead>
        <tr>
          <th>文件名</th>
          <th>上传日期</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="file in uploadedFiles" :key="file.id">
          <td>{{ file.fileName }}</td>
          <td>{{ file.uploadDate }}</td>
          <td class="action-buttons">
            <button class="download-btn" @click="downloadFile(file.fileUrl, file.fileName)">
              <i class="fas fa-download"></i>
            </button>
            <button class="delete-btn" @click="deleteFile(file.fileUrl, file.fileName)">
              <i class="fas fa-trash-alt"></i>
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { getAllFiles, deleteFile, uploadnewFiles } from '@/api/forum_content';
import { getFileFromUrl } from '@/api/userFile';
import { uploadDocument } from '@/api/ragDemo'
import axios from 'axios';
import config from '@/config.js';

const baseUrl = config.baseUrl;

export default {
  data() {
    return {
      uploadedFiles: []
    };
  },
  methods: {
	  deleteFile(url, fileName) {
		  deleteFile(url, fileName).then(response => {
			  this.fetchUploadedFiles();
		  });
	  },
    fetchUploadedFiles() {
      getAllFiles().then(response => {
		console.log(response)
        this.uploadedFiles = response;
      }).catch(error => {
        console.error("Failed to fetch uploaded files:", error);
      });
    },
    downloadFile(url, fileName) {
      const urlObj = new URL(url);
      const newPath = baseUrl + urlObj.pathname + urlObj.search + urlObj.hash;
      console.log(newPath);

      if (typeof plus === 'undefined') {
        axios({
          method: 'get',
          url: newPath,
          responseType: 'blob'
        }).then(response => {
          const link = document.createElement('a');
          link.href = URL.createObjectURL(response.data);
          link.download = fileName || 'file';
          link.style.display = 'none';
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
          URL.revokeObjectURL(link.href);

          uni.showToast({
            title: '下载成功',
            icon: 'success'
          });
          console.log('文件已下载并保存');
        }).catch(error => {
          uni.showToast({
            title: '下载失败',
            icon: 'none'
          });
          console.error('下载文件失败：', error);
        });
      } else {
        this.plusDownloadFile(newPath, fileName);
      }
    },
    plusDownloadFile(url, fileName) {
      uni.showLoading({
        title: '下载中'
      });

      let dtask = plus.downloader.createDownload(url, {
        filename: "file://storage/emulated/0/" + "project-App/" + (fileName || 'file')
      }, (d, status) => {
        uni.hideLoading();
        if (status == 200) {
          uni.showToast({
            title: '下载成功',
            icon: 'success'
          });
          console.log('文件存储路径：' + d.filename);
        } else {
          uni.showToast({
            title: '下载失败，请稍后重试',
            icon: 'none'
          });
          console.error('下载文件失败：', status);
          plus.downloader.clear();
        }
      });

      dtask.start();
    },
	async updateDatabase() {
		
		getAllFiles().then(response => {
				console.log(response)
		  this.uploadedFiles = response;
		}).catch(error => {
		  console.error("Failed to fetch uploaded files:", error);
		});
		
	  const files = this.uploadedFiles;
	  
	  // 使用 Promise.all 以便等待所有文件处理和上传完成
	  const uploadPromises = files.map(async (file) => {
	    try {
		  if (file.has_upload === false) {
			  
			  const urlObj = new URL(file.fileUrl);
			  const newPath = baseUrl + urlObj.pathname + urlObj.search + urlObj.hash;
			  const realFile = await getFileFromUrl(newPath, file.fileName);
			  console.log('Real file:', realFile);
			  const response = await uploadDocument(realFile);
			  console.log('Upload response:', response);
		  }
	    } catch (error) {
	      console.error('Error processing file:', file.fileName, error);
	    }
	  });
	
	  // 等待所有上传操作完成
	  await Promise.all(uploadPromises);
	  uni.showToast({
	    title: '更新成功',
	    icon: 'success'
	  });
	  console.log('所有文件处理和上传完成');
	  
	  uploadnewFiles();
	}
  },

  mounted() {
    this.fetchUploadedFiles();
  }
}
</script>

<style scoped>
.update-button {
	
	position: absolute;/*或relative*/ 
	top: 20px;
	left: 60%;
}	
	
.title	 {
	display: flex;
}

.uploaded-files-container {
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

th {
  background-color: #f2f2f2;
}


.download-btn i {
  color: royalblue;
}

.delete-btn {
  background-color: #ff4d4f;
}

.delete-btn i {
  color: white;
}

</style>
