#!/bin/bash

# -- create softlinks of the form: "ln -s <vcs> <-- <home>"
#    where <vrc> is dotfile under src control and <home>
#    is file in home directory
echo ">>>>> Creating softlinks..."

ln -s $PWD/.inputrc ~/.inputrc
ln -s $PWD/.git-excludesfile ~/.git-excludesfile
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/Brewfile ~/Brewfile

mkdir -p ~/.config/nvim
ln -s $PWD/.config/nvim/init.vim ~/.config/nvim/init.vim

echo ">>>>> Success: Created softlinks."

ls -lah ~ | grep lr
echo ">>>>> You can view dotfiles by running: ls ~ -lah | grep lr"
