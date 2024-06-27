<template>
  <view>
    <view class="header">
      <view class="title">通知公告管理</view>
    </view>
    <view class="content">
      <view class="section">
        <view class="section-header">
          <view class="section-title">公告</view>
          <button v-if="isAdmin" @click="handleAdd" class="section-button">新增公告</button>
        </view>
        <view class="table">
          <view class="table-header">
            <view class="table-cell center">标题</view>
            <view class="table-cell center">发布时间</view>
            <view class="table-cell center">操作</view>
          </view>
          <view v-for="notice in noticeList" :key="notice.noticeId" class="table-row">
            <view class="table-cell">{{ notice.noticeTitle }}</view>
            <view class="table-cell">{{ notice.createTime }}</view>
            <view class="action-buttons center">
<!--              <button class="edit-btn" @click="handleEdit(notice.noticeId)">
                <i class="fas fa-cog"></i>
              </button> -->
              <button class="delete-btn" @click="handleDelete(notice.noticeId)">
                <i class="fas fa-trash-alt"></i>
              </button>
            </view>
          </view>
        </view>
      </view>
      <view class="section">
        <view class="section-header">
          <view class="section-title">通知</view>
          <button @click="handleDeleteReadNotifications" class="section-button">删除已读</button>
        </view>
        <view class="table">
          <view class="table-header">
            <view class="table-cell center">通知内容</view>
            <view class="table-cell center">时间</view>
            <view class="table-cell center">操作</view>
          </view>
          <view v-for="notification in notificationList" :key="notification.id" :class="{'table-row': true, 'read': notification.isRead, 'unread': !notification.isRead}">
            <view class="table-cell">{{ notification.content }}</view>
            <view class="table-cell-formatTime">{{ formatTime(notification.createTime) }}</view>
            <view class="action-buttons">
              <button class="view-btn" @click="handleNotificationClick(notification)">
                <i class="fas fa-eye"></i>
              </button>
              <button class="delete-btn" @click="handleDeleteNotification(notification.id)">
                <i class="fas fa-trash-alt"></i>
              </button>
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
  font-size: 32px;
  font-weight: bold;
}
.section-title{
  font-size: 20px;
  font-weight: bold;
}
.content {
  padding: 10px;
}
.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px; /* 可根据需要调整 */
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
  text-align: left;
}

.table-cell-formatTime {
  flex: 1;
  padding: 10px;
  
  margin-left: 30px;
}


.table-header .table-cell {
  font-weight: bold;
  background-color: #f5f5f5;
}
.center {
	text-align: center;
}
.read {
  background-color: #e0e0e0; /* Gray background for read notifications */
}
.unread {
  background-color: #ffffff; /* White background for unread notifications */
  font-weight: bold; /* Bold text for unread notifications */
}
.action-buttons {
  display: flex;
  justify-content: space-between; /* 确保按钮左右放置 */
  gap: 10px; /* 增加按钮之间的间距 */
}
.view-btn, .edit-btn, .delete-btn {
  width: 40px; /* 保证按钮是正方形 */
  height: 40px; /* 保证按钮是正方形 */
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
.view-btn i {
  color: black;
}
.edit-btn i {
  color: #007bff;
}
.delete-btn i {
  color: #ff4d4f;
}

</style>
