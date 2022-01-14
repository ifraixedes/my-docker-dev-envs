#!/usr/bin/env -S bash -

set -eu -o pipefail


docker build \
  --force-rm \
  --no-cache \
  --pull \
  -t ifraixedes/ubuntu/app-keybase:20.04 .
