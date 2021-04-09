### ZSH Plugins Pre-loaded ###
# Author: Dylan Thomas

## ZSH Script plugins

# Syntax highlighting from zsh-users
source ~/.config/zsh/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Substring search from zsh-users
source ~/.config/zsh/vendor/zsh-history-substring-search/zsh-history-substring-search.zsh
# Auto suggestions (pre-typed)
source ~/.config/zsh/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh

## ZSH function plugins

# Extra completions
source ~/.config/zsh/vendor/zsh-completions/zsh-completions.plugin.zsh
# Conda completion
fpath=(~/.config/zsh/vendor/conda-zsh-completion $fpath)

## Custom ZSH plugins

# ZSH completion for pip
# Retrieved via: `pip completion --zsh`
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion python -m pip

# FZF sourcing
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
# Force FZF to use ag. -g "" allow ag to search filenames and pipe to fzf
export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.config/agignore -g ""'
# # Copy command to fzf keyboard shortcuts
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--reverse --preview 'cat {}' --color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672"
