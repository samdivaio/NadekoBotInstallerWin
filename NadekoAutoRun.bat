@ECHO off
@TITLE NadekoBot


SET "root=%~dp0"
CD /D "%root%"

CLS
ECHO Welcome to NadekoBot Auto Restart and Update!
ECHO --------------------------------------------
ECHO 1.Auto Restart and Update with Dev Build (latest)
ECHO 2.Run Auto Restart normally without Updating (will restart faster)
ECHO 3.To exit
ECHO.

CHOICE /C 123 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO exit
IF ERRORLEVEL 2 GOTO autorun
IF ERRORLEVEL 1 GOTO latestar

:latestar
ECHO Auto Restart and Update with Dev Build (latest)
ECHO Bot will auto update on every restart!
CD /D "%~dp0NadekoBot"
dotnet restore
dotnet build --configuration Release
CD /D "%~dp0NadekoBot\src\NadekoBot"
dotnet run -c Release --no-build -- {0} {1}
ECHO Updating...
SET "FILENAME=%~dp0\Latest.bat"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/samdivaio/NadekoBotInstallerWin/1.9/Latest.bat -OutFile '%FILENAME%'"
ECHO NadekoBot Dev Build (latest) downloaded.
SET "root=%~dp0"
CD /D "%root%"
CALL Latest.bat
GOTO latestar

:autorun
ECHO Normal Auto Restart
ECHO Bot will not auto update on every restart!
timeout /t 3
CD /D "%~dp0NadekoBot"
dotnet restore
dotnet build --configuration Release
CD /D "%~dp0NadekoBot\src\NadekoBot"
dotnet run -c Release --no-build -- {0} {1}
goto autorun

:Exit
SET "root=%~dp0"
CD /D "%root%"
del NadekoAutoRun.bat
CALL NadekoInstaller.bat
