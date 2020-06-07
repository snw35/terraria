#!/bin/bash

confd -config-file "terraria.toml" -onetime -backend env

# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "${1:0:1}" = '-' ]; then
    set -- TerrariaServer "$@"
fi

# If running with default CMD, apply the config file
if [ "$1" = 'TerrariaServer' ]; then
  exec "$@" -config /opt/terraria/serverconfig.txt
fi

# else default to run whatever the user wanted like "bash"
exec "$@"
