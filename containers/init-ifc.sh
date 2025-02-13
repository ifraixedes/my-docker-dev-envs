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

## Save mcfly (https://github.com/cantino/mcfly) shell history into the
## persistent volume
mkdir -p "${docker_persistent_path}/mcfly"
ln -s "${docker_persistent_path}/mcfly" "${HOME}/.mcfly"

## Keep Go build and gopls cache in the persistent volume for avoiding to recreate every time that
## I run a container.
mkdir -p "${HOME}/.cache"
cache_dir="${docker_persistent_path}/tmp/cache"
mkdir -p "${cache_dir}/go-build"
ln -s "${cache_dir}/go-build" "${HOME}/.cache/go-build"
mkdir -p "${cache_dir}/gopls"
ln -s "${cache_dir}/gopls" "${HOME}/.cache/gopls"

## Codeium
mkdir -p "${docker_persistent_path}/codeium"
ln -s "${docker_persistent_path}/codeium" "${HOME}/.codeium"

## Github Copilot configuration directory
mkdir -p "${docker_persistent_path}/github-copilot"
mkdir -p "${HOME}/.config"
ln -s "${docker_persistent_path}/github-copilot" "${HOME}/.config/github-copilot"

## Solana development
mkdir -p "${docker_persistent_path}/solana/avm"
ln -s "${docker_persistent_path}/solana/avm" "${HOME}/.avm"
