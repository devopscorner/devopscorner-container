#!/usr/bin/env sh

# ================================================================================================
#  INSTALL KUBECTL (AMAZON LINUX)
# ================================================================================================
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

ln -nsf /usr/bin/kubectl /usr/local/bin/kubectl
ln -nsf /usr/bin/kubectl /usr/local/bin/k
