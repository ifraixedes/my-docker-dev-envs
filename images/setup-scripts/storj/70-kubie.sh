#!/usr/bin/env -S bash -

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

curl --fail -L \
  -o "${installation_dir}/kubie" \
  "https://github.com/sbstp/kubie/releases/download/v0.9.0/kubie-linux-amd64"

chmod +x "${installation_dir}/kubie"
