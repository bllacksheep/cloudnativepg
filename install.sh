#!/usr/bin/env bash

if [ "$1" == "-v" ]; then
  set -x
fi

sudo apt update && sudo apt upgrade -y
sudo apt install curl -y

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.24.17+k3s1" sh -

(
cd "$(mktemp -d)" &&   OS="$(uname | tr '[:upper:]' '[:lower:]')" && \
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" && \
KREW="krew-${OS}_${ARCH}" &&   wget "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" && \
tar zxvf "${KREW}.tar.gz" && ./"${KREW}" install krew;
)

echo 'export PATH="export PATH="$HOME/.krew/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

(
cd $(mktemp -d) && \
wget "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
wget "https://github.com/derailed/k9s/releases/download/v0.50.18/k9s_Linux_arm64.tar.gz" 
)

sudo kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.16/releases/cnpg-1.16.5.yaml

for i in {1..5}; do echo waiting for $((6-$i)) && sleep 1; done

sudo kubectl apply -f cluster.yaml
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
kubectl krew install cnpg

echo ################ RUNNING DB STATUS ######################
sudo --preserve-env=PATH kubectl cnpg status cluster-with-metrics -n db
