#!/bin/bash

# echo https://ourcodeworld.com/articles/read/1686/how-to-install-prometheus-node-exporter-on-ubuntu-2004
# https://docs.vmware.com/en/VMware-vRealize-Operations-Management-Pack-for-Kubernetes/1.6/kubernetes-solution/GUID-A1B68BE5-EF38-48E1-AA80-FD71E6F19989.html

pushd /tmp

wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz
tar xvfz node_exporter*
sudo mv node_exporte*/node_exporter /usr/local/bin/
sudo useradd -rs /bin/false node_exporter

sudo tee /etc/systemd/system/node_exporter.service<<EOF
[Unit]
Description=Node Exporter
After=network.target
 
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
 
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

popd