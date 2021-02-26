#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "# make..."
sudo apt-get install -y \
        make

echo "# microk8s..."
sudo snap install microk8s --classic --channel=1.19
mkdir -p $HOME/.kube/
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
sudo microk8s config > $HOME/.kube/config
sudo microk8s enable helm3

tee -a ~/.bash_aliases <<'EOF'
function helm {
        sudo microk8s helm3 "$@"
}

function kubectl {
        sudo microk8s kubectl "$@"
}
EOF
source ~/.bash_aliases

echo "# k9s..."
VERSION='0.24.2'
curl -OL https://github.com/derailed/k9s/releases/download/v${VERSION}/k9s_Linux_x86_64.tar.gz
mkdir -p tmp/
tar -C tmp/ -xvf k9s_Linux_x86_64.tar.gz
rm k9s_Linux_x86_64.tar.gz
sudo mv -f tmp/k9s /usr/local/bin
rm -rf tmp/
mkdir $HOME/.k9s/

echo "# lazygit..."
sudo add-apt-repository --yes ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install -y lazygit

echo "# golang..."
VERSION='1.16'
OS='linux'
ARCH='amd64'

curl -OL https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

echo 'PATH="$PATH:/usr/local/go/bin:/root/go/bin"' >> ~/.bash_aliases

echo "# kedacore/keda..."
{
# https://keda.sh/docs/2.0/deploy/#install
helm repo add kedacore https://kedacore.github.io/charts
helm repo update

kubectl create namespace keda
helm install keda kedacore/keda --version 2.0.0 --namespace keda
} || true

echo "# kedacore/http-add-on..."
{
cd $HOME
git clone https://github.com/kedacore/http-add-on.git
cd http-add-on
} || true

echo "# complete!"
