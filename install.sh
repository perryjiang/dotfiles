#!/usr/bin/env bash

set -euo pipefail

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew_bundle() {
  if [[ "$(uname)" == 'Darwin' ]]; then
    cat homebrew/Brewfile* | brew bundle "$1" --file=-
  else
    brew bundle "$1" --file=homebrew/Brewfile
  fi
}

if ! brew_bundle check; then
  brew_bundle install
fi

"$(brew --prefix)/opt/fzf/install" --xdg --key-bindings --completion --no-bash --no-update-rc

git submodule update --init --recursive

stow --verbose=2 --target="${HOME}/.config" --dir='..' dotfiles
stow --verbose=2 --target="${HOME}/.config" starship

echo "Done! Make sure the default shell is zsh."
