<template>
  <div class="merchant-insights">
    <div class="container" style="padding-top: 100px; padding-bottom: 40px;">
      <div class="breadcrumb">
        <a href="/" class="breadcrumb-link">
          <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
            <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
          </svg>
          Home
        </a>
        <span class="breadcrumb-separator">/</span>
        <span class="breadcrumb-current">Merchant Insights</span>
      </div>

      <div class="page-header">
        <h1>Merchant Insights Narrative</h1>
        <p class="subtitle">Transform raw merchant KPIs into executive-ready strategic insights</p>
      </div>

      <div v-if="!selectedMerchant" class="merchant-selection">
        <div class="merchants-grid">
          <div 
            v-for="merchant in merchants" 
            :key="merchant.id"
            class="merchant-card card"
            @click="selectMerchant(merchant.id)"
          >
            <div class="merchant-header">
              <h3>{{ merchant.name }}</h3>
              <span class="business-type">{{ merchant.business_type }}</span>
            </div>
            <div class="merchant-location">
              <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/>
              </svg>
              {{ merchant.location }}
            </div>
            <div class="problem-statement">
              <strong>Business Challenge:</strong>
              <p>{{ merchant.problem_statement }}</p>
            </div>
            <div class="card-action">
              <span>Analyze This Merchant</span>
              <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div v-else class="merchant-analysis">
        <div class="analysis-header card">
          <div class="header-content">
            <div>
              <h2>{{ merchantData.name }}</h2>
              <div class="merchant-meta">
                <span class="badge badge-info">{{ merchantData.business_type }}</span>
                <span class="location-text">{{ merchantData.location }}</span>
              </div>
            </div>
            <button class="btn btn-secondary" @click="resetSelection">
              Change Merchant
            </button>
          </div>
          <div class="problem-banner">
            <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
            </svg>
            <strong>Business Challenge:</strong> {{ merchantData.problem_statement }}
          </div>
        </div>

        <div class="kpi-summary card">
          <h3 class="section-title">12-Month KPI Overview</h3>
          <div class="kpi-grid">
            <div class="kpi-item">
              <div class="kpi-label">Total Revenue (12mo)</div>
              <div class="kpi-value">${{ formatNumber(totalRevenue) }}</div>
              <div class="kpi-change" :class="revenueGrowth >= 0 ? 'positive' : 'negative'">
                {{ revenueGrowth >= 0 ? '↑' : '↓' }} {{ Math.abs(revenueGrowth).toFixed(1) }}% YoY
              </div>
            </div>
            <div class="kpi-item">
              <div class="kpi-label">Avg Ticket Size</div>
              <div class="kpi-value">${{ avgTicketSize.toFixed(2) }}</div>
              <div class="kpi-change" :class="ticketGrowth >= 0 ? 'positive' : 'negative'">
                {{ ticketGrowth >= 0 ? '↑' : '↓' }} {{ Math.abs(ticketGrowth).toFixed(1) }}%
              </div>
            </div>
            <div class="kpi-item">
              <div class="kpi-label">Chargeback Rate</div>
              <div class="kpi-value">{{ avgChargebackRate.toFixed(2) }}%</div>
              <div class="kpi-change" :class="avgChargebackRate < 1 ? 'positive' : 'negative'">
                {{ avgChargebackRate < 1 ? 'Healthy' : 'High Risk' }}
              </div>
            </div>
            <div class="kpi-item">
              <div class="kpi-label">Refund Rate</div>
              <div class="kpi-value">{{ avgRefundRate.toFixed(2) }}%</div>
              <div class="kpi-change" :class="refundTrend <= 0 ? 'positive' : 'negative'">
                {{ refundTrend >= 0 ? '↑' : '↓' }} {{ Math.abs(refundTrend).toFixed(1) }}%
              </div>
            </div>
          </div>
        </div>

        <div class="generate-section card">
          <h3 class="section-title">Generate AI Narrative Report</h3>
          <p class="generate-description">
            Our AI will analyze 12 months of KPI data and generate an executive-ready narrative with strategic insights, 
            anomaly detection, and actionable recommendations.
          </p>
          <button 
            class="btn btn-primary" 
            @click="generateNarrative"
            :disabled="generating"
            style="width: 100%;"
          >
            <span v-if="generating" class="loading"></span>
            <span v-else>Generate Weekly Insights Report</span>
          </button>
        </div>

        <div v-if="narrative" class="narrative-report card">
          <div class="report-header">
            <h3>
              <svg width="24" height="24" viewBox="0 0 20 20" fill="currentColor">
                <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
              </svg>
              AI-Generated Strategic Insights Report
            </h3>
            <span class="report-date">Generated: {{ new Date().toLocaleDateString() }}</span>
          </div>
          <div class="report-content">
            <div v-html="formattedNarrative"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { config } from '../config.js'

const API_BASE = config.BACKEND_URL

export default {
  name: 'MerchantInsights',
  data() {
    return {
      merchants: [],
      selectedMerchant: null,
      merchantData: null,
      generating: false,
      narrative: null
    }
  },
  computed: {
    totalRevenue() {
      if (!this.merchantData) return 0
      return this.merchantData.monthly_data.reduce((sum, month) => sum + month.revenue, 0)
    },
    revenueGrowth() {
      if (!this.merchantData) return 0
      const data = this.merchantData.monthly_data
      const firstHalf = data.slice(0, 6).reduce((sum, m) => sum + m.revenue, 0)
      const secondHalf = data.slice(6, 12).reduce((sum, m) => sum + m.revenue, 0)
      return ((secondHalf - firstHalf) / firstHalf) * 100
    },
    avgTicketSize() {
      if (!this.merchantData) return 0
      const avg = this.merchantData.monthly_data.reduce((sum, m) => sum + m.avg_ticket_size, 0) / 12
      return avg
    },
    ticketGrowth() {
      if (!this.merchantData) return 0
      const data = this.merchantData.monthly_data
      const first = data[0].avg_ticket_size
      const last = data[11].avg_ticket_size
      return ((last - first) / first) * 100
    },
    avgChargebackRate() {
      if (!this.merchantData) return 0
      return this.merchantData.monthly_data.reduce((sum, m) => sum + m.chargeback_rate, 0) / 12
    },
    avgRefundRate() {
      if (!this.merchantData) return 0
      return this.merchantData.monthly_data.reduce((sum, m) => sum + m.refund_rate, 0) / 12
    },
    refundTrend() {
      if (!this.merchantData) return 0
      const data = this.merchantData.monthly_data
      const first = data[0].refund_rate
      const last = data[11].refund_rate
      return ((last - first) / first) * 100
    },
    formattedNarrative() {
      if (!this.narrative) return ''
      
      return this.narrative
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\n\n/g, '</p><p>')
        .replace(/\n/g, '<br>')
        .replace(/^(.*)$/, '<p>$1</p>')
    }
  },
  async mounted() {
    console.log('[MerchantInsights] Component mounted')
    await this.loadMerchants()
  },
  methods: {
    async loadMerchants() {
      try {
        console.log('[MerchantInsights] Loading merchants...')
        const response = await axios.get(`${API_BASE}/api/merchants`)
        console.log('[MerchantInsights] Response:', response)
        this.merchants = response.data
        console.log('[MerchantInsights] Loaded merchants:', this.merchants.length)
      } catch (error) {
        console.error('[MerchantInsights] Failed to load merchants:', error)
        console.error('[MerchantInsights] Error details:', error.response || error.message)
        console.error('[MerchantInsights] Backend URL:', API_BASE)
        alert(`Failed to load merchants. Make sure the backend is running on ${API_BASE}`)
      }
    },
    async selectMerchant(merchantId) {
      try {
        console.log('[MerchantInsights] Selecting merchant:', merchantId)
        const response = await axios.get(`${API_BASE}/api/merchants/${merchantId}`)
        this.merchantData = response.data
        this.selectedMerchant = merchantId
        this.narrative = null
        console.log('[MerchantInsights] Merchant data loaded')
      } catch (error) {
        console.error('[MerchantInsights] Failed to load merchant data:', error)
      }
    },
    resetSelection() {
      this.selectedMerchant = null
      this.merchantData = null
      this.narrative = null
    },
    async generateNarrative() {
      this.generating = true
      this.narrative = null
      
      try {
        console.log('[MerchantInsights] Generating narrative...')
        const response = await axios.post(`${API_BASE}/api/generate-merchant-narrative`, {
          merchant_id: this.selectedMerchant
        })
        this.narrative = response.data.narrative
        console.log('[MerchantInsights] Narrative generated')
      } catch (error) {
        console.error('[MerchantInsights] Failed to generate narrative:', error)
        alert('Failed to generate narrative. Please check your API key and try again.')
      } finally {
        this.generating = false
      }
    },
    formatNumber(num) {
      return num.toLocaleString()
    }
  }
}
</script>

<style scoped>
.merchant-insights {
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

.merchant-selection h2 {
  font-size: 24px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 8px;
  text-align: center;
}

.selection-subtitle {
  text-align: center;
  color: var(--mc-gray);
  margin-bottom: 32px;
}

.merchants-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 24px;
}

@media (max-width: 768px) {
  .merchants-grid {
    grid-template-columns: 1fr;
  }
}

.merchant-card {
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.merchant-card::before {
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

.merchant-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
}

.merchant-card:hover::before {
  transform: scaleX(1);
}

.merchant-header {
  margin-bottom: 12px;
}

.merchant-header h3 {
  font-size: 20px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 8px;
}

.business-type {
  display: inline-block;
  padding: 4px 12px;
  background: var(--mc-light-gray);
  border-radius: 6px;
  font-size: 12px;
  font-weight: 600;
  color: var(--mc-dark);
}

.merchant-location {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--mc-gray);
  font-size: 14px;
  margin-bottom: 16px;
}

.problem-statement {
  padding: 16px;
  background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
  border-radius: 8px;
  margin-bottom: 16px;
}

.problem-statement strong {
  display: block;
  font-size: 12px;
  font-weight: 600;
  color: #92400e;
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.problem-statement p {
  font-size: 14px;
  line-height: 1.5;
  color: #78350f;
  margin: 0;
}

.card-action {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 16px;
  border-top: 1px solid var(--mc-border);
  font-weight: 600;
  color: #3b82f6;
}

.merchant-card:hover .card-action {
  color: #1e40af;
}

.analysis-header {
  margin-bottom: 24px;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.header-content h2 {
  font-size: 28px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 12px;
}

.merchant-meta {
  display: flex;
  align-items: center;
  gap: 12px;
}

.location-text {
  color: var(--mc-gray);
  font-size: 14px;
}

.problem-banner {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 16px;
  background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
  border-radius: 8px;
  color: #78350f;
  font-size: 14px;
  line-height: 1.6;
}

.problem-banner svg {
  flex-shrink: 0;
  margin-top: 2px;
}

.section-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 20px;
}

.kpi-summary {
  margin-bottom: 24px;
}

.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 24px;
}

.kpi-item {
  text-align: center;
  padding: 20px;
  background: var(--mc-light-gray);
  border-radius: 12px;
}

.kpi-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--mc-gray);
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-bottom: 8px;
}

.kpi-value {
  font-size: 32px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 8px;
}

.kpi-change {
  font-size: 14px;
  font-weight: 600;
}

.kpi-change.positive {
  color: var(--mc-success);
}

.kpi-change.negative {
  color: var(--mc-danger);
}

.generate-section {
  margin-bottom: 24px;
}

.generate-description {
  font-size: 14px;
  line-height: 1.6;
  color: var(--mc-gray);
  margin-bottom: 20px;
}

.narrative-report {
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

.report-date {
  font-size: 13px;
  color: #047857;
  font-weight: 600;
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
