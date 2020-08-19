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
	-o "${tmp_dir}/hyperfine.tgz" \
	"https://github.com/sharkdp/hyperfine/releases/download/v1.8.0/hyperfine-v1.8.0-x86_64-unknown-linux-gnu.tar.gz"

cd "${tmp_dir}"
tar -zxf "hyperfine.tgz" --strip-components 1 --no-same-owner
chmod +x "hyperfine"
mv hyperfine "${installation_dir}/hyperfine"
