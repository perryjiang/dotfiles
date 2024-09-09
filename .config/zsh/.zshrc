# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias config="git --git-dir ${HOME}/dotfiles --work-tree ${HOME}"

source "${ZDOTDIR}/antidote/antidote.zsh"
antidote load

if [[ -v commands[fzf] ]]; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND='fd --exclude .git --follow --hidden'
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
  export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type directory"
  _fzf_compgen_path() { fd --exclude .git --follow --hidden . "$1" }
  _fzf_compgen_dir() { fd --exclude .git --follow --hidden --type directory . "$1" }
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ -r ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh
