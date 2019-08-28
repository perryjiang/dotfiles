#!/usr/bin/env zsh

alias mach="$HOME/src/mozilla-unified/mach"

export PATH="$HOME/.mozbuild/arcanist/bin:$HOME/.mozbuild/moz-phab:$PATH"

export HGRCPATH="$DOTFILES/mozilla/.hgrc"
export MOZCONFIGS_DIR="$DOTFILES/mozilla/mozconfigs"

if [[ "$(uname)" == "Linux" ]]; then
  export MOZCONFIG="$MOZCONFIGS_DIR/mozconfig.linux"
elif [[ "$(uname)" == "Darwin" ]]; then
  export MOZCONFIG="$MOZCONFIGS_DIR/mozconfig.macos"
fi

# Suppress {++,--}{DOCSHELL,DOMWINDOW} debugging output
export MOZ_QUIET=1
