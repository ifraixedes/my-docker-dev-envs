#!/usr/bin/env -S bash -

set -eux -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${tmp_dir}/hugo.tgz" \
	"https://github.com/gohugoio/hugo/releases/download/v0.68.3/hugo_0.68.3_Linux-64bit.tar.gz"

tar -C "${installation_dir}" --no-same-owner -xzf "${tmp_dir}/hugo.tgz"
