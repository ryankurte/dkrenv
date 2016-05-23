#!/bin/bash

work_dir=`pwd`
config_file=$work_dir/.dkrenv
config_file_secured=$work_dir/.dkrenv_sec
args=""

# Check if file exists
if [ ! -f $config_file ]; then
    echo "$config_file not found"
    exit
fi

# Check if the file contains something we don't want
# from: http://wiki.bash-hackers.org/howto/conffile
if egrep -q -v '^#|^[^ ]*=[^;]*' "$config_file"; then
  # Filter the original to a new file
  egrep '^#|^[^ ]*=[^;&]*'  "$config_file" > "$config_file_secured"
  # Use filtered file
  config_file="$config_file_secured"
fi

# Load Config
source $config_file

# Image name must be specified
if [ -z "$DKR_IMAGE" ]; then
    echo ".dkrenv must specify DKR_IMAGE to be used"
    exit
fi

# Command defaults to /bin/bash
if [ -z "$DKR_CMD" ]; then
    CMD="/bin/bash"
fi

# Bind ports
# Note that multiple ports must be specified as a string
if [ ! -z "$DKR_PORTS" ]; then
    echo "Ports: $DKR_PORTS"
    for port in $DKR_PORTS; do
        args="$args -p $port"
    done
fi

# Bind additional volumes
# Note that multiple volumes must be specified as a string
if [ ! -z "$DKR_VOLUMES" ]; then
    for volume in $DKR_VOLUMES; do
        args="$args -v $volume"
    done
fi

# Run the docker instance
docker run --rm -it -v $work_dir:/root $args $DKR_IMAGE $DKR_CMD


