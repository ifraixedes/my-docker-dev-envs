#!/usr/bin/env bash

set -eu -o pipefail

readonly VERSION="2024.7.4"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="mise"
readonly DOWNLOAD_URL="https://github.com/jdx/mise/releases/download/v${VERSION}/mise-v${VERSION}-linux-x64.tar.xz"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	trap - EXIT

	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.tar.xz" \
	"${DOWNLOAD_URL}"

cd "${TMP_DIR}"
xz -d "${BIN_NAME}.tar.xz"
tar xf "${BIN_NAME}.tar" --strip-components 1
chmod +x "bin/${BIN_NAME}"
mv "bin/${BIN_NAME}" "${INSTALLATION_DIR}"
