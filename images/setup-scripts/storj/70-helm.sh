#!/usr/bin/env bash

set -eux -o pipefail

readonly VERSION="3.15.2"
readonly INSTALLATION_DIR=/apps
mkdir -p ${INSTALLATION_DIR}

readonly BIN_NAME="helm"
readonly DONWLOAD_URL="https://get.helm.sh/helm-v${VERSION}-linux-amd64.tar.gz"
readonly DONWLOAD_SHA_URL="https://get.helm.sh/helm-v${VERSION}-linux-amd64.tar.gz.sha256sum"

TMP_DIR=$(mktemp -d)
readonly TMP_DIR
cleanup() {
	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.tgz" \
	"${DONWLOAD_URL}"

curl --fail -L \
	-o "${TMP_DIR}/${BIN_NAME}.sha" \
	"${DONWLOAD_SHA_URL}"

cd "${TMP_DIR}"
readonly SHA=$(cat ${BIN_NAME}.sha)
readonly SHA_CALCULATED=$(sha256sum ${BIN_NAME}.tgz | cut -d ' ' -f 1)
if [ "${SHA}" -ne "${SHA_CALCULATED}" ]; then
	echo "Invalid Helm checksum"
	exit 1
fi

tar xzf "${BIN_NAME}.tgz" --no-same-owner --strip-components 1
chmod +x "${BIN_NAME}"
mv "${BIN_NAME}" "${INSTALLATION_DIR}/"

ln -s "${INSTALLATION_DIR}/${BIN_NAME}" "${INSTALLATION_DIR}/helm3"
