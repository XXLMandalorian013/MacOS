#!/bin/bash

# Uninstalls Actifile if it is not already.
Install_Path="/Library/Application Support/Actifile"

if [ ! -d "$Install_Path" ]; then
    echo "Actifile is already uninstalled...ending script."
else
    # Program DL URL Var.
    DOWNLOAD_URL1="https://support.actifile.com/wp-content/uploads/2021/06/silent_install.zip"
    # .zip unzipped name.
    SLT_Installer_Zip="silent_install.zip"
    # Temp dir location full path.
    Temp_Location="/var"

    echo "Actifile is not installed...installing Actifile"
    # Changes the dir location to the temp location
    cd "$Temp_Location"
    # Makes a folder in the temp location
    mktemp -d -t temp99
    # Downloads the file from the URL var above.
    curl -sSL "$DOWNLOAD_URL1" -o "$Temp_Location/$SLT_Installer_Zip"
    # unzips the DL.
    unzip "$Temp_Location/$SLT_Installer_Zip" -d "$Temp_Location"
    # Makes the DL script executable.
    chmod +x install_actifile.sh
    # Silently uninstalls the program. Be sure to specify the user to uninstall the program
    sudo ./ActifileMacAgentInstaller.app/Contents/MacOS/FileControlInstaller uninstall --user root

    # waits for the uninstall to finish
    sleep 180
    # Checks to see if Actifile installed or not.
    if [ ! -d "$Install_Path" ]; then
        echo "Actifile uninstall successful!!!"
    fi
fi

