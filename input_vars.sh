#!/usr/bin/env bash
########################################
# Jody Lent
# Input vars to new_mac.sh
# Used by subscripts
# REPLACE WITH YOUR OWN VALUES
#
# N.B. new_mac.sh EXPORTS `SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"`
#
# If you keep a dotfiles repo, Strap looks for it here:
# -- "https://github.com/$STRAP_GITHUB_USER/dotfiles"
# It then does the following to "install" them:
#    cd ~/.dotfiles
#    for i in script/setup script/bootstrap; do
#      if [ -f "$i" ] && [ -x "$i" ]; then
#        log "Running dotfiles $i:"
#        "$i" 2>/dev/null
#        break
#      fi
#    done 
#
# If you have a Brewfile, Strap looks for it here:
# -- "https://github.com/$STRAP_GITHUB_USER/homebrew-brewfile/Brewfile"
#
########################################

# Strap script vars
GIT_NAME='Jody Lent'
GIT_EMAIL='jodylent@gmail.com'
GITHUB_USER='jodylent'
GITHUB_TOKEN='DeleteOrWipeThisScriptWhenDone'

# Subscript vars
export NEW_HOSTNAME='jlent-mbp'
export PRIVATE_DOTFILE_PATH=~/Dropbox/scripts/private_dotfiles/personal
export PRIVATE_DOTFILE_CMD="ln -sf ~/.dotfiles/private/alias.sh ~/.private_alias"
export SUBLIME_SETTINGS_PATH=~/.dotfiles/Preferences.sublime-settings

########################################
