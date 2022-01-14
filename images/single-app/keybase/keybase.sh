#!/usr/bin/env -S bash -

set -eu -o pipefail

user_name=$(id -un)

docker run \
  --rm \
  -ti \
  --user "${user_name}:${user_name}" \
  --hostname keybase-app \
  --env="DISPLAY" \
  --mount type=bind,src="$HOME/.Xauthority",dst="/root/.Xauthority" \
  --mount type=bind,src="$HOME/.config/keybase",dst="/home/${user_name}/.config/keybase" \
  --volume="$(pwd):/hostmachine" \
  ifraixedes/ubuntu/app-base:20.04 \
  /bin/bash
