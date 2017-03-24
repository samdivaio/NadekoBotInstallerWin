@ECHO OFF
TITLE NadekoBot Installer!
SET "root=%~dp0"
CD /D "%root%"
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%NadekoCredentials.bat" del "%root%NadekoCredentials.bat"
IF EXIST "%root%NadekoAutoRun.bat" del "%root%NadekoAutoRun.bat"
IF EXIST "%root%NadekoRun.bat" del "%root%NadekoRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"
SET "FILENAME=%root%windowsAIO.bat"
powershell -Command "Invoke-WebRequest https://github.com/Kwoth/NadekoBotInstallerWin/raw/master/windowsAIO.bat -OutFile '%FILENAME%'"
CALL windowsAIO.bat
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%NadekoCredentials.bat" del "%root%NadekoCredentials.bat"
IF EXIST "%root%NadekoAutoRun.bat" del "%root%NadekoAutoRun.bat"
IF EXIST "%root%NadekoRun.bat" del "%root%NadekoRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"
pause