localip() {
    ifconfig | grep inet | head -n 1 | awk '($1=$1)'
}