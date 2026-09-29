@echo off
REM ============================================================
REM WAR-CRAB-V2 - Windows Setup Script
REM ============================================================

setlocal enabledelayedexpansion

title WAR-CRAB-V2 Setup

echo.
echo ============================================================
echo    WAR-CRAB-V2 - Setup Script v2.0.0
echo    Ultimate Cybersecurity Platform
echo ============================================================
echo.

REM Check for admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Not running as Administrator
    echo [!] Some features may be limited
    echo [!] Consider running as Administrator for full functionality
    echo.
)

REM Check Python
echo [*] Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Python not found. Please install Python 3.8+ from python.org
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo [+] Found Python %PYTHON_VERSION%

REM Check pip
echo [*] Checking pip...
python -m pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] pip not found. Installing...
    python -m ensurepip --upgrade
)

REM Create virtual environment
echo.
echo [*] Creating virtual environment...
if exist venv (
    echo [!] Virtual environment already exists
    set /p RECREATE="Do you want to recreate it? (y/n): "
    if /i "!RECREATE!"=="y" (
        rmdir /s /q venv
    ) else (
        goto :skip_venv
    )
)

python -m venv venv
if %errorlevel% neq 0 (
    echo [!] Failed to create virtual environment
    pause
    exit /b 1
)

:skip_venv

REM Activate virtual environment
echo [*] Activating virtual environment...
call venv\Scripts\activate.bat

REM Upgrade pip
echo [*] Upgrading pip...
python -m pip install --upgrade pip setuptools wheel

REM Install requirements
echo [*] Installing Python dependencies...
if exist requirements.txt (
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo [!] Failed to install some dependencies
        echo [!] Continuing anyway...
    )
) else (
    echo [!] requirements.txt not found
)

REM Create directories
echo [*] Creating configuration directories...
if not exist .war_crab_v2 mkdir .war_crab_v2
if not exist .war_crab_v2\payloads mkdir .war_crab_v2\payloads
if not exist .war_crab_v2\workspaces mkdir .war_crab_v2\workspaces
if not exist .war_crab_v2\scans mkdir .war_crab_v2\scans
if not exist .war_crab_v2\phishing_pages mkdir .war_crab_v2\phishing_pages
if not exist .war_crab_v2\captured_credentials mkdir .war_crab_v2\captured_credentials
if not exist .war_crab_v2\keylog_exfil mkdir .war_crab_v2\keylog_exfil
if not exist .war_crab_v2\deployments mkdir .war_crab_v2\deployments
if not exist .war_crab_v2\domain_hosting mkdir .war_crab_v2\domain_hosting
if not exist war_crab_v2_reports mkdir war_crab_v2_reports

REM Copy .env
if not exist .env (
    if exist .env.example (
        copy .env.example .env >nul
        echo [+] Created .env from template
    )
)

REM Verify installation
echo [*] Verifying installation...
python -c "import requests; import psutil; print('[+] Core dependencies verified')"
if %errorlevel% neq 0 (
    echo [!] Verification failed
    pause
    exit /b 1
)

echo.
echo ============================================================
echo    SETUP COMPLETE!
echo ============================================================
echo.
echo To start WAR-CRAB-V2:
echo   venv\Scripts\activate
echo   python war_crab_v2.py
echo.
echo Or use:
echo   scripts\start.bat
echo.
echo [!] For authorized security testing only!
echo.

pause
endlocal
