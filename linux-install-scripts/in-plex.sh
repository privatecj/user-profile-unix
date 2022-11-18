#!/bin/bash

pushd /tmp

wget https://downloads.plex.tv/plex-media-server-new/1.20.1.3252-a78fef9a9/debian/plexmediaserver_1.20.1.3252-a78fef9a9_amd64.deb
sudo dpkg -i plexmedia*.deb
sudo apt --fix-broken install
sudo systemctl status plexmediaserver

PUBLICIP=$(curl ipinfo.io/ip)
echo "========================= SSH TUNNEL ========================="
echo "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null cj@$PUBLICIP -L 8888:localhost:32400"
echo "http://localhost:8888/web"
echo ""

popd