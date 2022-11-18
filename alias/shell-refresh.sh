#!/bin/bash

echo "Shell refresh"

function download_profile(){
    cd /home/$USER/mydrive;
    pwd;
    rm -rf user-profile
    wget -O user-profile.zip https://www.dropbox.com/sh/p7gylx6vwupq5u3/AACcQSAO_EYXtJgRB_mHdP6ha?dl=1;
    unzip -o user-profile.zip -d user-profile;
    rm -f user-profile.zip
    cd install;
    find /home/$USER/mydrive/user-profile -type f -exec dos2unix {} \;
    chown -R $USER /home/$USER
    pwd
}

function install_profile(){
    cd /home/$USER/mydrive/user-profile
    ./install.sh
}

function r { 
    echo $SCRIPT_ROOT_DIR
    source $SCRIPT_ROOT_DIR"/linux-init.sh"; 
}

function rr(){
    download_profile
}