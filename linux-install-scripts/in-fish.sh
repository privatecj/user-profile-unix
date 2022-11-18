#!/bin/bash

sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get -y update
sudo apt-get -y install fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
chsh -s /usr/bin/fish
