#!/usr/bin/env bash

set -eux -o pipefail

readonly VERSION="0.1.2"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="jnv"
readonly DOWNLOAD_URL="https://github.com/ynqa/jnv/releases/download/v${VERSION}/jnv-x86_64-unknown-linux-gnu.tar.xz"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	trap - EXIT

	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.xz" \
	"${DOWNLOAD_URL}"

cd "${TMP_DIR}"
tar xf "${BIN_NAME}.xz" --no-same-owner --strip-components 1
chmod +x "${BIN_NAME}"
mv "${BIN_NAME}" "${INSTALLATION_DIR}/"
