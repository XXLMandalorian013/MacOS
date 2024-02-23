#!/bin/bash
## Notes
#### the curl below can be found on client sites.
# Installs RC if it is not already.
if which /usr/local/rocketcyber >/dev/null; then
    echo "RC is already installed...ending script"
else
    echo "RC is not installed...installing RC"
    # Replace the numbers between "customers/12345-67890/supports" and after "bash -s 12345-67890" with your site key.
    curl -sSL https://app.rocketcyber.com/api/customers/12345-67890/supports/install.sh | bash -s 12345-67890 https://app.rocketcyber.com/ 
    # Checks to see if RC installed or not.
    if which /usr/local/rocketcyber >/dev/null; then
        echo "RC install successful!"
    fi
fi

