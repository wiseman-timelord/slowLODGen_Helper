@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ================================
echo PyPy slowLODGen Helper
echo ================================
echo.

:: === 4. admin check ===
fltmc >nul 2>&1 || (
   echo ERROR: Run as Administrator.
   pause & exit /b 1
)

:: === 5. safe batch checks ===
set "PYFOUND=0"
if exist "pypy.exe" set "PYFOUND=1"
echo [batch] pypy.exe present: %PYFOUND%

set "YAMLFOUND=0"
if exist "LODGen_config.yaml" set "YAMLFOUND=1"
echo [batch] LODGen_config.yaml present: %YAMLFOUND%

:: === hand over to PowerShell ===
echo.
echo [batch] Starting configuration via PowerShell...
powershell -ExecutionPolicy Bypass -File "%~dp0slowLODGen_Helper.ps1" -PYFOUND %PYFOUND% -YAMLFOUND %YAMLFOUND%
echo [batch] PowerShell script finished.

:: === return & countdown exit ===
echo.
echo Press Enter to exit...
pause
echo Exit In 5 seconds
timeout /t 5
exit /b 0