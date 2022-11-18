#!/bin/bash

pushd /tmp
INSTALL_DIR=~/MYDISK/user-installed/masscode
# ln -s "$(pwd)/masscode.AppImage" "$(pwd)/masscode"

sudo apt-get update
wget -O masscode.snap https://github.com/massCodeIO/massCode/releases/download/v3.4.1/masscode_3.4.1_amd64.snap
sudo snap install --dangerous masscode.snap

popd