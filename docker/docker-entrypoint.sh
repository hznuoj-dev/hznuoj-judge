#! /bin/bash

set -e -x

# judged

if [ -z "$*" ]; then
  /bin/bash
else
  exec "$@"
fi
