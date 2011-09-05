TARGET=$HOME
DOTFILES=$PWD

# Profile junk
echo -e "\nsource $DOTFILES/bashrc.sh\n" >> $TARGET/.bashrc

# Git junk
ln -s $DOTFILES/gitconfig $TARGET/.gitconfig
ln -s $DOTFILES/gitignore $TARGET/.gitignore

# Vim junk.
git clone git@github.com:daveray/vimfiles.git $TARGET/.vim
echo -e "runtime vimrc.vim\n" > $TARGET/.vimrc
mkdir $TARGET/vimbak

