export PATH="$PATH:/usr/texbin/:$HOME/bin:$HOME/.dotfiles/bin"
export HISTIGNORE="cd:ls:[bf]g:exit:pwd:clear:mount:git st*:hg st*:eclipse:history:gvim:vim"
export HISTCONTROL=ignoreboth

source $HOME/.dotfiles/git-completion.bash
source $HOME/.dotfiles/hg-completion.bash
source $HOME/.dotfiles/lein-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=true

yellow='\033[1;33m'
green='\033[1;32m'
red='\033[1;31m'
blue='\033[1;34m'
cyan='\033[1;36m'
fgcolor="\033[0m" # unsets color to term's fg color

gitprompt='$(__git_ps1 "[%s]")'
hgprompt='`hg prompt "[{branch}{status}{update}]" 2> /dev/null`'
export PS1="\[$yellow\][\!,\$?] \[$blue\]\W \[$cyan\]${hgprompt}\[$green\]${gitprompt}\[$fgcolor\]\$ "

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
}

function p() {
  title $1
  source "$HOME/.projects/$1.sh"
}

