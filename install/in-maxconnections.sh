#!/bin/bash
pushd /tmp


sudo tee /etc/sysctl.conf <<EOF
net.ipv4.ip_local_port_range = 1024 65535
fs.file-max = 2000000
fs.nr_open = 2000000 
EOF

sudo tee /etc/security/limits.conf <<EOF
* soft nofile 2000000
* hard nofile 2000000
root soft nproc 2000000
root hard nproc 2000000
EOF


sudo sysctl --system


popd