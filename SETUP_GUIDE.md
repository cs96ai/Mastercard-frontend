# Quick Setup Guide

## Production Deployment

**Frontend:** https://mastercard-csutherland.azurewebsites.net  
**Backend API:** https://mastercard-backend-csutherland.azurewebsites.net

---

## Local Development Setup

## Step 1: Install Dependencies

```bash
npm install
```

## Step 2: Configure Backend URL

Update `.env` file:
```env
# For local backend development
VITE_BACKEND_URL=http://localhost:8000

# For production Azure backend
# VITE_BACKEND_URL=https://mastercard-backend-csutherland.azurewebsites.net
```

## Step 3: Start the Development Server

```bash
npm run dev
```

You should see: `Local: http://localhost:5173/`

## Step 4: Open the Application

1. Open your browser to `http://localhost:5173`
2. The app will connect to the backend (local or Azure based on your `.env` configuration)
3. Start exploring fraud cases!

## Azure Deployment

To deploy to Azure:

1. **Build the application:**
   ```bash
   npm run build
   ```

2. **Create deployment package (Windows):**
   ```bash
   build-zip.bat
   ```

3. **Deploy to Azure:**
   - Go to https://portal.azure.com
   - Navigate to `mastercard-csutherland` App Service
   - Use Kudu Zip Push Deploy to upload `frontend-deploy.zip`

See `AZURE_DEPLOYMENT.md` for detailed deployment instructions.

## Troubleshooting

**Frontend won't start:**
- Make sure Node.js 16+ is installed: `node --version`
- Delete `node_modules` and run `npm install` again

**Backend connection errors:**
- Check `.env` file has correct `VITE_BACKEND_URL`
- For local development: ensure backend is running on port 8000
- For production: verify Azure backend URL is correct

**CORS errors:**
- Local: Make sure backend allows `http://localhost:5173`
- Production: Backend must allow `https://mastercard-csutherland.azurewebsites.net`

**Build errors:**
- Clear cache: `npm cache clean --force`
- Reinstall: `rm -rf node_modules package-lock.json && npm install`
