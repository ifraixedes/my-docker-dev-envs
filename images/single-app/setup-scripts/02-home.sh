#!/usr/bin/env -S bash -

set -eu -o pipefail

# Required arguments
user_name=${1}

# Cleaning current home and copying my dot files from specified repo
rm -rf "/home/${user_name}"
mkdir -p "/home/${user_name}"
chown -R "${user_name}":"${user_name}" "/home/${user_name}"
chmod 700 -R "/home/${user_name}"
