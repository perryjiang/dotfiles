# Path
typeset -U path

if [[ "$(uname)" == 'Darwin' ]]; then
  path=("/home/pjiang/.linuxbrew/opt/coreutils/libexec/gnubin" "$(brew --prefix llvm)/bin" "${path[@]}")
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

bindkey -e

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

beam_cursor() { echo -ne '\e[6 q' }
precmd_functions+=(beam_cursor)

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
