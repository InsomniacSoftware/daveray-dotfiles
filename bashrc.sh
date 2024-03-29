export PATH="/usr/local/bin:$PATH:/usr/texbin:$HOME/bin:$HOME/.dotfiles/bin"
export HISTIGNORE="cd:ls:[bf]g:exit:pwd:clear:mount:git st*:hg st*:eclipse:history:gvim:vim"
export HISTCONTROL=ignoreboth
export HISTSIZE=10000

# Make sure ctrl-d (useful in readline) doesn't cause the shell to exit
export IGNOREEOF=50

# keep saving history
shopt -s histappend

# color ls
alias ls="ls -G"

# read/write history http://briancarper.net/blog/248/
alias uh='history -n; history -a'

# Run gvim in terminal mode so we get nice colors
alias vim="gvim -v"
export EDITOR="gvim -v"

# Set up perforce editor
export P4EDITOR="gvim -v"

# Tell p4 to search up for .p4config to determine settings. Stupid.
export P4CONFIG=".p4config"

# alias to launch p4v app on osx
if [ `uname` == "Darwin" ]; then
  alias p4v="open -a p4v"
fi

# Make sure gradle puts its stuff in the right place
export GRADLE_USER_HOME="$HOME/.gradle"

# Nicer grep
alias grep='grep --color=auto'

# Tell tmux out term has color
alias tmux="tmux -2"

# Space will auto-expand history expressions
bind Space:magic-space


source $HOME/.dotfiles/git-completion.bash
source $HOME/.dotfiles/gitprompt.sh
source $HOME/.dotfiles/hg-completion.bash
source $HOME/.dotfiles/lein-completion.bash
# https://raw.github.com/skybert/my-little-friends/master/bash_completion.d/p4
source $HOME/.dotfiles/p4-completion.bash
source $HOME/.dotfiles/project-completion.bash

yellow='\033[1;33m'
green='\033[1;32m'
red='\033[1;31m'
blue='\033[1;34m'
cyan='\033[1;36m'
fgcolor="\033[0m" # unsets color to term's fg color

hgprompt='`hg prompt "[{branch}{status}{update}]" 2> /dev/null`'

export GIT_PROMPT_START="\[$yellow\][\!,\$?] \[$blue\]\W \[$cyan\]${hgprompt}"
export GIT_PROMPT_END="\$ "

# Set terminal title
# @param string $1  Tab/window title
# @param string $2  (optional) Separate window title
# The latest version of this software can be obtained here:
# See: http://fvue.nl/wiki/NameTerminal
function title() {
    [ "${TERM:0:5}" = "xterm" ]   && local ansiNrTab=0
    [ "$TERM"       = "rxvt" ]    && local ansiNrTab=61
    [ "$TERM"       = "konsole" ] && local ansiNrTab=30 ansiNrWindow=0
    # Change tab title
    [ $ansiNrTab ] && echo -n $'\e'"]$ansiNrTab;$1"$'\a'
    # If terminal support separate window title, change window title as well
    [ $ansiNrWindow -a "$2" ] && echo -n $'\e'"]$ansiNrWindow;$2"$'\a'
    [ $TMUX ] && tmux rename-window $1
}

function p() {
  title $1
  source "$HOME/.projects/$1.sh"
}

# grep history
function gh() {
  history | grep $*
}

# open a file
function view() {
  if which xdg-open > /dev/null
  then
    xdg-open "$1"
  fi
}

