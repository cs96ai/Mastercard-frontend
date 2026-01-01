<template>
  <div class="test-page">
    <div class="container" style="padding-top: 100px;">
      <div class="card test-card">
        <h1>OpenAI API Test Page</h1>
        <p class="subtitle">Test your OpenAI connection with a simple prompt</p>
        
        <div class="test-section">
          <h3>Test Prompt</h3>
          <textarea 
            v-model="testPrompt" 
            class="input test-prompt"
            rows="4"
            placeholder="Enter a test prompt..."
          ></textarea>
          
          <button 
            class="btn btn-primary" 
            @click="testOpenAI"
            :disabled="testing || !testPrompt"
            style="width: 100%; margin-top: 16px;"
          >
            <span v-if="testing" class="loading"></span>
            <span v-else>Send Test Request</span>
          </button>
        </div>
        
        <div v-if="result" class="result-section" :class="result.success ? 'success' : 'error'">
          <h3>{{ result.success ? '✅ Success' : '❌ Error' }}</h3>
          
          <div v-if="result.success" class="success-content">
            <div class="result-item">
              <strong>Model:</strong>
              <span>{{ result.model }}</span>
            </div>
            <div class="result-item">
              <strong>Response:</strong>
              <div class="response-text">{{ result.response }}</div>
            </div>
            <div class="result-item">
              <strong>Tokens Used:</strong>
              <span>{{ result.usage?.total_tokens || 'N/A' }}</span>
            </div>
          </div>
          
          <div v-else class="error-content">
            <strong>Error Message:</strong>
            <pre>{{ result.error }}</pre>
          </div>
        </div>
        
        <div class="back-link">
          <a href="/">← Back to Fraud Analysis</a>
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
  name: 'TestPage',
  data() {
    return {
      testPrompt: 'Hello! Please respond with "API connection successful!" if you can read this message.',
      testing: false,
      result: null
    }
  },
  methods: {
    async testOpenAI() {
      if (!this.testPrompt) return
      
      this.testing = true
      this.result = null
      
      try {
        const response = await axios.post(`${API_BASE}/api/test-prompt`, {
          prompt: this.testPrompt
        })
        
        this.result = {
          success: true,
          model: response.data.model,
          response: response.data.response,
          usage: response.data.usage
        }
      } catch (error) {
        this.result = {
          success: false,
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
.test-page {
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

.test-card {
  max-width: 800px;
  margin: 0 auto;
}

h1 {
  font-size: 32px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 8px;
}

.subtitle {
  font-size: 16px;
  color: var(--mc-gray);
  margin-bottom: 32px;
}

.api-key-display {
  padding: 16px;
  background: var(--mc-light-gray);
  border-radius: 8px;
  margin-bottom: 32px;
  font-size: 14px;
}

.api-key-display code {
  display: block;
  margin-top: 8px;
  padding: 8px;
  background: white;
  border-radius: 4px;
  font-family: 'Courier New', monospace;
  word-break: break-all;
}

.test-section {
  margin-bottom: 32px;
}

.test-section h3 {
  font-size: 18px;
  font-weight: 600;
  color: var(--mc-dark);
  margin-bottom: 12px;
}

.test-prompt {
  width: 100%;
  min-height: 100px;
  resize: vertical;
  font-family: inherit;
}

.result-section {
  padding: 24px;
  border-radius: 12px;
  margin-bottom: 32px;
  animation: slideIn 0.3s ease-out;
}

.result-section.success {
  background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
  border-left: 4px solid var(--mc-success);
}

.result-section.error {
  background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
  border-left: 4px solid var(--mc-danger);
}

.result-section h3 {
  font-size: 20px;
  font-weight: 700;
  margin-bottom: 16px;
}

.result-section.success h3 {
  color: #065f46;
}

.result-section.error h3 {
  color: #991b1b;
}

.success-content,
.error-content {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.result-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.result-item strong {
  font-size: 14px;
  font-weight: 600;
  color: #065f46;
}

.result-item span {
  font-size: 14px;
  color: #047857;
}

.response-text {
  padding: 16px;
  background: white;
  border-radius: 8px;
  font-size: 14px;
  line-height: 1.6;
  color: var(--mc-dark);
  white-space: pre-wrap;
}

.error-content strong {
  font-size: 14px;
  font-weight: 600;
  color: #991b1b;
  margin-bottom: 8px;
}

.error-content pre {
  background: white;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-size: 13px;
  color: #991b1b;
  white-space: pre-wrap;
  word-wrap: break-word;
}

.back-link {
  text-align: center;
  padding-top: 24px;
  border-top: 1px solid var(--mc-border);
}

.back-link a {
  color: var(--mc-orange);
  text-decoration: none;
  font-weight: 600;
  font-size: 16px;
}

.back-link a:hover {
  text-decoration: underline;
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
</style>
