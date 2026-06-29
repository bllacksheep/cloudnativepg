#!/usr/bin/env bash
sudo apt get update && sudo apt get upgrade
sudo apt install curl
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.24.17+k3s1" sh -
(   set -x; cd "$(mktemp -d)" &&   OS="$(uname | tr '[:upper:]' '[:lower:]')" &&   ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&   KREW="krew-${OS}_${ARCH}" &&   curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&   tar zxvf "${KREW}.tar.gz" &&   ./"${KREW}" install krew; )
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "/tmp/awscliv2.zip"
wget https://github.com/derailed/k9s/releases/download/v0.50.18/k9s_Linux_arm64.tar.gz -o "/tmp/k9s_Linux_arm64.tgz"
sudo kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.16/releases/cnpg-1.16.5.yaml
sudo kubectl apply -f cluster.yaml
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
sudo kubectl krew install cnpg
sudo --preserve-env=PATH kubectl cnpg status cluster-with-metrics -n db