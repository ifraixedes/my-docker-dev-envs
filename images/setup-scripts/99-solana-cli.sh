#!/usr/bin/env bash

set -eu -o pipefail

readonly VERSION="2.1.11"
readonly INSTALLATION_DIR="/apps"
mkdir -p "${INSTALLATION_DIR}"

readonly BIN_NAME="solana"
readonly DOWNLOAD_URL="https://github.com/anza-xyz/agave/releases/download/v${VERSION}/solana-release-x86_64-unknown-linux-gnu.tar.bz2"

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
tar xjf "${BIN_NAME}.tar.bz2" --strip-components 1 --same-permissions
mv "bin" "${INSTALLATION_DIR}/solana"
