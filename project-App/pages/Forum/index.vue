<template>
  <view class="forum-home-container">
    <view class="header">
      <picker mode="selector" :range="sortOptions" @change="changeSort">
        <view class="picker">
          {{ sortOptions[sortIndex] }}
        </view>
      </picker>
      <input class="search-bar" placeholder="搜索帖子..." v-model="searchQuery" @input="filterPosts" />
    </view>
    <view class="post-list">
      <view class="post-item" v-for="post in filteredPosts" :key="post.id" @click="navigateToPost(post.id)">
        <view class="post-header">
          <image v-if="post.avatar" :src="post.avatar" class="avatar round" mode="widthFix" @click.stop="navigateToUserInfo(post.userName)"></image>
          <text class="post-user">{{ post.userName }} - {{ post.postTime }}</text>
        </view>
        <text class="post-title">{{ post.title }}</text>
        <text class="post-likes">点赞: {{ post.likes }}</text>
      </view>
    </view>

    <button @click="navigateToCreatePost" class="create-post-btn">
      <text class="icon">&#9998;</text> <!-- 这是笔的图标 -->
      <text class="label">发帖</text>
    </button>
  </view>
</template>



<script>
import { getprofileByuserName } from '../../api/system/user'
import { getAllPosts, getRepliesByPostId } from '@/api/forum'

const baseUrl = "http://172.20.255.31:8080"

export default {
  data() {
    return {
      posts: [],
      searchQuery: '',
      sortIndex: 0,
      sortOptions: ['最新发布', '最多点赞', '最多回复']
    }
  },
  computed: {
    avatar() {
      return this.$store.state.user.avatar
    },
    sortedPosts() {
      if (this.sortIndex === 0) {
        // 最新发布
        return this.posts.sort((a, b) => new Date(b.postTime) - new Date(a.postTime))
      } else if (this.sortIndex === 1) {
        // 最多点赞
        return this.posts.sort((a, b) => b.likes - a.likes)
      } else if (this.sortIndex === 2) {
        // 最多回复
        return this.posts.sort((a, b) => b.replyCount - a.replyCount)
      }
      return this.posts
    },
    filteredPosts() {
      if (this.searchQuery) {
        return this.sortedPosts.filter(post => 
          post.title.includes(this.searchQuery) || 
          post.userName.includes(this.searchQuery)
        )
      }
      return this.sortedPosts
    }
  },
  methods: {
    navigateToCreatePost() {
      this.$tab.navigateTo('/pages/Forum/CreatePost')
    },
    navigateToPost(postId) {
      this.$tab.navigateTo(`/pages/Forum/PostDetail?postId=${postId}`)
    },
    async navigateToUserInfo(userName) {
      this.$tab.navigateTo(`/pages/mine/info/index?userName=${userName}`)
    },
    async fetchAvatars(posts) {
      for (const post of posts) {
        try {
          const profile = await getprofileByuserName(post.userName);
          if (profile.data.avatar == "") {
            post.avatar = baseUrl + "/profile/avatar/new_user.png";
          } else {
            post.avatar = baseUrl + profile.data.avatar;
          }
        } catch (error) {
          console.error(`Error fetching avatar for user ${post.userName}:`, error);
        }
      }
    },
    async fetchPosts() {
      try {
        const response = await getAllPosts();
        const posts = response.data;
        const fetchRepliesPromises = posts.map(post => this.fetchReplies(post.id));

        const repliesCounts = await Promise.all(fetchRepliesPromises);
        posts.forEach((post, index) => {
          post.replyCount = repliesCounts[index];
        });

        await this.fetchAvatars(posts);

        this.posts = posts;

      } catch (error) {
        console.error("Error fetching posts or replies:", error);
      }
    },
    fetchReplies(postId) {
      return getRepliesByPostId(postId).then(response => {
        return response.data.length;
      }).catch(error => {
        console.error("Failed to fetch replies:", error);
        return 0;
      });
    },
    changeSort(e) {
      this.sortIndex = e.target.value;
    },
    filterPosts() {
      this.filteredPosts;
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

.picker {
  border: 1px solid #ccc;
  padding: 5px;
  border-radius: 5px;
}

.search-bar {
  flex: 1;
  border: 1px solid #ccc;
  padding: 1px;
  border-radius: 5px;
  margin-left: 10px;
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
