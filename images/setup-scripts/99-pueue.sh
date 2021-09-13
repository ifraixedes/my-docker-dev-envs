#!/usr/bin/env bash

set -eu -o pipefail

readonly VERSION="1.0.1"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="pueue"
readonly DOWNLOAD_URL="https://github.com/Nukesor/pueue/releases/download/v${VERSION}/pueue-linux-x86_64"

curl --fail -L \
	-o "${INSTALLATION_DIR}/${BIN_NAME}" \
	"${DOWNLOAD_URL}"

chmod +x "${INSTALLATION_DIR}/${BIN_NAME}"