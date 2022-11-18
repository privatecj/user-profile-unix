#!/bin/bash

sudo mkdir /usr/local/apps
sudo chown -R $USER /usr/local/apps
sudo chmod 777 /usr/local/apps
export SDKMAN_DIR="/usr/local/apps/sdkman"
curl -s "https://get.sdkman.io" | bash
source "$SDKMAN_DIR/bin/sdkman-init.sh"
sdk version

sdk i java 17.0.5-zulu
sdk i maven
sdk i gradleq