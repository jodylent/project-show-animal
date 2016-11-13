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
export STRAP_GIT_NAME='Jody Lent'
export STRAP_GIT_EMAIL='jodylent@gmail.com'
export STRAP_GITHUB_USER='jodylent'
export STRAP_GITHUB_TOKEN='REDACTED'
export COMPANY_REPOMGMT_URL='gitbucket.yourcompany.com'

# Subscript vars
export NEW_HOSTNAME='jlent-mbp'
export PRIVATE_DOTFILE_PATH=~/Dropbox/scripts/private_dotfiles/personal
export PRIVATE_DOTFILE_CMD="echo 'Jody's private dotfiles in Dropbox have been symlinked'"
export SUBLIME_SETTINGS_PATH=~/.dotfiles/copy/Preferences.sublime-settings

########################################
