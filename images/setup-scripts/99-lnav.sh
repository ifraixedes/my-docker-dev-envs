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
  -o "${tmp_dir}/lnav.zip" \
  "https://github.com/tstack/lnav/releases/download/v0.8.5/lnav-0.8.5-linux-64bit.zip"
unzip -jX "${tmp_dir}/lnav.zip" "*/lnav" -d ${installation_dir}
