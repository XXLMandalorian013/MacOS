#!/bin/bash
## Notes
#### The curl URL below can be found on client sites.
# Installs Actifile if it is not already.
if which /Library/Application Support/Actifile >/dev/null; then
    #echo "Actifile is already installed...ending script"
else
    # Program URL Var.
    DOWNLOAD_URL1="https://support.actifile.com/wp-content/uploads/2021/06/silent_install.zip"
    # download .zip unzipped name.
    SLT_Installer_Zip="silent_install.zip"
    # Temp dir location full path.
    Temp_Location="/var"
    echo "Actifile is not installed...installing Actifile"
    #Set the dir so mktemp will be made
    cd "$Temp_Location"
    # Creates a temporary directory.
    mktemp -d -t temp99
    # Downloads the silent installer .zip to the tmp dir.
    curl -sSL "$DOWNLOAD_URL1" -O "$Temp_Location"
    # Unzips the silent installer
    unzip $SLT_Installer_Zip -d "$Temp_Location"
    # Makes the script executable
    chmod +x install_actifile.sh
    # Silently installs the program. Be sure to change the install key!!!
    ./silent_install.sh install INSTALL_KEY
    # Checks to see if RC installed or not.
    if which /Library/Application Support/Actifile >/dev/null; then
        echo "Actifile install successful!"#
    fi
fi

