#!/usr/bin/env bash

set -eux -o pipefail

readonly VERSION="1.35.0"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="fnm"
readonly DOWNLOAD_URL="https://github.com/Schniz/fnm/releases/download/v${VERSION}/fnm-linux.zip"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	trap - EXIT

	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.zip" \
	"${DOWNLOAD_URL}"

cd "${TMP_DIR}"
unzip "${BIN_NAME}.zip" -d "${INSTALLATION_DIR}"
chmod +x "${INSTALLATION_DIR}/fnm"
