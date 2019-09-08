#!/usr/bin/env bash

set -eu -o pipefail

script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
${script_dir}/entrypoint-base.sh
