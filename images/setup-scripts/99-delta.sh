#!/usr/bin/env -S bash -

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${tmp_dir}/delta.tgz" \
	"https://github.com/dandavison/delta/releases/download/0.1.1/delta-0.1.1-x86_64-unknown-linux-musl.tar.gz"

cd "${tmp_dir}"
tar -zxf "delta.tgz" --strip-components 1 --no-same-owner
chmod +x "delta"
mv delta "${installation_dir}/delta"
