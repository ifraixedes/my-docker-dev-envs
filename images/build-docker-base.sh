#!/usr/bin/env bash

set -eu -o pipefail

# configuration parameters
user_name=$(id -un)
user_id=$(id -u)

# Root's password to use
if [[ "$#" -gt 0 ]]; then
  root_pwd="${1}"
else
  read -s -p "specify password for root user: " root_pwd
fi

docker build \
  --force-rm \
  --no-cache \
  --pull \
  --build-arg USER_NAME="${user_name}" \
  --build-arg USER_ID="${user_id}" \
  --build-arg ROOT_PWD="${root_pwd}" \
  -f Dockerfile.base \
  -t ifraixedes/ubuntu/base:19.04 .
