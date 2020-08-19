#!/usr/bin/env bash

set -eu -o pipefail

version_to_install="1.7.1"

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${tmp_dir}/vale.tgz" \
	"https://github.com/errata-ai/vale/releases/download/v${version_to_install}/vale_${version_to_install}_Linux_64-bit.tar.gz"
tar -C "${tmp_dir}" --no-same-owner -xzf "${tmp_dir}/vale.tgz"
mv "${tmp_dir}/vale" "${installation_dir}"
chmod +x "${installation_dir}/vale"
