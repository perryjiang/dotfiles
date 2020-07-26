#!/usr/bin/env bash

set -euo pipefail

brew_bundle() {
  brew bundle "$1" --file=macos/Brewfile
}

if [[ "$(uname)" == 'Darwin' ]] && ! brew_bundle check; then
  brew_bundle install
fi

git submodule update --init --recursive

stow --target="${HOME}" */

readonly ZSH_PATH="$(command -v zsh)"

if [[ "${SHELL}" != "${ZSH_PATH}" ]]; then
  chsh -s "${ZSH_PATH}"
  exec zsh
fi
