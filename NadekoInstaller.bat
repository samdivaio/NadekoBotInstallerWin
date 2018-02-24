@ECHO OFF
TITLE NadekoBot Installer!
SET "root=%~dp0"
CD /D "%root%"
goto check_Permissions
timeout /t 5
goto installer

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
	echo.

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		echo.
		pause
    ) else (
        echo Failure: Current permissions inadequate.
		echo.
		echo Run again as Administrator.
		echo.
		pause >nul
		goto exit
    )

:installer
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%NadekoCredentials.bat" del "%root%NadekoCredentials.bat"
IF EXIST "%root%NadekoAutoRun.bat" del "%root%NadekoAutoRun.bat"
IF EXIST "%root%NadekoRun.bat" del "%root%NadekoRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"
SET "FILENAME=%root%windowsAIO.bat"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/samdivaio/NadekoBotInstallerWin/1.9/windowsAIO.bat -OutFile '%FILENAME%'"
CALL windowsAIO.bat
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%NadekoCredentials.bat" del "%root%NadekoCredentials.bat"
IF EXIST "%root%NadekoAutoRun.bat" del "%root%NadekoAutoRun.bat"
IF EXIST "%root%NadekoRun.bat" del "%root%NadekoRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"
pause


:exit
exit