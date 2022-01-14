#!/usr/bin/env zsh

# NOTES:
# This script assumes that it's executed in the same user home directory
cd ${HOME}

set -eu -o pipefail

## Required arguments
# docker volume to persist installations across container instances and they
# don't have to be in the home git repository
docker_persistent_path="${1}"
repo_url="${2}"
repo_branch="${3}"

## Initialize the base init configuration
script_dir="$(
	cd "$(dirname "$0")"
	pwd -P
)"
${script_dir}/init-base.sh ${docker_persistent_path} ${repo_url} ${repo_branch}

## Source custom paths
source .my-env

## Configure Flutter
# flutter_dir=${docker_persistent_path}/flutter

# Create precache dir if itnot exists and the corresponding symlink
# if [[ ! -d "${flutter_dir}/pub-cache" ]]; then
#   mkdir -p "${flutter_dir}pub-cache"
#   ln -s "${flutter_dir}/pub-cache" .pub-cache
# else
#   ln -s "${flutter_dir}/pub-cache" .pub-cache
# fi
