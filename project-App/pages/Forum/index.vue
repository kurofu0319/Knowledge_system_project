<template>
  <view class="forum-home-container">
    <view class="header">
      <text class="title">论坛</text>
      <button @click="navigateToCreatePost" class="create-post-btn">发帖</button>
    </view>

    <view class="post-list">
      <view class="post-item" v-for="post in posts" :key="post.id" @click="navigateToPost(post.id)">
        <text class="post-title">{{ post.title }}</text>
        <text class="post-user">{{ post.userName }} - {{ post.postTime }}</text>
        <text class="post-likes">Likes: {{ post.likes }}</text>
      </view>
    </view>
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
  methods: {
    navigateToCreatePost() {
      this.$tab.navigateTo('/pages/Forum/CreatePost')
    },
    navigateToPost(postId) {
      this.$tab.navigateTo(`/pages/Forum/PostDetail?postId=${postId}`)
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
}

.header {
  display: flex;
  justify-content: space-between;
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
  padding: 5px 12px;
  border-radius: 5px;
  font-size: 12px;
  position: absolute;
  right: 0;
  top: 0;
}

.post-list {
  margin-top: 20px;
}

.post-item {
  padding: 15px;
  border-bottom: 1px solid #ccc;
  cursor: pointer;
  height: 100px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.post-title {
  font-size: 18px;
  font-weight: bold;
  white-space: normal;
}

.post-user {
  font-size: 14px;
  color: #666;
  margin-top: 5px;
}

.post-likes {
  font-size: 14px;
  color: #666;
  margin-top: 5px;
}
</style>
