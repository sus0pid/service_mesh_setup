#!/bin/bash
#-----------------------------------------------------------
# Script Name: step1_containerd.sh
# Description: Install containerd (each node)
# Author: Xinshu Ma
# Date: $(date +"%Y-%m-%d")
#-----------------------------------------------------------

sudo apt-get update
sudo apt-get upgrade -y
curl -L -o containerd-1.7.20-linux-amd64.tar.gz https://github.com/containerd/containerd/releases/download/v1.7.20/containerd-1.7.20-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.7.20-linux-amd64.tar.gz
sudo mkdir /usr/local/lib/systemd
sudo mkdir /usr/local/lib/systemd/system
sudo curl -o /usr/local/lib/systemd/system/containerd.service https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
curl -L -o runc.amd64 https://github.com/opencontainers/runc/releases/download/v1.1.7/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
curl -L -o  cni-plugins-linux-amd64-v1.5.1.tgz https://github.com/containernetworking/plugins/releases/download/v1.5.1/cni-plugins-linux-amd64-v1.5.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.5.1.tgz

# generate config.toml file
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

containerd --version
echo "Step 1 done, containerd installed."
