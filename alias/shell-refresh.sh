#!/bin/bash

function download_profile(){
    pushd ~/mydrive/user-profile
    git pull;
    popd
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