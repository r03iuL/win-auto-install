@echo off
:: 1. UAC Elevation via VBScript (Bulletproof)
fltmc >nul 2>&1
if %errorlevel% neq 0 (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

:: 2. Lock onto the exact folder
cd /d "%~dp0"

:: 3. BREAK OUT of the CMD window and launch a Native PowerShell window!
start "" powershell -NoProfile -NoExit -ExecutionPolicy Bypass -File "Installer.ps1"
exit