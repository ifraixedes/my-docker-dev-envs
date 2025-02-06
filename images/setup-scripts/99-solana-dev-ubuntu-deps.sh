#!/usr/bin/env bash

set -eu -o pipefail

apt-get update -y
apt-get install -y \
	build-essential \
	pkg-config \
	libudev-dev llvm libclang-dev \
	protobuf-compiler libssl-dev
