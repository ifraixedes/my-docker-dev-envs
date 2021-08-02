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

## Configure Rust to use the persistent volume
readonly rust_dir="${docker_persistent_path}/rust"

# Create rustup symlink
mkdir -p "${rust_dir}/rustup"
ln -s "${rust_dir}/rustup" .rustup

# Create cargo symlink
mkdir -p "${rust_dir}/cargo"
ln -s "${rust_dir}/cargo" .cargo

# Install rustup and component's toolchain if it has not been installed before
if [[ -z $(which rustup) ]]; then
	# This runs an interactive session
	rustup-init --no-modify-path
	rustup component add rls rust-analysis rust-src rustfmt clippy
	# Required by racer
	rustup toolchain add nightly
	cargo +nightly install racer
fi

mkdir -p .oh-my-zsh/completions
"${rust_dir}/cargo/bin/rustup" completions zsh >.oh-my-zsh/completions/rustup
"${rust_dir}/cargo/bin/rustup" completions zsh cargo >.oh-my-zsh/completions/cargo

## Create directory for Vim Coc plugin (https://github.com/neoclide/coc.nvim)
VIM_PLUGINS_CONFIG="${docker_persistent_path}/vim/plugins-config"
mkdir -p "${HOME}/.config"

mkdir -p "${VIM_PLUGINS_CONFIG}/coc"
ln -s "${VIM_PLUGINS_CONFIG}/coc" "${HOME}/.config/coc"

## Save mcfly (https://github.com/cantino/mcfly) shell history into the
## persistent volume
mkdir -p "${docker_persistent_path}/mcfly"
ln -s "${docker_persistent_path}/mcfly" .mcfly
