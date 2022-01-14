#!/usr/bin/env bash

set -e -o pipefail

# Required arguments
user_name=${1}
user_home_dir="/home/${user_name}"

# Flutter installation
installation_dir="${user_home_dir}/apps/flutter"
flutter_release="v1.12.13+hotfix.7"

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

cat >"${tmp_dir}/flutter-install.sh" <<EOL
  cd "${user_home_dir}"
  mkdir -p ${installation_dir}

  git clone https://github.com/flutter/flutter.git -b "${flutter_release}" "${installation_dir}"

  mkdir ${installation_dir}/pub-cache
  ln -s ${installation_dir}/pub-cache .pub-cache
  ${installation_dir}/bin/flutter precache
EOL

chmod -R a+rx "${tmp_dir}"
su ${user_name} -c "${tmp_dir}/flutter-install.sh"
