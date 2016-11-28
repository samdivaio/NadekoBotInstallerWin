@echo off
SET "FILENAME=%~dp0\Nadeko1.bat"
bitsadmin.exe /transfer "Nadeko" /priority high https://github.com/samdivaio/NadekoBotInstallerWin/raw/master/NadekoRun.bat "%FILENAME%"

Nadeko1.bat
pause
