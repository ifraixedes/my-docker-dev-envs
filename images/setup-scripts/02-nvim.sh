#!/usr/bin/env bash

set -eu -o pipefail

# This allows sites (like the Neovim Personal Package Archive) which prefer IPv4
# to work.
echo "precedence ::ffff:0:0/96 100" >>/etc/gai.conf

# Install this package because is required to add PPA repositories.
apt-get install -y software-properties-common

# Install Neovim.
add-apt-repository -y ppa:neovim-ppa/stable
apt-get install -y neovim

# If there is the need for Python modules in the future visit
# https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
