#!/bin/bash

# -- create softlinks of: s <- h,
#    where s is dotfile in src control and h is file in home directory
echo ">>>>> Creating softlinks..."

ln -s $PWD/.bash_profile ~/.bash_profile
ln -s $PWD/.inputrc ~/.inputrc
ln -s $PWD/.gitignore_global ~/.gitignore_global
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.ctags ~/.ctags
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/Brewfile ~/Brewfile

mkdir -p ~/.vim/after
ln -s $PWD/.vim/after/ftplugin ~/.vim/after/ftplugin

mkdir -p ~/.git-templates/hooks
ln -s $PWD/.git-templates/hooks/prepare-commit-msg ~/.git-templates/hooks/prepare-commit-msg
chmod a+x ~/.git-templates/hooks/prepare-commit-msg

echo ">>>>> Success: Created softlinks."

ls -lah ~ | grep lr
echo ">>>>> You can view dotfiles by running: ls ~ -lah | grep lr"
