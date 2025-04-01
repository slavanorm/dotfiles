eval "$(/opt/homebrew/bin/brew shellenv)"
alias python3=python3.11
alias python=python3
#HOMEBREW_NO_AUTO_UPDATE=1
#HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export EDITOR=nvim
export MANPAGER='nvim +Man!'

[ -z "$PS1" ] && return

# load module for list-style selection
zmodload zsh/complist

# use the module above for autocomplete selection
zstyle ':completion:*' menu yes select

setopt menucomplete
# now we can define keybindings for complist module
# you want to trigger search on autocomplete items
# so we'll bind some key to trigger history-incremental-search-forward function
bindkey -M menuselect '?' history-incremental-search-forward

setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_NO_FUNCTIONS
export HISTTIMEFORMAT='%F -'
export HISTCONTROL=ignoreboth:erasedups
export HISTORY_IGNORE="(ls*|[bf]g|exit|pwd|clear|cat*|nvim*|history*|which*| * --help)"
export HISTSIZE=99999
export HISTFILESIZE=999999
export SAVEHIST=$HISTSIZE
alias history="history 1"
alias ls="ls -AFGSh"
alias lazygit="lazygit -ucd ~/.config/lazygit"
