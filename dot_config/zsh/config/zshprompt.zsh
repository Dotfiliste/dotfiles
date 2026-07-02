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

# Only show the kube context after a kube-related command has been run.
my_kube_used=0
my_preexec() {
    [[ $3 == (kubectl|kubectx|kubens|helm|k9s)(| *) ]] && my_kube_used=1
}
autoload -U add-zsh-hook
add-zsh-hook preexec my_preexec

# Cache expensive calls in precmd (runs once per command, not on async redraws).
my_kube_context=
my_precmd() {
    (( my_kube_used )) || return
    my_kube_used=0
	my_kube_context=$(kubectl config current-context 2>/dev/null)
}
add-zsh-hook precmd my_precmd

prompt_pure_precustom() {
	psvar[23]=${my_kube_context:+⎈ $my_kube_context}
}

autoload -U promptinit
promptinit

zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:environment:node_version symbol ⬡
zstyle :prompt:pure:git:dirty detailed yes
zstyle :prompt:pure:custom:suffix color '#326CE5'

prompt pure
