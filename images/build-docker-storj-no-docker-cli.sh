#!/usr/bin/env bash

set -eu -o pipefail

docker build \
  --force-rm \
  --no-cache \
  -f Dockerfile-no-docker-cli.storj \
  -t ifraixedes/ubuntu/storj:22.04 .
