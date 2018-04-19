@echo off

SET root=%~dp0
CD /D %root%

call :guide %%%%1 %%%%2 %%%%3 %%%%4 %%%%5 %%%%6 %%%%7 %%%%8 %%%%9
goto end

:guide
start https://nadekobot.readthedocs.io/en/latest/JSON%20Explanations/

:end

IF EXIST "%root%NadekoBot\src\NadekoBot" (GOTO installed) ELSE (GOTO notinstalled)

:notinstalled
title Failed Creating NadekoBot credentials.json
echo.
echo You don't have NadekoBot installed. Please Install NadekoBot (latest or stable) build before trying again!
echo.
pause
del NadekoCredentials.bat

:installed
title Creating NadekoBot credentials.json
echo.
echo Please make sure you have all the required informations to setup the credentials.json before continuing...
echo.
echo Refer to the hosting documents for more info...
echo.
pause
IF EXIST "%root%NadekoBot\src\NadekoBot\credentials.json" (GOTO backup) ELSE (GOTO create)

:backup
echo.
echo Backing up existing credentials.json...
IF EXIST "%root%NadekoBot\src\NadekoBot\credentials.json.backup3" del "%root%NadekoBot\src\NadekoBot\credentials.json.backup3"
IF EXIST "%root%NadekoBot\src\NadekoBot\credentials.json.backup2" rename "%root%NadekoBot\src\NadekoBot\credentials.json.backup2" "credentials.json.backup3"
IF EXIST "%root%NadekoBot\src\NadekoBot\credentials.json.backup" rename "%root%NadekoBot\src\NadekoBot\credentials.json.backup" "credentials.json.backup2"
rename "%root%NadekoBot\src\NadekoBot\credentials.json" "credentials.json.backup"
echo.
echo Back up complete...
echo.
pause
GOTO create

:create
cls
set /p client=Please enter your Client ID:
cls
set /p token=Please enter your Bot Token ~59 characters long(it is not the Client Secret, Please make sure you enter the Token and not Client Secret):
cls
set /p owner=Please enter your Owner ID:
cls
set /p googleapi=Please enter your Google API key (Optional!! You can skip this step pressing Enter key): 
cls
set /p lolapi=Please enter your LoLApiKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p mashape=Please enter your MashapeKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p osu=Please enter your OsuApiKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p scid=Please enter your SoundCloudClientId (Optional!! You can skip this step pressing Enter key):
cls
set /p clvrapi=Please enter your CleverbotApiKey (Optional!! You can skip this step pressing Enter key):
cls
(
echo {
echo   "ClientId": %client%,
echo   "Token": "%token%",
echo   "OwnerIds": [
echo     %owner%,
echo   ],
echo   "LoLApiKey": "%lolapi%",
echo   "GoogleApiKey": "%googleapi%",
echo   "MashapeKey": "%mashape%",
echo   "OsuApiKey": "%osu%",
echo   "SoundCloudClientId": "%scid%",
echo   "CleverbotApiKey": "%clvrapi%",
echo   "TwitchClientId": null,
echo   "CarbonKey": "",
echo   "Db": null,
echo   "RestartCommand": {
echo       "Cmd": "dotnet",
echo       "Args": "run -c Release"
echo   },
echo   "ShardRunCommand": "dotnet",
echo   "ShardRunArguments": "run -c Release -- {0} {1}",
echo   "TotalShards": 1,
echo }
) > "%root%NadekoBot\src\NadekoBot\credentials.json"
echo.
echo Saved!
echo credentials.json setup is now complete!
echo.
CD /D "%root%"
pause
del NadekoCredentials.bat
