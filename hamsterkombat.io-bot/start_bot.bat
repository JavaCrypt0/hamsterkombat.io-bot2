@echo off
setlocal

REM Function to set console color
call :colorEcho

REM Check for Node.js installation
node -v >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    call :colorEcho yellow
    echo Node.js is not installed. Starting installation...

    powershell -Command "Invoke-WebRequest -Uri https://nodejs.org/dist/v16.17.1/node-v16.17.1-x64.msi -OutFile nodejs.msi"

    msiexec /i nodejs.msi /quiet /norestart

    set "NODE_PATH=C:\Program Files\nodejs"
    setx PATH "%PATH%;%NODE_PATH%"

    set "PATH=%PATH%;%NODE_PATH%"

    node -v >nul 2>&1
    IF %ERRORLEVEL% NEQ 0 (
        call :colorEcho red
        echo Node.js installation failed. Please install it manually.
        exit /b 1
    )
    call :colorEcho green
    echo Node.js has been successfully installed.
) ELSE (
    call :colorEcho green
    echo Node.js is already installed.
)
call :colorEcho white
echo Installing npm dependencies...
npm install

echo Running bot.js...
node bot.js

endlocal
pause
exit /b

:colorEcho
if "%1"=="red" color 0c
if "%1"=="green" color 0a
if "%1"=="yellow" color 0e
if "%1"=="white" color 0f
exit /b
