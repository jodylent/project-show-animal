#!/usr/bin/env bash
########################################
# Jody Lent
# Script for building a new Mac

### Directions:
# git clone https://github.com/jodylent/project-show-animal.git
# Modify input_vars.sh (set your Git user info + token)
# Run new_mac.sh

### Actions:
# Clones and runs Strap (https://github.com/MikeMcQuaid/strap):
# -- Installs Homebrew
# -- Downloads/accepts license/installs Xcode Command Line Tools
# -- Downloads dotfiles from https://github.com/$STRAP_GITHUB_USER/dotfiles and installs
# -- Downloads Brewfile from https://github.com/$STRAP_GITHUB_USER/homebrew-brewfile and runs `brew bundle --global`
# -- Does other awesome stuff. See https://github.com/MikeMcQuaid/strap/blob/master/README.md
# Copies private dotfiles from $PRIVATE_DOTFILE_PATH (Dropbox, private repo, etc.s)
# Installs pip-requirements
# Installs macOS settings
# Installs application settings (someday, may use https://github.com/lra/mackup)
# Syncs git repos
# Reboots if run with `--reboot`

### Things that have to be done by hand post-run:
# Remap Capslock to Ctrl
# Chrome Extensions:
# -- Stash plugin (https://chrome.google.com/webstore/detail/stash-extension/kpgdinlfgnkbfkmffilkgmeahphehegk)
# System Preferences > Internet Accounts
# -- Calendars
# -- Contacts
# -- Email
# -- Twitter
# -- etc.
# Pip/gem install requirements for repos
# VERACRYPT issue https://github.com/caskroom/homebrew-cask/issues/20726
# -- Allow `brew bundle` to run (or just `brew cask install osxfuse`) and then:
# ---- run `open /usr/local/Caskroom/osxfuse/*/Install\ OSXFUSE*.pkg`
# ---- install with MacFUSE compatibility layer
# ---- run `brew cask install veracrypt`

########################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function symlink_dirs() {
    SOURCE_DIR=$1
    TARGET_DIR=$2
    FILES_TO_LINK=`ls ${SOURCE_DIR}`
    for REAL_FILE in ${FILES_TO_LINK}; do
        # Get name, not name.sh
        filename="${REAL_FILE%.*}"
        echo "linking  ${SOURCE_DIR}/${REAL_FILE} to ${TARGET_DIR}/.${filename}"
        # Move existing to backup
        [ -f ~/.${filename} ] && mv ~/.${filename} ~/.dotfiles/backup/${filename}
        # Link it
        ln -sf ${SOURCE_DIR}/${REAL_FILE} ${TARGET_DIR}/.${filename}
    done
}

# PULL ENV VARIABLES from input_vars.sh
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
mkdir -p /tmp/strap


git clone https://github.com/mikemcquaid/strap /tmp/strap

# Strap customizations
git config --global push.default current # I like current > simple
git config --global url.ssh://git@${COMPANY_REPOMGMT_URL}/.insteadOf https://${COMPANY_REPOMGMT_URL}/
sed -i -e "s/DOTFILES_URL=\"https:\/\//DOTFILES_URL=\"ssh:\/\/git@/g"                   /tmp/strap/bin/strap.sh
sed -i -e "s/HOMEBREW_BREWFILE_URL=\"https:\/\//HOMEBREW_BREWFILE_URL=\"ssh:\/\/git@/g" /tmp/strap/bin/strap.sh

# Run strap
bash /tmp/strap/bin/strap.sh

# Set dotfiles repo to SSH, NOT HTTPS
git -C ~/.dotfiles remote set-url origin git@github.com:${GITHUB_USER}/dotfiles.git

# Private Dotfiles (we're assuming my Brewfile is one), then source bash_profile
mkdir -p ~/.dotfiles/private
symlink_dirs ${PRIVATE_DOTFILE_PATH} ~/.dotfiles/private
# Install them if we have anything special to do
if [ -z ${PRIVATE_DOTFILE_CMD+x} ]; then
    echo "PRIVATE_DOTFILE_CMD is unset"
else
    ${PRIVATE_DOTFILE_CMD}
fi
source ~/.bash_profile

# Pip is installed thanks to brew!
if [ -f ~/.dotfiles/script/pip-requirements.txt ]; then
    pip install --user python -r ~/.dotfiles/script/pip-requirements.txt
    pip install --user python -r ~/.dotfiles/script/pip-requirements.txt --upgrade
fi

if [ -f ~/.dotfiles/script/pip3-requirements.txt ]; then
    pip3 install --user python -r ~/.dotfiles/script/pip-requirements.txt
    pip3 install --user python -r ~/.dotfiles/script/pip-requirements.txt --upgrade
fi

# Mac settings
sudo bash ~/.dotfiles/script/macos.sh

# App settings
sudo bash ~/.dotfiles/script/app_settings.sh

# Git repos, based on list of `git remote get-url origin` values
echo "#### REPO SYNC BEGINNING #####"
source ~/.dotfiles/script/refresh_repos.sh 2&>1
echo "#### REPO SYNC COMPLETE #####"

# Reboot if flagged, else tell user to reboot
if [ "$1" = "--reboot" ]; then
    sudo reboot
else;
    echo "Done. Note that some of these changes require a logout/restart to take effect."
fi