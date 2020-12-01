#!/usr/bin/env bash

set -eu -o pipefail

version=3.6.1

installation_dir=/apps
mkdir -p ${installation_dir}

curl --fail -L \
	-o "${installation_dir}/sops" \
	"https://github.com/mozilla/sops/releases/download/v${version}/sops-v${version}.linux"
chmod +x "${installation_dir}/sops"
