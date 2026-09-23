@echo off
title Deploy Spice Street to GitHub / Netlify
color 0A
cls
echo =======================================================================
echo          SPICE STREET - INSTANT FIX FOR GITHUB & NETLIFY
echo =======================================================================
echo.
echo  WHY NETLIFY / GITHUB WAS SHOWING A DIFFERENT SITE:
echo  --------------------------------------------------
echo  Your GitHub repository currently only has 'README.md'.
echo  The actual website files (index.html, dashboard, css, js, images)
echo  were not uploaded to GitHub yet!
echo.
echo =======================================================================
echo  CHOOSE HOW YOU WANT TO PUBLISH:
echo =======================================================================
echo.
echo  [1] Publish on Netlify (Instant 10-Second Free Domain - No Git needed)
echo  [2] Upload to GitHub (vinaypalsam8-source/spice-street)
echo  [3] Open local folder with ready files
echo  [4] Exit
echo.
set /p choice="Enter choice [1, 2, 3 or 4]: "

if "%choice%"=="1" (
    echo.
    echo Opening Netlify Drop and your files folder...
    start https://app.netlify.com/drop
    explorer "%~dp0DEPLOY_READY"
    echo.
    echo INSTRUCTIONS FOR NETLIFY:
    echo 1. Just DRAG the "DEPLOY_READY" folder into the Netlify Drop box in your browser!
    echo 2. Your website will be LIVE instantly with a free .netlify.app link!
    echo.
    pause
    exit /b
)

if "%choice%"=="2" (
    echo.
    echo Opening GitHub upload page and your files folder...
    start https://github.com/vinaypalsam8-source/spice-street/upload/main
    explorer "%~dp0DEPLOY_READY"
    echo.
    echo INSTRUCTIONS FOR GITHUB:
    echo 1. In the folder that opened, press Ctrl+A to select all files.
    echo 2. Drag them into the GitHub page in your browser.
    echo 3. Scroll down and click green "Commit changes" button!
    echo 4. Then go to Settings -> Pages to view your free .github.io link!
    echo.
    pause
    exit /b
)

if "%choice%"=="3" (
    explorer "%~dp0DEPLOY_READY"
    exit /b
)

exit /b
