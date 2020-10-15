bind 'TAB':menu-complete
alias lc='colorls -lA --sd'
alias config='/usr/bin/git --git-dir=$HOME/config-files/ --work-tree=$HOME'

export EDITOR='nvim'

export VISUAL='nvim'

export PATH=/snap/bin:$PATH
export PATH=~/.emacs.d/bin:$PATH
# wakatime for bash
# hook function to send wakatime a tick
pre_prompt_command() {
    version="1.0.0"
    entity=$(echo $(fc -ln -0) | cut -d ' ' -f1)
    [ -z "$entity" ] && return # $entity is empty or only whitespace
    $(git rev-parse --is-inside-work-tree 2> /dev/null) && local project="$(basename $(git rev-parse --show-toplevel))" || local project="Terminal"
    (wakatime --write --plugin "bash-wakatime/$version" --entity-type app --project "$project" --entity "$entity" 2>&1 > /dev/null &)
}

PROMPT_COMMAND="pre_prompt_command; $PROMPT_COMMAND"
