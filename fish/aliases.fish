alias windscribe="sudo systemctl start windscribe && windscribe"
alias upyay="yes '' | yay"
alias code="codium"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo
alias sudo='sudo '

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv" 
alias yt="youtube-dl --add-metadata -i"

alias myip="curl ipinfo.io/ip"
alias localip="ifconfig | grep inet | head -n 1 | awk '$1=$1'"


