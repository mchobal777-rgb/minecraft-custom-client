@echo off
REM Minecraft Custom Client - Automatic Setup for Windows
REM This script downloads LWJGL libraries and sets up the project

setlocal enabledelayedexpansion

echo.
echo ===================================
echo Minecraft Custom Client Setup
echo ===================================
echo.

REM Check if Java is installed
echo [*] Checking Java installation...
java -version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Java is not installed or not in PATH!
    echo Please install Java 17+ from: https://www.oracle.com/java/technologies/downloads/
    pause
    exit /b 1
)
echo [OK] Java found!
echo.

REM Create lib directory if it doesn't exist
echo [*] Creating lib directory...
if not exist "lib" (
    mkdir lib
    echo [OK] lib directory created
) else (
    echo [OK] lib directory already exists
)
echo.

REM Create bin directory for compiled classes
echo [*] Creating bin directory...
if not exist "bin" (
    mkdir bin
    echo [OK] bin directory created
) else (
    echo [OK] bin directory already exists
)
echo.

REM Create resources directory structure
echo [*] Creating resources directory structure...
if not exist "src\main\resources\shaders" mkdir src\main\resources\shaders
if not exist "src\main\resources\textures\skybox" mkdir src\main\resources\textures\skybox
echo [OK] Resources directories created
echo.

echo [*] Downloading LWJGL 3.3.2 libraries...
echo.

REM Download LWJGL libraries using PowerShell
powershell -Command ^
    "$ProgressPreference = 'SilentlyContinue'; ^
    $libs = @( ^
        @{url='https://repo1.maven.org/maven2/org/lwjgl/lwjgl/3.3.2/lwjgl-3.3.2.jar'; file='lib/lwjgl-3.3.2.jar'}, ^
        @{url='https://repo1.maven.org/maven2/org/lwjgl/lwjgl-opengl/3.3.2/lwjgl-opengl-3.3.2.jar'; file='lib/lwjgl-opengl-3.3.2.jar'}, ^
        @{url='https://repo1.maven.org/maven2/org/lwjgl/lwjgl-glfw/3.3.2/lwjgl-glfw-3.3.2.jar'; file='lib/lwjgl-glfw-3.3.2.jar'}, ^
        @{url='https://repo1.maven.org/maven2/org/joml/joml/1.10.5/joml-1.10.5.jar'; file='lib/joml-1.10.5.jar'}, ^
        @{url='https://repo1.maven.org/maven2/org/lwjgl/lwjgl-stb/3.3.2/lwjgl-stb-3.3.2.jar'; file='lib/lwjgl-stb-3.3.2.jar'} ^
    ); ^
    foreach ($$lib in $$libs) { ^
        Write-Host '[*] Downloading' $$lib.file.Split('/')[-1]'...'; ^
        try { ^
            (New-Object Net.WebClient).DownloadFile($$lib.url, $$lib.file); ^
            if (Test-Path $$lib.file) { ^
                Write-Host '[OK]' $$lib.file.Split('/')[-1] 'downloaded' ^
            } ^
        } ^
        catch { ^
            Write-Host '[WARN] Failed to download' $$lib.file.Split('/')[-1] ^
        } ^
    }"

echo.

REM Compile project
echo [*] Compiling project...
echo.
javac -cp "lib/*" -d bin src/main/java/client/*.java src/main/java/client/*/*.java src/main/java/client/*/*/*.java 2>nul

if errorlevel 1 (
    echo [ERROR] Compilation failed!
    echo Trying to compile with detailed error output...
    javac -cp "lib/*" -d bin src/main/java/client/*.java src/main/java/client/*/*.java src/main/java/client/*/*/*.java
    pause
    exit /b 1
) else (
    echo [OK] Compilation successful!
)
echo.

echo ===================================
echo Setup Complete!
echo ===================================
echo.
echo Next steps:
echo 1. Add skybox textures to: src\main\resources\textures\skybox\
echo.
echo 2. Run the client with:
echo    run.bat
echo.
pause
