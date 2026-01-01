<template>
  <div class="api-test-panel card">
    <h4 class="section-title">
      <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
      </svg>
      API Connection Test
    </h4>
    
    <div class="test-info">
      <p>Test your OpenAI API key connection before analyzing fraud cases.</p>
    </div>
    
    <button 
      class="btn btn-primary" 
      @click="testConnection"
      :disabled="testing"
      style="width: 100%;"
    >
      <span v-if="testing" class="loading"></span>
      <span v-else>Test Connection</span>
    </button>
    
    <div v-if="testResult" class="test-result" :class="testResult.success ? 'success' : 'error'">
      <div class="result-header">
        <svg v-if="testResult.success" width="24" height="24" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
        </svg>
        <svg v-else width="24" height="24" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
        </svg>
        <strong>{{ testResult.message }}</strong>
      </div>
      
      <div v-if="testResult.success" class="result-details">
        <div class="detail-item">
          <span class="label">Model:</span>
          <span class="value">{{ testResult.model }}</span>
        </div>
        <div class="detail-item">
          <span class="label">Response:</span>
          <span class="value">{{ testResult.response }}</span>
        </div>
      </div>
      
      <div v-else class="error-details">
        <p><strong>Error:</strong></p>
        <pre>{{ testResult.error }}</pre>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { config } from '../config.js'

const API_BASE = config.BACKEND_URL || 'http://localhost:8000'

export default {
  name: 'ApiTestPanel',
  data() {
    return {
      testing: false,
      testResult: null
    }
  },
  methods: {
    async testConnection() {
      this.testing = true
      this.testResult = null
      
      try {
        const response = await axios.post(`${API_BASE}/api/test-connection`)
        this.testResult = response.data
      } catch (error) {
        this.testResult = {
          success: false,
          message: 'Connection failed',
          error: error.response?.data?.detail || error.message
        }
      } finally {
        this.testing = false
      }
    }
  }
}
</script>

<style scoped>
.api-test-panel {
  background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
  border-left: 4px solid #3b82f6;
  margin-bottom: 24px;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--mc-dark);
  margin-bottom: 12px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.test-info {
  margin-bottom: 16px;
}

.test-info p {
  font-size: 14px;
  color: var(--mc-gray);
  line-height: 1.5;
}

.test-result {
  margin-top: 16px;
  padding: 16px;
  border-radius: 8px;
  animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.test-result.success {
  background: #d1fae5;
  border: 1px solid #10b981;
}

.test-result.error {
  background: #fee2e2;
  border: 1px solid #ef4444;
}

.result-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 12px;
}

.result-header svg {
  flex-shrink: 0;
}

.test-result.success .result-header {
  color: #065f46;
}

.test-result.error .result-header {
  color: #991b1b;
}

.result-details {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-top: 12px;
}

.detail-item {
  display: flex;
  gap: 8px;
  font-size: 13px;
}

.detail-item .label {
  font-weight: 600;
  color: #065f46;
}

.detail-item .value {
  color: #047857;
}

.error-details {
  font-size: 13px;
  color: #991b1b;
}

.error-details p {
  margin-bottom: 8px;
}

.error-details pre {
  background: rgba(0, 0, 0, 0.05);
  padding: 8px;
  border-radius: 4px;
  overflow-x: auto;
  font-size: 12px;
  white-space: pre-wrap;
  word-wrap: break-word;
}
</style>
