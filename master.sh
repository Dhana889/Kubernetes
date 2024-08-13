#!/bin/bash
#
# Setup for Control Plane (Master) servers

set -euxo pipefail

# Initialize Kubeadm ( just Master nodes)
sudo kubeadm config images pull
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Switch to Normal user and configure kubeconfig

mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

# Setup Calico Network Plugin

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/custom-resources.yaml -O

# Any changes in Pod cidr should require the below command to run
# sed -i 's/cidr: 192\.168\.0\.0\/16/cidr: 10.10.0.0\/16/g' custom-resources.yaml

kubectl create -f custom-resources.yaml

# Verify the Cluster

kubectl cluster-info
kubectl get no
kubectl get po -A

# misc

# If you missed copying the join command, execute the following command in the master node
## kubeadm token create --print-join-command

# To label worker nodes, replace <node01>
## kubectl label node <node01> node-role.kubernetes.io/worker=worker
