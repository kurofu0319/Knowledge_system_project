<template>
  <view>
    <view class="header">
      <view class="title">用户管理</view>
      <button @click="handleAddUser">新增用户</button>
    </view>
    <view class="content">
      <view class="table">
        <view class="table-header">
          <view class="table-cell">用户名</view>
          <view class="table-cell">创建时间</view>
          <view class="table-cell">是否管理员</view>
          <view class="table-cell">操作</view>
        </view>
        <view v-for="user in userList" :key="user.userId" class="table-row">
          <view class="table-cell">{{ user.userName }}</view>
          <view class="table-cell">{{ user.createTime }}</view>
          <view class="table-cell">{{ user.admin ? '是' : '否' }}</view>
          <view class="table-cell">
            <view class="action-buttons">
              <button class="edit-btn" @click="handleEditUser(user.userId)">
                <i class="fas fa-cog"></i>
              </button>
              <button class="delete-btn" @click="handleDeleteUser(user.userId)">
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
import { listUsers, deleteUser } from '@/api/user_control'

export default {
  data() {
    return {
      userList: []
    }
  },
  onLoad() {
    this.fetchUsers()
  },
  methods: {
    fetchUsers() {
      listUsers().then(response => {
        this.userList = response.rows
      })
    },
    handleAddUser() {
      // 跳转到新增用户页面
      uni.navigateTo({
        url: '/pages/user_management/add_user'
      })
    },
    handleEditUser(userId) {
      // 跳转到编辑用户页面
      uni.navigateTo({
        url: '/pages/user_management/edit_user?userId=' + userId
      })
    },
    handleDeleteUser(userId) {
      deleteUser([userId]).then(() => {
        this.fetchUsers()
      })
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
.content {
  padding: 10px;
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
  background-color: white;
}
.table-row {
  background-color: white; /* 将表格的所有行背景颜色设为白色 */
}
.action-buttons {
  display: flex;
  justify-content: center;
}
.action-buttons button {
  width: 40px;
  height: 40px;
  margin: 0 5px;
  font-size: 16px;
  border: none;
  background: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.edit-btn {
  background-color: white;
  color: #007bff;
  border-radius: 4px;
}
.delete-btn {
  background-color: white;
  color: #ff4d4f;
  border-radius: 4px;
}
</style>
