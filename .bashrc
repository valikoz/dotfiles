# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history

shopt -s histappend # append to the history file, don't overwrite it

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# TERM="xterm-256color"
# TERM="tmux-256color" # dublicate command in nvim terminal!?

# PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
PS1='\u:\W\$ '
export EDITOR='nvim'

# alias ls='ls --color=auto'
# alias lg='lazygit -ucd $HOME/.config/lazygit'

alias mvim='NVIM_APPNAME=mvim nvim'
alias bashconfig="$EDITOR -o $HOME/.bashrc $HOME/.bash_profile"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias server='python3 -m http.server'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

lg() { lazygit -ucd "$HOME/.config/lazygit" "$@"; }
export -f lg

function fw {
  aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

function cx() { cd "$@" && ls; }

function fcd() {
  cd "$(find . -type d -not -path '*/.*' $@ | fzf)" && ls -la
}

function f() {
  echo "$(find . -type f -not -path '*/.*' $@ | fzf)" | pbcopy
}

function fe() {
  $EDITOR "$(find . -type f -not -path '*/.*' $@ | fzf)"
}

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
