#!/bin/bash
# Links
# MacOS Duo relese versions https://duo.com/docs/macos-notes
# MacOS Duo system requirements https://duo.com/docs/macos
# Vars
# Latest software version.
latest_software_version="MacLogon-2.0.4"
# Grabs the installed version name from system_profiler
installed_software_version=$(system_profiler SPInstallHistoryDataType | grep "MacLogon" | sed 's/^[ \t]*//; s/[:]*$//')
# MacOS required version
mac_os_version_required="15"
# MacOS current version
mac_os_current_version=$(sw_vers -productVersion)
# Trims down the product version to just the first number.
mac_os_major_version=$(echo "$mac_os_current_version" | cut -d '.' -f 1)
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
installer_name="MacLogon-2.0.4.pkg"
# Client specific vars for the configuration script.
ikey="DIRHVP0AHK0XX964QR6H"
skey="0tJ7UpL5zhn3tn4086J5lttkfKmFGRXQiO2RQOaE"
host="api-e34ea2c3.duosecurity.com"
failopen="false"
bypass_smartcard="false"
autopush="true"
# Script
# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo." 
    exit 1
fi
# Compairs the latest version above to the installed.
if [ "$installed_software_version" = "$latest_software_version" ]; then
    echo "The MacLogon version is the latest version ($installed_software_version)... ending script..."
    exit 1
else
    echo "The MacLogon version is NOT the latest version ($installed_software_version)... updating..."
fi
# Compairs the required MacOS version.
if [ "$mac_os_major_version" -ge "$mac_os_version_required" ]; then
    echo "The MacOS version is on the required or higher version ($mac_os_current_version)...continuing script..."
else
    echo "The MacOS version is NOT on the required or higher version ($mac_os_current_version)...version required is ($mac_os_version_required) or higher...ending script..."
    exit 1
fi
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
# Runs the configuration script that was extracted from the zip.
configure_script="./configure_maclogon.sh"
echo "Setting execute permission for the configuration script."
chmod +x "$configure_script"
echo "Passing Duo config vars..."
$configure_script <<EOF
$ikey
$skey
$host
$failopen
$bypass_smartcard
$autopush
EOF
#Runs the MacLogon installer
echo "Running the installer($installer_name)..."
sudo installer -pkg $installer_name -target / -verboseR


