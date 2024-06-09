<template>
  <view class="create-post-container">
    <text class="title">创建新帖子</text>
    <input v-model="title" class="input-title" placeholder="标题" />
    <textarea v-model="content" class="textarea-content" placeholder="内容"></textarea>
    <button @click="createPost" class="submit-btn">发布帖子</button>
  </view>
</template>

<script>
import { createPost } from '@/api/forum'
import { formatDateTime } from '@/api/OllamaApi.js'

export default {
  data() {
    return {
      title: '',
      content: ''
    }
  },
  methods: {
    createPost() {
      const postData = {
        userName: this.$store.state.user.name,
        title: this.title,
        content: this.content,
        postTime: formatDateTime(new Date())
      }
      createPost(postData).then(() => {
        this.$tab.navigateBack();
      })
    }
  }
}
</script>

<style lang="scss">
.create-post-container {
  padding: 20px;
}

.title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 20px;
}

.input-title {
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  height: 50px; /* 增加高度 */
}

.textarea-content {
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  height: 200px; /* 增加高度 */
}

.submit-btn {
  background-color: #007bff;
  color: white;
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
}
</style>
