#!/bin/bash

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

sdk i java 17.0.4-zulu
sdk i maven
sdk i gradle