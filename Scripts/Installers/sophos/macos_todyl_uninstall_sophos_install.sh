#!/bin/bash
#Notes
## Todyl Uninstaller: https://support.todyl.com/hc/en-us/articles/360052086014-Deployment-Updating-Uninstallation-of-the-SGN-Agent#h_01EVVXTS754Q8708YE0MFQ2Q2S
## Sophos Installer: https://docs.sophos.com/central/partner/help/en-us/Help/Configure/Installers/MacCommandLine/index.html#customer-token
# vars
# sgn service
sgnservice=$(launchctl list | grep -i com.todyl.SGNAgent*)
# Location to create tmp folder in.
temp_folder="/tmp"
# Location to DL software to.
software_dl_location="tmp-99"  # Removed leading slash
# URL to DL software
## Note, to get the client specific URL, manually download the installer onto a windows device, then run the following PowerShell cmd against the file. Be sure to change the path to the file.
### Get-Content -Path "C:\Users\UserNameHere\Downloads\SophosInstall.zip" -Stream Zone.Identifier
software_dl_url="https://dzr-api-amzn-us-west-2-fa88.api-upe.p.hmr.sophos.com/api/download/12345678901234567890/SophosInstall.zip"
# MacLogon .zip name.
zip_software_name="SophosInstall.zip"
# Unzipped software name.
unzipped_software_name="SophosInstall"
# Installer name
installer_name="Sophos Installer.app"
# Script
# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi
# checks to see if SGN is install by checking for the following service. If so, it uninstalls it.
if launchctl list | grep -q "$sgnservice"; then
    echo "($sgnservice) found...uninstalling it..."
    sudo curl -s https://portal.todyl.com/tools/MacUninstall.sh | sudo bash -s -- -f
else
    echo "The service does not exist or is not running...continuing..."
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
# Extracts the .zip
echo "Unzipping ($zip_software_name) to ($temp_folder/$software_dl_location)..."
unzip "$zip_software_name" -d "$temp_folder/$software_dl_location"
# Change the location to the unzipped location.
echo "Changing the dir to the unzipped dir($temp_folder/$software_dl_location)"
cd "$temp_folder/$software_dl_location"
# Runs the installer
echo "Running the installer ($installer_name)..."
sudo "./Sophos Installer.app/Contents/MacOS/Sophos Installer" --quiet

