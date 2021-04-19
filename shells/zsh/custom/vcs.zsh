### Dylan's ZSH Git Integration
# Idea for how to use async.zsh from: https://vincent.bernat.ch/en/blog/2019-zsh-async-vcs-info

# Encapsulate in check for root user. Don't do git if root
[[ $USERNAME != "root" ]] && {

    ## Helper functions for async

    ## Initialize asynchronous prompt
    # Define async worker "vcs_info" & set callback to "_dt_vcs_info_done"
    _dt_vcs_async_start() {
        async_start_worker vcs_info
        async_register_callback vcs_info _dt_vcs_info_done
    }

    ## Run asynchronously by "vcs_info"
    # CD into directory, call `vcs_info`, print output to stdout
    _dt_vcs_info() {
        cd -q $1
        vcs_info
        print ${vcs_info_msg_0_}
    }

    ## Asynchronous callback for when "vcs_info" completes it's job
    # Restars if bad return code. Set VCS variable. Resets prompt if no is done.
    _dt_vcs_info_done() {
        local job=$1
        local return_code=$2
        local stdout=$3
        local more=$6
        if [[ $job == '[async]' ]]; then
            if [[ $return_code -eq 2 ]]; then
                # Need to restart the worker. Taken from
                # https://github.com/mengelbrecht/slimline/blob/master/lib/async.zsh
                _dt_vcs_async_start
                return
            fi
        fi
        vcs_info_msg_0_=$stdout
        # We shouldn't reset unless all jobs are done. Make sure to re-draw prompt
        [[ $more == 1 ]] || _dt_setup_prompt && zle reset-prompt
    }

    ## ZSH Hook: run when initially changing directory
    # Sets VCS variable to empty
    _dt_vcs_chpwd() {
        vcs_info_msg_0_=
    }

    ## ZSH hook: run before prompt
    # Flushes jobs from "vcs_info", and assigns it "_dt_vcs_info"
    _dt_vcs_precmd() {
        async_flush_jobs vcs_info
        async_job vcs_info _dt_vcs_info $PWD
    }

    # Load VCS plugin
    autoload -Uz vcs_info

    # Only enable git
    zstyle ':vcs_info:*' enable git
    # Anonymous function that is called immediately
    # Allows scoping variables
    () {
        # Define formats here
        local format='%F{blue}${PRCH[branch]} %B%b%%b%f %u%c'
        local action_format='%F{blue}${PRCH[branch]} %B%b%F{white}|%%b%F{red}%a%f %u%c'
        # Auto check for staged/unstaged
        zstyle ':vcs_info:git:*' check-for-changes true
        # Set format for VCS info msg on regular check
        zstyle ':vcs_info:git:*' formats $format
        # Set format for VCS info msg when doing rebase/merge/cherry pick, etc.
        zstyle ':vcs_info:git:*' actionformats $action_format
        # Set color & symbol for git staged/unstaged info
        zstyle ':vcs_info:git:*' stagedstr '%F{green}${PRCH[circle]}%f'
        zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}${PRCH[circle]}%f'
    }

    # Custom git hook to check for untracked files. Adds a black circle.
    zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
    +vi-git-untracked () {
        if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain 2> /dev/null | grep -q '??' ; then
            hook_com[staged]+='%F{240}${PRCH[circle]}%f'
        fi
    }

    # Load async zsh plugin
    source ~/.config/zsh/vendor/zsh-async/async.zsh

    # Initialize async plugin and create async worker
    async_init
    _dt_vcs_async_start

    # Add ZSH hooks
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _dt_vcs_precmd
    add-zsh-hook chpwd _dt_vcs_chpwd
}