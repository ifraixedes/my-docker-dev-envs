#!/usr/bin/env bash

set -eu -o pipefail

GO_VERSION=1.14.1

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail \
  -o "${tmp_dir}/golang.tar.gz" \
  "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz"
tar -C "${installation_dir}" --no-same-owner -xzf "${tmp_dir}/golang.tar.gz"

# Install tools usually used for Go development
apt-get install -y graphviz
