import Vue from 'vue'
import Vuex from 'vuex'
import user from '@/store/modules/user'
import forum from '@/store/modules/forum' // 确保已导入
import getters from './getters'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    user,
    forum // 注册 forum 模块
  },
  getters
});

export default store;
