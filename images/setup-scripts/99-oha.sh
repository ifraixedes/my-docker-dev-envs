#!/usr/bin/env bash

set -eu -o pipefail

version_to_install="0.4.1"

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
  -o "${tmp_dir}/oha" \
  "https://github.com/hatoo/oha/releases/download/v${version_to_install}/oha-linux-amd64"
mv "${tmp_dir}/oha" "${installation_dir}"
chmod +x "${installation_dir}/oha"
