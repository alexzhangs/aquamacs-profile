# aquamacs-profile

Aquamacs customizations for Mac OS X.

Tested with Aquamacs 3.3 on OS X EI Capitan.

## Get Code

```sh
git clone https://github.com/alexzhangs/aquamacs-profile.git
```

## Usage

### install.sh

Copy `aquamacs-profile/customizations.el` to `~/Library/Preferences/Aquamacs\ Emacs/customizations.el`

```sh
sh aquamacs-profile/install.sh
```

### load.sh

Copy `~/Library/Preferences/Aquamacs\ Emacs/customizations.el` to `aquamacs-profile/customizations.el`

```sh
sh aquamacs-profile/load.sh
```

### diff.sh

Diff `~/Library/Preferences/Aquamacs\ Emacs/customizations.el` and
`aquamacs-profile/customizations.el`

```sh
export GUI_DIFF_TOOL=/usr/local/bin/bcomp # BeyondCompare here
sh aquamacs-profile/diff.sh
```
