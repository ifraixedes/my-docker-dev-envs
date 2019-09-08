#!/usr/bin/env bash

set -eu -o pipefail

# Required arguments
locale=${1}
user_name=${2}
user_id=${3}
root_pwd=${4}

# Update OS
apt-get update -y
apt-get upgrade -y

# Configure locale
apt-get install -y locales
locale-gen ${locale}

# Configure local time
apt-get install -y tzdata
ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# Configure root account
# set a password to the root account for being able to use `su` command
echo root:"${root_pwd}" | chpasswd
chsh --shell /bin/bash

# Create normal user
useradd --create-home --user-group --uid "${user_id}" "${user_name}"
