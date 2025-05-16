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

# Initialize mamba - attempt to make this permanent, however will it continue
# to add to home every time a user logs in?
# Confirmed - this will append the command every time its launched
#echo 'eval "$(mamba shell hook --shell bash)"' >> ~/.bashrc

# Set specific conda env - may not want to do this since it will be set
# in users home across all hub instances, some of which wont have the 
# isofit env
#echo "mamba activate isofit" >> ~/.bashrc

exec "$@"
