#!/usr/bin/env bash

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

curl --fail -L \
  -o "${installation_dir}/kind" \
  "https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64"
chmod +x "${installation_dir}"/kind
