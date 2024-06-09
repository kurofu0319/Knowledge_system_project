<template>
  <view class="post-detail-container">
    <view class="post-header">
      <text class="post-title">{{ post.title }}</text>
      <view class="spacer"></view>
      <text class="post-content">{{ post.content }}</text>
      <view class="spacer"></view>
      <view class="post-user-container">
        <text class="post-user">{{ post.userName }} - {{ post.postTime }}</text>
		&nbsp;
        <text class="post-likes">Likes: {{ post.likes }}</text>
        <button @click="toggleLikePost" class="like-btn">{{ likedPost ? 'Unlike' : 'Like' }}</button>
      </view>
    </view>
    <button @click="deletePost" v-if="post.userName === $store.state.user.name" class="delete-post-btn">删除帖子</button>
    <view class="replies">
      <view class="reply-item" v-for="reply in replies" :key="reply.id">
        <text class="reply-content">{{ reply.content }}</text>
        <view class="spacer"></view>
        <view class="reply-user-container">
          <text class="reply-user">{{ reply.userName }} - {{ reply.replyTime }}</text>
          <text class="reply-likes">Likes: {{ reply.likes }}</text>
          <button @click="toggleLikeReply(reply)" class="like-reply-btn">{{ likedReplies.includes(reply.id) ? 'Unlike' : 'Like' }}</button>
          <text @click="deleteReply(reply.id)" v-if="reply.userName === $store.state.user.name" class="delete-reply-text">Delete</text>
        </view>
      </view>
    </view>
    <textarea v-model="newReplyContent" placeholder="填写回复"></textarea>
    <button @click="addReply" class="submit-btn">提交回复</button>
  </view>
</template>

<script>
import { getPostById, getRepliesByPostId, createReply, deletePostById, deleteReplyById, likePost, unlikePost, likeReply, unlikeReply, checkUserLikeStatus, checkUserReplyLikeStatus } from '@/api/forum'
import { formatDateTime } from '@/api/OllamaApi.js'

export default {
  data() {
    return {
      post: {},
      replies: [],
      newReplyContent: '',
      likedPost: false,
      likedReplies: []
    }
  },
  methods: {
    addReply() {
      const replyData = {
        postId: this.post.id,
        userName: this.$store.state.user.name,
        content: this.newReplyContent,
        replyTime: formatDateTime(new Date())
      }
      createReply(replyData).then(() => {
        this.newReplyContent = '';
        this.fetchReplies();
      }).catch(error => {
        console.error("Failed to create reply:", error);
      });
    },
    deletePost() {
      if (confirm("确定删除帖子？")) {
        deletePostById(this.post.id, this.$store.state.user.name).then(() => {
          this.$tab.navigateBack('/pages/Forum/index');
        }).catch(error => {
          console.error("Failed to delete post:", error);
        });
      }
    },
    deleteReply(replyId) {
      if (confirm("确定删除回复？")) {
        deleteReplyById(replyId).then(() => {
          this.fetchReplies();
        }).catch(error => {
          console.error("Failed to delete reply:", error);
        });
      }
    },
    toggleLikePost() {
      if (this.likedPost) {
        unlikePost(this.post.id, this.$store.state.user.name).then(() => {
          this.likedPost = false;
          this.fetchPost();
        }).catch(error => {
          console.error("Error unliking post:", error);
        });
      } else {
        likePost(this.post.id, this.$store.state.user.name).then(() => {
          this.likedPost = true;
          this.fetchPost();
        }).catch(error => {
          console.error("Error liking post:", error);
        });
      }
    },
    toggleLikeReply(reply) {
      if (this.likedReplies.includes(reply.id)) {
        unlikeReply(reply.id, this.$store.state.user.name).then(() => {
          this.likedReplies = this.likedReplies.filter(id => id !== reply.id);
          this.fetchReplies();
        }).catch(error => {
          console.error("Error unliking reply:", error);
        });
      } else {
        likeReply(reply.id, this.$store.state.user.name).then(() => {
          this.likedReplies.push(reply.id);
          this.fetchReplies();
        }).catch(error => {
          console.error("Error liking reply:", error);
        });
      }
    },
    fetchPost() {
      const postId = this.$route.query.postId;
      getPostById(postId).then(response => {
        this.post = response.data;
        this.checkUserLikeStatus(postId);
      }).catch(error => {
        console.error("Failed to fetch post:", error);
      });
    },
    fetchReplies() {
      const postId = this.$route.query.postId;
      getRepliesByPostId(postId).then(response => {
        this.replies = response.data;
        this.checkUserReplyLikeStatus();
      }).catch(error => {
        console.error("Failed to fetch replies:", error);
      });
    },
    fetchPostAndReplies() {
      this.fetchPost();
      this.fetchReplies();
    },
    checkUserLikeStatus(postId) {
      const userName = this.$store.state.user.name;
      checkUserLikeStatus(postId, userName).then(response => {
        this.likedPost = response.liked;
      }).catch(error => {
        console.error("Failed to check user like status:", error);
      });
    },
    checkUserReplyLikeStatus() {
      const userName = this.$store.state.user.name;
	  
      Promise.all(this.replies.map(reply => 
        checkUserReplyLikeStatus(reply.id, userName).then(response => {
			
          if (response.liked) {
            this.likedReplies.push(reply.id);
          }
        })
      )).catch(error => {
        console.error("Failed to check user reply like status:", error);
      });
    }
  },
  created() {
    this.fetchPostAndReplies();
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

.post-likes {
	padding-left: 10px;
}
</style>
