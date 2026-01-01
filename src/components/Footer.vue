<!--
  Mastercard AI Demo Application
  Author: Chris Sutherland
  Email: cs96ai@hotmail.com
  Phone: 416-839-9499
-->
<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-text">
          Developed by <strong>Chris Sutherland</strong>
        </div>
        <div class="footer-contact">
          <a href="mailto:cs96ai@hotmail.com" class="contact-link">
            <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
              <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
              <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
            </svg>
            cs96ai@hotmail.com
          </a>
          <span class="separator">•</span>
          <a href="tel:+14168399499" class="contact-link">
            <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
              <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
            </svg>
            416-839-9499
          </a>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style scoped>
.footer {
  background: white;
  border-top: 1px solid var(--mc-border);
  padding: 24px 0;
  margin-top: 60px;
}

.footer-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.footer-text {
  font-size: 14px;
  color: var(--mc-gray);
}

.footer-text strong {
  color: var(--mc-dark);
  font-weight: 600;
}

.footer-contact {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
  justify-content: center;
}

.contact-link {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  color: var(--mc-orange);
  text-decoration: none;
  transition: color 0.2s;
  font-weight: 500;
}

.contact-link:hover {
  color: var(--mc-red);
}

.separator {
  color: var(--mc-border);
  font-weight: 300;
}

@media (max-width: 768px) {
  .footer-contact {
    flex-direction: column;
    gap: 8px;
  }
  
  .separator {
    display: none;
  }
}
</style>
