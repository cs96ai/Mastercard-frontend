<template>
  <div class="landing-page">
    <div class="container" style="padding-top: 100px;">
      <div class="hero-section">
        <h1 class="hero-title">Mastercard AI Showcase</h1>
        <p class="hero-subtitle">Demonstrating AI-powered financial insights and analysis</p>
      </div>

      <div class="examples-grid">
        <div class="example-card card" @click="navigateTo('/fraud-explainer')">
          <div class="card-icon fraud-icon">
            <svg width="48" height="48" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
            </svg>
          </div>
          <h2 class="card-title">Fraud Case Explainer</h2>
          <p class="card-description">
            AI-powered fraud analysis that explains suspicious transactions with context-aware reasoning. 
            Navigate through 20 real-world fraud scenarios and get tailored explanations for different audiences.
          </p>
          <div class="card-features">
            <div class="feature-tag">Multi-audience Analysis</div>
            <div class="feature-tag">20 Scenarios</div>
            <div class="feature-tag">Real-time AI</div>
          </div>
          <div class="card-action">
            <span>Explore Fraud Analysis</span>
            <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
            </svg>
          </div>
        </div>

        <div class="example-card card" @click="navigateTo('/merchant-insights')">
          <div class="card-icon merchant-icon">
            <svg width="48" height="48" viewBox="0 0 20 20" fill="currentColor">
              <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"/>
            </svg>
          </div>
          <h2 class="card-title">Merchant Insights Narrative</h2>
          <p class="card-description">
            Transform raw merchant KPIs into executive-ready narratives. Select from 5 unique merchant personas 
            with real business challenges and get AI-generated strategic insights.
          </p>
          <div class="card-features">
            <div class="feature-tag">Data-to-Text</div>
            <div class="feature-tag">5 Personas</div>
            <div class="feature-tag">Strategic AI</div>
          </div>
          <div class="card-action">
            <span>Explore Merchant Insights</span>
            <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
            </svg>
          </div>
        </div>

        <div class="example-card card" @click="navigateTo('/customer-upgrade')">
          <div class="card-icon upgrade-icon">
            <svg width="48" height="48" viewBox="0 0 20 20" fill="currentColor">
              <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"/>
              <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z"/>
            </svg>
          </div>
          <h2 class="card-title">Customer Upgrade Recommendations</h2>
          <p class="card-description">
            AI-powered product upgrade analysis for credit card customers. Analyze 15 diverse customer profiles 
            and generate personalized upgrade recommendations with business justification.
          </p>
          <div class="card-features">
            <div class="feature-tag">15 Personas</div>
            <div class="feature-tag">Multi-format Output</div>
            <div class="feature-tag">Strategic AI</div>
          </div>
          <div class="card-action">
            <span>Explore Upgrade Analysis</span>
            <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
            </svg>
          </div>
        </div>

        <div class="example-card card" @click="navigateTo('/dispute-investigation')">
          <div class="card-icon dispute-icon">
            <svg width="48" height="48" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
            </svg>
          </div>
          <h2 class="card-title">First-Party Fraud Detection</h2>
          <p class="card-description">
            Forensic AI investigation of chargeback disputes to detect "friendly fraud." Analyze 10 dispute cases 
            with merchant evidence and generate trust scores with actionable recommendations.
          </p>
          <div class="card-features">
            <div class="feature-tag">10 Dispute Cases</div>
            <div class="feature-tag">Forensic Analysis</div>
            <div class="feature-tag">Trust Scoring</div>
          </div>
          <div class="card-action">
            <span>Explore Dispute Analysis</span>
            <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
            </svg>
          </div>
        </div>
      </div>

      <div class="test-link-section">
        <a href="/test" class="test-link">
          <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
          </svg>
          API Connection Test
        </a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'LandingPage',
  methods: {
    navigateTo(path) {
      this.$router.push(path)
    }
  }
}
</script>

<style scoped>
.landing-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
}

.hero-section {
  text-align: center;
  margin-bottom: 64px;
}

.hero-title {
  font-size: 48px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 16px;
  letter-spacing: -0.02em;
}

.hero-subtitle {
  font-size: 20px;
  color: var(--mc-gray);
  font-weight: 400;
}

.examples-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
  gap: 32px;
  margin-bottom: 48px;
}

@media (max-width: 768px) {
  .examples-grid {
    grid-template-columns: 1fr;
  }
}

.example-card {
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 32px;
  position: relative;
  overflow: hidden;
}

.example-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--mc-orange) 0%, var(--mc-red) 100%);
  transform: scaleX(0);
  transition: transform 0.3s ease;
}

.example-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
}

.example-card:hover::before {
  transform: scaleX(1);
}

.card-icon {
  width: 80px;
  height: 80px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
}

.fraud-icon {
  background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
  color: var(--mc-danger);
}

.merchant-icon {
  background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
  color: #1e40af;
}

.upgrade-icon {
  background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
  color: #047857;
}

.dispute-icon {
  background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
  color: var(--mc-danger);
}

.card-title {
  font-size: 24px;
  font-weight: 700;
  color: var(--mc-dark);
  margin-bottom: 12px;
}

.card-description {
  font-size: 15px;
  line-height: 1.6;
  color: var(--mc-gray);
  margin-bottom: 24px;
  min-height: 72px;
}

.card-features {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 24px;
}

.feature-tag {
  padding: 6px 12px;
  background: var(--mc-light-gray);
  border-radius: 6px;
  font-size: 12px;
  font-weight: 600;
  color: var(--mc-dark);
}

.card-action {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 24px;
  border-top: 1px solid var(--mc-border);
  font-weight: 600;
  color: var(--mc-orange);
}

.example-card:hover .card-action {
  color: var(--mc-red);
}

.test-link-section {
  text-align: center;
  padding-top: 32px;
  border-top: 1px solid var(--mc-border);
}

.test-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--mc-gray);
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  transition: color 0.2s;
}

.test-link:hover {
  color: var(--mc-orange);
}
</style>
