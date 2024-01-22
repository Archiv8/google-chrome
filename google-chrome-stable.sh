#!/bin/bash

# Disable various shellcheck rules that produce false positives in this file.
# Repository rules should be added to the .shellcheckrc file located in the
# repository root directory, see https://github.com/koalaman/shellcheck/wiki
# and https://archiv8.github.io for further information.
#

# Maintainer: Ross Clark <archiv8@artisteducator.com>
# Contributor: Ross Clark <archiv8@artisteducator.com>

#!/bin/bash

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}

# Allow users to override command-line options
if [[ -f $XDG_CONFIG_HOME/chrome-flags.conf ]]; then
    CHROME_USER_FLAGS="$(grep -v '^#' $XDG_CONFIG_HOME/chrome-flags.conf)"
fi

# Launch
exec /opt/google/chrome/google-chrome $CHROME_USER_FLAGS "$@"
