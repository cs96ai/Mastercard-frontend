# Mastercard Fraud Analysis System

A full-stack application for analyzing and explaining credit card fraud scenarios using AI-powered insights.

## 🚀 Features

- **Interactive Fraud Scenario Analysis**: Analyze various types of credit card fraud patterns
- **AI-Powered Explanations**: Get detailed explanations of fraud detection mechanisms using OpenAI
- **Professional Mastercard-themed UI**: Clean, responsive Vue.js interface with beautiful animations
- **20+ Fraud Scenarios**: Comprehensive fraud case studies with detailed transaction data
- **Audience-Specific Explanations**: Tailored for Risk Analysts, Executives, and Customer-friendly views
- **Real-time Analysis**: Submit transaction data and receive instant fraud risk assessments

## 🛠️ Technology Stack

- **Vue.js 3**: Progressive JavaScript framework
- **Vite**: Next-generation frontend tooling
- **Axios**: HTTP client for API requests
- **Vue Router**: Client-side routing

## 📦 Installation

### Prerequisites
- Node.js 16 or higher
- npm or yarn
- OpenAI API key

### Setup

1. Install dependencies:
```bash
npm install
```

2. Configure environment variables:
Create a `.env` file in the root directory:
```env
# Production backend (Azure)
VITE_BACKEND_URL=https://mastercard-backend-csutherland.azurewebsites.net

# Local development backend (uncomment to use)
# VITE_BACKEND_URL=http://localhost:8000
```

3. Start the development server:
```bash
npm run dev
```

The application will be available at `http://localhost:5173`

### Quick Start (Windows)
Use the provided batch file:
```bash
start-frontend.bat
```

## 🎯 Usage

1. Start the development server
2. Open your browser to `http://localhost:5173`
3. Enter your OpenAI API key if prompted
4. Select a fraud scenario from the available options
5. View the analysis results and AI-generated explanations

## 🔧 Configuration

### API Key Setup
The application requires an OpenAI API key for fraud explanations. You can:
- Set it as an environment variable (recommended for production)
- Enter it through the UI modal when the application starts

## 🚀 Deployment

### Building for Production

```bash
npm run build
```

The production build will be in the `dist` folder.

### Deployment Options
The frontend can be deployed to:
- Vercel
- Netlify
- GitHub Pages
- AWS S3 + CloudFront
- Azure Static Web Apps

### Production Deployment

**Frontend URL:** https://mastercard-csutherland.azurewebsites.net  
**Backend API URL:** https://mastercard-backend-csutherland.azurewebsites.net

The application is deployed on Azure App Service. Use the `build-zip.bat` script to create a deployment package.

## 📝 Project Structure

```
Mastercard-frontend/
├── src/
│   ├── components/      # Vue components
│   ├── App.vue         # Main application component
│   ├── main.js         # Application entry point
│   ├── router.js       # Vue Router configuration
│   ├── config.js       # Configuration settings
│   └── style.css       # Global styles
├── index.html          # HTML entry point
├── package.json        # Dependencies and scripts
├── vite.config.js      # Vite configuration
└── README.md           # This file
```

## 🔒 Security

- Never commit API keys to the repository
- Use environment variables for sensitive configuration
- Implement rate limiting for production deployments
- Validate all user inputs on the backend

## 📧 Contact

For questions or support, please open an issue on GitHub.

## 🙏 Acknowledgments

- OpenAI for providing the AI capabilities
- Vue.js community for excellent documentation
- Mastercard for inspiration on fraud detection patterns
