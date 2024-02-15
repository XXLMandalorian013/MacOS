#!/bin/bash
#Kills the OneDrive Process and any other child process.
pgrep -i "OneDrive" | xargs pkill -9 "OneDrive"
#Re-opens OneDrive after the kill. OneDirve, when it
open -jg /Applications/OneDrive.app
