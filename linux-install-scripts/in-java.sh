#!/bin/bash

sudo mkdir /usr/local/sdkman
sudo chown -R $USER /usr/local/sdkman
sudo chmod 777 /usr/local/sdkman
export SDKMAN_DIR="/usr/local/sdkman"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

sdk i java 17.0.5-zulu
sdk i maven
sdk i gradle