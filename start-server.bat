@echo off
title Spice Street - Restaurant Server
echo Starting Spice Street Local Web Server on Port 8080...
powershell -ExecutionPolicy Bypass -File "%~dp0serve.ps1" -Port 8080
pause
