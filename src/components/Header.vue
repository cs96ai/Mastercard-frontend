<!--
  Mastercard AI Demo Application
  Author: Chris Sutherland
  Email: cs96ai@hotmail.com
  Phone: 416-839-9499
  
  This application demonstrates AI-powered financial analysis and fraud detection
  using OpenAI's GPT models integrated with FastAPI and Vue.js
-->
<template>
  <header class="header">
    <div class="container">
      <div class="header-content">
        <a href="/" class="logo-section">
          <div class="logo">
            <svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="18" cy="24" r="14" fill="#EB001B"/>
              <circle cx="30" cy="24" r="14" fill="#FF5F00"/>
              <path d="M24 13.5C21.5 15.5 20 18.5 20 22C20 25.5 21.5 28.5 24 30.5C26.5 28.5 28 25.5 28 22C28 18.5 26.5 15.5 24 13.5Z" fill="#F79E1B"/>
            </svg>
          </div>
          <div class="title-section">
            <div class="title">Mastercard Demo</div>
            <div class="subtitle">Powered by AI</div>
          </div>
        </a>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header'
}
</script>

<style scoped>
.header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: white;
  border-bottom: 1px solid var(--mc-border);
  z-index: 100;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 0;
}

.logo-section {
  display: flex;
  align-items: center;
  gap: 16px;
  text-decoration: none;
  cursor: pointer;
  transition: opacity 0.2s;
}

.logo-section:hover {
  opacity: 0.8;
}

.logo {
  display: flex;
  align-items: center;
  justify-content: center;
}

.title-section {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.title {
  font-size: 20px;
  font-weight: 700;
  color: var(--mc-dark);
  letter-spacing: -0.02em;
}

.subtitle {
  font-size: 13px;
  color: var(--mc-gray);
  font-weight: 500;
}
</style>
