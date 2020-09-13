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

git submodule update --init --recursive

stow --target="${HOME}" */

readonly ZSH_PATH="$(command -v zsh)"

if [[ "${SHELL}" != "${ZSH_PATH}" ]]; then
  echo "Change the default shell to ${ZSH_PATH}"
fi
