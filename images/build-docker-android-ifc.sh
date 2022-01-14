#!/usr/bin/env bash

set -eu -o pipefail

# configuration parameters
user_name=$(id -un)

docker build \
  --force-rm \
  --no-cache \
  --build-arg USER_NAME="${user_name}" \
  -f Dockerfile.ifc.android \
  -t ifraixedes/ubuntu/android/ifc:19.04 .
