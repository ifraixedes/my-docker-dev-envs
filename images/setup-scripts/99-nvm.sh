#!/usr/bin/env bash

set -eux -o pipefail

NVM_DIR="/apps/nvm"
git clone https://github.com/creationix/nvm.git "${NVM_DIR}"
cd "${NVM_DIR}"
git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" origin)"
