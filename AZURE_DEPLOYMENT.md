# Azure Deployment Guide

**Author:** Chris Sutherland  
**Email:** cs96ai@hotmail.com  
**Phone:** 416-839-9499

## ✅ Project Status: READY FOR DEPLOYMENT

Your backend is now configured for Azure App Service deployment.

## 📋 Pre-Deployment Checklist

- [x] `app.py` created (Azure entry point)
- [x] `requirements.txt` updated with all dependencies
- [x] `startup.txt` created (Azure startup command)
- [x] All Python modules present
- [x] Author information embedded in code

## 🚀 Deployment Steps (VS Code Method)

### 1. Install Azure Tools Extension
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Azure Tools"
4. Install the extension pack by Microsoft

### 2. Sign in to Azure
1. Click the Azure icon in the left sidebar
2. Click "Sign in to Azure"
3. Follow the authentication prompts

### 3. Deploy the Backend

1. **Open the backend folder in VS Code**
   - File → Open Folder → Select `e:\Mastercard\backend`
   - **IMPORTANT:** Open the `backend` folder directly, not the parent `Mastercard` folder

2. **Create the Web App**
   - Click the Azure icon in the sidebar
   - In the "Resources" section, click the `+` button
   - Select "Create App Service Web App..."
   
3. **Configure the Web App**
   - **Name:** `mastercard-demo-csutherland` (must be globally unique)
   - **Runtime Stack:** Python 3.11 or 3.12
   - **Region:** Choose closest to you (e.g., East US, West US)
   - **Pricing Tier:** Free (F1) for demo

4. **Deploy**
   - After creation, VS Code will show a notification
   - Click "Deploy" in the notification
   - Or right-click the web app → Deploy to Web App
   - Select the `backend` folder when prompted

### 4. Configure Environment Variables

After deployment, you need to add your OpenAI API key:

1. In VS Code Azure extension, find your web app
2. Right-click → "Open in Portal"
3. In Azure Portal, go to: **Settings → Configuration**
4. Click "+ New application setting"
5. Add:
   - **Name:** `OPENAI_API_KEY`
   - **Value:** `your_openai_api_key_here`
6. Click "Save"
7. Restart the web app

### 5. Test Your Deployment

Your API will be available at:
```
https://mastercard-demo-csutherland.azurewebsites.net
```

Test endpoints:
- `https://mastercard-demo-csutherland.azurewebsites.net/` - Root endpoint
- `https://mastercard-demo-csutherland.azurewebsites.net/api/scenarios` - Fraud scenarios
- `https://mastercard-demo-csutherland.azurewebsites.net/api/merchants` - Merchant data
- `https://mastercard-demo-csutherland.azurewebsites.net/api/customers` - Customer profiles
- `https://mastercard-demo-csutherland.azurewebsites.net/api/disputes` - Dispute cases

## 🖥️ Frontend Configuration

After deploying the backend, update your frontend to use the Azure URL:

1. Open `e:\Mastercard\frontend\src\config.js`
2. Add the backend URL:
```javascript
export const config = {
  OPENAI_API_KEY: 'sk-proj-...',
  BACKEND_URL: 'https://mastercard-demo-csutherland.azurewebsites.net'
}
```

3. Update all axios calls to use `config.BACKEND_URL` instead of `http://localhost:8000`

## 🔧 Alternative: Deploy via Azure CLI

If you prefer command line:

```bash
# Login to Azure
az login

# Create resource group
az group create --name mastercard-demo-rg --location eastus

# Create App Service plan
az appservice plan create --name mastercard-plan --resource-group mastercard-demo-rg --sku F1 --is-linux

# Create web app
az webapp create --resource-group mastercard-demo-rg --plan mastercard-plan --name mastercard-demo-csutherland --runtime "PYTHON:3.11"

# Deploy code
cd e:\Mastercard\backend
az webapp up --name mastercard-demo-csutherland --resource-group mastercard-demo-rg

# Set environment variable
az webapp config appsettings set --name mastercard-demo-csutherland --resource-group mastercard-demo-rg --settings OPENAI_API_KEY="your-key-here"
```

## 📊 What Gets Deployed

The backend includes:
- ✅ 4 AI-powered demos
- ✅ 20 fraud scenarios
- ✅ 5 merchant personas with 12 months of KPI data
- ✅ 15 customer profiles for upgrade analysis
- ✅ 10 dispute cases for fraud detection
- ✅ All FastAPI endpoints
- ✅ OpenAI GPT integration

## ⚠️ Important Notes

1. **Free Tier Limitations:**
   - App sleeps after 20 minutes of inactivity
   - First request after sleep takes ~30 seconds to wake up
   - 60 minutes of compute time per day

2. **CORS Configuration:**
   - The backend allows requests from `localhost:5173` and `localhost:3000`
   - Update CORS settings in `main.py` if deploying frontend to a different domain

3. **API Key Security:**
   - Never commit API keys to Git
   - Use Azure Application Settings for environment variables
   - Keys are encrypted at rest in Azure

4. **Monitoring:**
   - View logs in Azure Portal → Your Web App → Log stream
   - Monitor performance in Application Insights (if enabled)

## 🎯 Next Steps After Backend Deployment

1. **Deploy Frontend** (Optional):
   - Build the Vue app: `npm run build` in frontend folder
   - Deploy to Azure Static Web Apps, Netlify, or Vercel
   - Update CORS in backend to allow your frontend domain

2. **Custom Domain** (Optional):
   - Purchase domain
   - Configure in Azure Portal → Custom domains

3. **SSL Certificate:**
   - Azure provides free SSL for `.azurewebsites.net` domains
   - Automatic HTTPS redirect

## 🐛 Troubleshooting

**App won't start:**
- Check logs in Azure Portal
- Verify `requirements.txt` has all dependencies
- Ensure `app.py` exists in root of deployed folder

**API returns 500 errors:**
- Check Application Settings for `OPENAI_API_KEY`
- Verify API key is valid
- Check logs for Python errors

**CORS errors from frontend:**
- Update `allow_origins` in `main.py`
- Redeploy after changes

## 📞 Support

For issues or questions:
- **Developer:** Chris Sutherland
- **Email:** cs96ai@hotmail.com
- **Phone:** 416-839-9499
