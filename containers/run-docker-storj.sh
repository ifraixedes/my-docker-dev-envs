#!/usr/bin/env bash

set -eu -o pipefail

# Required parameters
repo_remote="${1}"
path_dir_container_script="${2}"

# This variable is used for identifying docker image, volumes, git branches,etc.
id=storj

volume_name="ifraixedes-ubuntu-${id}"
if ! docker volume ls | grep ${volume_name} >/dev/null; then
	docker volume create ${volume_name}
fi

user_name=$(id -un)
repo_branch="${id}"
persistent_dir="/home/${user_name}/persistent"

# group isn't passed to --user flag because it allows to use all the groups that
# the host machine user belongs. This is useful to be able to use docker-cli
# installed in the container connecting to the host docker daemon
docker run --name ifraixedes-${id} \
	--rm \
	-ti \
	--user "${user_name}" \
	--hostname if${id} \
	--network=host \
	--mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
	--mount type=volume,src="${volume_name}",dst=/home/"${user_name}"/persistent \
	--mount type=bind,src="${HOME}",dst=/hostmachine \
	--cap-add=SYS_PTRACE \
	--security-opt seccomp=unconfined \
	ifraixedes/ubuntu/${id}:20.04 \
	zsh -c \
	"${path_dir_container_script}/private/init-storj.sh ${persistent_dir} ${repo_remote} ${repo_branch} && \
    ${path_dir_container_script}/entrypoint-storj.sh"
