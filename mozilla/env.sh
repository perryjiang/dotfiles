#!/usr/bin/env zsh

alias mach="$HOME/src/mozilla-unified/mach"

export PATH="$HOME/.mozbuild/arcanist/bin:$HOME/.mozbuild/moz-phab:$PATH"

export HGRCPATH="$DOTFILES/mozilla/.hgrc"
export MOZCONFIG="$DOTFILES/mozilla/mozconfig"

# Suppress {++,--}{DOCSHELL,DOMWINDOW} debugging output
export MOZ_QUIET=1
