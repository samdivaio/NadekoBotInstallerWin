@ECHO off
@TITLE NadekoBot
del NadekoAutoRun.bat
:auto
CD /D %~dp0NadekoBot\src\NadekoBot
dotnet run --configuration Release
goto auto
