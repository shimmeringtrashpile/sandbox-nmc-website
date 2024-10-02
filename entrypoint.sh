#!/bin/bash

# abort if we reference a variable which has not been set.
set -e -u

# Double square brackets tests the condition
# usermod exists on linux but not BSD/osx
[[ $USERID ]] && usermod --uid "${USERID}" www-data

exec "$@"