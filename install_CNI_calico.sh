#!/bin/bash

# 1.install calico
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/tigera-operator.yaml

mkdir -p ~/k8s/calico && cd ~/k8s/calico

# the version of calico should match k8s version
wget --no-check-certificate  https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/custom-resources.yaml
# edit the calico.yaml file
#！！！
# 修改calico.yaml，在 CALICO_IPV4POOL_CIDR 的位置，修改value为pod网段：20.2.0.0/16
#(与前面的--pod-network-cidr参数一致)

kubectl apply -f custom-resources.yaml

# Confirm that all of the pods are running with the following command.
watch kubectl get pods -n calico-system

# 2.install calictl
# navigate to where you want to put the lib
cd /usr/local/bin/
# download calicoctl lib (root)
sudo curl -L https://github.com/projectcalico/calico/releases/download/v3.28.1/calicoctl-linux-amd64 -o calicoctl
# set the file executable (root)
sudo chmod +x calicoctl

# test if installed successfully
# calicoctl command
calicoctl -h
sudo calicoctl node status
sudo calicoctl get nodes

