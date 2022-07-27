#!/usr/bin/env zsh

alias windscribe="sudo systemctl start windscribe && windscribe"
alias upyay="yes '' | yay"
alias uparu="paru -Syu --noconfirm && antigen update"
alias upfish="fisher list | fisher update"

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

alias myip="dig @1.1.1.1 whoami.cloudflare TXT CH +short +tries=1 +timeout=3 | sed -e 's/^\"//' -e 's/\"$//'"

#Get the last installed packages installed by pacman
alias last-install="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -n"

# Run dolphin in the background and mute its output
dolphin() { setsid /usr/bin/dolphin $1 >/dev/null 2>&1; }

# Control pulseaudio devices
pa-list() { pacmd list-sinks | awk '/index/ || /name:/'; }
pa-set() {
    # list all apps in playback tab (ex: cmus, mplayer, vlc)
    inputs=($(pacmd list-sink-inputs | awk '/index/ {print $2}'))
    # set the default output device
    pacmd set-default-sink $1 &>/dev/null
    # apply the changes to all running apps to use the new output device
    for i in ${inputs[*]}; do pacmd move-sink-input $i $1 &>/dev/null; done
}
pa-cycle() {
    echo lol
    current=$(pacmd list-sinks | awk '/* index/ {print $3}')
    total=$(pactl list short sinks | wc -l)
    ((next = ($current + 1) % $total))
    pa-set $next
}
pa-playbacklist() {
    # list individual apps
    echo "==============="
    echo "Running Apps"
    pacmd list-sink-inputs | awk '/index/ || /application.name /'

    # list all sound device
    echo "==============="
    echo "Sound Devices"
    pacmd list-sinks | awk '/index/ || /name:/'
}
pa-playbackset() {
    # set the default output device
    pacmd set-default-sink "$2" &>/dev/null
    # apply changes to one running app to use the new output device
    pacmd move-sink-input "$1" "$2" &>/dev/null
}