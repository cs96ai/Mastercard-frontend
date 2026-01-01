<template>
  <div class="dispute-investigation">
    <div class="container" style="padding-top: 100px; padding-bottom: 40px;">
      <div class="breadcrumb">
        <a href="/" class="breadcrumb-link">
          <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
            <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
          </svg>
          Home
        </a>
        <span class="breadcrumb-separator">/</span>
        <span class="breadcrumb-current">First-Party Fraud Detection</span>
      </div>

      <div class="page-header">
        <h1>First-Party Fraud Detection</h1>
        <p class="subtitle">Forensic AI analysis for chargeback dispute investigation</p>
      </div>

      <div v-if="!selectedDispute" class="disputes-dashboard">
        <div class="dashboard-header card">
          <div class="alert-banner">
            <svg width="24" height="24" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
            </svg>
            <div>
              <strong>{{ disputes.length }} Active Disputes Detected</strong>
              <p>Potential first-party fraud cases requiring investigation</p>
            </div>
          </div>
        </div>

        <div class="disputes-grid">
          <div 
            v-for="dispute in disputes" 
            :key="dispute.case_id"
            class="dispute-card card"
            @click="selectDispute(dispute.case_id)"
          >
            <div class="dispute-header">
              <div class="case-id">{{ dispute.case_id }}</div>
              <div class="status-badge" :class="'status-' + dispute.status.toLowerCase().replace(' ', '-')">
                {{ dispute.status }}
              </div>
            </div>
            <div class="dispute-amount">{{ dispute.transaction_amount }}</div>
            <div class="dispute-claim">
              <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
              </svg>
              <strong>Claim:</strong> {{ dispute.customer_claim }}
            </div>
            <div class="dispute-item">{{ dispute.item }}</div>
            <div class="dispute-date">Filed: {{ dispute.transaction_date }}</div>
            <div class="card-action">
              <span>Run Forensic Analysis</span>
              <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div v-else class="dispute-analysis">
        <div class="analysis-layout">
          <!-- Left Panel: Customer Claim -->
          <div class="claim-panel card">
            <div class="panel-header">
              <h3>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                </svg>
                Customer Dispute
              </h3>
              <button class="btn btn-secondary btn-sm" @click="resetSelection">
                Back to Dashboard
              </button>
            </div>
            <div class="claim-details">
              <div class="detail-row">
                <span class="label">Case ID:</span>
                <span class="value">{{ disputeData.case_id }}</span>
              </div>
              <div class="detail-row">
                <span class="label">Status:</span>
                <span class="value status-badge status-under-investigation">{{ disputeData.status }}</span>
              </div>
              <div class="detail-row">
                <span class="label">Amount:</span>
                <span class="value amount-highlight">{{ disputeData.dispute_details.transaction_amount }}</span>
              </div>
              <div class="detail-row">
                <span class="label">Item:</span>
                <span class="value">{{ disputeData.dispute_details.item }}</span>
              </div>
              <div class="detail-row">
                <span class="label">Claim Type:</span>
                <span class="value claim-type">{{ disputeData.dispute_details.customer_claim }}</span>
              </div>
              <div class="customer-statement">
                <strong>Customer Statement:</strong>
                <p>"{{ disputeData.dispute_details.customer_statement }}"</p>
              </div>
            </div>
          </div>

          <!-- Center Panel: Evidence -->
          <div class="evidence-panel card">
            <div class="panel-header">
              <h3>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clip-rule="evenodd"/>
                </svg>
                Merchant Evidence Bundle
              </h3>
            </div>
            <div class="evidence-details">
              <div class="evidence-section">
                <h4>Shipping & Delivery</h4>
                <div class="evidence-grid">
                  <div class="evidence-item" v-if="disputeData.merchant_evidence.carrier">
                    <span class="evidence-label">Carrier:</span>
                    <span class="evidence-value">{{ disputeData.merchant_evidence.carrier }}</span>
                  </div>
                  <div class="evidence-item" v-if="disputeData.merchant_evidence.tracking_number">
                    <span class="evidence-label">Tracking #:</span>
                    <span class="evidence-value">{{ disputeData.merchant_evidence.tracking_number }}</span>
                  </div>
                  <div class="evidence-item" v-if="disputeData.merchant_evidence.tracking_status">
                    <span class="evidence-label">Status:</span>
                    <span class="evidence-value status-delivered">{{ disputeData.merchant_evidence.tracking_status }}</span>
                  </div>
                  <div class="evidence-item" v-if="disputeData.merchant_evidence.delivery_timestamp">
                    <span class="evidence-label">Delivered:</span>
                    <span class="evidence-value">{{ disputeData.merchant_evidence.delivery_timestamp }}</span>
                  </div>
                  <div class="evidence-item full-width" v-if="disputeData.merchant_evidence.delivery_gps">
                    <span class="evidence-label">GPS Location:</span>
                    <span class="evidence-value gps-match">{{ disputeData.merchant_evidence.delivery_gps }}</span>
                  </div>
                  <div class="evidence-item full-width" v-if="disputeData.merchant_evidence.signature">
                    <span class="evidence-label">Signature:</span>
                    <span class="evidence-value">{{ disputeData.merchant_evidence.signature }}</span>
                  </div>
                  <div class="evidence-item full-width" v-if="disputeData.merchant_evidence.delivery_photo_link">
                    <span class="evidence-label">Photo Evidence:</span>
                    <span class="evidence-value photo-link">{{ disputeData.merchant_evidence.delivery_photo_link }}</span>
                  </div>
                </div>
              </div>

              <div class="evidence-section" v-if="disputeData.merchant_evidence.customer_history">
                <h4>Customer History</h4>
                <div class="evidence-grid">
                  <div class="evidence-item">
                    <span class="evidence-label">Total Orders:</span>
                    <span class="evidence-value">{{ disputeData.merchant_evidence.customer_history.total_orders }}</span>
                  </div>
                  <div class="evidence-item">
                    <span class="evidence-label">Previous Disputes:</span>
                    <span class="evidence-value" :class="disputeData.merchant_evidence.customer_history.previous_disputes > 0 ? 'warning-text' : ''">
                      {{ disputeData.merchant_evidence.customer_history.previous_disputes }}
                    </span>
                  </div>
                  <div class="evidence-item">
                    <span class="evidence-label">Account Age:</span>
                    <span class="evidence-value">{{ disputeData.merchant_evidence.customer_history.account_age_days }} days</span>
                  </div>
                  <div class="evidence-item" v-if="disputeData.merchant_evidence.customer_history.average_order_value">
                    <span class="evidence-label">Avg Order:</span>
                    <span class="evidence-value">{{ disputeData.merchant_evidence.customer_history.average_order_value }}</span>
                  </div>
                </div>
              </div>

              <div class="evidence-section" v-if="disputeData.merchant_evidence.additional_evidence">
                <h4>Additional Evidence</h4>
                <div class="additional-evidence-list">
                  <div 
                    v-for="(value, key) in disputeData.merchant_evidence.additional_evidence" 
                    :key="key"
                    class="additional-evidence-item"
                  >
                    <strong>{{ formatKey(key) }}:</strong>
                    <span>{{ value }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Right Panel: AI Analysis -->
          <div class="analysis-panel card">
            <div class="panel-header">
              <h3>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M13 7H7v6h6V7z"/>
                  <path fill-rule="evenodd" d="M7 2a1 1 0 012 0v1h2V2a1 1 0 112 0v1h2a2 2 0 012 2v2h1a1 1 0 110 2h-1v2h1a1 1 0 110 2h-1v2a2 2 0 01-2 2h-2v1a1 1 0 11-2 0v-1H9v1a1 1 0 11-2 0v-1H5a2 2 0 01-2-2v-2H2a1 1 0 110-2h1V9H2a1 1 0 010-2h1V5a2 2 0 012-2h2V2zM5 5h10v10H5V5z" clip-rule="evenodd"/>
                </svg>
                AI Trust Agent
              </h3>
            </div>

            <div v-if="!analysis" class="analysis-prompt">
              <div class="prompt-content">
                <div class="ai-icon">
                  <svg width="64" height="64" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M13 7H7v6h6V7z"/>
                    <path fill-rule="evenodd" d="M7 2a1 1 0 012 0v1h2V2a1 1 0 112 0v1h2a2 2 0 012 2v2h1a1 1 0 110 2h-1v2h1a1 1 0 110 2h-1v2a2 2 0 01-2 2h-2v1a1 1 0 11-2 0v-1H9v1a1 1 0 11-2 0v-1H5a2 2 0 01-2-2v-2H2a1 1 0 110-2h1V9H2a1 1 0 010-2h1V5a2 2 0 012-2h2V2zM5 5h10v10H5V5z" clip-rule="evenodd"/>
                  </svg>
                </div>
                <h4>Ready to Investigate</h4>
                <p>Click the button below to run forensic AI analysis on this dispute case</p>
                <button 
                  class="btn btn-primary btn-lg"
                  @click="runAnalysis"
                  :disabled="analyzing"
                >
                  <span v-if="analyzing" class="loading"></span>
                  <span v-else>Run AI Trust Agent</span>
                </button>
                <div v-if="analyzing" class="analysis-progress">
                  <div class="progress-step">✓ Fetching carrier GPS data...</div>
                  <div class="progress-step">✓ Checking customer history...</div>
                  <div class="progress-step">✓ Analyzing photo metadata...</div>
                  <div class="progress-step active">⟳ Cross-referencing evidence...</div>
                </div>
              </div>
            </div>

            <div v-else class="analysis-result">
              <div class="result-content" v-html="formattedAnalysis"></div>
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

const API_BASE = config.BACKEND_URL

export default {
  name: 'DisputeInvestigation',
  data() {
    return {
      disputes: [],
      selectedDispute: null,
      disputeData: null,
      analyzing: false,
      analysis: null
    }
  },
  computed: {
    formattedAnalysis() {
      if (!this.analysis) return ''
      
      return this.analysis
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\n\n/g, '</p><p>')
        .replace(/\n/g, '<br>')
        .replace(/^(.*)$/, '<p>$1</p>')
    }
  },
  async mounted() {
    console.log('[DisputeInvestigation] Component mounted')
    await this.loadDisputes()
  },
  methods: {
    async loadDisputes() {
      try {
        console.log('[DisputeInvestigation] Loading disputes...')
        const response = await axios.get(`${API_BASE}/api/disputes`)
        this.disputes = response.data
        console.log('[DisputeInvestigation] Loaded disputes:', this.disputes.length)
      } catch (error) {
        console.error('[DisputeInvestigation] Failed to load disputes:', error)
        console.error('[DisputeInvestigation] Error details:', error.response || error.message)
        console.error('[DisputeInvestigation] Backend URL:', API_BASE)
        alert(`Failed to load disputes. Make sure the backend is running on ${API_BASE}`)
      }
    },
    async selectDispute(caseId) {
      try {
        console.log('[DisputeInvestigation] Selecting dispute:', caseId)
        const response = await axios.get(`${API_BASE}/api/disputes/${caseId}`)
        this.disputeData = response.data
        this.selectedDispute = caseId
        this.analysis = null
        console.log('[DisputeInvestigation] Dispute data loaded')
      } catch (error) {
        console.error('[DisputeInvestigation] Failed to load dispute data:', error)
      }
    },
    resetSelection() {
      this.selectedDispute = null
      this.disputeData = null
      this.analysis = null
    },
    async runAnalysis() {
      this.analyzing = true
      this.analysis = null
      
      try {
        console.log('[DisputeInvestigation] Running forensic analysis...')
        const response = await axios.post(`${API_BASE}/api/analyze-dispute`, {
          case_id: this.selectedDispute
        })
        
        // Simulate analysis delay for better UX
        await new Promise(resolve => setTimeout(resolve, 2000))
        
        this.analysis = response.data.analysis
        console.log('[DisputeInvestigation] Analysis complete')
      } catch (error) {
        console.error('[DisputeInvestigation] Failed to run analysis:', error)
        alert('Failed to run analysis. Please check your API key and try again.')
      } finally {
        this.analyzing = false
      }
    },
    formatKey(key) {
      return key.split('_').map(word => 
        word.charAt(0).toUpperCase() + word.slice(1)
      ).join(' ')
    }
  }
}
</script>

<style scoped>
.dispute-investigation {
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

.dashboard-header {
  margin-bottom: 32px;
}

.alert-banner {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  padding: 20px;
  background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
  border-left: 4px solid var(--mc-danger);
  border-radius: 8px;
}

.alert-banner svg {
  flex-shrink: 0;
  color: var(--mc-danger);
  margin-top: 2px;
}

.alert-banner strong {
  display: block;
  font-size: 18px;
  color: var(--mc-dark);
  margin-bottom: 4px;
}

.alert-banner p {
  font-size: 14px;
  color: var(--mc-gray);
  margin: 0;
}

.disputes-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 24px;
}

.dispute-card {
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.dispute-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--mc-danger) 0%, #dc2626 100%);
  transform: scaleX(0);
  transition: transform 0.3s ease;
}

.dispute-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
}

.dispute-card:hover::before {
  transform: scaleX(1);
}

.dispute-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.case-id {
  font-size: 14px;
  font-weight: 700;
  color: var(--mc-dark);
  font-family: 'Courier New', monospace;
}

.status-badge {
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.status-under-investigation {
  background: #fef3c7;
  color: #92400e;
}

.dispute-amount {
  font-size: 32px;
  font-weight: 700;
  color: var(--mc-danger);
  margin-bottom: 12px;
}

.dispute-claim {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  padding: 12px;
  background: var(--mc-light-gray);
  border-radius: 8px;
  margin-bottom: 12px;
  font-size: 13px;
  line-height: 1.5;
}

.dispute-claim svg {
  flex-shrink: 0;
  color: var(--mc-orange);
  margin-top: 2px;
}

.dispute-item {
  font-size: 15px;
  font-weight: 600;
  color: var(--mc-dark);
  margin-bottom: 8px;
}

.dispute-date {
  font-size: 13px;
  color: var(--mc-gray);
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
  color: var(--mc-danger);
}

.dispute-card:hover .card-action {
  color: #dc2626;
}

.analysis-layout {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 24px;
}

@media (max-width: 1400px) {
  .analysis-layout {
    grid-template-columns: 1fr;
  }
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 2px solid var(--mc-border);
}

.panel-header h3 {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 18px;
  font-weight: 700;
  color: var(--mc-dark);
}

.claim-details {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.detail-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  background: var(--mc-light-gray);
  border-radius: 8px;
}

.detail-row .label {
  font-size: 13px;
  font-weight: 600;
  color: var(--mc-gray);
}

.detail-row .value {
  font-size: 14px;
  font-weight: 600;
  color: var(--mc-dark);
}

.amount-highlight {
  font-size: 18px !important;
  color: var(--mc-danger) !important;
}

.claim-type {
  color: var(--mc-orange) !important;
}

.customer-statement {
  padding: 16px;
  background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
  border-radius: 8px;
  border-left: 4px solid #f59e0b;
}

.customer-statement strong {
  display: block;
  font-size: 12px;
  font-weight: 600;
  color: #92400e;
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.customer-statement p {
  font-size: 14px;
  font-style: italic;
  line-height: 1.6;
  color: #78350f;
  margin: 0;
}

.evidence-section {
  margin-bottom: 24px;
}

.evidence-section h4 {
  font-size: 14px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 12px;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.evidence-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

.evidence-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 10px;
  background: var(--mc-light-gray);
  border-radius: 6px;
}

.evidence-item.full-width {
  grid-column: 1 / -1;
}

.evidence-label {
  font-size: 11px;
  font-weight: 600;
  color: var(--mc-gray);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.evidence-value {
  font-size: 13px;
  font-weight: 600;
  color: var(--mc-dark);
}

.status-delivered {
  color: var(--mc-success) !important;
}

.gps-match {
  color: var(--mc-danger) !important;
  font-family: 'Courier New', monospace;
}

.photo-link {
  color: #3b82f6 !important;
}

.warning-text {
  color: var(--mc-danger) !important;
}

.additional-evidence-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.additional-evidence-item {
  padding: 12px;
  background: var(--mc-light-gray);
  border-radius: 6px;
  font-size: 13px;
  line-height: 1.6;
}

.additional-evidence-item strong {
  display: block;
  color: var(--mc-dark);
  margin-bottom: 4px;
}

.analysis-prompt {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 400px;
}

.prompt-content {
  text-align: center;
  max-width: 400px;
}

.ai-icon {
  margin-bottom: 24px;
  color: #3b82f6;
}

.prompt-content h4 {
  font-size: 20px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 12px;
}

.prompt-content p {
  font-size: 14px;
  color: var(--mc-gray);
  margin-bottom: 24px;
  line-height: 1.6;
}

.btn-lg {
  padding: 14px 32px;
  font-size: 16px;
}

.analysis-progress {
  margin-top: 24px;
  text-align: left;
}

.progress-step {
  padding: 8px 12px;
  font-size: 13px;
  color: var(--mc-success);
  font-family: 'Courier New', monospace;
}

.progress-step.active {
  color: #3b82f6;
  font-weight: 600;
}

.analysis-result {
  padding: 20px;
  background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
  border-radius: 12px;
  border-left: 4px solid var(--mc-success);
}

.result-content >>> p {
  font-size: 14px;
  line-height: 1.8;
  color: var(--mc-dark);
  margin-bottom: 12px;
}

.result-content >>> strong {
  color: #065f46;
  font-weight: 700;
}

.result-content >>> p:last-child {
  margin-bottom: 0;
}

.btn-sm {
  padding: 6px 12px;
  font-size: 13px;
}
</style>
