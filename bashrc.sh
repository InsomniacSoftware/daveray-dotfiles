export PATH="$PATH:$HOME/bin"
source $HOME/.dotfiles/git-completion.bash
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
