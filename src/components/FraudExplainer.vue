<template>
  <div class="fraud-explainer">
    <div class="breadcrumb">
      <a href="/" class="breadcrumb-link">
        <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
          <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
        </svg>
        Home
      </a>
      <span class="breadcrumb-separator">/</span>
      <span class="breadcrumb-current">Fraud Case Explainer</span>
    </div>
    
    <div class="controls-section card">
      <div class="controls-header">
        <h2>Fraud Case Explorer</h2>
        <div class="scenario-counter">
          <span class="current">{{ currentScenarioIndex + 1 }}</span>
          <span class="separator">/</span>
          <span class="total">{{ totalScenarios }}</span>
        </div>
      </div>
      
      <div class="controls-row">
        <div class="navigation-controls">
          <button 
            class="btn btn-secondary nav-btn" 
            @click="previousScenario"
            :disabled="currentScenarioIndex === 0"
          >
            <svg width="16" height="16" viewBox="0 0 16 16" fill="currentColor">
              <path d="M10 12L6 8L10 4" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            Previous
          </button>
          
          <button 
            class="btn btn-secondary nav-btn" 
            @click="nextScenario"
            :disabled="currentScenarioIndex === totalScenarios - 1"
          >
            Next
            <svg width="16" height="16" viewBox="0 0 16 16" fill="currentColor">
              <path d="M6 4L10 8L6 12" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </button>
        </div>
        
        <div class="audience-control">
          <label for="audience">Audience:</label>
          <select 
            id="audience" 
            v-model="selectedAudience" 
            class="select"
            @change="analyzeCurrentScenario"
          >
            <option value="Risk Analyst">Risk Analyst</option>
            <option value="Executive Summary">Executive Summary</option>
            <option value="Customer-friendly">Customer-friendly</option>
          </select>
        </div>
      </div>
    </div>

    <div v-if="loading" class="loading-state card">
      <div class="loading-spinner"></div>
      <p>Analyzing transaction with AI...</p>
    </div>

    <div v-else-if="currentScenario" class="scenario-content">
      <div class="scenario-grid">
        <div class="left-column">
          <div class="card case-header">
            <div class="case-title-row">
              <h3>{{ currentScenario.case_name }}</h3>
              <span class="badge badge-danger">FLAGGED</span>
            </div>
          </div>

          <div class="card account-info">
            <h4 class="section-title">Account Information</h4>
            <div class="info-grid">
              <div class="info-item">
                <span class="label">Cardholder</span>
                <span class="value">{{ currentScenario.account.cardholder_name }}</span>
              </div>
              <div class="info-item">
                <span class="label">Account Number</span>
                <span class="value">{{ currentScenario.account.account_number }}</span>
              </div>
              <div class="info-item">
                <span class="label">Address</span>
                <span class="value">{{ currentScenario.account.address }}</span>
              </div>
              <div class="info-item">
                <span class="label">Account Age</span>
                <span class="value">{{ currentScenario.account.account_age_days }} days</span>
              </div>
              <div class="info-item">
                <span class="label">Avg Monthly Spend</span>
                <span class="value">${{ currentScenario.account.typical_monthly_spend.toFixed(2) }}</span>
              </div>
              <div class="info-item">
                <span class="label">Past Chargebacks</span>
                <span class="value">{{ currentScenario.account.past_chargebacks }}</span>
              </div>
            </div>
          </div>

          <div class="card flagged-transaction">
            <h4 class="section-title">
              <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor" style="color: var(--mc-danger);">
                <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
              </svg>
              Flagged Transaction
            </h4>
            <div class="transaction-highlight">
              <div class="transaction-amount">
                ${{ currentScenario.flagged_transaction.amount.toFixed(2) }}
              </div>
              <div class="transaction-details">
                <div class="detail-row">
                  <span class="label">Merchant:</span>
                  <span class="value">{{ currentScenario.flagged_transaction.merchant }}</span>
                </div>
                <div class="detail-row">
                  <span class="label">MCC:</span>
                  <span class="value">{{ currentScenario.flagged_transaction.mcc }} - {{ currentScenario.flagged_transaction.mcc_description }}</span>
                </div>
                <div class="detail-row">
                  <span class="label">Location:</span>
                  <span class="value">{{ currentScenario.flagged_transaction.location }}</span>
                </div>
                <div class="detail-row">
                  <span class="label">Time:</span>
                  <span class="value">{{ formatDate(currentScenario.flagged_transaction.timestamp) }}</span>
                </div>
                <div class="detail-row">
                  <span class="label">Device:</span>
                  <span class="value">{{ currentScenario.flagged_transaction.device_id }}</span>
                </div>
                <div class="detail-row">
                  <span class="label">Card Present:</span>
                  <span class="value">{{ currentScenario.flagged_transaction.card_present ? 'Yes' : 'No' }}</span>
                </div>
                <div class="detail-row" v-if="currentScenario.flagged_transaction.ip_address !== 'N/A'">
                  <span class="label">IP Address:</span>
                  <span class="value">{{ currentScenario.flagged_transaction.ip_address }}</span>
                </div>
                <div class="detail-row">
                  <span class="label">Transaction ID:</span>
                  <span class="value">{{ currentScenario.flagged_transaction.transaction_id }}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="card fraud-indicators">
            <h4 class="section-title">Fraud Indicators</h4>
            <div class="indicators-grid">
              <div 
                v-for="(value, key) in currentScenario.fraud_indicators" 
                :key="key"
                class="indicator-item"
              >
                <div class="indicator-label">{{ formatIndicatorLabel(key) }}</div>
                <div class="indicator-value">{{ formatIndicatorValue(value) }}</div>
              </div>
            </div>
          </div>

          <div class="card historical-transactions">
            <h4 class="section-title">Recent Transaction History</h4>
            <div class="transactions-list">
              <div 
                v-for="(txn, index) in currentScenario.historical_transactions" 
                :key="index"
                class="transaction-item"
              >
                <div class="txn-date">{{ txn.date }}</div>
                <div class="txn-merchant">{{ txn.merchant }}</div>
                <div class="txn-location">{{ txn.location }}</div>
                <div class="txn-amount">${{ txn.amount.toFixed(2) }}</div>
              </div>
            </div>
          </div>
        </div>

        <div class="right-column">
          <div class="card ai-analysis">
            <div class="analysis-header">
              <h4 class="section-title">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor" style="color: var(--mc-orange);">
                  <path d="M13 7H7v6h6V7z"/>
                  <path fill-rule="evenodd" d="M7 2a1 1 0 012 0v1h2V2a1 1 0 112 0v1h2a2 2 0 012 2v2h1a1 1 0 110 2h-1v2h1a1 1 0 110 2h-1v2a2 2 0 01-2 2h-2v1a1 1 0 11-2 0v-1H9v1a1 1 0 11-2 0v-1H5a2 2 0 01-2-2v-2H2a1 1 0 110-2h1V9H2a1 1 0 010-2h1V5a2 2 0 012-2h2V2zM5 5h10v10H5V5z" clip-rule="evenodd"/>
                </svg>
                AI Analysis
              </h4>
              <span class="badge badge-info">{{ selectedAudience }}</span>
            </div>
            
            <div v-if="analysis" class="analysis-content">
              <div class="analysis-text">{{ analysis }}</div>
            </div>
            
            <div v-else class="analysis-placeholder">
              <p>Click "Analyze" or change the audience to generate AI analysis</p>
            </div>
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
  name: 'FraudExplainer',
  data() {
    return {
      scenarios: [],
      currentScenarioIndex: 0,
      selectedAudience: 'Risk Analyst',
      analysis: '',
      loading: false,
      totalScenarios: 0
    }
  },
  computed: {
    currentScenario() {
      return this.scenarios[this.currentScenarioIndex] || null
    }
  },
  async mounted() {
    await this.loadScenarios()
  },
  methods: {
    async loadScenarios() {
      try {
        const response = await axios.get(`${API_BASE}/api/scenarios`)
        this.scenarios = response.data.scenarios
        this.totalScenarios = response.data.total
        
        if (this.scenarios.length > 0) {
          await this.analyzeCurrentScenario()
        }
      } catch (error) {
        console.error('Failed to load scenarios:', error)
      }
    },
    
    async analyzeCurrentScenario() {
      if (!this.currentScenario) return
      
      this.loading = true
      this.analysis = ''
      
      try {
        const response = await axios.post(`${API_BASE}/api/analyze-fraud`, {
          scenario_id: this.currentScenarioIndex,
          audience: this.selectedAudience
        })
        
        this.analysis = response.data.analysis
      } catch (error) {
        console.error('Failed to analyze scenario:', error)
        this.analysis = error.response?.data?.detail || error.message || 'Failed to generate analysis.'
      } finally {
        this.loading = false
      }
    },
    
    async nextScenario() {
      if (this.currentScenarioIndex < this.totalScenarios - 1) {
        this.currentScenarioIndex++
        await this.analyzeCurrentScenario()
      }
    },
    
    async previousScenario() {
      if (this.currentScenarioIndex > 0) {
        this.currentScenarioIndex--
        await this.analyzeCurrentScenario()
      }
    },
    
    formatDate(timestamp) {
      return new Date(timestamp).toLocaleString()
    },
    
    formatIndicatorLabel(key) {
      return key.split('_').map(word => 
        word.charAt(0).toUpperCase() + word.slice(1)
      ).join(' ')
    },
    
    formatIndicatorValue(value) {
      if (typeof value === 'boolean') {
        return value ? 'Yes' : 'No'
      }
      return value
    }
  }
}
</script>

<style scoped>
.fraud-explainer {
  max-width: 1600px;
  margin: 0 auto;
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

.controls-section {
  margin-bottom: 24px;
}

.controls-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.controls-header h2 {
  font-size: 24px;
  font-weight: 700;
  color: var(--mc-dark);
}

.scenario-counter {
  display: flex;
  align-items: baseline;
  gap: 4px;
  font-size: 14px;
  color: var(--mc-gray);
}

.scenario-counter .current {
  font-size: 24px;
  font-weight: 700;
  color: var(--mc-orange);
}

.scenario-counter .separator {
  font-size: 18px;
  color: var(--mc-gray);
}

.scenario-counter .total {
  font-size: 18px;
  font-weight: 600;
  color: var(--mc-gray);
}

.controls-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  flex-wrap: wrap;
}

.navigation-controls {
  display: flex;
  gap: 12px;
}

.nav-btn {
  min-width: 120px;
}

.audience-control {
  display: flex;
  align-items: center;
  gap: 12px;
}

.audience-control label {
  font-size: 14px;
  font-weight: 600;
  color: var(--mc-dark);
}

.audience-control .select {
  min-width: 200px;
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 24px;
  gap: 16px;
}

.loading-spinner {
  width: 48px;
  height: 48px;
  border: 4px solid var(--mc-light-gray);
  border-top-color: var(--mc-orange);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

.loading-state p {
  font-size: 16px;
  color: var(--mc-gray);
}

.scenario-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}

@media (max-width: 1200px) {
  .scenario-grid {
    grid-template-columns: 1fr;
  }
}

.left-column, .right-column {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.case-header {
  background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
  border-left: 4px solid var(--mc-danger);
}

.case-title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.case-title-row h3 {
  font-size: 20px;
  font-weight: 700;
  color: var(--mc-dark);
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--mc-dark);
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.info-item .label {
  font-size: 12px;
  font-weight: 500;
  color: var(--mc-gray);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.info-item .value {
  font-size: 14px;
  font-weight: 600;
  color: var(--mc-dark);
}

.flagged-transaction {
  background: linear-gradient(135deg, #fff7ed 0%, #ffedd5 100%);
  border-left: 4px solid var(--mc-orange);
}

.transaction-highlight {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.transaction-amount {
  font-size: 36px;
  font-weight: 700;
  color: var(--mc-danger);
  letter-spacing: -0.02em;
}

.transaction-details {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.detail-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.detail-row:last-child {
  border-bottom: none;
}

.detail-row .label {
  font-size: 13px;
  font-weight: 500;
  color: var(--mc-gray);
}

.detail-row .value {
  font-size: 13px;
  font-weight: 600;
  color: var(--mc-dark);
  text-align: right;
}

.indicators-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 12px;
}

.indicator-item {
  padding: 12px;
  background: var(--mc-light-gray);
  border-radius: 8px;
  border-left: 3px solid var(--mc-warning);
}

.indicator-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--mc-dark);
  margin-bottom: 4px;
}

.indicator-value {
  font-size: 13px;
  color: var(--mc-gray);
}

.transactions-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.transaction-item {
  display: grid;
  grid-template-columns: 100px 1fr 1fr auto;
  gap: 12px;
  padding: 12px;
  background: var(--mc-light-gray);
  border-radius: 8px;
  align-items: center;
}

.txn-date {
  font-size: 12px;
  font-weight: 600;
  color: var(--mc-gray);
}

.txn-merchant {
  font-size: 13px;
  font-weight: 600;
  color: var(--mc-dark);
}

.txn-location {
  font-size: 12px;
  color: var(--mc-gray);
}

.txn-amount {
  font-size: 14px;
  font-weight: 700;
  color: var(--mc-dark);
  text-align: right;
}

.ai-analysis {
  position: sticky;
  top: 116px;
  background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
  border-left: 4px solid var(--mc-success);
}

.analysis-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.analysis-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
}

.analysis-text {
  font-size: 14px;
  line-height: 1.7;
  color: var(--mc-dark);
  white-space: pre-wrap;
}

.analysis-placeholder {
  background: white;
  padding: 40px 20px;
  border-radius: 8px;
  text-align: center;
}

.analysis-placeholder p {
  font-size: 14px;
  color: var(--mc-gray);
}
</style>
