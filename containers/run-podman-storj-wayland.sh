#!/usr/bin/env bash

set -eu -o pipefail

# Required parameters
readonly repo_remote="${1}"

# This variable is used for identifying docker image, volumes, git branches,etc.
readonly ID=storj
user_name=$(id -un)
readonly user_name
user_group_name=$(id -gn)
readonly user_group_name
repo_branch="${ID}"
readonly repo_branch
readonly persistent_dir="/home/${user_name}/persistent"

volume_name="ifraixedes-ubuntu-${ID}"
if ! podman volume ls | grep ${volume_name} >/dev/null; then
	podman volume create  ${volume_name}
fi

# TODO: figure out how to share the GUI windows with a Wayland host machine

podman container run --name ifraixedes-${ID} \
	--rm \
	-ti \
	--user "${user_name}:${user_group_name}" \
	--hostname if${ID} \
	--add-host=if${ID}:127.0.0.1 \
	--dns=1.1.1.1 \
	--network=host \
	--mount "type=volume,src=${volume_name},dst=/home/${user_name}/persistent,chown" \
	--mount "type=bind,src=${HOME}/workspace,dst=/hostmachine/workspace" \
	--mount "type=bind,src=${HOME}/cloud/mega/devices/configs/operative-system/docker/ubuntu/22.04/containers,dst=/hostmachine/container-scripts,readonly" \
	--mount "type=bind,src=${HOME}/cloud/mega/devices/configs/operative-system/docker/home.git,dst=/hostmachine/container-home.git" \
	--cap-add=SYS_PTRACE \
	--security-opt seccomp=unconfined \
	--userns=keep-id \
	--workdir="/home/${user_name}" \
	ifraixedes/ubuntu/${ID}:22.04 \
	zsh -c \
	"/hostmachine/container-scripts/private/init-${ID}.sh ${persistent_dir} ${repo_remote} ${repo_branch} && \
    	/hostmachine/container-scripts/entrypoint-${ID}.sh"
