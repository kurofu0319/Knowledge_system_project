<template>
  <div class="post-detail-container">
    <div class="post-header">
      <h1 class="post-title">{{ post.title }}</h1>
      <div class="delete-post-btn" @click="deletePost" v-if="post.userName === $store.state.user.name">
        <i class="fas fa-trash-alt"></i>
      </div>
      <div class="spacer"></div>
      <p class="post-content">{{ post.content }}</p>
      <div class="spacer"></div>
      <div class="post-user-container">
        <span class="post-user" @click="navigateToUserInfo(post.userId)">{{ post.userName }} - {{ post.postTime }}</span>
        <span class="post-likes">
          <i :class="['fas', 'fa-heart', { liked: likedPost }]" @click="toggleLikePost"></i>
          <span class="like-count">{{ post.likes }}</span>
        </span>
      </div>
      <hr class="post-reply-divider"/>
    </div>
    <div class="replies">
      <div class="reply-item" v-for="reply in replies" :key="reply.id">
        <div class="delete-reply-btn" @click="deleteReply(reply.id)" v-if="reply.userName === $store.state.user.name">
          <i class="fas fa-trash-alt"></i>
        </div>
        <p class="reply-content">{{ reply.content }}</p>
        <div class="spacer"></div>
        <div class="reply-user-container">
          <span class="reply-user" @click="navigateToUserInfo(reply.userId)">{{ reply.userName }} - {{ reply.replyTime }}</span>
          <span class="reply-likes">
            <i :class="['fas', 'fa-heart', { liked: likedReplies.includes(reply.id) }]" @click="toggleLikeReply(reply)"></i>
            <span class="like-count">{{ reply.likes }}</span>
          </span>
        </div>
        <div v-if="reply.fileUrl" class="reply-file">
          <a href="#" @click="downloadFile(reply.fileUrl, reply.fileName)">{{ reply.fileName }}</a>
        </div>
        <hr class="reply-divider"/>
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
import uploadFile from '@/utils/uploadFiles'
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
      console.log('上传成功的响应:', response)
    },
    downloadFile(url, fileName) {
      axios({
        method: 'get',
        url: url,
        responseType: 'blob'
      }).then(response => {
        saveAs(response.data, fileName)
      }).catch(error => {
        console.error('下载文件失败:', error)
      })
    },
    navigateToUserInfo(userId) {
      this.$router.push(`/pages/mine/info/index?userId=${userId}`)
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
  position: relative;
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
}

.post-user, .reply-user {
  font-size: 0.9em;
  color: #666;
  cursor: pointer; /* 增加点击手型指针 */
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
  position: absolute;
  top: 5px;
  right: 10px; /* 调整位置 */
  color: #1E90FF;
  cursor: pointer;
  font-size: 1em; /* 调整大小 */
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
