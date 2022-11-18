#!/bin/bash

pushd /tmp

wget https://git.io/wireguard -O wireguard-install.sh && sudo bash wireguard-install.sh
sudo cat /root/client.conf

popd