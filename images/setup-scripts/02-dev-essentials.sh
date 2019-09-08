#!/usr/bin/env bash

set -eu -o pipefail

# Install general compilers
apt-get install -y g++

# Install code tools
## https://github.com/ggreer/the_silver_searcher
apt-get install -y silversearcher-ag
