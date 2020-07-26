# ==============================================================================
# Environment
# ==============================================================================
export DOTFILES="${HOME}/src/dotfiles"

export VISUAL='vim'
export EDITOR="${VISUAL}"

export LESS='FRX'
export PAGER='less'

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--height 40%'

if [ -z "$TMUX"  ];then
  export TERM='xterm-256color'
fi

typeset -U path

path=(
  $HOME/.vim/pack/minpac/start/fzf/bin
  $path[@]
)

if [[ "$(uname)" == 'Darwin' ]]; then
  path=(
    /usr/local/opt/coreutils/libexec/gnubin
    /usr/local/opt/llvm/bin
    $path[@]
  )
fi

# ==============================================================================
# Aliases
# ==============================================================================
alias h='history'
alias j='jobs'
alias rg='rg --smart-case --context 8'

alias la='ls -A'
alias ll='ls -Al'
alias ls='ls --color --group-directories-first'

alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'

alias d='dirs -v'
alias po='popd'
alias pu='pushd'

# ==============================================================================
# Key Bindings
# ==============================================================================
# Use emacs keybindings even if $EDITOR is set to vi
bindkey -e

# Edit the current command with $VISUAL: CTRL-x CTRL-e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Call run-help for the command on the current input line: ESC-h
unalias run-help
autoload run-help

# ==============================================================================
# History
# ==============================================================================
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zsh_history

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# ==============================================================================
# Autocompletion
# ==============================================================================
autoload -Uz compinit && compinit

setopt CORRECT_ALL
setopt AUTO_CD

# Group completions by category
zstyle 'completion:*' group-name ''

# Enable approximate completions
zstyle ':completion:*' completer _expand _complete _correct _approximate

# ==============================================================================
# Plugins
# ==============================================================================
# Initialize the zsh plugin manager
source <(antibody init)

antibody bundle robbyrussell/oh-my-zsh path:plugins/z/z.plugin.zsh
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions

# ==============================================================================
# Prompt
# ==============================================================================
autoload -Uz promptinit && promptinit
antibody bundle denysdovhan/spaceship-prompt

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
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
