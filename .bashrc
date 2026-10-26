# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval $(ssh-agent -s) >/dev/null 2>&1
fi

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR='vim'
export PAGER='less'
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
PATH="$PATH:$HOME/.local/bin"
