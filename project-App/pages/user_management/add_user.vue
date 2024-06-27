<template>
  <view>
    <view class="header">
      <view class="title">新增用户</view>
    </view>
    <view class="content">
      <view class="form-item">
        <text>用户名：</text>
        <input v-model="user.userName" placeholder="请输入用户名" class="input-box"/>
      </view>
      <view class="form-item">
        <text>昵称：</text>
        <input v-model="user.nickName" placeholder="请输入昵称" class="input-box"/>
      </view>
      <view class="form-item">
        <text>邮箱：</text>
        <input v-model="user.email" placeholder="请输入邮箱" class="input-box"/>
      </view>
      <view class="form-item">
        <text>手机号码：</text>
        <input v-model="user.phonenumber" placeholder="请输入手机号码" class="input-box"/>
      </view>
      <view class="form-item">
        <text>密码：</text>
        <input v-model="user.password" placeholder="请输入密码" type="password" class="input-box"/>
      </view>
      <button @click="handleSubmit">提交</button>
    </view>
  </view>
</template>

<script>
import { addUser } from '@/api/user_control'

export default {
  data() {
    return {
      user: {
        userName: '',
        nickName: '', // 新增的昵称字段
        email: '',
        phonenumber: '',
        password: ''
      }
    }
  },
  methods: {
    handleSubmit() {
      // 添加简单的验证逻辑，确保所有必填字段都有填写
      if (!this.user.userName || !this.user.nickName || !this.user.email || !this.user.phonenumber || !this.user.password) {
        uni.showToast({
          title: '请填写所有必填字段',
          icon: 'none'
        })
        return;
      }

      addUser(this.user).then(() => {
        uni.showToast({
          title: '新增用户成功',
          icon: 'success'
        })
        uni.navigateBack()
      }).catch(error => {
        console.error('Error adding user:', error)
        uni.showToast({
          title: '新增用户失败',
          icon: 'none'
        })
      })
    }
  }
}
</script>

<style scoped>
.header {
  display: flex;
  justify-content: left;
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
