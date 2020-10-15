set -g theme_nerd_fonts yes
set -g theme_display_git yes
set -g theme_display_git_untracked yes
set -g theme_display_vi yes

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/alexander/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

alias lc 'colorls -lA --sd'
alias config '/usr/bin/git --git-dir=$HOME/config-files/ --work-tree=$HOME'
funcsave lc
funcsave config
set -Ux EDITOR nvim
set -Ux VISUAL vim

# wakatime for fish
# hook function to send wakatime a tick

if git rev-parse --is-inside-work-tree 2> /dev/null 
	set project (basename (git rev-parse --show-toplevel))
else
	set project "Terminal"
end

set  project "Terminal"
set entity (echo $history[1] | cut -d ' ' -f1)
wakatime --write --plugin "fish-wakatime/0.0.1" --entity-type app --project "$project" --entity "$entity" 2>&1 > /dev/null&
