# ==============================================================================
# Sections:
#       => General
#       => Autocompletion
#       => History
#       => Plugins
#       => Prompt
# ==============================================================================

# ==============================================================================
# General
# ==============================================================================
alias ls="ls --color --group-directories-first"
alias mux="tmuxinator"
alias rg="rg --smart-case --context 8"

typeset -U path
path=(
  $HOME/.cargo/bin
  $HOME/.vim/pack/minpac/start/fzf/bin
  /usr/local/opt/coreutils/libexec/gnubin
  $path[@]
)

export DOTFILES="$HOME/src/dotfiles"

export LESS="FRX"
export PAGER="less"

export VISUAL="vim"
export EDITOR="$VISUAL"

export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--height 40%"

[ -z "$TMUX"  ] && export TERM=xterm-256color

# Use emacs keybindings even if $EDITOR is set to vi
bindkey -e

# Edit the current command with $VISUAL: CTRL-x CTRL-e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Load Mozilla-specific config
source $DOTFILES/mozilla/env.sh

# ==============================================================================
# Autocompletion
# ==============================================================================
# Initialize autocompletion
autoload -U compinit; compinit

setopt CORRECT_ALL
setopt AUTO_CD

# Group completions by category
zstyle 'completion:*' group-name ''

# Enable approximate completions
zstyle ':completion:*' completer _expand _complete _correct _approximate

# ==============================================================================
# History
# ==============================================================================
# Keep 10000 lines of history within the shell, saved to $HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zsh_history

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# ==============================================================================
# Plugins
# ==============================================================================
# Initialize the zsh plugin manager
source <(antibody init)

autoload -U promptinit; promptinit
antibody bundle denysdovhan/spaceship-prompt

antibody bundle robbyrussell/oh-my-zsh path:plugins/z/z.plugin.zsh
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions

# ==============================================================================
# Prompt
# ==============================================================================
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# ==============================================================================
# Things that need to come last
# ==============================================================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
antibody bundle zsh-users/zsh-syntax-highlighting
