#!/usr/bin/env bash

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

curl --fail -L \
  -o "${installation_dir}/kubectl" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.14.8/bin/linux/amd64/kubectl"
chmod +x "${installation_dir}/kubectl"
