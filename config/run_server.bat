@ECHO OFF

REM Binary Settings
SET BINARY="ArmaReforgerServer.exe"
REM Check if the binary exists
IF NOT EXIST %BINARY% (
    ECHO Binary not found: %BINARY%
    EXIT /B 1
)
REM Basic Settings
SET logLevel="normal"
SET maxFPS="120"
SET profile=".\custom"
SET config=".\custom\config.json"
REM Performance Settings
SET freezeCheck="300"
SET logStats="10000"
REM Content Settings - "C:\Users\%USERNAME%\Documents\My Games\ArmaReforger\addons"
SET addonsDir=".\custom\addons"
SET addonDownloadDir=".\custom"
SET addonTempDir=".\custom\temp"
REM Build the command
SET SETTINGS_BASIC=-logLevel %logLevel% -maxFPS %maxFPS% -config %config% -profile %profile%
SET SETTINGS_PERFORMANCE=-freezeCheck %freezeCheck% -logStats %logStats% -backendLog -noThrow -loadSessionSave
SET SETTINGS_CONTENT=-addonsDir %addonsDir% -addonDownloadDir %addonDownloadDir% -addonTempDir %addonTempDir%
REM Compose the full settings
SET SETTINGS_FULL=%SETTINGS_BASIC% %SETTINGS_PERFORMANCE% %SETTINGS_CONTENT%
REM Compose the full command
SET APP_CMD=%BINARY% %SETTINGS_FULL%
REM Print the full command
ECHO %APP_CMD%
timeout /t 5 /nobreak
REM Run the server with the full command
%APP_CMD%