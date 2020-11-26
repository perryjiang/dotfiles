export DOTFILES="${HOME}/dotfiles"
export ZDOTDIR="${DOTFILES}/zsh"

export VISUAL='nvim'
export EDITOR="${VISUAL}"

export MANPAGER="zsh -c 'col -bx | bat -l man -p'"
export PAGER='less'
export LESS='FRX'

export HISTSIZE=10000
export SAVEHIST="${HISTSIZE}"
export HISTFILE="${ZDOTDIR}/.zsh_history"

[[ -z "${TMUX}" ]] && export TERM='xterm-256color'

export CTEST_OUTPUT_ON_FAILURE=1
export CTEST_PARALLEL_LEVEL="$([[ "$(uname)" == 'Darwin' ]] && sysctl -n hw.physicalcpu || nproc)"
export CTEST_PROGRESS_OUTPUT=1

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

# Gruvbox dark colors
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse
  --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

export RIPGREP_CONFIG_PATH="${DOTFILES}/ripgrep/config"
