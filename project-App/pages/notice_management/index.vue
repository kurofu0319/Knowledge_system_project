<template>
  <view>
    <view class="header">
      <view class="title">通知公告管理</view>
      <button v-if="isAdmin" @click="handleAdd">新增公告</button>
      <button @click="handleDeleteReadNotifications">删除已读</button>
    </view>
    <view class="content">
      <view class="section">
        <view class="section-title">公告</view>
        <view class="table">
          <view class="table-header">
            <view class="table-cell">标题</view>
            <view class="table-cell">发布时间</view>
            <view class="table-cell">操作</view>
          </view>
          <view v-for="notice in noticeList" :key="notice.noticeId" class="table-row">
            <view class="table-cell">{{ notice.noticeTitle }}</view>
            <view class="table-cell">{{ notice.createTime }}</view>
            <view class="table-cell">
              <button v-if="isAdmin" @click="handleEdit(notice.noticeId)">编辑</button>
              <button v-if="isAdmin" @click="handleDelete(notice.noticeId)">删除</button>
            </view>
          </view>
        </view>
      </view>
      <view class="section">
        <view class="section-title">通知</view>
        <view class="table">
          <view class="table-header">
            <view class="table-cell">通知内容</view>
            <view class="table-cell">时间</view>
            <view class="table-cell">操作</view>
          </view>
          <view v-for="notification in notificationList" :key="notification.id" :class="{'table-row': true, 'read': notification.isRead, 'unread': !notification.isRead}">
            <view class="table-cell">{{ notification.content }}</view>
            <view class="table-cell">{{ formatTime(notification.createTime) }}</view>
            <view class="table-cell">
              <button @click="handleNotificationClick(notification)">查看</button>
              <button @click="handleDeleteNotification(notification.id)">删除</button>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { listNotices, deleteNotice } from '@/api/notice'
import { getUserProfile } from '@/api/system/user'
import { listNotifications, markNotificationAsRead, deleteNotification } from '@/api/notification'

export default {
  data() {
    return {
      noticeList: [],
      notificationList: [],
      isAdmin: false
    }
  },
  onShow() {
    this.checkAdmin()
    this.fetchNotices()
    this.fetchNotifications()
  },
  methods: {
    async checkAdmin() {
      try {
        const response = await getUserProfile()
        const user = response.data
        this.isAdmin = user.roles.some(role => role.roleKey === 'admin')
      } catch (error) {
        console.error('Error fetching user profile:', error)
      }
    },
    fetchNotices() {
      listNotices().then(response => {
        this.noticeList = response.rows
      }).catch(error => {
        console.error('Error fetching notices:', error)
      })
    },
    fetchNotifications() {
      const userName = this.$store.state.user.name;
      listNotifications(userName).then(response => {
        this.notificationList = response.data
        console.log(response);
      }).catch(error => {
        console.error('Error fetching notifications:', error)
      })
    },
    handleAdd() {
      uni.navigateTo({
        url: '/pages/notice_management/add'
      })
    },
    handleEdit(noticeId) {
      uni.navigateTo({
        url: '/pages/notice_management/edit?noticeId=' + noticeId
      })
    },
    handleDelete(noticeId) {
      deleteNotice([noticeId]).then(() => {
        uni.showToast({
          title: '删除成功',
          icon: 'success'
        })
        this.fetchNotices()
      }).catch(error => {
        console.error('Error deleting notice:', error)
      })
    },
    handleNotificationClick(notification) {
      console.log(notification)
      markNotificationAsRead(notification.id).then(() => {
        uni.navigateTo({
          url: `/pages/Forum/PostDetail?postId=${notification.postId}`
        })
        this.fetchNotifications()  // Refresh notifications list to update read status
      }).catch(error => {
        console.error('Error marking notification as read:', error)
      })
    },
    handleDeleteNotification(notificationId) {
      deleteNotification([notificationId]).then(() => {
        uni.showToast({
          title: '删除成功',
          icon: 'success'
        })
        this.fetchNotifications()
      }).catch(error => {
        console.error('Error deleting notification:', error)
      })
    },
    handleDeleteReadNotifications() {
      const readNotifications = this.notificationList.filter(notification => notification.isRead).map(notification => notification.id);
      if (readNotifications.length === 0) {
        uni.showToast({
          title: '没有已读通知',
          icon: 'none'
        });
        return;
      }
      deleteNotification(readNotifications).then(() => {
        uni.showToast({
          title: '已读通知删除成功',
          icon: 'success'
        })
        this.fetchNotifications()
      }).catch(error => {
        console.error('Error deleting read notifications:', error)
      })
    },
    formatTime(time) {
      const currentTime = new Date();
      const postTime = new Date(time);
      const diff = currentTime - postTime;

      const seconds = Math.floor(diff / 1000);
      const minutes = Math.floor(seconds / 60);
      const hours = Math.floor(minutes / 60);
      const days = Math.floor(hours / 24);

      if (days > 0) {
        return `${days}天前`;
      } else if (hours > 0) {
        return `${hours}小时前`;
      } else if (minutes > 0) {
        return `${minutes}分钟前`;
      } else {
        return `刚刚`;
      }
    }
  }
}
</script>

<style scoped>
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
}
.title {
  font-size: 20px;
}
.content {
  padding: 10px;
}
.section {
  margin-bottom: 20px;
}
.section-title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 10px;
}
.table {
  width: 100%;
  border-collapse: collapse;
}
.table-header, .table-row {
  display: flex;
  border-bottom: 1px solid #ccc;
}
.table-cell {
  flex: 1;
  padding: 10px;
  text-align: center;
}
.table-header {
  background-color: #f5f5f5;
}
.read {
  background-color: #e0e0e0; /* Gray background for read notifications */
}
.unread {
  background-color: #ffffff; /* White background for unread notifications */
  font-weight: bold; /* Bold text for unread notifications */
}
</style>
