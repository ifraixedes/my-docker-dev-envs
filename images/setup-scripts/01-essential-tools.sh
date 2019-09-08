#!/usr/bin/env bash

set -eu -o pipefail

# Update certificates
apt-get install -y ca-certificates
update-ca-certificates

# Install essentials tools
apt-get install -y \
  apt-transport-https \
  bzip2 \
  curl \
  git \
  gnupg \
  gnupg-agent \
  htop \
  keychain \
  locales \
  mercurial \
  net-tools \
  psmisc \
  tmux \
  unzip \
  zsh
