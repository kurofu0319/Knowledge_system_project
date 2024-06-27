<template>
  <view class="history-container">
    <view v-if="searchHistory.length > 0">
      <uni-section title="历史记录" type="line"></uni-section>
      <view class="search-history">
        <table>
          <thead>
            <tr>
              <th>时间</th>
              <th>关键词</th>
              <th>结果</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(history, index) in searchHistory" :key="index">
              <td>{{ history.searchTime }}</td>
              <td>{{ history.searchKeyword }}</td>
              <td>{{ history.results }}</td>
            </tr>
          </tbody>
        </table>
      </view>
    </view>
    <view v-else>
      暂无搜索历史记录
    </view>
  </view>
</template>


<script>
import { getUserSearchHistory } from 'api/OllamaApi';
import { getprofileByuserName } from 'api/system/user';
import { getInfo } from '../../api/login';

export default {
  data() {
    return {
      searchHistory: [], // 搜索历史记录
    };
  },
  async created() {
    // 获取用户信息
    const userInfo = await this.$store.dispatch('GetInfo');
    const userName = userInfo.user.userName;

    // 查询搜索历史记录
    const response = await getUserSearchHistory(userName);
    const sortedHistory = response.data.sort((a, b) => new Date(b.searchTime) - new Date(a.searchTime)); // 按时间排序
    this.searchHistory = sortedHistory.slice(0, 100); // 显示最近一百条记录
  },
};
</script>


<style lang="scss">
/* 样式根据需求调整 */
.history-container {
  padding: 20px;
}

.search-history {
  margin: 20px 0;
}

table {
  width: 100%;
  border-collapse: collapse;
  background-color: white;
}

th,
td {
  border: 1px solid #ddd;
  padding: 8px;
}

th {
  background-color: white;
  text-align: left;
}
</style>

