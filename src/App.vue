<template>
  <div id="app">
    <Header />
    <main class="container" style="padding-top: 100px; padding-bottom: 40px;">
      <FraudExplainer />
    </main>
  </div>
</template>

<script>
import FraudExplainer from './components/FraudExplainer.vue'

export default {
  name: 'App',
  components: {
    FraudExplainer
  }
}
</script>

<style scoped>
.api-key-error {
  max-width: 600px;
  margin: 0 auto;
  text-align: center;
  padding: 48px 32px;
  background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
  border-left: 4px solid var(--mc-danger);
}

.error-icon {
  display: flex;
  justify-content: center;
  margin-bottom: 24px;
  color: var(--mc-danger);
}

.api-key-error h2 {
  font-size: 24px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 16px;
}

.api-key-error p {
  font-size: 16px;
  color: var(--mc-gray);
  line-height: 1.6;
  margin-bottom: 24px;
}

.api-key-error code {
  background: rgba(0, 0, 0, 0.1);
  padding: 2px 6px;
  border-radius: 4px;
  font-family: 'Courier New', monospace;
  font-size: 14px;
}

.code-example {
  background: white;
  border-radius: 8px;
  padding: 16px;
  text-align: left;
}

.code-example pre {
  margin: 0;
  font-family: 'Courier New', monospace;
  font-size: 13px;
  color: var(--mc-dark);
  overflow-x: auto;
}
</style>
