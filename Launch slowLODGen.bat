@echo off

# Change to script dir
cd /d "%~dp0"

# Admin Check
fltmc >nul 2>&1 || (
   echo ERROR: Run as Administrator.
   pause & exit /b 1
)

# Run pypy in script dir
.\pypy.exe slowLODGen.py 

# Review work
pause
