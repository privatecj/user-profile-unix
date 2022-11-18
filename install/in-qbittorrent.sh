#!/bin/bash

# https://www.kryii.com/12.html
# https://linuxhomeserver.com/applications/install-torrent-client/
# https://stackoverflow.com/questions/5161193/how-to-kill-a-child-process-after-a-given-timeout-in-bash

sudo apt-get -y install software-properties-common
yes | sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt update
sudo apt install -y qbittorrent-nox

#sudo adduser --system qbtuser

echo "
[Unit]
Description=qBittorrent Daemon Service
After=network.target

[Service]
User=cj
ExecStart=/usr/bin/qbittorrent-nox
ExecStop=/usr/bin/killall -w qbittorrent-nox

[Install]
WantedBy=multi-user.target
" > /tmp/qbi.service

sudo mv /tmp/qbi.service /etc/systemd/system/qbittorrent.service
sudo sed -i 's#ExecStart=/usr/bin/qbittorrent-nox#ExecStart=/usr/bin/qbittorrent-nox --webui-port=8000#g' /etc/systemd/system/qbittorrent.service

( cmdpid=$BASHPID; (sleep 10; kill -9 $cmdpid) & exec print 'y' | qbittorrent-nox )

sudo systemctl enable qbittorrent.service
sudo systemctl start qbittorrent.service
sudo systemctl status qbittorrent.service
