#!/bin/bash

set -eo pipefail

if [[ $DEBUG -gt 0 ]]; then
    set -x
else
    set +x
fi

BASE_DIR="$(cd "$(dirname "$0")"; pwd)"
PROFILE_DIR=~/Library/Preferences/Aquamacs\ Emacs

echo "Copying $BASE_DIR/customizations.el to $PROFILE_DIR"
/bin/cp -a "$BASE_DIR/customizations.el" "$PROFILE_DIR"

echo "Done"

exit
