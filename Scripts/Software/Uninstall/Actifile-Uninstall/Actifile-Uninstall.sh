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
    # Dir location temp folder.
    Dir_Location="/var"
    # Temp folder for the files.
    Temp_Folder="temp99"

    echo "Actifile is installed...uninstalling Actifile"
    # Changes the dir location to the temp location
    cd "$Dir_Location"
    # Makes a folder in the temp location
    echo "Making temp dir..."
    mktemp -d -p "$Dir_Location" "$Temp_Folder"
    # Downloads the file from the URL var above.
    echo "Downloading uninstaller..."
    curl -sSL "$DOWNLOAD_URL1" -o "$Dir_Location/$Temp_Folder"
    echo "Unzipping the file..."
    # unzips the DL.
    unzip "$Dir_Location/$Temp_Folder/$SLT_Installer_Zip" -d "$Dir_Location/$Temp_Folder/$SLT_Installer_Zip"
    # Makes the DL script executable.
    echo "Making the file executble..."
    chmod +x install_actifile.sh
    # Silently uninstalls the program. Be sure to specify the user to uninstall the program
    echo "uninstalling the software..."
    sudo ./ActifileMacAgentInstaller.app/Contents/MacOS/FileControlInstaller uninstall --user root

    # waits for the uninstall to finish
    sleep 180
    # Checks to see if Actifile installed or not.
    if [ ! -d "$Install_Path" ]; then
        echo "Actifile uninstall successful!!!"
        rm -r "$Dir_Location"
    fi
fi

