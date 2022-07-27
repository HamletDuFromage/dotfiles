localip() {
    ifconfig | grep inet | head -n 1 | awk '($1=$1)'
}

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

_zsh_autosuggest_strategy_histdb_success() {
    typeset -g suggestion
    suggestion=$(_histdb_query "
            SELECT commands.argv
            FROM history
                LEFT JOIN commands ON history.command_id = commands.rowid
                LEFT JOIN places ON history.place_id = places.rowid
            WHERE
                commands.argv LIKE '$(sql_escape $1)%' AND
                exit_status = 0
            GROUP BY commands.argv
            ORDER BY count(*) desc
            LIMIT 1
    ")
}