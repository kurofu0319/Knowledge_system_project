<template>
  <div class="knowledge-base-container">
	<div class="title">
		<h1>个人知识库</h1>
		<uni-button class = "update-button" @click="updateDatabase" type="primary">更新</uni-button>
	</div>
    <div class="upload-section">
      <uni-file-picker 
        ref="files"
        v-model="fileList"
        :auto-upload="false"
        file-mediatype="all"
        @select="selectUpload"
        @progress="handleFileUploadProgress"
        @success="uploadSuccess"
        @fail="uploadFail"
        :list-styles="listStyles"
      >
        <uni-button >选择文件路径</uni-button>
      </uni-file-picker>
      <uni-button @click="submitUpload" type="primary" :loading="upload.isUploading">上传</uni-button>
    </div>
    <div class="search-section">
      <input v-model="searchQuery" @input="searchFiles" class="search-input" placeholder="按名称搜索文件" />
    </div>
    <div class="file-list">
      <table>
        <thead>
          <tr>
            <th class="file-name">文件名</th>
            <th class="update-date">上传日期</th>
            <th class="action-column">操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="file in filteredFiles" :key="file.id">
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
	
	<!-- 搜索框 -->
	  <view class="search-title">高级搜索</view>
	  <view class="search-section">
	    <input v-model="searchKeyword" class="search-input" type="text" placeholder="请输入搜索内容" maxlength="30" />
	    <button :disabled="loading" @click="handleSearch" :class="['search-btn', loading ? 'disabled' : '']">搜索</button>
	  </view>
	  
	  <!-- 显示答案 -->
	  <view v-if="searchResult" class="answer-section">
	    <text class="answer-content">{{ searchResult }}</text>
	  </view>
	</view>
  </div>
</template>



<script>
import axios from 'axios';
import { saveFileInfo, getAllFiles, uploadnewFiles, getFileFromUrl, deleteFile } from '@/api/userFile';
import config from '@/config.js';
import { getToken } from '@/utils/auth';
import { uploadDocument, chatWithDocument } from '@/api/ragDemo'
import { getInfo } from '@/api/login';
import {  saveSearchHistory } from '@/api/OllamaApi';

const baseUrl = config.baseUrl;

export default {
  data() {
    return {
      fileList: [],
	  searchKeyword: '',
	  searchResult: '',
	  loading: false,
      upload: {
        isUploading: false,
        fileList: [],
        url: baseUrl + '/common/upload', // 自定义上传的 URL
        headers: {
          Authorization: "Bearer " + getToken()
        }
      },
	  uploadedFiles: [],
      searchQuery: '',
	  listStyles: {
	    "borderStyle": {
	      "width": "0", // 边框宽度
	    },
	    "border": false, // 是否显示边框
	    "dividline": false
	  },
      userName: this.$store.state.user.name
    };
  },
  computed: {
    filteredFiles() {
      if (this.searchQuery.trim() === '') {
        return this.uploadedFiles;
      }
      return this.uploadedFiles.filter(file =>
        file.fileName.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
    }
  },
  methods: { 
	  deleteFile(url, fileName) {
		  deleteFile(this.userName, fileName, url).then(response => {
			  this.fetchUploadedFiles();
		  });
	  },
	  
	  async handleSearch() {
	    if (this.searchKeyword === "") {
	      this.$modal.msgError("请输入搜索内容");
	      return;
	    }
	  
	    const currentKeyword = this.searchKeyword;
	    this.searchKeyword = '';
	    this.loading = true;
	  
	    try {
	      const result = await chatWithDocument(currentKeyword);
	      console.log(result);
	  
	      // 将搜索结果存储到searchResult中
	      this.searchResult = result.data;
	  
	      const userInfo = await getInfo();
	      const userName = userInfo.user.userName;
	      await saveSearchHistory(userName, currentKeyword, result.response);
	    } catch (error) {
	      console.error('搜索请求失败:', error);
	      this.$modal.msgError("搜索请求失败");
	    }
	  
	    this.loading = false;
	  },

    async updateDatabase() {
		
		getAllFiles(this.userName).then(response => {
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
			  const realFile = await getFileFromUrl(file.fileUrl, file.fileName);
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
      console.log('所有文件处理和上传完成');
	  
	  uploadnewFiles(this.userName);
    },
  
	
    handleFileSelect(files) {
      this.fileList = files;
    },
	handleFileUploadProgress(event) {
	  console.log('上传进度:', event)
	},
	handleFileChange(event) {
	  this.upload.fileList = event.tempFiles;
	},
	handleFileSuccess(event) {
	  console.log('上传成功的响应:', event)
	},
	selectUpload(e) {
	  console.log('选择文件：', e)
	  this.upload.fileList = e.tempFiles;
	},
	uploadSuccess(e) {
	  console.log('上传成功', e);
	  this.fileUrl = e.data.url; // 假设服务器返回的URL在response.data.url中
	  this.fileName = e.data.originalFilename; // 假设服务器返回的原始文件名在response.data.originalFilename中
	},
	uploadFail(e) {
	  console.log('上传失败：', e);
	},
	submitUpload() {
	  const files = this.upload.fileList;
	  if (files.length === 0) {
	    uni.showToast({
	      title: '请先选择文件',
	      icon: 'none'
	    });
	    return;
	  }
	
	  files.forEach(file => {
	    const formData = new FormData();
	    formData.append('file', file.file);
	    formData.append('name', file.name);
	    
	    axios.post(this.upload.url, formData, {
	      headers: this.upload.headers
	    }).then(response => {
	      uni.showToast({
	        title: '文件上传成功',
	        icon: 'success'
	      });
			  this.uploadSuccess(response);
			  const fileUrl = response.data.url;
			  console.log(this.userName)
			  saveFileInfo(this.userName, file.name, fileUrl).then(() => {
			  alert('文件上传并保存成功');
			  this.fetchUploadedFiles();
		  });
	    }).catch(error => {
	      uni.showToast({
	        title: '文件上传失败',
	        icon: 'none'
	      });
	      this.uploadFail(error);
	    });
	  });
	  
	   
	},
   //  uploadFile() {
   //    if (this.fileList.length === 0) {
   //      alert('请先选择一个文件');
   //      return;
   //    }
   //    const file = this.fileList[0];
	  // console.log(file)
   //    const formData = new FormData();
   //    formData.append('file', file.file);
	  // formData.append('file', file.name);

   //    axios.post(baseUrl + '/common/upload', formData, {
   //      headers: {
   //        Authorization: "Bearer " + getToken(),
   //        'Content-Type': 'multipart/form-data'
   //      }
   //    }).then(response => {
   //      const fileUrl = response.data.url;
   //      saveFileInfo(this.userName, file.name, fileUrl).then(() => {
   //        alert('文件上传并保存成功');
   //        this.fetchUploadedFiles();
   //        this.fileList = [];
   //      }).catch(error => {
   //        console.error('Failed to save file URL:', error);
   //      });
   //    }).catch(error => {
   //      console.error('File upload failed:', error);
   //    });
   //  },
    fetchUploadedFiles() {
      getAllFiles(this.userName).then(response => {
		console.log(response)
        this.uploadedFiles = response;
      }).catch(error => {
        console.error("Failed to fetch uploaded files:", error);
      });
    },
    downloadFile(url, fileName) {
      const urlObj = new URL(url);
      const newPath = baseUrl + urlObj.pathname + urlObj.search + urlObj.hash;

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

          alert('下载成功');
        }).catch(error => {
          alert('下载失败');
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
          alert('下载成功');
          console.log('文件存储路径：' + d.filename);
        } else {
          alert('下载失败，请稍后重试');
          console.error('下载文件失败：', status);
          plus.downloader.clear();
        }
      });

      dtask.start();
    },
    searchFiles() {
      // This method is used to trigger the computed property filteredFiles
    },
    uploadSuccess(response) {
      console.log('上传成功', response);
    },
    uploadFail(error) {
      console.log('上传失败', error);
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
	left: 80.5%;
}

	
.title	 {
	display: flex;
}
	
.knowledge-base-container {
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
}

.upload-section,
.search-section {
  margin-bottom: 20px;
  display: flex;
  justify-content: center;
  gap: 10px;
}

.file-list {
  margin-top: 20px;
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

.file-name{
  width: 150px; /* 增加操作列的宽度 */
}

.update-date{
  width: 150px; /* 增加操作列的宽度 */
}

.action-column {
  width: 150px; /* 增加操作列的宽度 */
}

.action-buttons {
  display: flex;
  justify-content: space-between;
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

.search-title {
  align-self: flex-start;
  font-size: 18px; /* 调整字体大小 */
  font-weight: bold;
  margin-top: 20px;
}

.search-section {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
  width: 95%;
  border: 1px solid #ccc; /* 增加边框 */
  border-radius: 5px; /* 圆角 */
  padding: 10px; /* 内边距 */
}

.search-input {
  flex: 1;
  height: 45px;
  border: 1px solid #ccc;
  border-radius: 20px;
  padding: 0 15px;
  margin-right: 10px;
  font-size: 16px;
}

.search-btn {
  height: 45px;
  padding: 0 20px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 20px;
  cursor: pointer;
}

.search-btn.disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.answer-section {
  margin-top: 20px;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  width: 100%;
  background-color: #f9f9f9;
}

.answer-content {
  font-size: 16px;
}
</style>
