function fish_prompt --description 'Write out the prompt'
    set laststatus $status

    if set -l git_branch (command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '')
        set git_branch (set_color -o magenta)"$git_branch"
        if command git diff-index --quiet HEAD --
            if set -l count (command git rev-list --count --left-right $upstream...HEAD 2>/dev/null)
                echo $count | read -l ahead behind
                if test "$ahead" -gt 0
                    set git_status "$git_status"(set_color red)⬆
                end
                if test "$behind" -gt 0
                    set git_status "$git_status"(set_color red)⬇
                end
            end
            for i in (git status --porcelain | string sub -l 2 | uniq)
                switch $i
                    case "."
                        set git_status "$git_status"(set_color green)✚
                    case " D"
                        set git_status "$git_status"(set_color red)✖
                    case "*M*"
                        set git_status "$git_status"(set_color green)✱
                    case "*R*"
                        set git_status "$git_status"(set_color purple)➜
                    case "*U*"
                        set git_status "$git_status"(set_color brown)═
                    case "??"
                        set git_status "$git_status"(set_color red)≠
                end
            end
        else
            set git_status (set_color green):
        end
        set git_info "(git$git_status$git_branch"(set_color white)")"
    end

    # Disable PWD shortening by default.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    printf '%s[%s] %s%s%s%s%s@%s%s %s%s%s%s%s%s' (set_color cyan) (date "+%H:%M") (set_color -o white) '❰' (set_color normal) $USER (set_color normal) (prompt_hostname) (set_color -o blue) (prompt_pwd) (set_color white) $git_info (set_color white) '❱' (set_color white)
    
    if test $laststatus -ne 0
        printf "%s✘" (set_color -o red)
    end
    printf " %s≻%s " (set_color white) (set_color normal)
end
