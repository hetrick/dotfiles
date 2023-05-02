#!/bin/bash

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

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

pretty_print "brewing up some installs..."
brew update
brew tap homebrew/bundle
brew bundle --file $HOME/.dotfiles/Brewfile

# install zsh theme
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc

pretty_print "symlinking some dotfiles..."
# remove (if necessary) and symlink .zshrc from .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# remove (if necessary) and symlink .p10k.zsh from .dotfiles
rm -rf $HOME/.p10k.zsh
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh

pretty_print "setting up python environment..."
source $HOME/.dotfiles/.python
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
eval "$(pyenv virtualenv-init -)"

pretty_print "setting up vs code..."
rm -rf $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/.vscode-settings.json $HOME/Library/Application\ Support/Code/User/settings.json
source $HOME/.dotfiles/.vscode-extensions

pretty_print "setting up gitconfig..."
rm -rf $HOME/.gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

pretty_print "finally, applying macOS defaults..."
source $HOME/.dotfiles/.macos
