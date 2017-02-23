# project-show-animal
If servers are cattle, not pets, what are workstations? They are "show animals"--valuable, pampered beasts when compared to cattle, but in the end, we only keep them as long as they are useful.

We want our Macs to be tools--fungible, flexible and easily rebuilt--and this is a project to make it possible to rebuild a Mac every week.

## Directions:

Install XCode--the native Mac git install requires it.

Clone this repo:

	git clone https://github.com/jodylent/project-show-animal.git

Set up any cloud storage used by your dotfiles repo(s). Mine uses Dropbox, so I install/configure it before running.

Modify input_vars.sh

* Set your Git user info
* Set a new hostname

Run new_mac.sh

	bash /path/to/project-show-animal/new_mac.sh

## What it does:
* Secures your ssh key with `chmod 600 ~/.ssh/id_rsa` if it exists.
* Clones and runs [Strap](https://github.com/MikeMcQuaid/strap):
    * Installs Homebrew
    * Downloads/accepts license/installs Xcode Command Line Tools
    * Downloads `https://github.com/$STRAP_GITHUB_USER/dotfiles` to `~/.dotfiles`
	    * Runs any scripts in `~/.dotfiles/setup`
	    * (I [symlink in my dotfiles](https://github.com/jodylent/dotfiles/blob/master/script/setup/install.sh))
    * Downloads Brewfile from `https://github.com/$STRAP_GITHUB_USER/homebrew-brewfile`
    * Runs `brew bundle --global`
    * Does other awesome stuff. See [the README](https://github.com/MikeMcQuaid/strap/blob/master/README.md)
* Sets git config for your company URL to use SSH
* Sources ~/.bash_profile
* Installs pip-requirements from `~/.dotfiles/script/pip-requirements.txt`
* Installs macOS settings from `~/.dotfiles/script/macos.sh`
* Installs application settings from `~/.dotfiles/script/app_settings.sh` (someday, may use https://github.com/lra/mackup)
* Syncs git repos using `~/.dotfiles/script/refresh_repos.sh`
* Reboots if run with `--reboot`

## Things that have to be done by hand post-run:
* AWS CLI & Boto config: ~/.aws/{config,credentials}
* Chrome Extensions: any configuration
* Pip/gem install requirements for repos
* System Preferences > Internet Accounts
* Installing anything **without** a Homebrew cask or formula
* Allow yourself unlimited cosmic power:

```
sudo su -
visudo -f /etc/sudoers

# Sudo no password -- USE AT YOUR OWN RISK
USERNAME ALL=(ALL) NOPASSWD: ALL
```

## Related repos
* https://github.com/MikeMcQuaid/strap
* https://github.com/jodylent/dotfiles
* https://github.com/jodylent/homebrew-brewfile
* https://github.com/mathiasbynens/dotfiles/blob/master/.macos
* https://github.com/lra/mackup
* https://github.com/tiiiecherle/osx_install_config
