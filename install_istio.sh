#!/bin/bash

# 7.1 install istioctl
# https://istio.io/latest/docs/ops/diagnostic-tools/istioctl/
curl -sL https://istio.io/downloadIstioctl | sh -
export PATH=$HOME/.istioctl/bin:$PATH
istioctl x precheck

# 7.2 install istio with istioctl
# https://istio.io/latest/zh/docs/setup/install/istioctl/
istioctl install
istioctl install --set meshConfig.accessLogFile=/dev/stdout

# check if installation succeed
istioctl manifest generate > $HOME/generated-manifest.yaml
istioctl verify-install -f $HOME/generated-manifest.yaml
# Now you can start explore istio and k8s following the tutorial.

# check installed istio resources
kubectl get deploy,svc,hpa,cm,secret -n istio-system

# 查看istio安装的API对象，istio使用它们来完成各项任务
kubectl api-resources |grep istio
