<template>
  <div class="admin-forum-container">
    <h1>论坛管理</h1>
	
    <div class="filter-options">
      <select v-model="filterDays" @change="filterPosts">
        <option value="0">全部</option>
        <option value="3">三天内</option>
        <option value="7">一周内</option>
        <option value="30">一个月内</option>
      </select>
    </div>
    <div class="post-list">
      <div v-for="post in filteredPosts" :key="post.id" class="post-item">
        <div class="post-header">
          <span @click="toggleReplies(post.id)" class="toggle-btn">
            {{ post.showReplies ? '▼' : '▶' }}
          </span>
          <span 
            @click="togglePostSelection(post)" 
            :class="{'selected': post.selected}" 
            class="post-content"
          >
            {{ post.content }}
          </span>
          <span @click="deletePost(post.id)" class="delete-text">删除</span>
        </div>
        <div v-if="post.showReplies" class="replies">
          <div v-for="reply in post.replies" :key="reply.id" class="reply-item">
            <span 
              @click="toggleReplySelection(post, reply)" 
              :class="{'selected': reply.selected}" 
              class="reply-content"
            >
              {{ reply.content }}
            </span>
            <span @click="deleteReply(reply.id)" class="delete-text">删除</span>
          </div>
        </div>
      </div>
    </div>
    <button @click="generateAndUploadTxt">生成并上传TXT</button>
	<button @click="navigateToDetail"> 查看已上传 </button>
  </div>
</template>






<script>
import { getAllPosts, getRepliesByPostId, deletePostById, deleteReplyById } from '@/api/forum';
import axios from 'axios';
import config from '@/config.js';
import { getToken } from '@/utils/auth';
import { saveFileInfo } from '../../api/forum_content';

const baseUrl = config.baseUrl;

export default {
  data() {
    return {
      posts: [],
      filterDays: 0, // 默认显示全部
      filteredPosts: []
    };
  },
  methods: {
    fetchPosts() {
      getAllPosts().then(response => {
        this.posts = response.data.map(post => ({
          ...post,
          showReplies: false,
          selected: false,
          replies: []
        }));
        this.filterPosts(); // 过滤帖子
      }).catch(error => {
        console.error("Failed to fetch posts:", error);
      });
    },
    toggleReplies(postId) {
      const post = this.posts.find(post => post.id === postId);
      if (post.showReplies) {
        post.showReplies = false;
      } else {
        if (post.replies.length === 0) {
          getRepliesByPostId(postId).then(response => {
            post.replies = response.data.map(reply => ({
              ...reply,
              selected: false
            }));
            post.showReplies = true;
          }).catch(error => {
            console.error("Failed to fetch replies:", error);
          });
        } else {
          post.showReplies = true;
        }
      }
    },
	navigateToDetail() {
		this.$tab.navigateTo("/pages/forum_control/detail");
	},
    togglePostSelection(post) {
      post.selected = !post.selected;
    },
    toggleReplySelection(post, reply) {
      reply.selected = !reply.selected;
    },
    deletePost(postId) {
      if (confirm("确定删除帖子？")) {
        deletePostById(postId).then(() => {
          this.fetchPosts();
        }).catch(error => {
          console.error("Failed to delete post:", error);
        });
      }
    },
    deleteReply(replyId) {
      if (confirm("确定删除回复？")) {
        deleteReplyById(replyId).then(() => {
          this.fetchPosts();
        }).catch(error => {
          console.error("Failed to delete reply:", error);
        });
      }
    },
    filterPosts() {
      const now = new Date();
      this.filteredPosts = this.posts.filter(post => {
        const postDate = new Date(post.postTime);
        const diffDays = (now - postDate) / (1000 * 60 * 60 * 24);
        return this.filterDays === 0 || diffDays <= this.filterDays;
      });
    },
    generateTxtContent() {
      let content = '';
      this.filteredPosts.forEach(post => {
        if (post.selected) {
          content += `Q: ${post.content}\n`;
          post.replies.forEach(reply => {
            if (reply.selected) {
              content += `A: ${reply.content}\n`;
            }
          });
        }
      });
      return content;
    },
    generateAndUploadTxt() {
      const content = this.generateTxtContent();
      const blob = new Blob([content], { type: 'text/plain' });
      const formData = new FormData();
      formData.append('file', blob, 'forum.txt');

      axios.post(baseUrl + '/common/upload', formData, {
        headers: {
          Authorization: "Bearer " + getToken(),
          'Content-Type': 'multipart/form-data'
        }
      }).then(response => {
        console.log('File uploaded successfully:', response.data);
		const fileName = response.data.newFileName;
		const fileUrl = response.data.url;
		saveFileInfo(fileName, fileUrl).then(saveResponse => {
		          // console.log('File URL saved successfully:', saveResponse);
		        }).catch(saveError => {
		          console.error('Failed to save file URL:', saveError);
		        });

      }).catch(error => {
        console.error('File upload failed:', error);
      });
    }
  },
  mounted() {
    this.fetchPosts();
  }
}
</script>


<style scoped>
.admin-forum-container {
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
}

.filter-options {
  margin-bottom: 20px;
}

.filter-options select {
  padding: 5px 10px;
  border-radius: 5px;
  border: 1px solid #ddd;
}

.post-list {
  margin-bottom: 20px;
}

.post-item {
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
  background-color: #fff;
  position: relative;
}

.post-header {
  display: flex;
  align-items: center;
}

.toggle-btn {
  cursor: pointer;
  margin-right: 10px;
}

.post-content {
  flex-grow: 1;
  padding-right: 50px;
  cursor: pointer;
}

.post-content.selected {
  background-color: #e0f7fa;
}

.delete-text {
  position: absolute;
  right: 10px;
  color: red;
  cursor: pointer;
  text-decoration: underline;
}

.replies {
  margin-top: 10px;
  padding-left: 20px;
  border-left: 2px solid #ddd;
}

.reply-item {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  position: relative;
}

.reply-content {
  flex-grow: 1;
  padding-right: 50px;
  cursor: pointer;
}

.reply-content.selected {
  background-color: #e0f7fa;
}

.reply-item .delete-text {
  position: absolute;
  right: 10px;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
}

button {
  padding: 10px 15px;
  border: none;
  background-color: #007bff;
  color: white;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
