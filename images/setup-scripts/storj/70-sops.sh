#!/usr/bin/env bash

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

curl --fail -L \
  -o "${installation_dir}/sops" \
  "https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.linux"
chmod +x "${installation_dir}/sops"
