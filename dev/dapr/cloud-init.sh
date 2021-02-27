#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

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

echo 'PATH="$PATH:/usr/local/go/bin:'$HOME'/go/bin"' >> ~/.bash_aliases

echo "# dapr..."
wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash

dapr init

echo "# complete!"
