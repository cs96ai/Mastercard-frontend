@echo off
echo Starting Mastercard Fraud Analysis Frontend...
echo.
echo Installing dependencies...
set NODE_TLS_REJECT_UNAUTHORIZED=0
set npm_config_strict_ssl=false
call npm install --strict-ssl=false
echo.
echo Starting Vue development server on http://localhost:5173
echo.
call npm run dev
