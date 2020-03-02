#!/usr/bin/env bash

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
  -o "${tmp_dir}/terraform.zip" \
  "https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip"
unzip -jX "${tmp_dir}/terraform.zip" -d "${installation_dir}"
chmod +x "${installation_dir}/terraform"
