import Vue from 'vue'
import App from './App'
import store from './store' // store
import plugins from './plugins' // plugins
import './permission' // permission

// 引入 Element UI 和样式
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

// 使用 Element UI 组件库
Vue.use(ElementUI)

Vue.use(plugins)

Vue.config.productionTip = false
Vue.prototype.$store = store

App.mpType = 'app'

const app = new Vue({
  store,
  render: h => h(App)
})

app.$mount()
