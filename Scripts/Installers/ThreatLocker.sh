#!/bin/bash
# Location to create tmp folder in.
temp_folder="/tmp"
# Location to DL software to.
software_dl_location="tmp-99"  # Removed leading slash
# URL to DL software
software_dl_url="https://updates.threatlocker.com/repository/MAC/pkg/ThreatLocker.pkg"
# Installer name (should match what curl downloads)
installer_name="ThreatLocker.pkg"
# Installers name to change to client specific one w/ key.
installer_re_named="ThreatLocker Installer-12345678910.pkg"
# Script
# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi
# Creating a folder to DL to
full_dl_path="$temp_folder/$software_dl_location"
if [ -d "$full_dl_path" ]; then
    echo "The temp folder ($full_dl_path) exists...continuing..."
else
    echo "The temp folder ($full_dl_path) does not exist...creating it..."
    mkdir -p "$full_dl_path"
fi
# Setting DL location
echo "Setting the dir to the DL location ($full_dl_path)..."
cd "$full_dl_path"
# Downloading software
echo "Downloading the latest software from ($software_dl_url)..."
curl -O "$software_dl_url"
# Change installer name to client specific w/ key.
mv "$installer_name" "$installer_re_named"
# Runs the installer
echo "Running the installer ($installer_name)..."
sudo installer -pkg "$installer_re_named" -target / -verbose


