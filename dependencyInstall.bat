@echo OFF

mkdir C:\EPICS

SET WINDOWS_EPICS_CONFIG=%cd%

SET EPICS_TOOLS_LOC=C:\EPICS\TOOLS

mkdir %EPICS_TOOLS_LOC%

REM Install git
echo Installing git...
IF EXIST "%EPICS_TOOLS_LOC%\Git" (GOTO SKIPGIT) ELSE (
mkdir %EPICS_TOOLS_LOC%\Git
curl -L https://github.com/git-for-windows/git/releases/download/v2.27.0.windows.1/MinGit-2.27.0-64-bit.zip --output %EPICS_TOOLS_LOC%\Git\MinGit-2.27.0-64-bit.zip
cd %EPICS_TOOLS_LOC%\Git
tar -xf MinGit-2.27.0-64-bit.zip
del MinGit-2.27.0-64-bit.zip
)
echo Done installing git.
GOTO DONEGIT
:SKIPGIT
echo Git was already installed
:DONEGIT


REM We need git in our path for cloning some epics utility tools.
echo Adding git to PATH...
SET PATH=%EPICS_TOOLS_LOC%\Git\cmd;%PATH%
echo.


REM Setup Make/Wget/re2c
echo Collecting make, re2c, and wget...
IF EXIST "%EPICS_TOOLS_LOC%\bin" (GOTO SKIPUTILS) ELSE (
cd %EPICS_TOOLS_LOC%
git clone --quiet https://github.com/kgofron/windowsEPICS
move windowsEPICS\bin bin
move windowsEPICS\BACKUP\wget.exe bin\wget.exe
rmdir /S /Q windowsEPICS
echo Downloaded build tools.
)

GOTO DONEUTILS
:SKIPUTILS
echo Make, re2c, and wget were already installed
:DONEUTILS

REM Update the path to include wget for grabbing 7zip later. (For some reason curl fails on that link)
echo Adding tools to PATH...
SET PATH=%EPICS_TOOLS_LOC%\bin;%PATH%
echo.



REM Setup 7zip
echo Installing 7zip...
IF EXIST "%EPICS_TOOLS_LOC%\7-Zip" (GOTO SKIP7Z) ELSE (
mkdir %EPICS_TOOLS_LOC%\7-Zip
cd %EPICS_TOOLS_LOC%\7-Zip
wget https://www.7-zip.org/a/7za920.zip
tar -xf 7za920.zip
del 7za920.zip
echo Done installing 7-zip.
)

GOTO DONE7Z
:SKIP7Z
echo 7-Zip was already installed
:DONE7Z

REM We need 7zip in path to unpack portable python archive.
echo Adding 7zip to PATH...
SET PATH=%EPICS_TOOLS_LOC%\7-Zip;%PATH%
echo.


REM Setup Strawberry Perl
echo Installing strawberry perl...
IF EXIST "%EPICS_TOOLS_LOC%\Perl" (GOTO SKIPPERL) ELSE (
mkdir %EPICS_TOOLS_LOC%\Perl
curl http://strawberryperl.com/download/5.30.2.1/strawberry-perl-5.30.2.1-64bit-portable.zip --output %EPICS_TOOLS_LOC%\Perl\strawberry-perl-5.30.2.1-64bit-portable.zip
cd %EPICS_TOOLS_LOC%\Perl
7za x -y strawberry-perl-5.30.2.1-64bit-portable.zip > nul
REM del strawberry-perl-5.30.2.1-64bit-portable.zip
echo Done installing perl.
)

GOTO DONEPERL
:SKIPPERL
echo Perl was already installed
:DONEPERL
echo.

REM Add Perl to path 
echo Adding Perl to PATH...
SET PATH=%EPICS_TOOLS_LOC%\Perl\perl\bin;%PATH%
echo.


REM Setup Python3
echo Installing python...
IF EXIST "%EPICS_TOOLS_LOC%\Python" (GOTO SKIPPYTHON) ELSE ( 
cd %EPICS_TOOLS_LOC%
curl -L https://github.com/winpython/winpython/releases/download/2.3.20200530/Winpython64-3.8.3.0dot.exe --output Winpython64-3.8.3.0dot.exe
7za x -y Winpython64-3.8.3.0dot.exe > nul
move WPy64-3830\python-3.8.3.amd64 Python
rmdir /S /Q WPy64-3830
del Winpython64-3.8.3.0dot.exe
)
echo Done installing python.
GOTO DONEPYTHON
:SKIPPYTHON
echo Python was already installed
:DONEPYTHON

REM Add Python to path
echo Adding Python to PATH
SET PATH=%EPICS_TOOLS_LOC%\Python;%PATH%
echo.


REM Setup Visual Studio, if isn't installed already
echo Installing Visual Studio...
IF EXIST "C:\Program Files (x86)\Microsoft Visual Studio" (GOTO SKIPVS) ELSE (
mkdir %EPICS_TOOLS_LOC%\VS
# Curl exact MS download link
curl https://download.visualstudio.microsoft.com/download/pr/05734053-383e-4b1a-9950-c7db8a55750d/fbfc005ace3e6b4990e9a4be0fa09e7face1af5ee1f61035c64dbc16c407aeda/vs_BuildTools.exe --output %EPICS_TOOLS_LOC%\VS\vs_BuildTools.exe
cd %EPICS_TOOLS_LOC%\VS
vs_BuildTools.exe --passive --add Microsoft.VisualStudio.Workload.VCTools
)

echo Done installing Visual Studio.
GOTO DONEVS
:SKIPVS
echo Visual Studio was already installed
:DONEVS
echo.

REM Call Visual Studio environment setup script
REM echo Configuring Visual Studio build environment
REM call "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64

cd %WINDOWS_EPICS_CONFIG%

echo Successfully initialized EPICS build environment.
echo Done.
