#!/bin/bash

# Disable various shellcheck rules that produce false positives in this file.
# Repository rules should be added to the .shellcheckrc file located in the
# repository root directory, see https://github.com/koalaman/shellcheck/wiki
# and https://archiv8.github.io for further information.
#
# @ToDo Create script to get various files from the AUR

# Maintainer: Ross Clark <archiv8@artisteducator.com>
# Contributor: Ross Clark <archiv8@artisteducator.com>

# https://aur.archlinux.org/cgit/aur.git/tree/?h=google-chrome

if [ ! -x "$wget" ]; then
  echo "ERROR: No wget." >&2
  exit 1
elif
