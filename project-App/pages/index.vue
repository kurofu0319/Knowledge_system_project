<template>
  <view class="home-container">
	  <view class="title">
    <view class="navbar">
      <text class="app-title">知识库问答系统</text>
      
    </view>
	
	<view class="notification-icon" @click="navigateTo('notice_management')">
	  <image src="/static/bell.png" class="bell-icon" />
	  <view v-if="unreadCount > 0" class="badge">{{ unreadCount }}</view>
	</view>
    </view>
    <view class="welcome-section">
      <text class="welcome-title">欢迎使用知识库问答系统</text>
      <text class="welcome-subtitle">提升您的工作效率，从这里开始</text>
    </view>
    
    <view class="quick-links">
      <view class="quick-link" @click="navigateTo('forum')">
        <image src="@/static/forum.png" class="icon"/>
        <text>论坛</text>
      </view>
      <view class="quick-link" @click="navigateTo('search')">
        <image src="@/static/search.png" class="icon"/>
        <text>通用搜索</text>
      </view>
      <view class="quick-link" @click="navigateTo('myKnowledge')">
        <image src="@/static/my_knowledge.png" class="icon"/>
        <text>我的知识库</text>
      </view>
    </view>

    <view class="info-cards">
      <view class="info-card">
        <text class="card-title">热门问题</text>
        <view class="post-item" v-for="(post, index) in processedHotPosts" :key="post.id">
          <view class="post-title" @click="navigateToPost(post.id)">Top{{ index + 1 }}: {{ post.title }}</view>
          <view class="likes-bar-container">
            <view class="likes-bar" :style="{ width: post.barWidth + '%' }"></view>
          </view>
        </view>
      </view>
    </view>
    
    <!-- 搜索框 -->
    <view class="search-title">快捷搜索</view>
    <view class="search-section">
      <input v-model="searchKeyword" class="search-input" type="text" placeholder="请输入搜索内容" maxlength="30" />
      <button :disabled="loading" @click="handleSearch" :class="['search-btn', loading ? 'disabled' : '']">搜索</button>
    </view>
    
    <!-- 显示答案 -->
    <view v-if="searchResult" class="answer-section">
      <text class="answer-content">{{ searchResult }}</text>
    </view>
  </view>
</template>

<script>
import { getAllPosts } from '@/api/forum';
import { generateOllamaCompletion, saveSearchHistory } from '@/api/OllamaApi';
import { getInfo } from '@/api/login';
import { listNotifications } from '@/api/notification';

export default {
  data() {
    return {
      hotPosts: [],
      maxLikes: 0,
      searchKeyword: '',
      loading: false,
      messages: [],
      searchResult: '', // 用于存储搜索结果
      unreadCount: 0 // 未读通知数量
    };
  },
  computed: {
    processedHotPosts() {
      return this.hotPosts.map(post => ({
        ...post,
        barWidth: this.calculateBarWidth(post.likes)
      }));
    }
  },
  methods: {
    navigateTo(page) {
      let url = '';
      if (page === 'forum') {
        url = '/pages/Forum/index';
      } else if (page === 'search') {
        url = '/pages/Search/index';
      } else if (page === 'myKnowledge') {
        url = '/pages/userFile/index';
      } else if (page === 'notice_management') {
        url = '/pages/notice_management/index';
      }
      this.$tab.navigateTo(url);
    },
    fetchHotPosts() {
      getAllPosts().then(response => {
        this.hotPosts = response.data.sort((a, b) => b.likes - a.likes).slice(0, 5);
        this.maxLikes = Math.max(...this.hotPosts.map(post => post.likes));
      }).catch(error => {
        console.error("Failed to fetch hot posts:", error);
      });
    },
	processedHotPosts() {
	  return this.hotPosts.map(post => ({
	    ...post,
	    barWidth: this.calculateBarWidth(post.likes)
	  }));
	},
    calculateBarWidth(likes) {
      return (likes / this.maxLikes) * 100;
    },
    async handleSearch() {
      if (this.searchKeyword === "") {
        this.$modal.msgError("请输入搜索内容");
        return;
      }

      const currentKeyword = this.searchKeyword;
      this.searchKeyword = '';
      this.loading = true;

      try {
        const result = await generateOllamaCompletion(currentKeyword);
        console.log(result);

        // 将搜索结果存储到searchResult中
        this.searchResult = result.response;

        const userInfo = await getInfo();
        const userName = userInfo.user.userName;
        await saveSearchHistory(userName, currentKeyword, result.response);
      } catch (error) {
        console.error('搜索请求失败:', error);
        this.$modal.msgError("搜索请求失败");
      }

      this.loading = false;
    },
	navigateToPost(postId) {
		this.$tab.navigateTo(`/pages/Forum/PostDetail?postId=${postId}`);
	},
    fetchNotifications() {
      const userName = this.$store.state.user.name;
      listNotifications(userName).then(response => {
        const notifications = response.data;
        // 计算未读通知数量
        this.unreadCount = notifications.filter(notification => !notification.isRead).length;
      }).catch(error => {
        console.error('Error fetching notifications:', error);
      });
    }
  },
  onShow() {
    this.fetchHotPosts();
    this.fetchNotifications();
  }
}
</script>

<style scoped>
.home-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  padding: 20px;
}


.title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;

}

.navbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 85%;
  background-color: #55aaff;
  padding: 40px;
}

.app-title {
  font-size: 35px;
  position: absolute;
  left: 50px;
  color: #ffffff;
}

.notification-icon {
  position: relative;
  display: flex;
  align-items: center;
  cursor: pointer;
}

.bell-icon {
  width: 30px;
  height: 30px;
}

.badge {
  position: absolute;
  top: -5px;
  right: -5px;
  background-color: #ff4d4f;
  color: #fff;
  padding: 2px 5px;
  border-radius: 50%;
  font-size: 12px;
}

.welcome-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 40px;
}

.welcome-title {
  font-size: 32px;
  font-weight: bold;
}

.welcome-subtitle {
  font-size: 18px;
  color: #888;
  margin-top: 10px;
}

.search-section {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
  width: 100%;
}

.search-input {
  flex: 1;
  height: 45px;
  border: 1px solid #ccc;
  border-radius: 20px;
  padding: 0 15px;
  margin-right: 10px;
  font-size: 16px;
}

.search-btn {
  height: 45px;
  padding: 0 20px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 20px;
  cursor: pointer;
}

.search-btn.disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.answer-section {
  margin-top: 20px;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  width: 100%;
  background-color: #f9f9f9;
}

.answer-title {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 10px;
}

.answer-content {
  font-size: 16px;
}

.quick-links {
  display: flex;
  justify-content: space-around;
  width: 100%;
  margin-top: 20px;
}

.quick-link {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #ffffff;
  color: #000000;
  border: none;
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  width: 30%;
  text-align: center;
}

.quick-link:hover {
  background-color: #0056b3;
}

.icon {
  width: 40px;
  height: 40px;
  margin-bottom: 5px;
}

.info-cards {
  display: flex;
  justify-content: space-around;
  width: 100%;
  margin-top: 20px;
}

.info-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
  width: 100%;
  background-color: #fff;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.card-title {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 10px;
}

.post-item {
  margin-top: 10px;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 8px;
  width: 100%;
  background-color: #f9f9f9;
}

.post-title {
  font-size: 16px;
  font-weight: bold;
}

.likes-bar-container {
  margin-top: 5px;
  height: 10px;
  background-color: #e0e0e0;
  border-radius: 5px;
  overflow: hidden;
}

.likes-bar {
  height: 10px;
  background-color: #007bff;
  border-radius: 5px;
}

.search-title {
  align-self: flex-start;
  font-size: 18px; /* 调整字体大小 */
  font-weight: bold;
  margin-top: 20px;
}
</style>
