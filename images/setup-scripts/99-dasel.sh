#!/usr/bin/env bash

set -eu -o pipefail

version=1.8.0

installation_dir=/apps
mkdir -p "${installation_dir}"

curl --fail -L \
	-o "${installation_dir}/dasel" \
	"https://github.com/TomWright/dasel/releases/download/v${version}/dasel_linux_amd64"

chmod +x "${installation_dir}/dasel"
