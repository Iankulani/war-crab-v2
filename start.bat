@echo off
REM ============================================================
REM WAR-CRAB-V2 - Windows Start Script
REM ============================================================

title WAR-CRAB-V2

echo.
echo Starting WAR-CRAB-V2...
echo.

REM Check if virtual environment exists
if not exist venv (
    echo [!] Virtual environment not found. Run setup.bat first.
    pause
    exit /b 1
)

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Load environment variables
if exist .env (
    for /f "tokens=*" %%a in (.env) do (
        set "%%a" 2>nul
    )
)

REM Start the application
python war_crab_v2.py %*

pause
