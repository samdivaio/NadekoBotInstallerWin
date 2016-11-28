@echo off
SET "FILENAME=%~dp0\AutoRestartNadeko.bat"
bitsadmin.exe /transfer "Nadeko" /priority high https://github.com/samdivaio/NadekoBotInstallerWin/raw/master/NadekoRun.bat "%FILENAME%"

AutoRestartNadeko.bat
ECHO.
ECHO Looks like that didn't work.
pause
