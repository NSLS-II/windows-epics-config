@ECHO OFF

SET EPICS_TOOLS_DIR=C:\EPICS\TOOLS

echo Adding EPICS tools locations to PATH
SET PATH=%EPICS_TOOLS_DIR%\Git\cmd;%EPICS_TOOLS_DIR%\Python;%EPICS_TOOLS_DIR%\Perl\perl\bin;%EPICS_TOOLS_DIR%\bin;%PATH%
echo.

echo Initializing Visual Studio build environment...
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64
echo.

echo Set EPICS host architecture to 64 bit static
SET EPICS_HOST_ARCH=windows-x64-static
echo.

echo Ready to build. Run 'make bundle' to generate a tarball archive, and 'make localinstall' for a local installation.
echo.