#!/bin/bash
## Links
### VulScan Discovery Agent install Doc https://www2.rapidfiretools.com/vs/help/nd-pro-docs/linux-and-osx-agent-install.htm


###########################################################################################

### Insatlls .net runtime 6.0, a requirment for the Vulscan Discovery Agent.
echo "Starting the dotnet runtime version 6.0.0 install"
## Variables
architecture=$(uname -m)
# Check if it's x86_64 (Intel-based)
if [[ "$architecture" == "x86_64" ]]; then
    # Run the Intel-specific curl command
    curl -O https://dotnetcli.blob.core.windows.net/dotnet/checksums/6.0.0-sha.txt
    export DOTNET_ROOT=$HOME/.dotnet
elif [[ "$architecture" == "arm64" ]]; then
    # Run the Apple M1-specific curl command
    curl -O https://dotnetcli.blob.core.windows.net/dotnet/checksums/6.0.0-sha.txt
else
    echo "Unknown architecture: $architecture"
    exit 1
fi

### Insatlls .net runtime 6.0, a requirment for the Vulscan Discovery Agent.
echo "Starting the dotnet runtime version 6.0.0 install"
## Variables
    # Run the Intel-specific curl command
    curl -O https://dotnetcli.blob.core.windows.net/dotnet/checksums/6.0.0-sha.txt


################################################################################################

./dotnet-install.sh --runtime dotnet --version 6.0.0


### Installs the VulScan Discovery Agent if it is not already.
echo "Starting the VulScan Discovery Agent install"
## Variables
DeviceName="$(scutil --get LocalHostName)"
# Be sure to change this var per the clients name
CompanyName="VS"
if which /usr/local/rocketcyber >/dev/null; then
    echo "The VulScan Discovery Agent is already installed...ending script"
else
    echo "The VulScan Discovery Agent is not installed...installing RC"
curl -O https://download.rapidfiretools.com/download/discoveryagent-install-osx.tar.gz
    tar zxf discoveryagent-install-osx.tar.gz
    ./discoveryagent-install-osx --install
    # Be sure to change the -installkey and the -comment & -label variables to match the client you are installing thos from.
    /opt/discoveryagent/discoveryagent -register -installkey 123456-7890 -comment "$DeviceName-$CompanyName" -label "$DeviceName-$CompanyName" 
    # Checks to see if the VulScan Discovery Agent installed or not.
    if which /usr/local/rocketcyber >/dev/null; then
        echo "The VulScan Discovery Agent install successful!"
    fi
fi

