#!/bin/bash
echo "Starting BASH SHELL"

## Detect current script location and user name 
SCRIPT_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Script Root DIR: "$SCRIPT_ROOT_DIR
echo "As User: "$USER
echo ""


function install_linux_profile() {
    echo "
    source ~/mydrive/user-profile/linux-init.sh
    " >> "~/.bashrc"
        
    echo "
    if [ -f ~/.bashrc ]; then 
        source ~/.bashrc 
    fi
    " >> "~/.bash_profile"
        
    touch ~/.user-profile-installed
    echo "installed linux profile"
}

function install_mac_profile() {
    echo "
    source ~/mydrive/user-profile/mac-init.sh
    " >> "~/.bashrc"
        
    echo "
    if [ -f ~/.bashrc ]; then 
        source ~/.bashrc 
    fi
    " >> "~/.bash_profile"
        
    touch ~/.user-profile-installed
    echo "installed linux profile"
}

function install_profile(){
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_linux_profile;
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        install_mac_profile
    fi
}

FILE=~/.user-profile-installed
if ! test -f "$FILE"; then
    echo "installing user profile"
    install_profile;
else
    echo "user profile already installed. skipping installtion"
fi



