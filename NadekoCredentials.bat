@echo off

SET root=%~dp0
CD /D %root%

IF EXIST "%root%NadekoBot\src\NadekoBot\credentials.json" (GOTO installed) ELSE (GOTO notinstalled)

:notinstalled
title Failed Creating NadekoBot credentials.json
echo You don't have NadekoBot installed. Please Install NadekoBot (latest or stable) build before trying again!
pause
del NadekoCredentials.bat

:installed
title Creating NadekoBot credentials.json
echo Please make sure you have all the required informations to setup the credentials.json before continuing...
echo Refer to the hosting documents for more info...
echo.
pause
set /p client=Please enter your Client ID:
cls
set /p botid=Please enter your Bot ID (it is same as the client ID for new users):
cls
set /p token=Please enter your Bot Token (it is not the Client Secret, Please make sure you enter the Token and not Client Secret):
cls
set /p owner=Please enter your Owner ID:
cls
set /p googleapi=Please enter your Goggle API key (Optional!! You can skip this step pressing Enter key): 
cls
set /p lolapi=Please enter your LoLApiKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p mashape=Please enter your MashapeKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p osu=Please enter your OsuApiKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p scid=Please enter your SoundCloudClientId (Optional!! You can skip this step pressing Enter key):
cls
(
echo {
echo   "ClientId": %client%,
echo   "BotId": %botid%,
echo   "Token": "%token%",
echo   "OwnerIds": [
echo     %owner%,
echo   ],
echo   "LoLApiKey": "%lolapi%",
echo   "GoogleApiKey": "%googleapi%",
echo   "MashapeKey": "%mashape%",
echo   "OsuApiKey": "%osu%",
echo   "SoundCloudClientId": "%scid%",
echo   "CarbonKey": "",
echo   "Db": null,
echo   "TotalShards": 1
echo }
) > %root%NadekoBot\src\NadekoBot\credentials.json
echo.
echo Saved!
echo credentials.json setup is now complete!
echo.
CD /D "%root%"
pause
del NadekoCredentials.bat