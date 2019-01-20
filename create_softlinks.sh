#!/bin/bash

# -- create softlinks of: s <- h,
#    where s is dotfile in src control and h is file in home directory
echo ">>>>> Creating softlinks..."
mkdir -p ~/.vim/after

ln -s $PWD/.gitignore_global ~/.gitignore_global
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.ctags ~/.ctags
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.git-templates/hooks/prepare-commit-msg ~/.git-templates/hooks/prepare-commit-msg
ln -s $PWD/.vim/after/ftplugin ~/.vim/after/ftplugin
ln -s $PWD/Brewfile ~/Brewfile
echo ">>>>> Success: Created softlinks."

ls -lah ~ | grep lr
echo ">>>>> You can view softlinks by running: ls ~ -lah | grep lr"
