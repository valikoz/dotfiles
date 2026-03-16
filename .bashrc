# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history
shopt -s histappend # append to the history file, don't overwrite it
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# TERM="xterm-256color"
# TERM="tmux-256color" # dublicate command in nvim terminal!?

# PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias gnome-control-center='XDG_CURRENT_DESKTOP=GNOME gnome-control-center'
PS1='[\u@\h \W]\$ '
export EDITOR='vim'

alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"

lg() { lazygit -ucd "$HOME/.config/lazygit" "$@"; }
export -f lg

PATH=$PATH:"$HOME/.local/node-v24.11.1-linux-x64/bin/"
PATH=$PATH:"$HOME/.local/bin/"
PATH=$PATH:"$HOME/.local/platform-tools/"

# https://gist.github.com/stecman/6cc2769b135f272b673a
__ltrim_colon_completions()
{
    if [[ "$1" == *:* && "$COMP_WORDBREAKS" == *:* ]]; then
        # Remove colon-word prefix from COMPREPLY items
        local colon_word=${1%"${1##*:}"}
        local i=${#COMPREPLY[*]}
        while [[ $((--i)) -ge 0 ]]; do
            COMPREPLY[$i]=${COMPREPLY[$i]#"$colon_word"}
        done
    fi
} # __ltrim_colon_completions()

_notes_complete()
{
    local cur prev opts

    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(ls ~/MyDrive/Notes/)"

    if [ ${COMP_CWORD} = 1 ]; then
          COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    fi
    return 0
}

complete -o nospace -F _notes_complete notes

_cht_complete()
{
    local cur prev opts
    # _get_comp_words_by_ref -n : cur

    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(curl -s cheat.sh/:list)"

    if [ ${COMP_CWORD} = 1 ]; then
          COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
          __ltrim_colon_completions "$cur"
    fi
    return 0
}
complete -F _cht_complete cht

