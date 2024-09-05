#!/usr/bin/env bash

set -eu -o pipefail

# Required parameters
repo_remote="${1}"
path_dir_container_scripts="${2}"

# This variable is used for identifying docker image, volumes, git branches,etc.
readonly ID=base

volume_name=ifraixedes-ubuntu-base
if ! docker volume ls | grep ${volume_name} >/dev/null; then
	docker volume create ${volume_name}
fi

user_name=$(id -un)
repo_branch=main
persistent_dir="/home/${user_name}/persistent"

docker run --name ifraixedes-base \
	--rm \
	-ti \
	--user "${user_name}:${user_name}" \
	--hostname ifbase \
	--network=host \
	--mount "type=volume,src=${volume_name},dst=/home/${user_name}/persistent" \
	--mount "type=bind,src=${HOME}/workspace,dst=/hostmachine/workspace" \
	--mount "type=bind,src=${path_dir_container_scripts},dst=/hostmachine/container-scripts,readonly" \
	--mount "type=bind,src=${repo_remote},dst=/hostmachine/container-home.git" \
	ifraixedes/ubuntu/base:22.04 \
	zsh -c \
	"/hostmachine/container-scripts/init-base.sh ${persistent_dir} /hostmachine/container-home.git ${repo_branch} && \
    /hostmachine/container-scripts/entrypoint-${ID}.sh"
