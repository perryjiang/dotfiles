export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
source "${HOME}/.fzf.zsh"
