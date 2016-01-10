### dotfiles

My dotfiles for vim, tmux, zsh

Suppose you cloned this repo to `<repo> = ~/github_projects/dotfiles`.    
To keep dotfiles in sync, create the appropriate softlinks:

````
cd <repo>
ln -s .zshrc ~/.zshrc
ln -s .vimrc ~/.vimrc
ln -s UltiSnips ~/.vim/UltiSnips
ln -s .tmux.conf ~/.tmux.conf
...
````

In your home folder, you can do `l | grep lrw` to see which dot files are symlinks.

----

**YouCompleteMe**   
````
brew install cmake 
vim
:PluginInstall
:q
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
````
[Full Instructions](https://github.com/Valloric/YouCompleteMe)
