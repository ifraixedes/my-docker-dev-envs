#!/usr/bin/env bash

set -eu -o pipefail

installation_dir=/apps
mkdir -p ${installation_dir}

curl --fail -L \
	-o "${installation_dir}/terragrunt" \
	"https://github.com/gruntwork-io/terragrunt/releases/download/v0.21.9/terragrunt_linux_amd64"
chmod +x "${installation_dir}/terragrunt"
