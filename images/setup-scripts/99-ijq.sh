#!/usr/bin/env bash

set -eux -o pipefail

readonly VERSION=1.0.0
readonly INSTALLATION_DIR=/apps
mkdir -p ${INSTALLATION_DIR}

readonly BIN_NAME="ijq"
readonly DOWNLOAD_URL="https://git.sr.ht/~gpanders/ijq/refs/download/v${VERSION}/ijq-${VERSION}-linux-amd64.tar.gz"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.tgz" \
	"${DOWNLOAD_URL}"

cd "${TMP_DIR}"
tar -zxf "${BIN_NAME}.tgz" --strip-components 1 --no-same-owner
chmod +x "${TMP_DIR}/ijq"
mv ijq "${INSTALLATION_DIR}/ijq"
