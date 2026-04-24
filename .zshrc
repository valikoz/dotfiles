XDG_CONFIG_HOME="$HOME/.config"
TERM="xterm-256color"
EDITOR='vim'

autoload -Uz compinit
compinit

# bindkey -v # enable Vi mode
bindkey -e # use emacs key bindings
# bindkey -L # list all keymaps

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M emacs "^[[A" up-line-or-beginning-search
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M emacs "^[[B" down-line-or-beginning-search
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Ctrl-RightArrow] - move forward one word
# bindkey -M emacs '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
# bindkey -M emacs '^[[1;5D' backward-word

cx() { cd "$@" && ls; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && ls -la; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fe() { $EDITOR "$(find . -type f -not -path '*/.*' | fzf)" }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

_notes_autocomplete() {
    local cur
    cur="${words[-1]}"  # Get the current word being typed

    # Directory to complete from
    local target_dir="$HOME/My_Drive/Notes"

    # Generate a list of files in the target directory for completion
    compadd $(ls $target_dir)
}

compdef _notes_autocomplete notes

_cht_complete()
{
    local cur prev opts

    cur="${words[CURRENT]}"
    prev="${words[CURRENT-1]}"
    opts=(${(f)"$(curl -s cheat.sh/:list)"})

    if [[ $CURRENT = 2 ]]; then
        compadd "$@" "${opts[@]}" 
    fi
}

compdef _cht_complete cht

lg() { lazygit -ucd "$HOME/.config/lazygit" "$@"; }
alias zshconfig="$EDITOR $HOME/.zshrc"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
