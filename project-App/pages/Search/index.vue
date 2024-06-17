<template>
  <view class="chat-container">
    <!-- 聊天消息 -->
    <view class="messages-container" ref="messagesContainer">
      <view v-for="message in messages" :key="message.id" :class="['message', message.type]">
        <text>{{ message.content }}</text>
      </view>
      <!-- 加载提示 -->
      <view v-if="loading" class="loading">
        <text>加载中...</text>
      </view>
    </view>

    <!-- 输入框 -->
    <view class="input-container flex align-center justify-center">
      <input v-model="searchKeyword" class="search-input" type="text" placeholder="请输入搜索内容" maxlength="30" />
      <button :disabled="loading" @click="handleSearch" :class="['search-btn', loading ? 'disabled' : '']">发送</button>
    </view>
  </view>
</template>

<script>
import { generateOllamaCompletion, saveSearchHistory } from '@/api/OllamaApi';
import { getInfo } from '@/api/login';

export default {
  data() {
    return {
      searchKeyword: '',
      messages: [], // 用于存储所有消息
      loading: false // 加载状态
    };
  },
  methods: {
    async handleSearch() {
      if (this.searchKeyword === "") {
        this.$modal.msgError("请输入搜索内容");
        return;
      }

      // 临时存储当前的搜索关键字
      const currentKeyword = this.searchKeyword;

      // 清空搜索输入框
      this.searchKeyword = '';

      // 添加用户消息到聊天框
      this.messages.push({
        id: Date.now(),
        type: 'user',
        content: currentKeyword
      });

      // 设置加载状态
      this.loading = true;

      // 发送搜索请求到后端
      try {
        const result = await generateOllamaCompletion(currentKeyword);
        console.log(result);

        // 添加机器人的响应到聊天框
        this.messages.push({
          id: Date.now() + 1,
          type: 'bot',
          content: result.response
        });

        // 获取用户信息
        const userInfo = await getInfo();
        const userName = userInfo.user.userName; // 假设后端返回的用户信息包含 userName 属性

        // 保存搜索结果到后端
        await saveSearchHistory(userName, currentKeyword, result.response);
      } catch (error) {
        console.error('搜索请求失败:', error);
        this.$modal.msgError("搜索请求失败");
      }

      // 关闭加载状态
      this.loading = false;

      // 滚动到最新消息
      this.$nextTick(() => {
        const container = this.$refs.messagesContainer;
        container.scrollTop = container.scrollHeight;
      });
    }
  }
}
</script>

<style lang="scss">
.chat-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: #f5f5f5;
}

.messages-container {
  flex: 1;
  padding: 10px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

.message {
  max-width: 80%;
  padding: 10px;
  margin: 5px 0;
  border-radius: 10px;
  white-space: pre-wrap; /* 保证换行显示 */
  word-break: break-word; /* 防止单词过长导致布局错乱 */
}

.message.user {
  background-color: #d1e7dd;
  align-self: flex-end;
  margin-bottom: 10px; /* 每个气泡间的换行 */
  width: auto; /* 根据内容调整宽度 */
  max-width: 80%; /* 最大宽度 */
}

.message.bot {
  background-color: #fff;
  align-self: flex-start;
  border: 1px solid #ccc;
  margin-bottom: 10px; /* 每个气泡间的换行 */
}

.input-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px;
  background-color: #fff;
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
}

.search-input {
  flex: 1;
  height: 45px;
  border: 1px solid #ccc;
  border-radius: 20px;
  padding: 0 15px;
  margin-right: 10px;
}

.search-btn {
  height: 45px;
  padding: 0 20px;
}

.search-btn.disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.loading {
  align-self: center;
  color: #888;
}
</style>
