#!/usr/bin/env -S bash -

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

curl --fail -L \
  -o "${installation_dir}/stern" \
  "https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64"

chmod +x "${installation_dir}/stern"
