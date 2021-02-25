eval "$(starship init zsh)"
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

path+=$HOME/.local/bin

source /usr/share/zsh/share/antigen.zsh
antigen bundle larkery/zsh-histdb
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle MichaelAquilina/zsh-you-should-use
antigen apply

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#2e2e2e,fg=#c9ffde,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#2e2e2e,fg=#ffaca6,bold'

source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/private_aliases.zsh
fpath=( $HOME/.config/zsh/zfunc.zsh "${fpath[@]}" )

setopt auto_cd
setopt correct_all
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(histdb_most completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export HISTDB_FILE=$HOME/.config/zsh/zsh-history.db


_zsh_autosuggest_strategy_histdb_latest() {
    typeset -g suggestion
    suggestion=$(_histdb_query "
            SELECT commands.argv
            FROM history
                LEFT JOIN commands ON history.command_id = commands.rowid
                LEFT JOIN places ON history.place_id = places.rowid
            WHERE
                commands.argv LIKE '$(sql_escape $1)%' AND
                places.dir = '$(sql_escape $PWD)' AND
                exit_status = 0
            GROUP BY commands.argv
            ORDER BY history.start_time desc
            LIMIT 1
    ")
}

_zsh_autosuggest_strategy_histdb_most() {
    typeset -g suggestion
    suggestion=$(_histdb_query "
            SELECT commands.argv
            FROM history
                LEFT JOIN commands ON history.command_id = commands.rowid
                LEFT JOIN places ON history.place_id = places.rowid
            WHERE
                commands.argv LIKE '$(sql_escape $1)%' AND
                places.dir = '$(sql_escape $PWD)' AND
                exit_status = 0
            GROUP BY commands.argv
            ORDER BY count(*) desc
            LIMIT 1
    ")
}



# The following lines were added by compinstall
zstyle :compinstall filename '/home/flb/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search # Up
#bindkey "^[[B" down-line-or-beginning-search # Down
