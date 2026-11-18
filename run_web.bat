@echo off
cd /d "%~dp0"
setlocal
call dart pub get || exit /b 1
if exist build rmdir /s /q build
call dart run tool\run_web.dart chrome
exit /b %errorlevel%
