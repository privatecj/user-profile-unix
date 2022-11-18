#!/bin/bash

pushd /tmp

sudo apt-get update
wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
sudo dpkg -i dropbox.deb
sudo apt-get install -fy

popd
