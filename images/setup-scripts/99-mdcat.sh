#!/usr/bin/env bash

set -eu -o pipefail

version="0.22.3"

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${tmp_dir}/mdcat.tgz" \
	"https://github.com/lunaryorn/mdcat/releases/download/mdcat-${version}/mdcat-${version}-x86_64-unknown-linux-musl.tar.gz"

cd "${tmp_dir}"
tar -zxf "mdcat.tgz" --strip-components 1 --no-same-owner
chmod +x "mdcat"
mv mdcat "${installation_dir}/mdcat"
