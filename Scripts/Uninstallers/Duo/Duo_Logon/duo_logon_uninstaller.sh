#!/bin/bash
# Links
# MacOS Duo relese versions https://duo.com/docs/macos-notes
# MacOS Duo system requirements https://duo.com/docs/macos
# Vars
# Location to create tmp folder in.
temp_folder="/tmp"
# Location do DL software to.
software_dl_location="/tmp-99"
# URL to DL software
software_dl_url="https://dl.duosecurity.com/MacLogon-latest.zip"
# MacLogon .zip name.
maclogon_zip_name="MacLogon-latest.zip"
# Unzipped software name.
unzipped_software_name="MacLogon-2.0.4"
# Installer name
uninstaller_name="MacLogon-Uninstaller-2.0.4.pkg"
# Script
# Creating a folder to DL to
if [ -d "$temp_folder/$software_dl_location" ]; then
    echo "The temp folder ($temp_folder/$software_dl_location) exists...continuing..."
else
    echo "The temp folder ($temp_folder/$software_dl_location) does not exist...creating it..."
    mkdir -p "$temp_folder/$software_dl_location"
fi
# Setting DL location
echo "Setting the dir to the DL location ($temp_folder/$software_dl_location)..."
cd "$temp_folder/$software_dl_location"
# Downloading software
echo "Downloading the latest software from ($software_dl_url)..."
curl -O "$software_dl_url"
# Extracts the .zip
echo "Unzipping ($maclogon_zip_name) to ($temp_folder/$software_dl_location)..."
unzip "$maclogon_zip_name" -d "$temp_folder/$software_dl_location"
# Change the location to the unzipppd location.
echo "Changing the dir to the unzipped dir($temp_folder/$software_dl_location/$unzipped_software_name)..."
cd "$temp_folder/$software_dl_location/$unzipped_software_name"
#Runs the MacLogon installer
echo "Running the uninstaller($uninstaller_name)..."
sudo installer -pkg $uninstaller_name -target / -verboseR


