# Quick Setup Guide

## Step 1: Install Backend Dependencies

Open a terminal in the `backend` folder:

```bash
cd backend
pip install -r requirements.txt
```

## Step 2: Install Frontend Dependencies

Open another terminal in the `frontend` folder:

```bash
cd frontend
npm install
```

## Step 3: Start the Backend Server

In the backend terminal:

```bash
uvicorn main:app --reload --port 8000
```

You should see: `Uvicorn running on http://127.0.0.1:8000`

## Step 4: Start the Frontend Server

In the frontend terminal:

```bash
npm run dev
```

You should see: `Local: http://localhost:5173/`

## Step 5: Open the Application

1. Open your browser to `http://localhost:5173`
2. Enter your OpenAI API key when prompted
3. Start exploring fraud cases!

## Troubleshooting

**Backend won't start:**
- Make sure Python 3.8+ is installed: `python --version`
- Try: `python -m pip install -r requirements.txt`

**Frontend won't start:**
- Make sure Node.js 16+ is installed: `node --version`
- Delete `node_modules` and run `npm install` again

**CORS errors:**
- Make sure backend is running on port 8000
- Make sure frontend is running on port 5173

**API key errors:**
- Get a valid key from https://platform.openai.com/api-keys
- Make sure you have credits in your OpenAI account
