#!/bin/bash
## Links
#### RC uninstall Doc https://helpdesk.kaseya.com/hc/en-gb/articles/4407233189777-How-To-Uninstall-RocketCyber-Agent
#Uninstalls RC if it is not already.
if which /usr/local/rocketcyber/mac-agent-updater >/dev/null; then
    echo "RC is installed...uninstalling RC..."
    sudo /usr/local/rocketcyber/mac-agent-updater UNINSTALL "" "" ""
    if which /usr/local/rocketcyber/mac-agent-updater >/dev/null; then
        echo "RC uninstalled successful!"
    else
        echo "The RC uninstall failed."
    fi
else
    echo "RC is not installed...ending script"
fi

