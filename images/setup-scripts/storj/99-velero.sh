#!/usr/bin/env -S bash -

set -eu -o pipefail

version_to_install="1.4.2"

installation_dir=/apps
mkdir -p ${installation_dir}

tmp_dir=$(mktemp -d)
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

curl --fail -L \
  -o "${tmp_dir}/velero.tgz" \
  "https://github.com/vmware-tanzu/velero/releases/download/v${version_to_install}/velero-v${version_to_install}-linux-amd64.tar.gz"

cd "${tmp_dir}"
tar -zxf "velero.tgz" --strip-components 1 --no-same-owner
chmod +x "velero"
mv velero "${installation_dir}/velero"
