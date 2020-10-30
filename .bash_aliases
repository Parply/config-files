bind 'TAB':menu-complete
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ALIASES

# ls
alias lc='colorls -lA --sd'
alias ls='ls --color=auto'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# interactive
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

# navigation
alias ..='cd ..' 
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim
alias vim="nvim"
alias vi="nvim"

# git
alias g='git'

# dotfiles
alias config='/usr/bin/git --git-dir=$HOME/config-files/ --work-tree=$HOME'

# bat
alias cat="batcat"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

### EXPORTS
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma ' -\""

export EDITOR='nvim'

export VISUAL='nvim'

export HISTCONTROL=ignoreboth

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

export PATH=/snap/bin:$PATH
export PATH=~/.emacs.d/bin:$PATH
export PATH=~/.cargo/bin:$PATH

if [ -s "/usr/share/terminfo/x/xterm-kitty" ]; then
	alias tput='tput -T xterm'
fi

### OH MY BASH

OSH_THEME="bobby"
plugins=(git battery npm progress)


### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}



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
