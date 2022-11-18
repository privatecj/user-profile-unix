#!/bin/bash

function download_profile(){
    pushd ~/mydrive/user-profile
    git pull;
    popd
}

function r { 
    source ~/.bashrc
}

function rr(){
    download_profile
}