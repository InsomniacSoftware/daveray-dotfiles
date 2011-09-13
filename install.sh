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


