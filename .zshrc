eval "$(/opt/homebrew/bin/brew shellenv)"
alias sys_python=/usr/bin/python3
alias python3=python3.11
alias python=python3
alias pip='python3.11 -m pip'
alias browse_epam="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser --profile-directory='Profile1'"
alias lc="n lc"
alias l=lazygit

#HOMEBREW_NO_AUTO_UPDATE=1
#HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export EDITOR=nvim
export MANPAGER='nvim +Man!'
export XDG_CONFIG_HOME="$HOME/.config"

alias n=nvim
[ -z "$PS1" ] && return

export PS1=" %1~ >"
# load module for list-style selection
autoload -Uz compinit
compinit
zmodload zsh/complist

# use the module above for autocomplete selection
#zstyle ':completion:*' menu yes select
zstyle ':completion:*' file-list all
zstyle ':completion:*' file-sort access follow
set completion-ignore-case on
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
export HISTORY_IGNORE='(ls|[bf]g|exit|pwd|nvim|history|cd ..|which| * --help)'
export HISTSIZE=99999
export HISTFILESIZE=999999
export SAVEHIST=$HISTSIZE
alias history="history 1"
alias ls="ls -AFGSh"

function cd() {
   builtin cd $1
   if [[ -d ./venv ]] ; then
      . ./venv/bin/activate
   fi
}
