<template>
  <div class="post-detail-container">
    <div class="post-header">
      <h1 class="post-title">{{ post.title }}</h1>
      <div class="spacer"></div>
      <p class="post-content">{{ post.content }}</p>
      <div class="spacer"></div>
      <div class="post-user-container">
        <span class="post-user">{{ post.userName }} - {{ post.postTime }}</span>
        &nbsp;
        <span class="post-likes">Likes: {{ post.likes }}</span>
        <button @click="toggleLikePost" class="like-btn">{{ likedPost ? 'Unlike' : 'Like' }}</button>
      </div>
    </div>
    <button @click="deletePost" v-if="post.userName === $store.state.user.name" class="delete-post-btn">删除帖子</button>
    <div class="replies">
      <div class="reply-item" v-for="reply in replies" :key="reply.id">
        <p class="reply-content">{{ reply.content }}</p>
        <div class="spacer"></div>
        <div class="reply-user-container">
          <span class="reply-user">{{ reply.userName }} - {{ reply.replyTime }}</span>
          <span class="reply-likes">Likes: {{ reply.likes }}</span>
          <button @click="toggleLikeReply(reply)" class="like-reply-btn">{{ likedReplies.includes(reply.id) ? 'Unlike' : 'Like' }}</button>
          <span @click="deleteReply(reply.id)" v-if="reply.userName === $store.state.user.name" class="delete-reply-text">Delete</span>
        </div>
        <div v-if="reply.fileUrl" class="reply-file">
          <a href="#" @click="downloadFile(reply.fileUrl, reply.fileName)">{{ reply.fileName }}</a>
        </div>
      </div>
    </div>
    <textarea v-model="newReplyContent" placeholder="填写回复"></textarea>
    <el-upload
      ref="upload"
      :limit="1"
      accept=".jpg,.png,.pdf,.docx"
      :file-list="upload.fileList"
      :action="upload.url"
      :headers="upload.headers"
      :on-change="handleFileChange"
      :on-success="handleFileSuccess"
      :on-progress="handleFileUploadProgress"
      :auto-upload="false"
      class="upload-container"
    >
      <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
      <el-button style="margin-left: 10px;" size="small" type="success" :loading="upload.isUploading" @click="submitUpload">上传文件</el-button>
    </el-upload>
    <button @click="addReply" class="submit-btn">提交回复</button>
  </div>
</template>

<script>
import { getPostById, getRepliesByPostId, createReply, deletePostById, deleteReplyById, likePost, unlikePost, likeReply, unlikeReply, checkUserLikeStatus, checkUserReplyLikeStatus } from '@/api/forum'
import { getToken } from '@/utils/auth'
import { formatDateTime } from '@/api/OllamaApi.js'
import uploadFile from '@/utils/upload'
import axios from 'axios';
import { saveAs } from 'file-saver';

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
        url: '/common/upload', // 上传的 URL
        headers: {
          Authorization: "Bearer " + getToken()
        }
      },
      fileUrl: null,
      fileName: null
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
      if (this.upload.fileList.length === 0) {
        this.$message.warning('请先选择文件')
        return
      }

      const file = this.upload.fileList[0].raw
      const config = {
        url: this.upload.url,
        file: file,
        name: 'file',
        headers: this.upload.headers,
        formData: {}
      }

      this.upload.isUploading = true

      uploadFile(config)
        .then(response => {
			console.log(response)
          this.upload.isUploading = false
          this.$message.success('文件上传成功')
          this.fileUrl = response.url
          this.fileName = response.originalFilename
          this.upload.fileList = [{
            name: response.originalFilename,
            url: response.url
          }]
        })
        .catch(error => {
          this.upload.isUploading = false
          this.$message.error('文件上传失败')
          console.error('上传失败的错误:', error)
        })
    },
    handleFileUploadProgress(event, file, fileList) {
      console.log('上传进度:', event.percent)
    },
    handleFileChange(file, fileList) {
      this.upload.fileList = fileList
    },
    handleFileSuccess(response, file, fileList) {
      console.log('上传成功:', response)
    },
    async downloadFile(fileUrl, fileName) {
      var url = `http://localhost:8080/common/download?fileName=${encodeURIComponent(fileName)}&delete=false`
      try {
        const response = await axios({
          method: 'get',
          url: fileUrl,
          responseType: 'blob',
          headers: { 'Authorization': `Bearer ${getToken()}` }
        });

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
      } catch (error) {
        console.error('下载文件时出错：', error);
      }
    }
  },

  created() {
    this.fetchPostAndReplies()
  }
}
</script>

<style lang="scss">
.post-detail-container {
  padding: 20px;
}

.post-header {
  background-color: #f9f9f9;
  padding: 15px;
  border-radius: 5px;
  margin-bottom: 20px;
}

.post-title {
  font-size: 24px;
  font-weight: bold;
  word-break: break-word;
}

.post-content {
  font-size: 18px;
  white-space: pre-wrap;
  word-break: break-word;
}

.post-user-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.post-user {
  font-size: 14px;
  color: #666;
}

.post-likes {
  font-size: 14px;
  color: #666;
}

.like-btn {
  background-color: #007bff;
  color: white;
  padding: 5px;
  border-radius: 5px;
  font-size: 12px;
  cursor: pointer;
  margin-left: 10px;
}

.replies {
  margin-top: 20px;
}

.reply-item {
  padding: 10px;
  border-bottom: 1px solid #ccc;
}

.reply-content {
  font-size: 16px;
  white-space: pre-wrap;
  word-break: break-word;
}

.reply-user-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.reply-user {
  font-size: 14px;
  color: #666;
}

.reply-likes {
  font-size: 14px;
  padding-left: 10px;
  color: #666;
}

.like-reply-btn {
  background-color: #007bff;
  color: white;
  padding: 5px;
  border-radius: 5px;
  font-size: 12px;
  cursor: pointer;
  margin-left: 10px;
}

textarea {
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.submit-btn, .delete-post-btn {
  background-color: #007bff;
  color: white;
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
  border: none;
}

.delete-reply-text {
  color: #ff0000;
  cursor: pointer;
  font-size: 14px;
  text-decoration: underline;
}

.spacer {
  height: 10px;
}

.upload-container {
  margin-bottom: 20px;
}

.post-likes {
  padding-left: 10px;
}

.reply-file {
  margin-top: 10px;
}
</style>
