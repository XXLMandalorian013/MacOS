#!/bin/bash
## Notes
#### Silently install Hyper if it is not already.
# Installed app name.
installlocation="Hyper.app"
# Installer package name.
brewpackage="wget"
# Software name.
softwarename="Hyper"
# Download URL.
dlurl="https://releases.hyper.is/download/mac"
# DL installer name. Note, check the DL link to see if the name change.
dlsoftwarename="Hyper-3.4.1-mac-x64.dmg"
# DL path.
dlpath="/tmp"
# mounted dmg name.
mntvolumename="Hyper 3.4.1"
# Argument to see if the app is installed or not.
findapp=$(find /Applications -name "$installlocation")
if [ -n "$findapp" ]; then
    echo "Application found at: $findapp...ending script..."
else
    echo "$softwarename not found...running installer..."
    # installs wget if its not already.
    if which "$brewpackage" >/dev/null; then
        echo "$brewpackage is installed...skipping step"
    else
        echo "$brewpackage is not installed...starting installer"
        brew install wget
    fi
    # setting DL path for wget and .dmg mount.
    cd $dlpath
    # dls the .dmg
    echo "downloading .dmg..."
    wget -O "$dlsoftwarename" "$dlurl"
    # mounting the .dmg
    echo "mounting .dmg..."
    hdiutil attach "$dlsoftwarename"
    # install the .dmg
    echo "installing .dmg..."
    cp -R "/Volumes/$mntvolumename" /Applications/
    # detaches the .dmg
    echo "ejecting .dmg..."
    hdiutil detach "/Volumes/$mntvolumename"
    # Argument to see if the app is installed or not.
    findapp=$(find /Applications -name "$installlocation")
    if [ -n "$findapp" ]; then
        echo "Installation successful: $findapp"
    else
        echo "Installation failed."
    fi
fi
