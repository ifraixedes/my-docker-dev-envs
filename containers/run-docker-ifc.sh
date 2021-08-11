#!/usr/bin/env bash

set -eu -o pipefail

# Required parameters
repo_remote="${1}"
path_dir_container_script="${2}"

# This variable is used for identifying docker image, volumes, git branches,etc.
readonly ID=ifc

volume_name="ifraixedes-ubuntu-${ID}"
if ! docker volume ls | grep ${volume_name} >/dev/null; then
	docker volume create ${volume_name}
fi

user_name=$(id -un)
repo_branch="${ID}"
persistent_dir="/home/${user_name}/persistent"

docker run --name ifraixedes-${ID} \
	--rm \
	-ti \
	--user "${user_name}:${user_name}" \
	--hostname if${ID} \
	--network=host \
	--mount type=volume,src="${volume_name}",dst=/home/"${user_name}"/persistent \
	--mount type=bind,src="${HOME}",dst=/hostmachine \
	ifraixedes/ubuntu/${ID}:20.04 \
	zsh -c \
	"${path_dir_container_script}/init-ifc.sh ${persistent_dir} ${repo_remote} ${repo_branch} && \
    ${path_dir_container_script}/entrypoint-ifc.sh"
