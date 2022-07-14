#!/usr/bin/env bash

set -e

pretty_print() {
  printf "\n%b\n" "$1"
}

pretty_print "bootstrapping your mac..."

# if not already installed, install homebrew
if ! command -v brew &>/dev/null; then
  pretty_print "installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  pretty_print "homebrew is already installed!"
fi

# remove (if necessary) and symlink .zshrc from .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# install all the things!
brew bundle --file $HOME/.dotfiles/Brewfile

# remove (if necessary) and symlink .vscode from .dotfiles
rm -rf $HOME/.vscode
ln -s $HOME/.dotfiles/.vscode $HOME/.vscode

source .python
source .dock
source .macos