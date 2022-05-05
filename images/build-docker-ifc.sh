#!/usr/bin/env bash

set -eu -o pipefail

docker build \
  --force-rm \
  --no-cache \
  -f Dockerfile.ifc \
  -t ifraixedes/ubuntu/ifc:22.04 .
