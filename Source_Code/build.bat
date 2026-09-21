@echo off
rem ============================================================
rem  QuickDict - Standalone Build Script (MSVC x64)
rem ============================================================
setlocal EnableDelayedExpansion

cd /d "%~dp0"
if not exist "build" mkdir "build"

rem ---- locate MSVC ------------------------------------------------
set "VCVARS="
if defined VCToolsInstallDir (
    if exist "%VCToolsInstallDir%\..\..\Auxiliary\Build\vcvars64.bat" set "VCVARS=%VCToolsInstallDir%\..\..\Auxiliary\Build\vcvars64.bat"
)
if not defined VCVARS (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat" (
        set "VCVARS=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    )
)
if not defined VCVARS (
    for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath 2^>nul`) do (
        if exist "%%i\VC\Auxiliary\Build\vcvars64.bat" set "VCVARS=%%i\VC\Auxiliary\Build\vcvars64.bat"
    )
)
if not defined VCVARS (
    if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
        set "VCVARS=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat" (
        set "VCVARS=C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat" (
        set "VCVARS=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
    )
)
if not defined VCVARS (
    echo [error] MSVC Build Tools not found. Install "Desktop development with C++" workload.
    exit /b 1
)

echo [info] vcvars: %VCVARS%
call "%VCVARS%" >nul 2>&1
if errorlevel 1 (
    echo [error] vcvars64.bat failed.
    exit /b 1
)

rem ---- compile resources -------------------------------------------
echo [info] Compiling resources resource.rc ...
rc /nologo /fo"build\resource.res" "resource.rc"
if errorlevel 1 goto :err

rem ---- compile C++ --------------------------------------------------
echo [info] Compiling QuickDictNative.cpp ...
cl /nologo /std:c++20 /utf-8 /EHsc /W4 /O2 /c "QuickDictNative.cpp" /Fo:"build\QuickDictNative.obj" /DUNICODE /D_UNICODE /DNOMINMAX /DWIN32_LEAN_AND_MEAN
if errorlevel 1 goto :err

rem ---- link ---------------------------------------------------------
echo [info] Linking QuickDict.exe ...
link /nologo /SUBSYSTEM:WINDOWS /ENTRY:wWinMainCRTStartup /MACHINE:X64 /OUT:"QuickDict.exe" "build\QuickDictNative.obj" "build\resource.res" user32.lib gdi32.lib shell32.lib advapi32.lib winhttp.lib comctl32.lib dwmapi.lib
if errorlevel 1 goto :err

echo [ok] Successfully built: QuickDict.exe
exit /b 0

:err
echo [error] Build failed.
exit /b 1
