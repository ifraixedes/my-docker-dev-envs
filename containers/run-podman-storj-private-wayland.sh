#!/usr/bin/env bash

set -eu -o pipefail

script_dir="$(
	cd "$(dirname "$0")"
	pwd -P
)"
repo_remote="/hostmachine/container-home.git"
path_dir_container_script="/hostmachine/cloud/mega/devices/configs/operative-system/docker/ubuntu/22.04/containers"

"${script_dir}/run-podman-storj-wayland.sh" "${repo_remote}" "${path_dir_container_script}"
