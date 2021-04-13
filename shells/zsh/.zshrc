# Run for interactive shells only

# Source additional sh configs
for config in "${HOME}"/.config/sh/*.sh ; do
    source "${config}"
done

# Allow local customizations in the ~/.zshrc_local_before file
[[ -f ~/.zshrc_local_before ]] && source ~/.zshrc_local_before

# External plugins (initialized before general settings)
[[ -f $ZDOTDIR/plugins_before.zsh ]] && source $ZDOTDIR/plugins_before.zsh

# General ZSH settings
[[ -f $ZDOTDIR/settings.zsh ]] && source $ZDOTDIR/settings.zsh

# Aliases explicitly for ZSH
[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh

# Custom prompt config
[[ -f $ZDOTDIR/prompt.zsh ]] && source $ZDOTDIR/prompt.zsh

# Load completion settings
[[ -f $ZDOTDIR/completions.zsh ]] && source $ZDOTDIR/completions.zsh

# Load keybindings
[[ -f $ZDOTDIR/keybinds.zsh ]] && source $ZDOTDIR/keybinds.zsh

# External plugins (initialized after general settings)
[[ -f $ZDOTDIR/plugins_after.zsh ]] && source $ZDOTDIR/plugins_after.zsh

# Allow local customizations in the ~/.zshrc_local_after file
# Note: This is where conda sourcing goes & Display export for WSL
[[ -f ~/.zshrc_local_after ]] && source ~/.zshrc_local_after
