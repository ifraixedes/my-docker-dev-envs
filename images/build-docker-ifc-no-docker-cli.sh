#!/usr/bin/env bash

set -eu -o pipefail

docker build \
	--force-rm \
	--no-cache \
	-f Dockerfile-no-docker-cli.ifc \
	-t ifraixedes/ubuntu/ifc:22.04 .
