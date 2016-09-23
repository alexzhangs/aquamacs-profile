#!/bin/bash

set -eo pipefail

if [[ $DEBUG -gt 0 ]]; then
    set -x
else
    set +x
fi

BASE_DIR="$(cd "$(dirname "$0")"; pwd)"
PROFILE_DIR=~/Library/Preferences/Aquamacs\ Emacs

if [[ -n $GUI_DIFF_TOOL ]]; then
    $GUI_DIFF_TOOL "$PROFILE_DIR/customizations.el" "$BASE_DIR/customizations.el" &
elif [[ -n $DIFF_TOOL ]]; then
    $DIFF_TOOL "$PROFILE_DIR/customizations.el" "$BASE_DIR/customizations.el"
elif which diff >/dev/null 2>&1; then 
    diff -s "$PROFILE_DIR/customizations.el" "$BASE_DIR/customizations.el"
else
    echo "Not found diff tool, please export Environment Variables: GUI_DIFF_TOOL and/or DIFF_TOOL"
    exit 255
fi

exit
