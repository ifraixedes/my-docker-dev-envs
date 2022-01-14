#!/usr/bin/env bash

set -eu -o pipefail

# Required arguments
user_name=${1}
user_home_dir="/home/${user_name}"

# Flutter installation
installation_dir="${user_home_dir}/apps/android"
android_sdk_tools_release="4333796"

tmp_dir=$(mktemp -d)
cleanup() {
	rm -rf "${tmp_dir}"
}
trap cleanup EXIT

mkdir -p "${tmp_dir}/android"

cat >"${tmp_dir}/android-install.sh" <<EOL
  curl --fail -L \
    -o "${tmp_dir}/android/sdk-tools.zip" \
    "https://dl.google.com/android/repository/sdk-tools-linux-${android_sdk_tools_release}.zip"

  cd "${user_home_dir}"
  mkdir -p ${installation_dir}
  unzip "${tmp_dir}/android/sdk-tools.zip" -d ${installation_dir}/
  mv ${installation_dir}/tools ${installation_dir}/sdk-tools

  mkdir .android
  touch .android/repositories.cfg

  yes | ${installation_dir}/sdk-tools/bin/sdkmanager --licenses

  ${installation_dir}/sdk-tools/bin/sdkmanager "system-images;android-29;google_apis_playstore;x86_64"
  ${installation_dir}/sdk-tools/bin/sdkmanager "build-tools;29.0.3"
  ${installation_dir}/sdk-tools/bin/sdkmanager "platforms;android-29"
EOL

chmod -R a+rwx "${tmp_dir}"
su ${user_name} -c "${tmp_dir}/android-install.sh"
