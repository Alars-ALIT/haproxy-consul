#!/bin/bash

#
# start.bash
#

HAPROXY="/etc/haproxy"
OVERRIDE="/conf"
PIDFILE="/var/run/haproxy.pid"

CONFIG="haproxy.cfg"
ERRORS="errors"

cd "$HAPROXY"

echo About to start haproxy
# Symlink errors directory
if [[ -d "$OVERRIDE/$ERRORS" ]]; then
  mkdir -p "$OVERRIDE/$ERRORS"
  rm -fr "$ERRORS"
  ln -s "$OVERRIDE/$ERRORS" "$ERRORS"
fi

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  echo Symlink	
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi

