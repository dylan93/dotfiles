
# test for an interactive shell. there is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # shell is non-interactive. be done now!
  return
fi

# Add useful aliases
alias g="git"
alias reload="source ~/.bashrc"

# Adds git completions
source ~/.git-completion.bash

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

export PYTHONSTARTUP="$HOME/.pythonrc.py"

# Source machine-specific bashrc file
if [ -f ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi
