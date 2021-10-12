#!/usr/bin/env bash

set -eu -o pipefail

installation_dir="/usr/local"
mkdir -p "${installation_dir}"

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

pushd "${tmp_dir}"

git clone https://github.com/universal-ctags/ctags.git

pushd ctags
./autogen.sh
./configure --prefix="${installation_dir}"
make
make install

popd
popd
