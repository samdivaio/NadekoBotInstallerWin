@ECHO off
TITLE Downloading Latest Build of NadekoBot...
::Setting convenient to read variables which don't delete the windows temp folder
SET "root=%~dp0"
CD /D "%root%"
SET "rootdir=%cd%"
SET "build5=%root%NadekoInstall_Temp\NadekoBot\src\NadekoBot\"
SET "installtemp=%root%NadekoInstall_Temp\"
::Deleting traces of last setup for the sake of clean folders, if by some miracle it still exists
IF EXIST "%installtemp%" ( RMDIR "%installtemp%" /S /Q >nul 2>&1)
echo.
timeout /t 5
::Checks that both git and dotnet are installed
dotnet --version >nul 2>&1 || GOTO :dotnet
git --version >nul 2>&1 || GOTO :git
::Creates the install directory to work in and get the current directory because spaces ruins everything otherwise
:start
MKDIR "%root%NadekoInstall_Temp"
CD /D "%installtemp%"
::Downloads the latest version of Nadeko
ECHO Downloading Nadeko...
ECHO.
git clone -b 1.9 --recursive --depth 1 https://gitlab.com/Kwoth/NadekoBot >nul
IF %ERRORLEVEL% EQU 128 (GOTO :giterror)
TITLE Installing NadekoBot, please wait...
ECHO.
ECHO Installing NadekoBot...
ECHO.
ECHO This will take a while...
ECHO.
CD /D "%build5%"
dotnet restore
dotnet build --configuration Release
ECHO.
ECHO.
ECHO NadekoBot installation completed successfully...
::Attempts to backup old files if they currently exist in the same folder as the batch file
IF EXIST "%root%NadekoBot\" (GOTO :backupinstall) ELSE (GOTO :freshinstall)
:freshinstall
	::Moves the NadekoBot folder to keep things tidy
	ECHO.
	ECHO Moving files, Please wait...
	ROBOCOPY "%root%NadekoInstall_Temp" "%rootdir%" /E /MOVE >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:backupinstall
	TITLE Backing up old files...
	ECHO.
	ECHO Moving and Backing up old files...
	::Recursively copies all files and folders from NadekoBot to NadekoBot_Old
	ROBOCOPY "%root%NadekoBot" "%root%NadekoBot_Old" /MIR >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	ECHO.
	ECHO Old files backed up to NadekoBot_Old...
	::Copies the credentials and database from the backed up data to the new folder
	COPY "%root%NadekoBot_Old\src\NadekoBot\credentials.json" "%installtemp%NadekoBot\src\NadekoBot\credentials.json" >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	ECHO.
	ECHO credentials.json copied...
	ROBOCOPY "%root%NadekoBot_Old\src\NadekoBot\bin" "%installtemp%NadekoBot\src\NadekoBot\bin" /E >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	IF EXIST "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db" ( COPY "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db" "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp2.1\data\NadekoBot.db" >nul 2>&1)
	timeout /t 2
	IF EXIST "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.1\data\NadekoBot.db" ( COPY "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.1\data\NadekoBot.db" "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp2.1\data\NadekoBot.db" >nul 2>&1)
	timeout /t 2
	IF EXIST "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp2.0\data\NadekoBot.db" ( COPY "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp2.0\data\NadekoBot.db" "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp2.1\data\NadekoBot.db" >nul 2>&1)
	timeout /t 2
	IF EXIST "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db" ( RENAME "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.0\data\NadekoBot.db" "NadekoBot_old.db" >nul 2>&1)
	ECHO.
	IF EXIST "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.1\data\NadekoBot.db" ( RENAME "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp1.1\data\NadekoBot.db" "NadekoBot_old.db" >nul 2>&1)
	ECHO.
	IF EXIST "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp2.0\data\NadekoBot.db" ( RENAME "%installtemp%NadekoBot\src\NadekoBot\bin\Release\netcoreapp2.0\data\NadekoBot.db" "NadekoBot_old.db" >nul 2>&1)
	ECHO.
	ECHO bin folder copied...
	ROBOCOPY "%root%NadekoBot_Old\src\NadekoBot\data" "%installtemp%NadekoBot\src\NadekoBot\data" /E >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	ECHO.
	ECHO Old data folder copied...
	::Moves the setup Nadeko folder
	RMDIR "%root%NadekoBot\" /S /Q >nul 2>&1
	ROBOCOPY "%root%NadekoInstall_Temp" "%rootdir%" /E /MOVE >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:dotnet
	::Terminates the batch script if it can't run dotnet --version
	TITLE Error!
	ECHO dotnet not found, make sure it's been installed as per the guides instructions!
	ECHO Press any key to exit.
	PAUSE >nul 2>&1
	CD /D "%root%"
	GOTO :EOF
:git
	::Terminates the batch script if it can't run git --version
	TITLE Error!
	ECHO git not found, make sure it's been installed as per the guides instructions!
	ECHO Press any key to exit.
	PAUSE >nul 2>&1
	CD /D "%root%"
	GOTO :EOF
:giterror
	ECHO.
	ECHO Git clone failed, trying again
	RMDIR "%installtemp%" /S /Q >nul 2>&1
	GOTO :start
:copyerror
	::If at any point a copy error is encountered 
	TITLE Error!
	ECHO.
	ECHO An error in copying data has been encountered, returning an exit code of %ERRORLEVEL%
	ECHO.
	ECHO Make sure to close any files, such as `NadekoBot.db` before continuing or try running the installer as an Administrator, if it does not help, try installing the bot again in a new folder.
	PAUSE >nul 2>&1
	CD /D "%root%"
	GOTO :EOF
:64BIT
ECHO.
ECHO Your System Architecture is 64bit...
GOTO end
:32BIT
ECHO.
ECHO Your System Architecture is 32bit...
timeout /t 5
ECHO.
ECHO Getting 32bit libsodium.dll and opus.dll...
IF EXIST "%root%\NadekoBot\NadekoBot.Core\_libs\32\libsodium.dll" (GOTO copysodium) ELSE (GOTO downloadsodium)
:copysodium
del "%root%\NadekoBot\src\NadekoBot\libsodium.dll"
IF EXIST "%root%\NadekoBot\src\NadekoBot\libsodium.dll" ren "%root%\NadekoBot\src\NadekoBot\libsodium.dll" "libsodium_%date:/=-%_%time::=-%.dll_backup"
COPY "%root%\NadekoBot\NadekoBot.Core\_libs\32\libsodium.dll" "%root%\NadekoBot\src\NadekoBot\libsodium.dll"
ECHO libsodium.dll file copied.
ECHO.
timeout /t 5
IF EXIST "%root%\NadekoBot\NadekoBot.Core\_libs\32\opus.dll" (GOTO copyopus) ELSE (GOTO downloadopus)
:downloadsodium
SET "FILENAME=%~dp0\NadekoBot\src\NadekoBot\libsodium.dll"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Kwoth/NadekoBot/1.9/NadekoBot.Core/_libs/32/libsodium.dll -OutFile '%FILENAME%'"
ECHO libsodium.dll downloaded.
ECHO.
timeout /t 5
IF EXIST "%root%\NadekoBot\NadekoBot.Core\_libs\32\opus.dll" (GOTO copyopus) ELSE (GOTO downloadopus)
:copyopus
del "%root%\NadekoBot\src\NadekoBot\opus.dll"
IF EXIST "%root%\NadekoBot\src\NadekoBot\opus.dll" ren "%root%\NadekoBot\src\NadekoBot\opus.dll" "opus_%date:/=-%_%time::=-%.dll_backup"
COPY "%root%\NadekoBot\NadekoBot.Core\_libs\32\opus.dll" "%root%\NadekoBot\src\NadekoBot\opus.dll"
ECHO opus.dll file copied.
GOTO end
:downloadopus
SET "FILENAME=%~dp0\NadekoBot\src\NadekoBot\opus.dll"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Kwoth/NadekoBot/1.9/NadekoBot.Core/_libs/32/opus.dll -OutFile '%FILENAME%'"
ECHO opus.dll downloaded.
GOTO end
:end
	::Normal execution of end of script
	TITLE NadekoBot Installation complete!
	CD /D "%root%"
	RMDIR /S /Q "%installtemp%" >nul 2>&1
	ECHO.
	ECHO Installation complete!
	ECHO.
	timeout /t 5
	del Latest.bat
