#!/bin/bash

sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh)
sudo usermod -aG nordvpn $USER
