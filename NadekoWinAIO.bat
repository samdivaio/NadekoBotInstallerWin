@ECHO OFF
CLS
ECHO 1.Download Dev Build (latest)
ECHO 2.Download Stable Build
ECHO 3.Run Nadeko (normally)
ECHO 4.Run Nadeko with Auto Restart (check if nadeko is working properly, before using this)
ECHO 5.To exit
ECHO.

CHOICE /C 12345 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 5 GOTO exit
IF ERRORLEVEL 4 GOTO autorestart
IF ERRORLEVEL 3 GOTO runnormal
IF ERRORLEVEL 2 GOTO stable
IF ERRORLEVEL 1 GOTO latest

:latest
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
ECHO Downloading NadekoBot (Latest), please wait...
SET "FILENAME=%~dp0\NadekoLatest.bat"
bitsadmin.exe /transfer "Downloading Nadeko (Latest)" /priority high https://github.com/Kwoth/NadekoBotInstallerWin/raw/master/NadekoInstallerLatest.bat "%FILENAME%"
ECHO NadekoBot Dev Build (latest) downloaded.
timeout /t 5
NadekoLatest.bat
GOTO End

:stable
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
ECHO Downloading NadekoBot (Stable), please wait...
SET "FILENAME=%~dp0\NadekoStable.bat"
bitsadmin.exe /transfer "Downloading Nadeko (Stable)" /priority high https://github.com/Kwoth/NadekoBotInstallerWin/raw/master/NadekoInstaller.bat "%FILENAME%"
ECHO NadekoBot Stable build downloaded.
timeout /t 5
NadekoStable.bat
GOTO End

:runnormal
ECHO Downloading NadekoBot Run, please wait...
SET "FILENAME=%~dp0\NadekoRunNormal.bat"
bitsadmin.exe /transfer "Downloading Nadeko Run (normal)" /priority high https://github.com/Kwoth/NadekoBotInstallerWin/raw/master/NadekoRun.bat "%FILENAME%"
ECHO.
ECHO Running Nadeko Normally, "if" you are running this to check Nadeko, use ".die" command on discord to stop Nadeko.
timeout /t 10
NadekoRunNormal.bat
GOTO End

:autorestart
ECHO Downloading NadekoBot Auto Run, please wait...
SET "FILENAME=%~dp0\NadekoAutoRun.bat"
bitsadmin.exe /transfer "Downloading Nadeko Auto-Run" /priority high https://github.com/Kwoth/NadekoBotInstallerWin/raw/master/NadekoAutoRun.bat "%FILENAME%"
ECHO.
ECHO Running Nadeko with Auto Restart, you will have to close the session to stop the auto restart.
timeout /t 15
NadekoAutoRun.bat

:exit
exit

:End
pause
NadekoWinAIO.bat
