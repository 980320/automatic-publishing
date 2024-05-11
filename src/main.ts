import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router/auto'
import App from './App.vue'

import '@unocss/reset/tailwind.css'
import './styles/main.css'
import 'uno.css'

const app = createApp(App)
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
})

const isAuthenticated = true // 假设用户已登录
router.beforeEach(async (to) => {
  if (
    // 检查用户是否已登录
    !isAuthenticated
    // ❗️ 避免无限重定向
    && to.path !== '/login'
  ) {
    // 将用户重定向到登录页面
    return { path: '/login' }
  }
})

app.use(router)
app.mount('#app')
