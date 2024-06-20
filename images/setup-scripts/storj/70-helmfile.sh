#!/usr/bin/env bash

set -eux -o pipefail

readonly VERSION="0.165.0"
readonly INSTALLATION_DIR=/apps
mkdir -p ${INSTALLATION_DIR}

readonly BIN_NAME="helmfile"
readonly DONWLOAD_URL="https://github.com/helmfile/helmfile/releases/download/v${VERSION}/helmfile_${VERSION}_linux_amd64.tar.gz"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.tgz" \
	"${DONWLOAD_URL}"

cd "${TMP_DIR}"
tar xzf "${BIN_NAME}.tgz"
chmod +x "${BIN_NAME}"
mv "${BIN_NAME}" "${INSTALLATION_DIR}/"
