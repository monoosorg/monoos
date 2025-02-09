@echo off

REM This is needed so as to avoid static expansion of environment variables
REM inside if (...) conditionals.
REM See http://stackoverflow.com/questions/305605/weird-scope-issue-in-bat-file
REM for more explanation.
REM Precisely needed for configuring Visual Studio Environment.
setlocal enabledelayedexpansion

REM Does the user need help?
if /I "%1" == "help" goto help
if /I "%1" == "/?" (
:help
    echo Help for configure script
    echo Syntax: path\to\source\configure.cmd [script-options] [Cmake-options]
    echo Available script-options: Codeblocks, Eclipse, Makefiles, clang, VSSolution
    echo Cmake-options: -DVARIABLE:TYPE=VALUE
    goto quit
)

REM Get the source root directory
set MONOOS_SOURCE_DIR=%~dp0

REM Ensure there's no spaces in the source path
echo %MONOOS_SOURCE_DIR%| find " " > NUL
if %ERRORLEVEL% == 0 (
    echo. && echo   Your source path contains at least one space.
    echo   This will cause problems with building.
    echo   Please rename your folders so there are no spaces in the source path,
    echo   or move your source to a different folder.
    goto quit
)

REM Set default generator
set CMAKE_GENERATOR="Ninja"
set CMAKE_ARCH=
set MONOOS_ARCH="arm"

REM Detect presence of cmake
cmd /c cmake --version 2>&1 | find "cmake version" > NUL || goto cmake_notfound


REM Detect build environment (MinGW, VS, WDK, ...)
if defined MONOOS_ARCH (
    echo Detected MONOOSBE for %MONOOS_ARCH%
    set BUILD_ENVIRONMENT=MinGW
    set ARCH=%MONOOS_ARCH%
    set MINGW_TOOCHAIN_FILE=toolchain-arm.cmake
) else (
    echo Error: Unable to detect build environment. Configure script failure.
    goto quit
)

REM Checkpoint
if not defined ARCH (
    echo Unknown build architecture
    goto quit
)

set USE_CLANG_CL=0

REM Parse command line parameters
set CMAKE_PARAMS=
set REMAINING=%*

set CMAKE_GENERATOR="Ninja"



REM Inform the user about the default build
if "!CMAKE_GENERATOR!" == "Ninja" (
    echo This script defaults to Ninja. Type "configure help" for alternative options.
)

REM Create directories
set MONOOS_OUTPUT_PATH=output-%BUILD_ENVIRONMENT%-%ARCH%


if "%MONOOS_SOURCE_DIR%" == "%CD%\" (
    set CD_SAME_AS_SOURCE=1
    echo Creating directories in %MONOOS_OUTPUT_PATH%

    if not exist %MONOOS_OUTPUT_PATH% (
        mkdir %MONOOS_OUTPUT_PATH%
    )
    cd %MONOOS_OUTPUT_PATH%
)


echo Preparing MONOOS...

if EXIST CMakeCache.txt (
    del CMakeCache.txt /q
)

@REM run cmake
rem cmake -G %CMAKE_GENERATOR% -DENABLE_CCACHE:BOOL=0 -DCMAKE_TOOLCHAIN_FILE:FILEPATH=%MINGW_TOOCHAIN_FILE% -DARCH:STRING=%ARCH% %BUILD_TOOLS_FLAG% %CMAKE_PARAMS% "%MONOOS_SOURCE_DIR%"
cmake -G %CMAKE_GENERATOR% -DENABLE_CCACHE:BOOL=0 -DCMAKE_TOOLCHAIN_FILE:FILEPATH=%MINGW_TOOCHAIN_FILE% -DARCH:STRING=%ARCH% %BUILD_TOOLS_FLAG% %CMAKE_PARAMS% "%MONOOS_SOURCE_DIR%"


Rem If Error
if %ERRORLEVEL% NEQ 0 (
    goto quit
)

if "%CD_SAME_AS_SOURCE%" == "1" (
    set ENDV= from %MONOOS_OUTPUT_PATH%
)

set ENDV= Execute appropriate build commands ^(ex: ninja, make, nmake, etc...^)%ENDV%

echo. && echo Configure script complete^^!%ENDV%

goto quit

:cmake_notfound
echo Unable to find cmake, if it is installed, check your PATH variable.

:quit
endlocal
exit /b
