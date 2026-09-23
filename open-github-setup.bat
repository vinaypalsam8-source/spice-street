@echo off
title Setup Spice Street Free Domain on GitHub
echo ========================================================
echo   SPICE STREET - CONNECT TO GITHUB (FREE DOMAIN)
echo ========================================================
echo.
echo 1. Opening GitHub New Repository page in your browser...
start https://github.com/new?name=spice-street
echo.
echo 2. Opening your Spice Street folder with ready-to-upload files...
explorer "%~dp0"
echo.
echo ========================================================
echo  QUICK 3 STEPS TO ACTIVATE YOUR FREE DOMAIN:
echo ========================================================
echo  Step 1: On GitHub, keep it Public and click "Create repository".
echo  Step 2: Click "uploading an existing file" and drag the files
echo          (or extract 'spice-street-deploy.zip').
echo  Step 3: Go to Settings -> Pages -> Source: select "GitHub Actions".
echo.
echo  Your free live URL will be:
echo  https://vinaypalsam8-source.github.io/spice-street/
echo ========================================================
pause
