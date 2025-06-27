#!/usr/bin/env bash

set -eu -o pipefail

readonly VERSION="1.0.29"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="goose"
readonly DOWNLOAD_URL="https://github.com/block/goose/releases/download/v${VERSION}/goose-x86_64-unknown-linux-gnu.tar.bz2"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	trap - EXIT

	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.tar.bz2" \
	"${DOWNLOAD_URL}"

cd "${TMP_DIR}"
tar xjf "${BIN_NAME}.tar.bz2" --same-permission # --strip-components 1 --same-permissions
mv "${BIN_NAME}" "${INSTALLATION_DIR}/"
