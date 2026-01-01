import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
import TestPage from './components/TestPage.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: App
  },
  {
    path: '/test',
    name: 'Test',
    component: TestPage
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
