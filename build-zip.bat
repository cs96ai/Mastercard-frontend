@echo off
REM Frontend ZIP Build Script for Windows
REM Author: Chris Sutherland (cs96ai@hotmail.com)
REM Creates a deployment ZIP for Azure App Service (Linux)

echo ========================================
echo Building Frontend ZIP for Azure Deployment
echo ========================================
echo.

REM Install dependencies
echo Installing dependencies...
call npm install

REM Build the Vue.js application
echo Building Vue.js application...
call npm run build

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Build failed!
    echo Please fix the errors above and try again.
    pause
    exit /b 1
)

echo.
echo Build successful!
echo.

REM Create deployment package
echo Creating deployment package...
if exist deploy-temp (
    rmdir /s /q deploy-temp
)
mkdir deploy-temp

REM Copy dist folder contents
echo Copying built files...
xcopy /E /I /Y dist deploy-temp\dist

REM Copy server files
echo Copying server files...
copy server.js deploy-temp\
copy package.json deploy-temp\

REM Create ZIP file
echo Creating frontend-deploy.zip...
cd deploy-temp
powershell -Command "Compress-Archive -Path * -DestinationPath ..\frontend-deploy.zip -Force"
cd ..

REM Clean up
rmdir /s /q deploy-temp

echo.
echo ========================================
echo Build Complete!
echo ========================================
echo.
echo ZIP file created: frontend-deploy.zip
echo.
echo To deploy to Azure:
echo 1. Go to https://portal.azure.com
echo 2. Navigate to: mastercard-csutherland (Frontend App Service)
echo 3. Go to: Development Tools ^> Advanced Tools ^> Go
echo 4. In Kudu, go to: Tools ^> Zip Push Deploy
echo 5. Drag and drop: frontend-deploy.zip
echo.
echo Frontend URL: https://mastercard-csutherland.azurewebsites.net
echo Backend URL:  https://mastercardapi-csutherland.azurewebsites.net
echo.

pause
