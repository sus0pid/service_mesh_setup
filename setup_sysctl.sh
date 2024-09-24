#!/bin/bash

# update the sysctl configuration file and apply the changes:
sudo tee -a /etc/sysctl.conf << EOF
vm.swappiness=0
vm.overcommit_memory=1
vm.panic_on_oom=0
fs.inotify.max_user_watches=89100
EOF

sudo sysctl -p

# create a new file in /etc/modules-load.d/ to ensure the specified kernel modules are loaded at boot:
sudo tee /etc/modules-load.d/k8s.conf << EOF
overlay
br_netfilter
EOF

# create a new sysctl configuration file specifically for Kubernetes-related settings:
sudo tee /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
EOF

sudo sysctl --system

# load the required kernel modules immediately and verify they are loaded:
sudo modprobe br_netfilter  # Load the network bridge module
sudo modprobe overlay       # Load the overlay filesystem module
lsmod | grep -e br_netfilter -e overlay

