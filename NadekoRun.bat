@ECHO off
@TITLE NadekoBot
CD /D "%~dp0NadekoBot"
dotnet restore
dotnet build --configuration Release
CD /D "%~dp0NadekoBot\src\NadekoBot"
dotnet run -c Release --no-build -- {0} {1}
ECHO NadekoBot has been succesfully stopped, press any key to close this window.
TITLE NadekoBot - Stopped
CD /D "%~dp0"
PAUSE >nul 2>&1
del NadekoRun.bat
