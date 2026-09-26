@echo off
setlocal
cd /d "%~dp0"
echo.
echo   Guild Scam -- web build, local playtest
echo.
echo   Keep this window open. Closing it stops the game.
echo.
set "PY="
where py      >nul 2>nul && set "PY=py"
if not defined PY where python  >nul 2>nul && set "PY=python"
if not defined PY where python3 >nul 2>nul && set "PY=python3"
if not defined PY goto nopy
%PY% serve.py 8123
exit /b 0

:nopy
echo   Python not found.
echo   Install it from python.org (tick "Add to PATH"),
echo   or push this folder to GitHub Pages instead.
echo   Chinese notes: see the txt file in this folder.
echo.
pause
exit /b 1
