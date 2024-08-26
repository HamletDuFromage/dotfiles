eval "$(starship init zsh)"
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

source /usr/share/zsh/share/antigen.zsh
#antigen bundle marzocchi/zsh-notify
antigen bundle larkery/zsh-histdb
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

if [ -f $HOME/.config/zsh/aliases.zsh ];            then source $HOME/.config/zsh/aliases.zsh; fi
if [ -f $HOME/.config/zsh/private_aliases.zsh ];    then source $HOME/.config/zsh/private_aliases.zsh; fi
if [ -f $HOME/.config/zsh/keybinds.zsh ];           then source $HOME/.config/zsh/keybinds.zsh; fi
if [ -f $HOME/.config/zsh/zfunc.zsh ];              then source $HOME/.config/zsh/zfunc.zsh; fi
if [ -f $HOME/.config/zsh/exports.zsh ];            then source $HOME/.config/zsh/exports.zsh; fi
if [ -f $HOME/.config/zsh/private_exports.zsh ];    then source $HOME/.config/zsh/private_exports.zsh; fi


export PATH=$HOME/.config/zsh/zfunc.zsh:$HOME/.local/bin:/opt/devkitpro/devkitA64/bin/:$PATH

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#2e2e2e,fg=#c9ffde,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#2e2e2e,fg=#ffaca6,bold'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#setopt auto_cd
setopt correct_all
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(histdb_most completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export HISTDB_FILE=$HOME/.config/zsh/zsh-history.db

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

# Enable zmv for easy file renaming
autoload zmv

# Automatically quote things such as url
#autoload -Uz bracketed-paste-magic
#zle -N bracketed-paste bracketed-paste-magic

#autoload -Uz url-quote-magic
#zle -N self-insert url-quote-magic


#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search # Up
#bindkey "^[[B" down-line-or-beginning-search # Down
