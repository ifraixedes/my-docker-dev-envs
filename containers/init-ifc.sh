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

## Configure Rust
rust_dir="${docker_persistent_path}/rust"

# Create rustup if not exists and the corresponding symlink
if [[ ! -d "${rust_dir}/rustup" ]]; then
	mkdir -p "${rust_dir}/rustup"
	ln -s "${rust_dir}/rustup" .rustup
else
	ln -s "${rust_dir}/rustup" .rustup
fi

# Create cargo if not exists and the corresponding symlink
if [[ ! -d "${rust_dir}/cargo" ]]; then
	mkdir -p "${rust_dir}/cargo"
	ln -s "${rust_dir}/cargo" .cargo
else
	ln -s "${rust_dir}/cargo" .cargo
fi

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
