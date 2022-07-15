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

# install all the things!
brew bundle --file $HOME/.dotfiles/Brewfile

# install zsh theme
brew install romkatv/powerlevel10k/powerlevel10k

# remove (if necessary) and symlink .zshrc from .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# remove (if necessary) and symlink .p10k.zsh from .dotfiles
rm -rf $HOME/./.p10k.zsh
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh

# remove (if necessary) and symlink .vscode from .dotfiles
rm -rf $HOME/.vscode
ln -s $HOME/.dotfiles/.vscode $HOME/.vscode

echo "setting up python environment..."
source .python

echo "setting up vs code..."
ln -s $HOME/.dotfiles/.vscode-settings.json $HOME/Library/Application\ Support/Code/User/settings.json
source .vscode-extensions

echo "setting up dock..."
source .dock

echo "applying macOS defaults..."
source .macos