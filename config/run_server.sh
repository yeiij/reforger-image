#!/bin/bash

# Default settings
addons="" # -addons 88037E46AD234C72,88037E46AD234C73
addonsDir="./custom/addons"
addonDownloadDir="./custom"
addonTempDir="./custom/temp"
config="./custom/config.json"
freezeCheck="300"
logLevel="normal"
logStats="10000"
maxFPS="120"
profile="./custom"

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -addons) addons="$2"; shift ;;
        -addonsDir) addonsDir="$2"; shift ;;
        -addonDownloadDir) addonDownloadDir="$2"; shift ;;
        -addonTempDir) addonTempDir="$2"; shift ;;
        -config) config="$2"; shift ;;
        -freezeCheck) freezeCheck="$2"; shift ;;
        -logLevel) logLevel="$2"; shift ;;
        -logStats) logStats="$2"; shift ;;
        -maxFPS) maxFPS="$2"; shift ;;
        -profile) profile="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Binary Settings
BINARY="./ArmaReforgerServer"

# Build the command
SETTINGS_BASIC="-logLevel $logLevel -maxFPS $maxFPS -config $config -profile $profile"
SETTINGS_PERFORMANCE="-freezeCheck $freezeCheck -logStats $logStats -backendLog -noThrow -loadSessionSave"
SETTINGS_CONTENT="-addons $addons -addonsDir $addonsDir -addonDownloadDir $addonDownloadDir -addonTempDir $addonTempDir"

# Compose the full settings
SETTINGS_FULL="$SETTINGS_BASIC $SETTINGS_PERFORMANCE $SETTINGS_CONTENT"

# Compose the full command
RUN_CMD="$BINARY $SETTINGS_FULL"

# Print the full command
echo "$RUN_CMD"
sleep 5

# Run the server with the full command
$RUN_CMD