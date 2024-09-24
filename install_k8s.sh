#!/bin/bash
#-----------------------------------------------------------
# Script Name: step2_k8s.sh
# Description: Install kubenetes: kubeadm、kubelet and kubectl (each node)
# Author: Xinshu Ma
# Date: $(date +"%Y-%m-%d")
#-----------------------------------------------------------

sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# 开机启动，且立即启动
sudo systemctl enable --now kubelet

# 检查版本
kubeadm version
kubelet --version
kubectl version

# 配置容器运行时，以便后续通过crictl管理 集群内的容器和镜像
sudo crictl config runtime-endpoint unix:///var/run/containerd/containerd.sock

# 注意更新节点时间（部署的Pod资源会使用节点的时间）：
sudo apt-get install -y ntpdate
sudo ntpdate -u pool.ntp.org

