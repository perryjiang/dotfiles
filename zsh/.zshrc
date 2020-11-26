# Path
typeset -U path

path=("$(brew --prefix coreutils)/libexec/gnubin" "${path[@]}")

if [[ "$(uname)" == 'Darwin' ]]; then
  path=("$(brew --prefix llvm)/bin" "${path[@]}")
else
  eval "$("${HOME}/.linuxbrew/bin/brew" shellenv)"
fi

try_source() {
  [[ -f "$1" ]] && source "$1"
}

# Aliases
source "${ZDOTDIR}/aliases"

# NOTE: start_tmux_if_ssh.zsh requires $PATH to be initialized to find the right tmux
try_source "${HOME}/pjiang/scripts/start_tmux_if_ssh.zsh"
try_source "${HOME}/pjiang/scripts/env.zsh"

# General options
setopt AUTO_CD
setopt CORRECT_ALL

# History
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# Directory stack
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Plugins
source <(antibody init)
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions

# Completion
setopt GLOB_DOTS

autoload -Uz compinit && compinit

zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _expand _complete _correct _approximate

# Vi mode
bindkey -v

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^u' kill-whole-line

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

setup_cursor() {
  block_cursor() { echo -ne '\e[1 q' }
  beam_cursor() { echo -ne '\e[6 q' }

  zle-keymap-select() {
    if [[ "${KEYMAP}" == 'vicmd' ]]; then
      block_cursor
    else
      beam_cursor
    fi
  }

  zle -N zle-keymap-select
  precmd_functions+=(beam_cursor)
}

setup_cursor

# Tools
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Should come after vi mode config - fzf.zsh overrides CTRL-R/T
source "${HOME}/.config/fzf/fzf.zsh"

# Should be last
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-history-substring-search

bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
