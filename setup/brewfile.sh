#! /usr/bin/env bash

REPO_NAME="homebrew-brewfile$1"

command -v gh >> /dev/null || brew install gh

gh auth status || gh auth login -w

# Create a new repo in github
echo "Creating git repo in ~/.$REPO_NAME"
gh repo create $REPO_NAME \
  --description "My Brewfile for breading new machines with Project Show Animal." \
  --public

# Generate brewfile
cd $REPO_NAME
brew bundle dump

# Commit and push
git add Brewfile
git commit -m "Initial Brewfile"
git push --set-upstream origin master
