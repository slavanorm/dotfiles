export EDITOR=nvim
export MANPAGER='nvim +Man!'
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# !exit for non-interactive shell
[ -z "$PS1" ] && return

HOMEBREW_NO_AUTO_UPDATE=1
HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# !omzsh 
plugins=(git zsh-autosuggestions zsh-completions)
export ZSH="$HOME/.oh-my-zsh"
DISABLE_AUTO_TITLE="true"
zstyle ':omz:update' mode disabled  # disable updates
source $ZSH/oh-my-zsh.sh
bindkey '^[[C' expand-or-complete-prefix

# !zsh conf
export PS1=" %1~ >"
# color
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
# completion
#autoload -Uz compinit && compinit # done by omz
zmodload zsh/complist

# ! my conf, override omz
eval "$(/opt/homebrew/bin/brew shellenv)"
alias sys_python=/usr/bin/python3
alias python3=python3.11
alias python=python3
alias pip='python3.11 -m pip'
alias n=nvim
alias lc="n lc"
alias l=lazygit
alias history="history 1"
alias ls="ls -AFGSh"
alias mailsrv="ssh mailsrv.us-central1-a.t-wsite"

#zstyle ':completion:*' menu yes select
setopt menucomplete 
# colors 
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"zstyle ':completion:*' file-list all
# (comments)
zstyle ':completion:*' verbose yes
# case insens 
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
set completion-ignore-case on # maybe dontneed
# sort by last access
zstyle ':completion:*' file-sort access follow

# !conf history todo: not enough yet, seems useless
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_NO_FUNCTIONS
export HISTTIMEFORMAT='%F -'
export HISTCONTROL=ignoreboth:erasedups
export HISTORY_IGNORE='(ls|[bf]g|exit|pwd|nvim|history|cd ..|which| * --help)'
export HISTSIZE=99999
export HISTFILESIZE=999999
export SAVEHIST=$HISTSIZE


# show .files in autocomp
setopt GLOB_DOTS



function cd() {
   builtin cd $1
   if [[ -d ./venv ]] ; then
      . ./venv/bin/activate
   fi
}


