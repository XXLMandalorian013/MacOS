#!/bin/bash
#Notes
## Sophos Installer: https://support.sophos.com/support/s/article/KBA-000001485?language=en_US
# vars
# sgn service
service=$(launchctl list | grep -i com.sophos.endpoint*)
# checks to see if software is install by checking for the following service. If so, it uninstalls it.
if launchctl list | grep -q "$service"; then
    echo "($service) found...uninstalling it..."
    cd /Library/Application\ Support/Sophos/saas/Installer.app/Contents/MacOS/tools/
    sudo ./InstallationDeployer --remove
else
    echo "The service does not exist or is not running...continuing..."
fi

