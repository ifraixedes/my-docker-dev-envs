#!/usr/bin/env bash

set -eu -o pipefail

apt-get install -y python3
pip3 install awscli --upgrade
