#!/usr/bin/env bash

set -eu -o pipefail

readonly VERSION="1.15.2"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="kubectl"
readonly DOWNLOAD_URL="https://storage.googleapis.com/kubernetes-release/release/v${VERSION}/bin/linux/amd64/kubectl"

curl --fail -L \
	-o "${INSTALLATION_DIR}/${BIN_NAME}" \
	"${DOWNLOAD_URL}"

chmod +x "${INSTALLATION_DIR}/${BIN_NAME}"
