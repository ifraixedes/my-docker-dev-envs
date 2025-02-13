#!/usr/bin/env bash

set -eux -o pipefail

readonly VERSION="0.63.0"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="difft"
readonly DOWNLOAD_URL="https://github.com/Wilfred/difftastic/releases/download/${VERSION}/difft-x86_64-unknown-linux-gnu.tar.gz"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	trap - EXIT

	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.tgz" \
	"${DOWNLOAD_URL}"

cd "${TMP_DIR}"
tar zxf "${BIN_NAME}.tgz" --no-same-owner
chmod +x "${BIN_NAME}"
mv "${BIN_NAME}" "${INSTALLATION_DIR}/"
