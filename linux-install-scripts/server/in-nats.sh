#!/bin/bash

pushd /tmp

curl -L https://github.com/nats-io/nats-server/releases/download/v2.9.2/nats-server-v2.9.2-amd64.deb -o nats-server.deb 
sudo dpkg -i nats-server.deb

curl -L https://github.com/nats-io/natscli/releases/download/v0.0.34/nats-0.0.34-amd64.deb -o nats-client.deb 
sudo dpkg -i nats-client.deb

curl -L https://github.com/nats-io/nats-top/releases/download/v0.5.3/nats-top-v0.5.3-amd64.deb -o nats-top.deb 
sudo dpkg -i nats-top.deb

sudo useradd -rs /bin/false nats

sudo tee /etc/systemd/system/nats.service<<EOF
[Unit]
Description=Nats Server
After=network.target
 
[Service]
User=nats
Group=nats
Type=simple
ExecStart=/usr/local/bin/nats-server -js -m 8222
 
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start nats
sudo systemctl status nats
sudo systemctl enable nats

popd