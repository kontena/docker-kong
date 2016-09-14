#!/usr/local/bin/dumb-init /bin/bash
set -e

# Disabling nginx daemon mode
export KONG_NGINX_DAEMON="off"
export KONG_CLUSTER_ADVERTISE=$(hostname -i):7946

[ -z "$KONG_NGINX_DAEMON" ] && export KONG_NGINX_DAEMON="off"

exec "$@"
