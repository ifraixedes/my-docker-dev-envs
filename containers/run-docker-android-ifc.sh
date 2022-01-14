#!/usr/bin/env bash

set -eu -o pipefail

# Required parameters
repo_remote="${1}"
path_dir_container_script="${2}"

# This variable is used for identifying docker image, volumes, git branches,etc.
id=ifc

volume_name="ifraixedes-ubuntu-19.04-android-${id}"
if ! docker volume ls | grep ${volume_name} >/dev/null; then
	docker volume create ${volume_name}
fi

user_name=$(id -un)
repo_branch="${id}-android"
persistent_dir="/home/${user_name}/persistent"

docker run --name ifraixedes-android-${id} \
	--rm \
	-ti \
	--user "${user_name}:${user_name}" \
	--hostname if${id} \
	--network=host \
	--env="DISPLAY" \
	--mount type=bind,src=${HOME}/.Xauthority,dst=/root/.Xauthority \
	--mount type=volume,src=${volume_name},dst=/home/${user_name}/persistent \
	--mount type=bind,src=${HOME},dst=/hostmachine \
	ifraixedes/ubuntu/android/${id}:19.04 \
	zsh -c \
	"${path_dir_container_script}/init-android-ifc.sh ${persistent_dir} ${repo_remote} ${repo_branch} && \
    ${path_dir_container_script}/entrypoint-android-ifc.sh"
