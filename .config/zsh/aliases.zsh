#!/usr/bin/env zsh

#alias windscribe="sudo systemctl start windscribe && windscribe"
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
alias rm="trash-put -v"
alias mkd="mkdir -pv"
alias yt="youtube-dl --add-metadata -i"

alias myip="dig @1.1.1.1 whoami.cloudflare TXT CH +short +tries=1 +timeout=3 | sed -e 's/^\"//' -e 's/\"$//'"
alias mycountry="geoiplookup $(myip) | sed -E 's/GeoIP Country Edition: ([A-Z]{2}), [a-zA-Z]+/\1/'"

#Get the last installed packages installed by pacman
alias last-install="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -n"

# Run software through wireguard netns
wg-run () {
    cmd=${@:2}
    if [ "$cmd" ]
    then
        sudo -E ip netns exec $1 sudo -E -u "$USER" ${@:2}
    elif [ "$1" ]
    then
        wg-run $1 zsh
    else
        echo "Please specify a network namespace."
    fi
}

wg-zsh () {
    wg-run $1
}

mute-run () {
    cmd=${@:1}
    if [ "$cmd" ]
    then
        setsid ${@:1} > /dev/null 2>&1;
    else
        echo "Please provide an argument"
    fi
}

# Run dolphin in the background and mute its output
alias dolphin="mute-run /usr/bin/dolphin"

# Run dolphin in the background and mute its output
konsole() { 
    if [ "$1" ]
    then
        mute-run /usr/bin/konsole --workdir $1;
    else
        mute-run /usr/bin/konsole
    fi
}

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
    # cycle through output devices
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

# broot
function br {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        command rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        command rm -f "$cmd_file"
        return "$code"
    fi
}
