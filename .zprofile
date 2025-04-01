eval "$(/opt/homebrew/bin/brew shellenv)"
alias python3=python3.11
#HOMEBREW_NO_AUTO_UPDATE=1
#HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
EDITOR=nvim

HISTCONTROL=ignoredups:erasedups
HISTIGNORE="&:ls:[bf]g:exit:pwd:clear:cat:cd"
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE
alias history="history 1"
alias lazygit="lazygit -ucd ~/.config/lazygit"
