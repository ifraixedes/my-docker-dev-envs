#!/usr/bin/env -S bash -

set -eu -o pipefail

# It's required by Google Cloud for connecting from local to CloudSQL Postgres
apt-get install -y postgresql-client

