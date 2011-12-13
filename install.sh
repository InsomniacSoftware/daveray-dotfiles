TARGET=$HOME
DOTFILES=$PWD

# Profile junk
echo -e "\nsource $DOTFILES/bashrc.sh\n" >> $TARGET/.bashrc
ln -s $DOTFILES/inputrc.rc $TARGET/.inputrc

# Git junk
ln -s $DOTFILES/gitconfig $TARGET/.gitconfig
ln -s $DOTFILES/gitignore $TARGET/.gitignore

# Hg junk
echo -e "\n%include $DOTFILES/hgrc.ini\n" >> $TARGET/.hgrc

# Vim junk.
git clone git@github.com:daveray/vimfiles.git $TARGET/.vim
echo -e "runtime vimrc.vim\n" > $TARGET/.vimrc
echo -e "runtime gvimrc.vim\n" > $TARGET/.gvimrc
make -C $TARGET/.vim/bundle/vimclojure-2.2.0/lib/nailgun
mkdir $TARGET/vimbak

# Openbox config
mkdir -p $TARGET/.config/openbox/
ln -s $DOTFILES/openboxrc $TARGET/.config/openbox

# cgdb config
mkdir -p $TARGET/.cgdb/
ln -s $DOTFILES/cgdbrc $TARGET/.cgdb/cgdbrc

# Vimperator
ln -s $DOTFILES/vimperatorrc.vim $TARGET/.vimperatorrc

# Project management
mkdir -p $TARGET/.projects/

