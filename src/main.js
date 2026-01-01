import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
import TestPage from './components/TestPage.vue'
import LandingPage from './components/LandingPage.vue'
import MerchantInsights from './components/MerchantInsights.vue'
import CustomerUpgrade from './components/CustomerUpgrade.vue'
import DisputeInvestigation from './components/DisputeInvestigation.vue'
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
import './style.css'

console.log('[Main] Starting application...')

const MainApp = {
  template: `
    <div id="app">
      <Header />
      <router-view></router-view>
      <Footer />
    </div>
  `,
  components: {
    Header,
    Footer
  },
  mounted() {
    console.log('[MainApp] Main app component mounted')
  }
}

const routes = [
  {
    path: '/',
    name: 'Home',
    component: LandingPage
  },
  {
    path: '/fraud-explainer',
    name: 'FraudExplainer',
    component: App
  },
  {
    path: '/merchant-insights',
    name: 'MerchantInsights',
    component: MerchantInsights
  },
  {
    path: '/customer-upgrade',
    name: 'CustomerUpgrade',
    component: CustomerUpgrade
  },
  {
    path: '/dispute-investigation',
    name: 'DisputeInvestigation',
    component: DisputeInvestigation
  },
  {
    path: '/test',
    name: 'Test',
    component: TestPage
  }
]

console.log('[Main] Routes configured:', routes)

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  console.log('[Router] Navigating from', from.path, 'to', to.path)
  next()
})

const app = createApp(MainApp)
app.use(router)
app.mount('#app')

console.log('[Main] Application mounted')
