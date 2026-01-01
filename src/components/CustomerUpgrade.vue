<template>
  <div class="customer-upgrade">
    <div class="container" style="padding-top: 100px; padding-bottom: 40px;">
      <div class="breadcrumb">
        <a href="/" class="breadcrumb-link">
          <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
            <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
          </svg>
          Home
        </a>
        <span class="breadcrumb-separator">/</span>
        <span class="breadcrumb-current">Customer Upgrade Recommendations</span>
      </div>

      <div class="page-header">
        <h1>Customer Upgrade Recommendations</h1>
        <p class="subtitle">AI-powered product upgrade analysis for enhanced customer value</p>
      </div>

      <div v-if="!selectedCustomer" class="customer-selection">
        <div class="customers-grid">
          <div 
            v-for="customer in customers" 
            :key="customer.customer_id"
            class="customer-card card"
            @click="selectCustomer(customer.customer_id)"
          >
            <div class="customer-header">
              <h3>{{ customer.name }}</h3>
              <span class="age-occupation">{{ customer.age }} • {{ customer.occupation }}</span>
            </div>
            <div class="customer-stats">
              <div class="stat-item">
                <span class="stat-label">Monthly Spend</span>
                <span class="stat-value">${{ formatNumber(customer.monthly_spend) }}</span>
              </div>
              <div class="stat-item">
                <span class="stat-label">Card Type</span>
                <span class="stat-value">{{ customer.card_type }}</span>
              </div>
              <div class="stat-item">
                <span class="stat-label">Utilization</span>
                <span class="stat-value" :class="getUtilizationClass(customer.credit_utilization)">
                  {{ customer.credit_utilization }}%
                </span>
              </div>
            </div>
            <div class="customer-location">
              <svg width="14" height="14" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/>
              </svg>
              {{ customer.location }}
            </div>
            <div class="card-action">
              <span>Analyze Upgrade Opportunities</span>
              <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div v-else class="customer-analysis">
        <div class="analysis-header card">
          <div class="header-content">
            <div>
              <h2>{{ customerData.name }}</h2>
              <div class="customer-meta">
                <span class="badge badge-info">{{ customerData.card_type }}</span>
                <span class="meta-text">{{ customerData.age }} years old • {{ customerData.occupation }}</span>
                <span class="meta-text">{{ customerData.location }}</span>
              </div>
            </div>
            <button class="btn btn-secondary" @click="resetSelection">
              Change Customer
            </button>
          </div>
        </div>

        <div class="profile-overview card">
          <h3 class="section-title">Customer Profile Overview</h3>
          <div class="profile-grid">
            <div class="profile-item">
              <div class="profile-label">Monthly Spend</div>
              <div class="profile-value">${{ formatNumber(customerData.monthly_spend) }}</div>
            </div>
            <div class="profile-item">
              <div class="profile-label">Credit Utilization</div>
              <div class="profile-value" :class="getUtilizationClass(customerData.credit_utilization)">
                {{ customerData.credit_utilization }}%
              </div>
            </div>
            <div class="profile-item">
              <div class="profile-label">Payment Behavior</div>
              <div class="profile-value">{{ customerData.payment_behavior }}</div>
            </div>
            <div class="profile-item">
              <div class="profile-label">Income Band</div>
              <div class="profile-value">{{ customerData.income_band }}</div>
            </div>
            <div class="profile-item">
              <div class="profile-label">Credit Score</div>
              <div class="profile-value">{{ customerData.credit_score_band }}</div>
            </div>
            <div class="profile-item">
              <div class="profile-label">Account Age</div>
              <div class="profile-value">{{ customerData.account_age_months }} months</div>
            </div>
          </div>

          <div class="spending-breakdown">
            <h4>Spending Categories</h4>
            <div class="spending-grid">
              <div 
                v-for="(amount, category) in customerData.spend_categories" 
                :key="category"
                class="spending-item"
              >
                <div class="spending-bar-container">
                  <div class="spending-label">{{ formatCategory(category) }}</div>
                  <div class="spending-bar">
                    <div 
                      class="spending-fill" 
                      :style="{ width: getSpendingPercentage(amount) + '%' }"
                    ></div>
                  </div>
                  <div class="spending-amount">${{ formatNumber(amount) }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="analysis-controls card">
          <h3 class="section-title">Generate Upgrade Recommendations</h3>
          <div class="controls-grid">
            <div class="control-group">
              <label>Output Mode</label>
              <select v-model="outputMode" class="select">
                <option value="Executive">Executive Summary</option>
                <option value="Analyst">Analyst Report</option>
                <option value="Customer-friendly">Customer-Friendly</option>
              </select>
            </div>
            <div class="control-group">
              <label>Format</label>
              <select v-model="formatMode" class="select">
                <option value="JSON">JSON Structure</option>
                <option value="Narrative">Narrative</option>
              </select>
            </div>
          </div>
          <button 
            class="btn btn-primary" 
            @click="generateRecommendation"
            :disabled="generating"
            style="width: 100%; margin-top: 16px;"
          >
            <span v-if="generating" class="loading"></span>
            <span v-else>Generate AI Recommendations</span>
          </button>
        </div>

        <div v-if="recommendation" class="recommendation-report card">
          <div class="report-header">
            <h3>
              <svg width="24" height="24" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V7.414A2 2 0 0015.414 6L12 2.586A2 2 0 0010.586 2H6zm5 6a1 1 0 10-2 0v3.586l-1.293-1.293a1 1 0 10-1.414 1.414l3 3a1 1 0 001.414 0l3-3a1 1 0 00-1.414-1.414L11 11.586V8z" clip-rule="evenodd"/>
              </svg>
              AI-Generated Upgrade Recommendations
            </h3>
            <div class="report-badges">
              <span class="badge badge-success">{{ outputMode }}</span>
              <span class="badge badge-info">{{ formatMode }}</span>
            </div>
          </div>
          <div class="report-content">
            <div v-html="formattedRecommendation"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { config } from '../config.js'

const API_BASE = config.BACKEND_URL || 'http://localhost:8000'

export default {
  name: 'CustomerUpgrade',
  data() {
    return {
      customers: [],
      selectedCustomer: null,
      customerData: null,
      outputMode: 'Executive',
      formatMode: 'Narrative',
      generating: false,
      recommendation: null
    }
  },
  computed: {
    formattedRecommendation() {
      if (!this.recommendation) return ''
      
      return this.recommendation
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\n\n/g, '</p><p>')
        .replace(/\n/g, '<br>')
        .replace(/^(.*)$/, '<p>$1</p>')
    }
  },
  async mounted() {
    console.log('[CustomerUpgrade] Component mounted')
    await this.loadCustomers()
  },
  methods: {
    async loadCustomers() {
      try {
        console.log('[CustomerUpgrade] Loading customers...')
        const response = await axios.get(`${API_BASE}/api/customers`)
        this.customers = response.data
        console.log('[CustomerUpgrade] Loaded customers:', this.customers.length)
      } catch (error) {
        console.error('[CustomerUpgrade] Failed to load customers:', error)
        console.error('[CustomerUpgrade] Error details:', error.response || error.message)
        console.error('[CustomerUpgrade] Backend URL:', API_BASE)
        alert(`Failed to load customers. Make sure the backend is running on ${API_BASE}`)
      }
    },
    async selectCustomer(customerId) {
      try {
        console.log('[CustomerUpgrade] Selecting customer:', customerId)
        const response = await axios.get(`${API_BASE}/api/customers/${customerId}`)
        this.customerData = response.data
        this.selectedCustomer = customerId
        this.recommendation = null
        console.log('[CustomerUpgrade] Customer data loaded')
      } catch (error) {
        console.error('[CustomerUpgrade] Failed to load customer data:', error)
      }
    },
    resetSelection() {
      this.selectedCustomer = null
      this.customerData = null
      this.recommendation = null
    },
    async generateRecommendation() {
      this.generating = true
      this.recommendation = null
      
      try {
        console.log('[CustomerUpgrade] Generating recommendation...')
        const response = await axios.post(`${API_BASE}/api/analyze-customer-upgrade`, {
          customer_id: this.selectedCustomer,
          output_mode: this.outputMode,
          format_mode: this.formatMode
        })
        this.recommendation = response.data.recommendation
        console.log('[CustomerUpgrade] Recommendation generated')
      } catch (error) {
        console.error('[CustomerUpgrade] Failed to generate recommendation:', error)
        alert('Failed to generate recommendation. Please check your API key and try again.')
      } finally {
        this.generating = false
      }
    },
    formatNumber(num) {
      return num.toLocaleString()
    },
    formatCategory(category) {
      return category.split('_').map(word => 
        word.charAt(0).toUpperCase() + word.slice(1)
      ).join(' ')
    },
    getSpendingPercentage(amount) {
      if (!this.customerData) return 0
      return (amount / this.customerData.monthly_spend) * 100
    },
    getUtilizationClass(utilization) {
      if (utilization >= 80) return 'high-risk'
      if (utilization >= 60) return 'medium-risk'
      return 'low-risk'
    }
  }
}
</script>

<style scoped>
.customer-upgrade {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
}

.breadcrumb {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 24px;
  padding: 12px 16px;
  background: white;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  font-size: 14px;
}

.breadcrumb-link {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--mc-orange);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s;
}

.breadcrumb-link:hover {
  color: var(--mc-red);
}

.breadcrumb-separator {
  color: var(--mc-gray);
}

.breadcrumb-current {
  color: var(--mc-dark);
  font-weight: 600;
}

.page-header {
  text-align: center;
  margin-bottom: 48px;
}

.page-header h1 {
  font-size: 36px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 12px;
}

.subtitle {
  font-size: 18px;
  color: var(--mc-gray);
}

.customers-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 24px;
}

.customer-card {
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.customer-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #3b82f6 0%, #1e40af 100%);
  transform: scaleX(0);
  transition: transform 0.3s ease;
}

.customer-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
}

.customer-card:hover::before {
  transform: scaleX(1);
}

.customer-header {
  margin-bottom: 16px;
}

.customer-header h3 {
  font-size: 18px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 4px;
}

.age-occupation {
  font-size: 13px;
  color: var(--mc-gray);
}

.customer-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
  margin-bottom: 16px;
  padding: 12px;
  background: var(--mc-light-gray);
  border-radius: 8px;
}

.stat-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-label {
  font-size: 11px;
  font-weight: 600;
  color: var(--mc-gray);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.stat-value {
  font-size: 14px;
  font-weight: 700;
  color: var(--mc-dark);
}

.stat-value.high-risk {
  color: var(--mc-danger);
}

.stat-value.medium-risk {
  color: #f59e0b;
}

.stat-value.low-risk {
  color: var(--mc-success);
}

.customer-location {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--mc-gray);
  font-size: 13px;
  margin-bottom: 16px;
}

.card-action {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 16px;
  border-top: 1px solid var(--mc-border);
  font-weight: 600;
  font-size: 14px;
  color: #3b82f6;
}

.customer-card:hover .card-action {
  color: #1e40af;
}

.analysis-header {
  margin-bottom: 24px;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.header-content h2 {
  font-size: 28px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 12px;
}

.customer-meta {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}

.meta-text {
  color: var(--mc-gray);
  font-size: 14px;
}

.section-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 20px;
}

.profile-overview {
  margin-bottom: 24px;
}

.profile-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-bottom: 32px;
}

.profile-item {
  text-align: center;
  padding: 16px;
  background: var(--mc-light-gray);
  border-radius: 8px;
}

.profile-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--mc-gray);
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-bottom: 8px;
}

.profile-value {
  font-size: 18px;
  font-weight: 700;
  color: var(--mc-dark);
}

.spending-breakdown h4 {
  font-size: 16px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 16px;
}

.spending-grid {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.spending-item {
  padding: 12px;
  background: var(--mc-light-gray);
  border-radius: 8px;
}

.spending-bar-container {
  display: grid;
  grid-template-columns: 150px 1fr 100px;
  gap: 12px;
  align-items: center;
}

.spending-label {
  font-size: 13px;
  font-weight: 600;
  color: var(--mc-dark);
}

.spending-bar {
  height: 24px;
  background: white;
  border-radius: 6px;
  overflow: hidden;
}

.spending-fill {
  height: 100%;
  background: linear-gradient(90deg, #3b82f6 0%, #1e40af 100%);
  transition: width 0.3s ease;
}

.spending-amount {
  font-size: 14px;
  font-weight: 700;
  color: var(--mc-dark);
  text-align: right;
}

.analysis-controls {
  margin-bottom: 24px;
}

.controls-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 16px;
}

.control-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.control-group label {
  font-size: 13px;
  font-weight: 600;
  color: var(--mc-dark);
}

.recommendation-report {
  background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
  border-left: 4px solid var(--mc-success);
}

.report-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 2px solid rgba(0, 0, 0, 0.1);
}

.report-header h3 {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 20px;
  font-weight: 700;
  color: #065f46;
}

.report-badges {
  display: flex;
  gap: 8px;
}

.report-content {
  background: white;
  padding: 32px;
  border-radius: 12px;
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
}

.report-content >>> p {
  font-size: 15px;
  line-height: 1.8;
  color: var(--mc-dark);
  margin-bottom: 16px;
}

.report-content >>> strong {
  color: #065f46;
  font-weight: 700;
}

.report-content >>> p:last-child {
  margin-bottom: 0;
}
</style>
