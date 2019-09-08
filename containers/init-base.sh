#!/usr/bin/env bash

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

## Install dot files
git init .
git remote add origin "${repo_url}"
git fetch
git checkout "${repo_branch}"

## Reset permissions on the .ssh keys
if [[ -d .ssh ]]; then
  chmod 700 .ssh
  chmod 600 -R .ssh/*
fi

## Create home user persistent directories if they don't exist
mkdir -p "${docker_persistent_path}/bin"

## Install vim plugins if they haven't been installed before
if [[ ! -d "${docker_persistent_path}/vim" ]]; then
  mkdir -p "${docker_persistent_path}/vim"
  ln -s "${docker_persistent_path}/vim" .vim
  GOBIN="${docker_persistent_path}/bin" vim +PlugInstall +qall!
else
  ln -s "${docker_persistent_path}/vim" .vim
fi

## Install tmux plugins if they haven't been installed before
if [[ ! -d "${docker_persistent_path}/tmux" ]]; then
  mkdir -p "${docker_persistent_path}/tmux"
  ln -s "${docker_persistent_path}/tmux" .tmux
  .tmux-tpm/scripts/install_plugins.sh
else
  ln -s "${docker_persistent_path}/tmux" .tmux
fi


## Create a persistent zsh history file if not exist and link it
if [[ ! -f "${docker_persistent_path}/.zsh_history" ]]; then
  touch "${docker_persistent_path}/.zsh_history"
fi

ln -s "${docker_persistent_path}/.zsh_history" .zsh_history
