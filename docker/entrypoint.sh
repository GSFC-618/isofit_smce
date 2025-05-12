#!/bin/bash
set -e

NB_UID=${NB_UID:-1000}
NB_GID=${NB_GID:-100}
NB_USER=${NB_USER:-jovyan}
HOME=${HOME:-/home/$NB_USER}

export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/etc/group
export LD_PRELOAD=$(find /usr/lib -name libnss_wrapper.so | head -n1)

echo "${NB_USER}:x:${NB_UID}:${NB_GID}:${NB_USER}:${HOME}:/bin/bash" > $NSS_WRAPPER_PASSWD

exec "$@"
