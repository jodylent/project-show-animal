#!/usr/bin/env bash
########################################
# Jody Lent
# Script for building a new Mac

### Directions:
# git clone https://github.com/jodylent/project-show-animal.git
# Modify input_vars.sh (set your Git user info)
# Run new_mac.sh

### Actions:
# Clones and runs Strap (https://github.com/MikeMcQuaid/strap):
# -- Installs Homebrew
# -- Downloads/accepts license/installs Xcode Command Line Tools
# -- Downloads dotfiles from https://github.com/$STRAP_GITHUB_USER/dotfiles and installs
# -- Downloads Brewfile from https://github.com/$STRAP_GITHUB_USER/homebrew-brewfile and runs `brew bundle --global`
# -- Does other awesome stuff. See https://github.com/MikeMcQuaid/strap/blob/master/README.md# Installs pip-requirements
# Installs macOS settings from ~/.dotfiles/script
# Installs application settings from ~/.dotfiles/script (someday, may use https://github.com/lra/mackup)
# Syncs git repos
# Reboots if run with `--reboot`

### Things that have to be done by hand post-run:
# Chrome Extensions:
# -- Stash plugin (https://chrome.google.com/webstore/detail/stash-extension/kpgdinlfgnkbfkmffilkgmeahphehegk)
# System Preferences > Internet Accounts
# -- Calendars
# -- Contacts
# -- Email
# -- Twitter
# -- etc.
# Pip/gem install requirements for repos

########################################

# PULL ENV VARIABLES from input_vars.sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPT_DIR}/input_vars.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Prereqs: Xcode, brew, cask, pip via Strap
# Chmod ssh key if it exists before we try to clone anything
if [ -f ~/.ssh/id_rsa ] ; then
    chmod 600 ~/.ssh/id_rsa
fi

# We remove ~/.dotfiles because Strap doesn't clone if it already exists, and why would it, on a new box?
if [ -d ~/.dotfiles ]; then
    rm -rf ~/.dotfiles
fi

# Ditto for strap dir; mildly improves idempotency
if [ -d /tmp/strap ]; then
    rm -rf /tmp/strap
fi
mkdir -p /tmp/strap

# Clone strap
git clone https://github.com/mikemcquaid/strap /tmp/strap

# Strap customizations -- I do  not use the GitHub tokenm, I copy in my ssh keys pre-run
sed -i -e "s/DOTFILES_URL=\"https:\/\//DOTFILES_URL=\"ssh:\/\/git@/g"                   /tmp/strap/bin/strap.sh
sed -i -e "s/HOMEBREW_BREWFILE_URL=\"https:\/\//HOMEBREW_BREWFILE_URL=\"ssh:\/\/git@/g" /tmp/strap/bin/strap.sh

# Run strap
bash /tmp/strap/bin/strap.sh

# Private Dotfiles should be installed by Strap if dotfiles/script/setup/install.sh exists
if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
fi

# Reboot if flagged, else tell user to reboot
if [ "$1" = "--reboot" ]; then
    sudo reboot
else
    echo "Done. Note that some of these changes require a logout/restart to take effect."
fi
