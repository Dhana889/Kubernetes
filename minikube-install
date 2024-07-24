How to install minikube on Ubuntu 22.04 LTS

In this article, we will how to install minikube on Ubuntu 22.04 LTS step by step.

minikube is a tool that lets you run Kubernetes locally. minikube runs a single-node Kubernetes cluster on your personal computer (including Windows, macOS and Linux PCs) so that you can try out Kubernetes, or for daily development work.

Prerequisites to install minikube:


1. sudo privileges or root user access
2. 2 CPUs or more
3. 2GB of free memory
4. 20GB of free disk space
5. Internet connection
6. Container or virtual machine manager, such as: Docker, QEMU, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
7. Virtualization must be enabled.

Steps to install minikube on Ubuntu 22.04 LTS Linux:
1. First we have to update and upgrade the packages of Ubuntu system.

$ sudo apt-get update -y
$ sudo apt-get upgrade -y

How to install minikube on Ubuntu 22.04 LTS

2. Install the following required packages

$ sudo apt-get install curl
$ sudo apt-get install apt-transport-https

3. Now, install Docker on Ubunut 22.04 LTS using below command.

$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

$ sudo systemctl status docker
$ sudo systemctl enable --now docker
$ sudo usermod -aG docker ubuntu && newgrp docker
$ sudo systemctl restart docker
$ docker ps

Install kubectl on Ubuntu 22.04 LTS version:

4. Install kubectl on Ubuntu 22.04 by running below commands
Download the latest release with the command:

$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

5. Validate the binary:

Download the checksum file.

$ curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

Validate the kubectl binary against the checksum file:

$ echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

6. Install kubectl using below command:

$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

7. Now verify the kubectl version.

$ kubectl version --client --output=yaml

Installation of minikube on Ubuntu 22.04
1. Run the below command to download the minikube binary.

$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

2. Install the minikube

$ sudo install minikube-linux-amd64 /usr/local/bin/minikube

3. Now verify minikube version:

$ minikube version

So, we have successfully performed minikube installation on Ubuntu 22.04 LTS.

To create a 2 node cluster on minikube:

$ minikube start --nodes 2 -p local-cluster --driver=docker

This command create a 2 nodes, ie., master and worker nodes with driver as docker engine. 

To check the status of the cluster, use the below command.

$ minikube status -p local-cluster
