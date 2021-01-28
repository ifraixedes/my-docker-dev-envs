#!/usr/bin/env bash

set -eu -o pipefail

version=0.2.3

installation_dir=/apps
mkdir -p "${installation_dir}"

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${tmp_dir}/ijq.tgz" \
	"https://git.sr.ht/~gpanders/ijq/refs/v${version}/ijq-${version}-linux-x86_64.tar.gz"

cd "${tmp_dir}"
tar -zxf "ijq.tgz" --strip-components 1 --no-same-owner
chmod +x "${tmp_dir}/ijq"
mv ijq "${installation_dir}/ijq"
