#!/bin/bash

#Exit if not run as root
if [[ "$EUID" -ne 0 ]]; then
    echo "Please run this script as root (sudo)."
    exit 1
fi

echo "Checking for ThreatLocker processes..."

#Quit ThreatLocker Tray App
echo "Attempting to quit ThreatLocker Tray..."
osascript -e 'tell application "System Events" to quit application process "ThreatLockerTray"' 2>/dev/null

#Kill all known ThreatLocker processes
echo "Killing ThreatLocker background processes..."
TL_PROCESSES=("ThreatLocker" "ThreatLockerTray" "ThreatLockerDaemon" "ThreatLockerAgent")

for PROC in "${TL_PROCESSES[@]}"; do
    pkill -f "$PROC"
done

#Remove ThreatLocker login items (if manually added)
echo "Attempting to remove login items (user scope)..."
su -l "$SUDO_USER" -c 'osascript -e "tell application \"System Events\" to delete login item \"ThreatLockerTray\""' 2>/dev/null

#Remove LaunchAgents and LaunchDaemons if applicable
echo "Attempting to unload and delete launch agents/daemons..."
launchctl bootout system /Library/LaunchDaemons/com.threatlocker.* 2>/dev/null
launchctl bootout user/$(id -u "$SUDO_USER") /Library/LaunchAgents/com.threatlocker.* 2>/dev/null

#Attempt uninstall
echo "Running uninstall..."
open /Applications/ThreatLocker.app --args -uninstall

mv /Applications/ThreatLocker.app ~/.Trash
echo "Removed the app icon ThreatLocker to trash"

echo "Attempted ThreatLocker removal process. Please confirm manually via the ThreatLocker portal or support tools if necessary."

echo "Thank you for using ThreatLocker product"