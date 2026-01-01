<template>
  <div class="modal-overlay">
    <div class="modal">
      <div class="modal-header">
        <h2>Welcome to Fraud Analysis Platform</h2>
        <p>OpenAI access is configured on the backend</p>
      </div>
      
      <div class="modal-body">
        <p class="help-text">
          Please set the <strong>OPENAI_API_KEY</strong> environment variable for the backend service.
        </p>
        
        <div v-if="error" class="error-message">
          {{ error }}
        </div>
        
        <button 
          class="btn btn-primary" 
          @click="$emit('api-key-submitted', true)"
          :disabled="loading"
          style="width: 100%;"
        >
          <span v-if="loading" class="loading"></span>
          <span v-else>Continue</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ApiKeyModal',
  data() {
    return {
      loading: false,
      error: ''
    }
  }
}
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(4px);
}

.modal {
  background: white;
  border-radius: 16px;
  max-width: 500px;
  width: 90%;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

.modal-header {
  padding: 32px 32px 24px;
  border-bottom: 1px solid var(--mc-border);
}

.modal-header h2 {
  font-size: 24px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 8px;
}

.modal-header p {
  font-size: 14px;
  color: var(--mc-gray);
}

.modal-body {
  padding: 32px;
}

.form-group {
  margin-bottom: 24px;
}

.form-group label {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: var(--mc-dark);
  margin-bottom: 8px;
}

.help-text {
  margin-top: 8px;
  font-size: 12px;
  color: var(--mc-gray);
  line-height: 1.5;
}

.help-text a {
  color: var(--mc-orange);
  text-decoration: none;
}

.help-text a:hover {
  text-decoration: underline;
}

.error-message {
  padding: 12px;
  background: #fee2e2;
  color: #991b1b;
  border-radius: 8px;
  font-size: 14px;
  margin-bottom: 16px;
}
</style>
