#!/bin/bash

set -eo pipefail

if [[ $DEBUG -gt 0 ]]; then
    set -x
else
    set +x
fi

BASE_DIR="$(cd "$(dirname "$0")"; pwd)"
PROFILE_DIR=~/Library/Preferences/Aquamacs\ Emacs

echo "Copying $PROFILE_DIR/customizations.el to $BASE_DIR"
/bin/cp -a "$PROFILE_DIR/customizations.el" "$BASE_DIR"

echo "Done"

exit
