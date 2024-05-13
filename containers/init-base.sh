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

## Install dot files
git init .
git remote add origin "${repo_url}"
git fetch
git checkout "${repo_branch}"

## SSH
# Reset permissions on the .ssh keys and link the 'known_hosts' file to the
# persistent volume.
mkdir -p ".ssh"
chmod 700 .ssh
chmod 600 -R .ssh/*
mkdir -p "${docker_persistent_path}/ssh"
touch -a "${docker_persistent_path}/ssh/known_hosts"
ln -s "${docker_persistent_path}/ssh/known_hosts" ".ssh/known_hosts"

## Reset permissions on the PGP directory
if [[ -d .gnupg ]]; then
	chmod 700 .gnupg
fi

## Create home user persistent directories if they don't exist
mkdir -p "${docker_persistent_path}/bin"

## Install tmux plugins if they haven't been installed before
if [[ ! -d "${docker_persistent_path}/tmux" ]]; then
	mkdir -p "${docker_persistent_path}/tmux/resurrect"
	ln -s "${docker_persistent_path}/tmux" .tmux
	git clone https://github.com/tmux-plugins/tpm "${docker_persistent_path}/tmux/plugins/tpm"
	"${docker_persistent_path}/tmux/plugins/tpm/scripts/install_plugins.sh"
else
	ln -s "${docker_persistent_path}/tmux" .tmux
fi

## Create a persistent zsh history file if not exist and link it
if [[ ! -f "${docker_persistent_path}/.zsh_history" ]]; then
	touch "${docker_persistent_path}/.zsh_history"
fi

ln -s "${docker_persistent_path}/.zsh_history" .zsh_history

## Create Neovim data directory and symlink
mkdir -p ".local/share"
ln -s "${docker_persistent_path}/nvim/data" ".local/share/nvim"
## Create directory for Neovim Coc plugin (https://github.com/neoclide/coc.nvim) and symlink
mkdir -p "${docker_persistent_path}/nvim/coc"
ln -s "${docker_persistent_path}/nvim/coc" "${HOME}/.config/coc"
## Install plug if it's not installed
if [[  ! -f "${docker_persistent_path}/nvim/data/site/autoload/plug.vim" ]]; then
  curl -fLo "${docker_persistent_path}/nvim/data/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

## Mise
mkdir -p "${docker_persistent_path}/mise/config"
mkdir -p "${docker_persistent_path}/mise/data"
mkdir -p "${docker_persistent_path}/mise/state"
mkdir -p "${HOME}/.local/state"
ln -s "${docker_persistent_path}/mise/config" "${HOME}/.config/mise"
ln -s "${docker_persistent_path}/mise/data" "${HOME}/.local/share/mise"
ln -s "${docker_persistent_path}/mise/state" "${HOME}/.local/state/mise"
