<template>
  <div class="post-detail-container">
    <div class="post-header">
      <h1 class="post-title">{{ post.title }}</h1>
      <div class="spacer"></div>
      <p class="post-content">{{ post.content }}</p>
      <div class="spacer"></div>
      <div class="post-user-container">
        <span class="post-user" @click="navigateToUserInfo(post.userId)">{{ post.userName }} - {{ post.postTime }}</span>
        <div class="post-actions">
          <span class="post-likes">
            <i :class="['fas', 'fa-heart', { liked: likedPost }]" @click="toggleLikePost"></i>
            <span class="like-count">{{ post.likes }}</span>
          </span>
          <div class="delete-post-btn" @click="deletePost" v-if="post.userName === $store.state.user.name">
            <i class="fas fa-trash-alt"></i>
          </div>
        </div>
      </div>
      <hr class="post-reply-divider"/>
    </div>
    <div class="replies">
      <div class="reply-item" v-for="reply in sortedReplies" :key="reply.id">
        <p class="reply-content">{{ reply.content }}</p>
        <div class="spacer"></div>
        <div class="reply-user-container">
          <span class="reply-user" @click="navigateToUserInfo(reply.userId)">{{ reply.userName }} - {{ reply.replyTime }}</span>
          <div class="reply-actions">
            <span class="reply-likes">
              <i :class="['fas', 'fa-heart', { liked: likedReplies.includes(reply.id) }]" @click="toggleLikeReply(reply)"></i>
              <span class="like-count">{{ reply.likes }}</span>
            </span>
            <div class="delete-reply-btn" @click="deleteReply(reply.id)" v-if="reply.userName === $store.state.user.name">
              <i class="fas fa-trash-alt"></i>
            </div>
          </div>
        </div>
        <div v-if="reply.fileUrl" class="reply-file">
          <a href="#" @click="downloadFile(reply.fileUrl, reply.fileName)">{{ reply.fileName }}</a>
        </div>
        <hr class="reply-divider"/>
      </div>
    </div>
    <textarea v-model="newReplyContent" placeholder="填写回复"></textarea>
    <div class="upload-container">
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
        <button>点击上传</button>
      </uni-file-picker>
    </div>
    <uni-button @click="submitUpload" type="primary" :loading="upload.isUploading">上传文件</uni-button>
    <button @click="addReply" class="submit-btn">提交回复</button>
  </div>
</template>

<script>
import { getPostById, getRepliesByPostId, createReply, deletePostById, deleteReplyById, likePost, unlikePost, likeReply, unlikeReply, checkUserLikeStatus, checkUserReplyLikeStatus } from '@/api/forum'
import { getToken } from '@/utils/auth'
import { formatDateTime } from '@/api/OllamaApi.js'
import axios from 'axios';
import config from '@/config.js';

const baseUrl = config.baseUrl;

export default {
  data() {
    return {
      post: {},
      replies: [],
      newReplyContent: '',
      likedPost: false,
      likedReplies: [],
      upload: {
        isUploading: false,
        fileList: [],
        url: baseUrl + '/common/upload', // 自定义上传的 URL
        headers: {
          Authorization: "Bearer " + getToken()
        }
      },
      fileUrl: null,
      fileName: null,
      fileList: [],
      listStyles: {
        "borderStyle": {
          "width": "0", // 边框宽度
        },
        "border": false, // 是否显示边框
        "dividline": false
      }
    }
  },
  computed: {
    sortedReplies() {
      return this.replies.sort((a, b) => b.likes - a.likes);
    }
  },
  methods: {
    addReply() {
      const replyData = {
        postId: this.post.id,
        userName: this.$store.state.user.name,
        content: this.newReplyContent,
        replyTime: formatDateTime(new Date()),
        fileUrl: this.fileUrl,
        fileName: this.fileName
      }
      createReply(replyData).then(() => {
        this.newReplyContent = ''
        this.upload.fileList = []
        this.fileUrl = null
        this.fileName = null
        this.fetchReplies()
      }).catch(error => {
        console.error("Failed to create reply:", error)
      })
    },
    deletePost() {
      if (confirm("确定删除帖子？")) {
        deletePostById(this.post.id, this.$store.state.user.name).then(() => {
          this.$router.push('/pages/Forum/index')
        }).catch(error => {
          console.error("Failed to delete post:", error)
        })
      }
    },
    deleteReply(replyId) {
      if (confirm("确定删除回复？")) {
        deleteReplyById(replyId).then(() => {
          this.fetchReplies()
        }).catch(error => {
          console.error("Failed to delete reply:", error)
        })
      }
    },
    toggleLikePost() {
      if (this.likedPost) {
        unlikePost(this.post.id, this.$store.state.user.name).then(() => {
          this.likedPost = false
          this.fetchPost()
        }).catch(error => {
          console.error("Error unliking post:", error)
        })
      } else {
        likePost(this.post.id, this.$store.state.user.name).then(() => {
          this.likedPost = true
          this.fetchPost()
        }).catch(error => {
          console.error("Error liking post:", error)
        })
      }
    },
    toggleLikeReply(reply) {
      if (this.likedReplies.includes(reply.id)) {
        unlikeReply(reply.id, this.$store.state.user.name).then(() => {
          this.likedReplies = this.likedReplies.filter(id => id !== reply.id)
          this.fetchReplies()
        }).catch(error => {
          console.error("Error unliking reply:", error)
        })
      } else {
        likeReply(reply.id, this.$store.state.user.name).then(() => {
          this.likedReplies.push(reply.id)
          this.fetchReplies()
        }).catch(error => {
          console.error("Error liking reply:", error)
        })
      }
    },
    fetchPost() {
      const postId = this.$route.query.postId
      getPostById(postId).then(response => {
        this.post = response.data
        this.checkUserLikeStatus(postId)
      }).catch(error => {
        console.error("Failed to fetch post:", error)
      })
    },
    fetchReplies() {
      const postId = this.$route.query.postId
      getRepliesByPostId(postId).then(response => {
        this.replies = response.data
        this.checkUserReplyLikeStatus()
      }).catch(error => {
        console.error("Failed to fetch replies:", error)
      })
    },
    fetchPostAndReplies() {
      this.fetchPost()
      this.fetchReplies()
    },
    checkUserLikeStatus(postId) {
      const userName = this.$store.state.user.name
      checkUserLikeStatus(postId, userName).then(response => {
        this.likedPost = response.liked
      }).catch(error => {
        console.error("Failed to check user like status:", error)
      })
    },
    checkUserReplyLikeStatus() {
      const userName = this.$store.state.user.name
      Promise.all(this.replies.map(reply => 
        checkUserReplyLikeStatus(reply.id, userName).then(response => {
          if (response.liked) {
            this.likedReplies.push(reply.id)
          }
        })
      )).catch(error => {
        console.error("Failed to check user reply like status:", error)
      })
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
        }).catch(error => {
          uni.showToast({
            title: '文件上传失败',
            icon: 'none'
          });
          this.uploadFail(error);
        });
      });
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
downloadFile(url, fileName) {
    // 在H5环境中
	const urlObj = new URL(url);
	const newPath = baseUrl + urlObj.pathname + urlObj.search + urlObj.hash;
	console.log(url)
	console.log(newPath)
    if (typeof plus === 'undefined') {
      axios({
        method: 'get',
        url: newPath,
        responseType: 'blob'
      }).then(response => {
        const link = document.createElement('a');
        link.href = URL.createObjectURL(response.data);
        link.download = fileName || 'file'; // 使用提供的文件名或默认为'file'
        link.style.display = 'none';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(link.href); // 释放URL

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
    } else { // 在App环境中
      this.plusDownloadFile(newPath, fileName);
    }
  },
  plusDownloadFile(url, fileName) {
    uni.showLoading({
      title: '下载中'
    });

    let dtask = plus.downloader.createDownload(url, {
      filename: "file://storage/emulated/0/" + "project-App/" + (fileName || 'file') // 保存路径，重命名文件
    }, (d, status) => {
      uni.hideLoading();
      if (status == 200) {
        uni.showToast({
          title: '下载成功',
          icon: 'success'
        });
        console.log('文件存储路径：' + d.filename);
        // 可选：打开文件
        // plus.runtime.openFile(d.filename, {}, (e) => {
        //   console.log('打开文件成功');
        // }, (e) => {
        //   console.log('打开文件失败：' + e.message);
        // });
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

    navigateToUserInfo(userId) {
      this.$tab.redirectTo(`/pages/mine/info/index?userId=${userId}`)
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
    }
  },
  mounted() {
    this.fetchPostAndReplies()
  }
}
</script>

<style scoped>
.post-detail-container {
  margin: 20px;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
  background-color: #fff;
}

.post-header {
  margin-bottom: 20px;
}

.post-title {
  font-size: 1.6em;
  font-weight: bold;
  margin-bottom: 10px;
}

.spacer {
  height: 10px;
}

.post-content {
  margin-bottom: 10px;
}

.post-user-container, .reply-user-container {
  display: flex;
  align-items: center;
  justify-content: space-between; /* Align items to the ends */
}

.post-user, .reply-user {
  font-size: 0.9em;
  color: #666;
  cursor: pointer; /* 增加点击手型指针 */
}

.post-actions, .reply-actions {
  display: flex;
  align-items: center;
}

.post-likes, .reply-likes {
  margin-left: 10px; /* 调整位置 */
  display: flex;
  align-items: center;
}

.post-likes i, .reply-likes i {
  cursor: pointer;
  font-size: 1em; /* 调整大小 */
  margin-left: 5px;
}

.like-count {
  margin-left: 10px; /* 增大距离 */
}

.liked {
  color: red;
}

.delete-post-btn, .delete-reply-btn {
  color: #1E90FF;
  cursor: pointer;
  font-size: 1em; /* 调整大小 */
  margin-left: 10px; /* 增大距离 */
}

.reply-item {
  position: relative;
}

.post-reply-divider {
  border: 1px solid black;
  margin: 10px 0;
}

.reply-divider {
  border: 1px solid grey;
  margin: 10px 0;
}

textarea {
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
  font-size: 1em;
}

.submit-btn {
  padding: 10px 20px;
  border: none;
  background-color: green;
  color: white;
  border-radius: 5px;
  cursor: pointer;
}

.upload-container {
  margin-bottom: 10px;
}

.reply-file a {
  font-size: 0.8em; /* 调整文件链接字体大小 */
}
</style>
