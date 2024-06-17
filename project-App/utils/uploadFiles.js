import axios from 'axios'
import { getToken } from '@/utils/auth'
import errorCode from '@/utils/errorCode'
import { Message } from 'element-ui'

const baseURL = 'http://localhost:8080' // 设置后端地址

const uploadFile = config => {
  return new Promise((resolve, reject) => {
    let formData = new FormData()
    formData.append(config.name || 'file', config.file)
    for (let key in config.formData) {
      formData.append(key, config.formData[key])
    }

    axios({
      method: 'post',
      url: baseURL + config.url,
      data: formData,
      headers: {
        'Authorization': 'Bearer ' + getToken(),
        'Content-Type': 'multipart/form-data'
      },
      timeout: config.timeout || 10000
    })
    .then(response => {
      const result = response.data
      const code = result.code || 200
      const msg = errorCode[code] || result.msg || errorCode['default']
      if (code === 200) {
        resolve(result)
      } else if (code === 401) {
        Message.confirm("登录状态已过期，您可以继续留在该页面，或者重新登录?").then(res => {
          if (res.confirm) {
            store.dispatch('LogOut').then(() => {
              location.reload()
            })
          }
        })
        reject('无效的会话，或者会话已过期，请重新登录。')
      } else {
        Message.error(msg)
        reject(code)
      }
    })
    .catch(error => {
      let { message } = error
      if (!message) {
        message = '上传失败'
      }
      if (message == 'Network Error') {
        message = '后端接口连接异常'
      } else if (message.includes('timeout')) {
        message = '系统接口请求超时'
      } else if (message.includes('Request failed with status code')) {
        message = '系统接口' + message.substr(message.length - 3) + '异常'
      }
      Message.error(message)
      reject(error)
    })
  })
}

export default uploadFile
