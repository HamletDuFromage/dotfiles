alias windscribe="sudo systemctl start windscribe && windscribe"
alias upyay="yes '' | yay"
alias upfish="fisher list | fisher update"
alias code="codium"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#use rust stuff to see what's the fuss is about
alias cat="bat -p"
alias ls="exa --git"
alias l="exa --long --header --git"
alias la="exa -a --long --header --git"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Use more secure doas
#alias sudo='doas '

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv" 
alias yt="youtube-dl --add-metadata -i"

alias myip="curl ipinfo.io/ip"

