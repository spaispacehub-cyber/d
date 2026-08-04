@echo off
setlocal
where java >nul 2>nul
if errorlevel 1 (
  echo Java is not installed on this PC.
  echo Install Java 21 first, then run this file again.
  pause
  exit /b 1
)

if not exist "%~dp0gradle\bin\gradle.bat" (
  echo Gradle is not installed. Please install Gradle or use the Gradle Wrapper.
  echo This project was converted to Gradle, but the wrapper bootstrap is not bundled.
  pause
  exit /b 1
)

call "%~dp0gradle\bin\gradle.bat" build
pause
