<template>
  <view class="forum-home-container">
    <view class="post-list">
      <view class="post-item" v-for="post in posts" :key="post.id" @click="navigateToPost(post.id)">
        <view class="post-header">
          <image v-if="avatar" :src="avatar" class="avatar round" mode="widthFix" @click.stop="navigateToUserInfo(post.userId)"></image>
          <text class="post-user">{{ post.userName }} - {{ post.postTime }}</text>
        </view>
        <text class="post-title">{{ post.title }}</text>
        <text class="post-likes">Likes: {{ post.likes }}</text>
      </view>
    </view>

    <button @click="navigateToCreatePost" class="create-post-btn">
      <text class="icon">&#9998;</text> <!-- 这是笔的图标 -->
      <text class="label">发帖</text>
    </button>
  </view>
</template>

<script>
import { getAllPosts } from '@/api/forum'

export default {
  data() {
    return {
      posts: []
    }
  },
  computed: {
    avatar() {
      return this.$store.state.user.avatar
    }
  },
  methods: {
    navigateToCreatePost() {
      this.$tab.navigateTo('/pages/Forum/CreatePost')
    },
    navigateToPost(postId) {
      this.$tab.navigateTo(`/pages/Forum/PostDetail?postId=${postId}`)
    },
    navigateToUserInfo(userId) {
      this.$tab.navigateTo(`/pages/mine/info/index?userId=${userId}`)
    },
    fetchPosts() {
      getAllPosts().then(response => {
        this.posts = response.data;
      }).catch(error => {
        console.error("Error fetching posts:", error);
      });
    }
  },
  onShow() {
    this.fetchPosts();
  }
}
</script>

<style lang="scss">
.forum-home-container {
  padding: 20px;
  position: relative; /* 为了放置右下角的按钮 */
}

.header {
  display: flex;
  justify-content: center; /* 修改为居中对齐 */
  align-items: center;
  margin-bottom: 20px;
}

.title {
  font-size: 24px;
  font-weight: bold;
}

.create-post-btn {
  background-color: #007bff;
  color: white;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  position: fixed;
  bottom: 20px;
  right: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 12px;
  cursor: pointer;
  flex-direction: column; /* 竖直排列图标和文字 */
}

.create-post-btn .icon {
  font-size: 24px; /* 图标的大小 */
}

.create-post-btn .label {
  font-size: 12px; /* 文字的大小 */
  position: relative;
  top: -15px; /* 上移文字，与图标接近 */
}

.post-list {
  margin-top: 20px;
}

.post-item {
  padding: 15px;
  border-bottom: 1px solid #ccc;
  cursor: pointer;
  display: flex;
  flex-direction: column;
}

.post-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.avatar {
  width: 30px; /* 调小头像大小 */
  height: 30px; /* 调小头像大小 */
  border-radius: 50%;
  margin-right: 10px;
}

.post-title {
  font-size: 18px;
  font-weight: bold;
  white-space: normal;
  margin-bottom: 10px;
}

.post-user {
  font-size: 16px;
  font-weight: bold;
  color: #333;
}

.post-likes {
  font-size: 14px;
  color: #666;
}
</style>
