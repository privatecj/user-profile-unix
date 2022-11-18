#!/bin/bash
echo "Starting BASH SHELL"

## Detect current script location and user name 
SCRIPT_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Script Root DIR: "$SCRIPT_ROOT_DIR
echo "As User: "$USER
echo ""

rm $HOME/.user-profile-installed

function install_linux_profile() {
    echo "
    source $HOME/mydrive/user-profile/linux-init.sh
    " >> "$HOME/.bashrc"
        
    # echo "
    # if [ -f $HOME/.bashrc ]; then 
    #     source $HOME/.bashrc 
    # fi
    # " >> "$HOME/.bash_profile"
        
    touch $HOME/.user-profile-installed
    echo "installed linux profile"
}

function install_mac_profile() {
    echo "
    source $HOME/mydrive/user-profile/mac-init.sh
    " >> "$HOME/.bashrc"
        
    # echo "
    # if [ -f $HOME/.bashrc ]; then 
    #     source $HOME/.bashrc 
    # fi
    # " >> "$HOME/.bash_profile"
        
    touch $HOME/.user-profile-installed
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
