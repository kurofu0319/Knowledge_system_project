import Vue from 'vue'
import App from './App'
import store from './store' // store
import plugins from './plugins' // plugins
import './permission' // permission
 // Font Awesome

// 引入并注册 Uni-UI 组件
import { uniButton, uniFilePicker, uniIcons  } from '@dcloudio/uni-ui'

Vue.component('uni-file-picker', uniFilePicker)
Vue.component('uni-icons', uniIcons)

Vue.use(plugins)

Vue.config.productionTip = false
Vue.prototype.$store = store

App.mpType = 'app'

const app = new Vue({
  store,
  render: h => h(App)
})

app.$mount()
