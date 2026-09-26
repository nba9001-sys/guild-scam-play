@echo off
setlocal
cd /d "%~dp0"
echo.
echo   Guild Scam -- push this folder to a GitHub Pages repo
echo.
echo   First create an EMPTY PUBLIC repo on GitHub.
echo   (suggested name: guild-scam-play)
echo.
echo   Chinese notes: see the txt file in this folder.
echo.
set "DEFREPO=https://github.com/nba9001-sys/guild-scam-play.git"
echo   Press ENTER to use: %DEFREPO%
set "REPO="
set /p "REPO=  Repo URL (ENTER = the one above): "
if not defined REPO set "REPO=%DEFREPO%"
echo.
echo   WARNING: this replaces the WHOLE repo with this folder,
echo   as a single fresh commit (force push).
echo   That is on purpose: 96 MB per version, ten versions = 1 GB.
echo.
pause
where git >nul 2>nul
if errorlevel 1 goto nogit
if exist ".git" rmdir /s /q ".git"
git init -q
git checkout -q -b main
git config user.email "play@localhost"
git config user.name "Guild Scam"
git add -A
git commit -q -m "Guild Scam web build"
git remote add origin "%REPO%"
git push -f -u origin main
if errorlevel 1 goto failed
echo.
echo   [OK] Pushed.
echo.
echo   Now: repo Settings ^> Pages
echo        Source   = Deploy from a branch
echo        Branch   = main   Folder = / (root)
echo   Wait a minute or two, then the URL is live.
echo.
pause
exit /b 0

:nogit
echo.
echo   git not found. Install Git for Windows (git-scm.com),
echo   keep the defaults, then open a NEW window and run this again.
echo.
pause
exit /b 1

:failed
echo.
echo   Push failed. Most common reasons:
echo     1. First push needs sign-in. Git opens a GitHub login window.
echo        Sign in, then run this file again.
echo     2. Wrong URL, or the repo was never created.
echo     3. Branch protection blocks force push. Turn it off in
echo        the repo Settings.
echo.
pause
exit /b 1
