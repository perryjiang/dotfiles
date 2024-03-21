if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -v commands[brew] ]]; then
  export HOMEBREW_BUNDLE_FILE=~/.config/homebrew/Brewfile
fi
