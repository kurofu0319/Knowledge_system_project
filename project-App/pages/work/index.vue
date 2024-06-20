<template>
  <view class="work-container">
    <!-- 轮播图 -->
    <uni-swiper-dot class="uni-swiper-dot-box" :info="data" :current="current" field="content">
      <swiper class="swiper-box" :current="swiperDotIndex" @change="changeSwiper">
        <swiper-item v-for="(item, index) in data" :key="index">
          <view class="swiper-item" @click="clickBannerItem(item)">
            <image :src="item.image" mode="aspectFill" :draggable="false" />
          </view>
        </swiper-item>
      </swiper>
    </uni-swiper-dot>

    <!-- 宫格组件 -->
    <uni-section title="系统管理" type="line"></uni-section>
    <view class="grid-body">
      <uni-grid :column="3" :showBorder="false" @change="changeGrid">
        <uni-grid-item :index="0">
          <view class="grid-item-box">
            <uni-icons type="search" size="30"></uni-icons>
            <text class="text">搜索页面</text>
          </view>
        </uni-grid-item>
        <uni-grid-item :index="1">
          <view class="grid-item-box">
            <uni-icons type="calendar-filled" size="30"></uni-icons>
            <text class="text">历史记录</text>
          </view>
        </uni-grid-item>
        <uni-grid-item :index="2">
          <view class="grid-item-box">
            <uni-icons type="chat-filled" size="30"></uni-icons>
            <text class="text">通知公告</text>
            <view v-if="unreadCount > 0" class="badge">{{ unreadCount }}</view>
          </view>
        </uni-grid-item>
        <uni-grid-item :index="3">
          <view class="grid-item-box">
            <uni-icons type="chatboxes-filled" size="30"></uni-icons>
            <text class="text">论坛</text>
          </view>
        </uni-grid-item>
         <!-- 仅管理员可见 -->
        <uni-grid-item v-if="isAdmin" :index="4">
          <view class="grid-item-box">
            <uni-icons type="staff-filled" size="30"></uni-icons>
            <text class="text">用户管理</text>
          </view>
        </uni-grid-item>
        <uni-grid-item v-if="isAdmin" :index="5">
          <view class="grid-item-box">
            <uni-icons type="pyq" size="30"></uni-icons>
            <text class="text">论坛管理</text>
          </view>
        </uni-grid-item>
		<uni-grid-item :index="6">
		  <view class="grid-item-box">
		    <uni-icons type="home-filled" size="30"></uni-icons>
		    <text class="text">个人知识库</text>
		  </view>
		</uni-grid-item>
      </uni-grid>
    </view>
  </view>
</template>

<script>
import { getUserProfile } from '@/api/system/user'
import { listNotifications } from '@/api/notification'

export default {
  data() {
    return {
      current: 0,
      swiperDotIndex: 0,
      data: [
        { image: '/static/images/banner/banner01.png' },
        { image: '/static/images/banner/banner02.png' },
        { image: '/static/images/banner/banner03.png' },
        { image: '/static/images/banner/banner04.png' }
      ],
      isAdmin: false,
      unreadCount: 0 // 未读通知数量
    };
  },
  onLoad(){
    this.checkAdmin()
  },
  onShow() {
    this.fetchNotifications() // 每次页面显示时获取未读通知数量
  },
  methods: {
    async checkAdmin() {
      try {
        const response = await getUserProfile();
        console.log(response);
        const user = response.data;
        this.isAdmin = user.roles.some(role => role.roleKey === 'admin');
      } catch (error) {
        console.error('Error fetching user profile:', error);
      }
    },
    fetchNotifications() {
      const userName = this.$store.state.user.name;
      listNotifications(userName).then(response => {
        const notifications = response.data;
        // 计算未读通知数量
        this.unreadCount = notifications.filter(notification => !notification.isRead).length;
		// console.log(this.unreadCount)
      }).catch(error => {
        console.error('Error fetching notifications:', error);
      });
    },
    clickBannerItem(item) {
      console.info(item);
    },
    changeSwiper(e) {
      this.current = e.detail.current;
    },
    changeGrid(e) {
      if (e.detail.index === 0) {
        this.$tab.navigateTo('/pages/Search/index'); // 跳转到搜索页面
      }
      if (e.detail.index === 1) {
        this.$tab.navigateTo('/pages/history/index'); // 跳转到历史记录页面
      }
      if (e.detail.index === 2) {
        this.$tab.navigateTo('/pages/notice_management/index'); // 跳转到通知公告页面
      }
      if (e.detail.index === 3) {
        this.$tab.navigateTo('/pages/Forum/index'); // 跳转到论坛首页
      }
      if (e.detail.index === 4) {
        this.$tab.navigateTo('/pages/user_management/index'); // 跳转到用户管理页面
      }
	  if (e.detail.index === 5) {
	    this.$tab.navigateTo('/pages/forum_control/index'); // 跳转到用户管理页面
	  }
	  if (e.detail.index === 6) {
	    this.$tab.navigateTo('/pages/userFile/index'); // 跳转到用户管理页面
	  }
    },
  },
};
</script>

<style scoped>
.work-container {
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  background-color: #fff;
  min-height: 100%;
}

.text {
  text-align: center;
  font-size: 26rpx;
  margin-top: 10rpx;
}

.grid-item-box {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 15px 0;
  position: relative; /* 为了放置徽章 */
}

.badge {
  position: absolute;
  top: 30px;
  right: 30px;
  background-color: #ff4d4f;
  color: #fff;
  padding: 2px 5px;
  border-radius: 50%;
  font-size: 12px;
}

.uni-margin-wrap {
  width: 690rpx;
  width: 100%;
}

.swiper {
  height: 300rpx;
}

.swiper-box {
  height: 150px;
}

.swiper-item {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #fff;
  height: 300rpx;
  line-height: 300rpx;
}

@media screen and (min-width: 500px) {
  .uni-swiper-dot-box {
    width: 400px;
    margin: 0 auto;
    margin-top: 8px;
  }

  .image {
    width: 100%;
  }
}
</style>
