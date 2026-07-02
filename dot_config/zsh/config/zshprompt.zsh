#! /usr/bin/env zsh

__pure_first_prompt=1
print() {
    if [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ]; then
        # Pure is trying to print its preprompt newline
        if [[ $__pure_first_prompt -eq 1 ]]; then
            __pure_first_prompt=0
            # Suppress on first prompt
        else
            # Allow on subsequent prompts
            builtin print "$@"
        fi
    else
        # Normal print call, pass through
        builtin print "$@"
    fi
}

# Reset flag when clear is run so next prompt has no newline
clear() {
    __pure_first_prompt=1
    command clear
}

autoload -U promptinit
promptinit

prompt pure
