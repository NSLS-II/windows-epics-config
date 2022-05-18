@echo OFF

mkdir C:\EPICS

SET EPICS_TOOLS_LOC=C:\EPICS\TOOLS

mkdir %EPICS_TOOLS_LOC%

REM Install git
echo Installing git...
mkdir %EPICS_TOOLS_LOC%\Git
curl -L https://github.com/git-for-windows/git/releases/download/v2.27.0.windows.1/MinGit-2.27.0-64-bit.zip --output %EPICS_TOOLS_LOC%\Git\MinGit-2.27.0-64-bit.zip
cd %EPICS_TOOLS_LOC%\Git
tar -xf MinGit-2.27.0-64-bit.zip
del MinGit-2.27.0-64-bit.zip
echo Done installing git.


REM We need git in our path for cloning some epics utility tools.
echo Adding git to PATH...
SET PATH=%EPICS_TOOLS_LOC%\Git\cmd;%PATH%
echo.

REM Setup Make/Wget/re2c
echo Collecting make, re2c, and wget...
cd %EPICS_TOOLS_LOC%
git clone --quiet https://github.com/kgofron/windowsEPICS
move windowsEPICS\bin bin
move windowsEPICS\BACKUP\wget.exe bin\wget.exe
rmdir /S /Q windowsEPICS
echo Downloaded build tools.

REM Update the path to include wget for grabbing 7zip later. (For some reason curl fails on that link)
echo Adding tools to PATH...
SET PATH=%EPICS_TOOLS_LOC%\bin;%PATH%
echo.


REM Setup Visual Studio, if isn't installed already
echo Installing Visual Studio...
IF EXIST "C:\Program Files (x86)\Microsoft Visual Studio" (GOTO SKIPVS) ELSE (
mkdir %EPICS_TOOLS_LOC%\VS
curl https://aka.ms/vs/17/release/vs_BuildTools.exe --output %EPICS_TOOLS_LOC%\VS\vs_BuildTools.exe
cd %EPICS_TOOLS_LOC%\VS
vs_BuildTools.exe --quiet --add Microsoft.VisualStudio.Workload.VCTools
)

echo Done installing Visual Studio.
GOTO DONEVS
:SKIPVS
echo Visual Studio was already installed
:DONEVS
echo.

REM Setup Strawberry Perl
echo Installing strawberry perl...
mkdir %EPICS_TOOLS_LOC%\Perl
curl http://strawberryperl.com/download/5.30.2.1/strawberry-perl-5.30.2.1-64bit-portable.zip --output %EPICS_TOOLS_LOC%\Perl\strawberry-perl-5.30.2.1-64bit-portable.zip
cd %EPICS_TOOLS_LOC%\Perl
tar -xf strawberry-perl-5.30.2.1-64bit-portable.zip
del strawberry-perl-5.30.2.1-64bit-portable.zip
echo Done installing perl.
echo.

REM Setup 7zip
echo Installing 7zip...
mkdir %EPICS_TOOLS_LOC%\7-Zip
cd %EPICS_TOOLS_LOC%\7-Zip
wget https://www.7-zip.org/a/7za920.zip
tar -xf 7za920.zip
del 7za920.zip
echo Done installing 7-zip.

REM We need 7zip in path to unpack portable python archive.
echo Adding 7zip to PATH...
SET PATH=%EPICS_TOOLS_LOC%\7-Zip;%PATH%
echo.


REM Setup Python3
echo Installing python...
cd %EPICS_TOOLS_LOC%
curl -L https://github.com/winpython/winpython/releases/download/2.3.20200530/Winpython64-3.8.3.0dot.exe --output Winpython64-3.8.3.0dot.exe
7za x -y Winpython64-3.8.3.0dot.exe
move WPy64-3830\python-3.8.3.amd64 Python
rmdir /S /Q WPy64-3830
del Winpython64-3.8.3.0dot.exe

echo Done installing python.
echo.

cd %EPICS_TOOLS_LOC%

echo Successfully installed windows epics tools.
echo Done.
