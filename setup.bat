@echo off
REM Check if python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo Python is not installed or not in PATH.
    exit /b 1
)
python --version
echo You have python installed

REM Check if Microsoft Visual Studio and Desktop C++ tools are installed
set VSWHERE="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if exist %VSWHERE% (
    %VSWHERE% -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath >nul 2>&1
    if errorlevel 1 (
        echo Desktop C++ workload NOT installed.
        exit /b 1
    ) else (
        echo Desktop C++ workload IS installed.
    )
) else (
    echo vswhere.exe not found. Cannot check Visual Studio installation.
    exit /b 1
)

REM Check if .venv folder exists in current directory
if exist ".venv" (
    echo Found ".venv"  folder here. dont need to make one.
) else (
    echo Not found ".venv" folder here. dont need to make one.
    python -m venv .venv
)
call .venv\Scripts\activate.bat

REM Check if already inside a virtual environment
if defined VIRTUAL_ENV (
    echo Running inside venv: %VIRTUAL_ENV%
) else (
    echo Not running in a virtual environment. Exiting...
    exit /b 1
)

echo This will take a little bit to install..... 
pause

pip Install -r requirements.txt
echo Install done :0
pause
