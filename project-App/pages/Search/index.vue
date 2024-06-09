<template>
  <view class="search-container">
    <!-- 搜索框 -->
    <view class="input-container flex align-center justify-center">
      <input v-model="searchKeyword" class="search-input" type="text" placeholder="请输入搜索内容" maxlength="30" />
      <button @click="handleSearch" class="search-btn cu-btn block bg-blue round">搜索</button>
    </view>

    <!-- 搜索结果展示 -->
    <view class="results-container">
      <view v-if="results.length === 0" class="no-results">
        暂无搜索结果
      </view>
      <view v-else class="results">
        <text>{{ results }}</text>
      </view>
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
      results: [] // 用于存储搜索结果
    };
  },
  methods: {
    async handleSearch() {
      if (this.searchKeyword === "") {
        this.$modal.msgError("请输入搜索内容");
        return;
      }
      // 发送搜索请求到后端
      try {
        const result = await generateOllamaCompletion(this.searchKeyword);
        console.log(result);
        this.results = result.response; // 更新搜索结果

        // 获取用户信息
        const userInfo = await getInfo();
        const userName = userInfo.user.userName; // 假设后端返回的用户信息包含 userName 属性

        // 保存搜索结果到后端
        await saveSearchHistory(userName, this.searchKeyword, result.response);
      } catch (error) {
        console.error('搜索请求失败:', error);
        this.$modal.msgError("搜索请求失败");
      }
    }
  }
}
</script>

<style lang="scss">
  .search-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px;
    background-color: #fff;
  }

  .input-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
  }

  .search-input {
    width: 60%;
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

  .results-container {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .no-results {
    color: #888;
  }

  .results {
    width: 100%;
  }

  .result-item {
    width: 100%;
    padding: 10px;
    border-bottom: 1px solid #eee;
  }
</style>
