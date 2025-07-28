@echo off
cd /d "%~dp0"

:: === 4. admin check ===
fltmc >nul 2>&1 || (
   echo ERROR: Run as Administrator.
   pause & exit /b 1
)

.\pypy.exe slowLODGen.py 

pause