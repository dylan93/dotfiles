### Bash general settings

# History settings
export HISTFILE="$XDG_CACHE_HOME/bash/history"
HISTCONTROL=ignoreboth
HISTSIZE= HISTFILESIZE=2000
shopt -s histappend

# Additional options
shopt -s checkwinsize globstar autocd

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Set the readline config file
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
