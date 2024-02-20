#!/usr/bin/env bash

set -eux -o pipefail

readonly VERSION=3.8.1
readonly INSTALLATION_DIR=/apps
mkdir -p ${INSTALLATION_DIR}

readonly BIN_NAME="sops"
readonly DOWNLOAD_URL="https://github.com/getsops/sops/releases/download/v${VERSION}/sops-v${VERSION}.linux.amd64"

curl --fail -L \
	-o "${INSTALLATION_DIR}/${BIN_NAME}" \
	"${DOWNLOAD_URL}"

chmod +x "${INSTALLATION_DIR}/${BIN_NAME}"
