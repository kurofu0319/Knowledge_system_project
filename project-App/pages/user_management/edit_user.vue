<template>
  <view>
    <view class="header">
      <view class="title">编辑用户</view>
    </view>
    <view class="content">
      <view class="form-item">
        <text>用户名</text>
        <input v-model="user.userName" placeholder="请输入用户名" disabled/>
      </view>
      <view class="form-item">
        <text>邮箱</text>
        <input v-model="user.email" placeholder="请输入邮箱" class="input-box"/>
      </view>
      <view class="form-item">
        <text>手机号码</text>
        <input v-model="user.phonenumber" placeholder="请输入手机号码" class="input-box"/>
      </view>
      <button @click="handleSubmit">提交</button>
    </view>
  </view>
</template>

<script>
import { getUser, updateUser } from '@/api/user_control'

export default {
  data() {
    return {
      user: {}
    }
  },
  onLoad(options) {
    this.fetchUser(options.userId)
  },
  methods: {
    fetchUser(userId) {
      getUser(userId).then(response => {
        this.user = response.data
      })
    },
    handleSubmit() {
      updateUser(this.user).then(() => {
        uni.showToast({
          title: '更新用户成功',
          icon: 'success'
        })
        uni.navigateBack()
      })
    }
  }
}
</script>

<style scoped>
.header {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px;
}
.title {
  font-size: 32px;
  font-weight: bold;
}
.input-box {
  padding: 20px;
  border: 1px solid #ccc;
  width: 100%;
  box-sizing: border-box; /* 确保 padding 不会影响元素的总宽度 */
}
.content {
  padding: 10px;
}
.form-item {
  margin-bottom: 10px;
}
</style>
