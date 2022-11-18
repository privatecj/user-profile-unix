#!/bin/bash

pushd /tmp

sudo apt-get update
wget -O hyper.deb https://releases.hyper.is/download/deb
sudo dpkg -i hyper.deb
sudo apt-get install -fy

popd
