# project-show-animal
If servers are cattle, not pets, what are workstations? They are "show animals"--valuable, pampered beasts when compared to cattle, but in the end, we only keep them as long as they are useful.

We want our Macs to be tools--fungible, flexible and easily rebuilt--and this is a project to make it possible to rebuild a Mac every week.

## Directions:

Clone this repo:

	git clone https://github.com/jodylent/project-show-animal.git

Modify input_vars.sh

* Set your Git user info + token
* Set the path to your private dotfiles (~/Dropbox, a private repo, what have you)
* Set the command(s) to run to setup those dotfiles
* We automatically source ~/.bash_profile AFTER all dotfiles are pulled down

Run new_mac.sh

	bash /path/to/project-show-animal/new_mac.sh

## What it does:
* Clones and runs Strap (https://github.com/MikeMcQuaid/strap):
    * Installs Homebrew
    * Downloads/accepts license/installs Xcode Command Line Tools
    * Downloads dotfiles from `https://github.com/$STRAP_GITHUB_USER/dotfiles` to ~/.dotfiles
	    * Runs any scripts in `~/.dotfiles/setup` (I symlink in my dotfiles)
    * Downloads Brewfile from `https://github.com/$STRAP_GITHUB_USER/homebrew-brewfile` and runs `brew bundle --global`
    * Does other awesome stuff. See https://github.com/MikeMcQuaid/strap/blob/master/README.md
* Copies private dotfiles from $PRIVATE\_DOTFILE\_PATH (Dropbox, private repo, etc.s)
* Installs pip-requirements from `~/.dotfiles/script/pip-requirements.txt`
* Installs macOS settings from `~/.dotfiles/script/macos.sh`
* Installs application settings from `~/.dotfiles/script/app_settings.sh` (someday, may use https://github.com/lra/mackup)
* Syncs git repos using `~/.dotfiles/script/refresh_repos.sh`
* Reboots if run with `--reboot`

## Things that have to be done by hand post-run:
* Chrome Extensions: 
* Pip/gem install requirements for repos
* Remap Capslock to Ctrl
* System Preferences > Internet Accounts
* VERACRYPT issue (https://github.com/caskroom/homebrew-cask/issues/20726)
    * Allow `brew bundle` to run (or just `brew cask install osxfuse`) and then:
    * Run `open /usr/local/Caskroom/osxfuse/*/Install\ OSXFUSE*.pkg`
    * Install with MacFUSE compatibility layer
    * Run `brew cask install veracrypt`

## Related repos
* https://github.com/MikeMcQuaid/strap
* https://github.com/jodylent/dotfiles
* https://github.com/jodylent/homebrew-brewfile
* https://github.com/mathiasbynens/dotfiles/blob/master/.macos
* https://github.com/lra/mackup