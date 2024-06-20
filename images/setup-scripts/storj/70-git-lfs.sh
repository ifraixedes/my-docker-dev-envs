#!/bin/bash

# Set up APT repository, keys, and run update afterwards
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

# Install Git LFS
apt-get install -y git-lfs
