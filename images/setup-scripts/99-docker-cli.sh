#!/usr/bin/env bash

# This scripts install the Docker cli...

set -eu -o pipefail

# Use the same group ID that the docker group of the host machine for adding
# the user to such group
user_name=${1}
docker_gid=${2}

groupadd -g ${docker_gid} docker
usermod -a -G docker ${user_name}

# Add docker APT repository requirements
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable" > /etc/apt/sources.list.d/docker-engine-community.list

apt-get update
apt-get install -y docker-ce-cli
