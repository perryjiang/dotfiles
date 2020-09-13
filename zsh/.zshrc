# General
# Use emacs keybindings even if $EDITOR is set to vi
bindkey -e

# Edit the current command with $VISUAL: CTRL-x CTRL-e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Call run-help for the command on the current input line: ESC-h
alias run-help &> /dev/null && unalias run-help
autoload -U run-help

setopt auto_cd
setopt correct_all

# History
HISTSIZE=10000
SAVEHIST="${HISTSIZE}"
HISTFILE="${HOME}/.zsh_history"
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

# Environment
typeset -U path

if [[ "$(uname)" == 'Darwin' ]]; then
  path=("$(brew --prefix llvm)/bin" "${path[@]}")
else
  eval "$("${HOME}/.linuxbrew/bin/brew" shellenv)"
fi

[[ -z "${TMUX}" ]] && export TERM='xterm-256color'
export CTEST_OUTPUT_ON_FAILURE=1
export DOTFILES="${HOME}/src/dotfiles"
export EDITOR='nvim'
export LESS='FRX'
export PAGER='less'
export VISUAL="${EDITOR}"

alias cat='bat'
alias cp='nocorrect cp'
alias ll='exa --group-directories-first --all --long'
alias ls='exa --group-directories-first'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias vim='nvim'

for dir in 'bat' 'exa' 'fzf' 'ht' 'neovim' 'ripgrep'; do
  source "${DOTFILES}/${dir}/configure.zsh"
done

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Plugins
source <(antibody init)

antibody bundle zsh-users/zsh-autosuggestions

zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _expand _complete _correct _approximate
antibody bundle zsh-users/zsh-completions
autoload -Uz compinit && compinit

antibody bundle zsh-users/zsh-syntax-highlighting
