#!/usr/bin/env -S bash -

set -eu -o pipefail

installation_dir=/usr/local/bin

tmp_dir=$(mktemp -d)
cleanup() {
  rm -rf "${tmp_dir}"
}
#trap cleanup EXIT

curl --fail \
  -o "${tmp_dir}/keybase.deb" \
  "https://prerelease.keybase.io/keybase_amd64.deb"

echo ${tmp_dir}
dpkg -i "${tmp_dir}/keybase.deb"
