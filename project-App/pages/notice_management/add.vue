<template>
  <view>
    <view class="header">
      <view class="title">新增通知公告</view>
    </view>
    <view class="content">
      <view class="form-item">
        <text>标题</text>
        <input v-model="notice.noticeTitle" placeholder="请输入标题"/>
      </view>
      <view class="form-item">
        <text>类型</text>
        <picker mode="selector" :range="['通知', '公告']" @change="handleTypeChange">
          <view class="picker">{{ noticeType }}</view>
        </picker>
      </view>
      <view class="form-item">
        <text>内容</text>
        <textarea v-model="notice.noticeContent" placeholder="请输入内容"></textarea>
      </view>
      <button @click="handleSubmit">提交</button>
    </view>
  </view>
</template>

<script>
import { addNotice } from '@/api/notice'

export default {
  data() {
    return {
      notice: {
        noticeTitle: '',
        noticeType: '1', // 默认类型为通知
        noticeContent: ''
      },
      noticeType: '通知'
    }
  },
  methods: {
    handleTypeChange(event) {
      this.noticeType = event.target.value === '0' ? '通知' : '公告'
      this.notice.noticeType = event.target.value === '0' ? '1' : '2'
    },
    handleSubmit() {
      if (!this.notice.noticeTitle || !this.notice.noticeContent) {
        uni.showToast({
          title: '请填写所有必填字段',
          icon: 'none'
        })
        return
      }

      addNotice(this.notice).then(() => {
        uni.showToast({
          title: '新增通知公告成功',
          icon: 'success'
        })
        uni.navigateBack()
      }).catch(error => {
        console.error('Error adding notice:', error)
        uni.showToast({
          title: '新增通知公告失败',
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
  justify-content: center;
  align-items: center;
  padding: 10px;
}
.title {
  font-size: 20px;
}
.content {
  padding: 10px;
}
.form-item {
  margin-bottom: 10px;
}
.picker {
  padding: 10px;
  border: 1px solid #ccc;
}
</style>
