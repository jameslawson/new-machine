### dotfiles

My dotfiles for vim, tmux, zsh

Suppose you cloned this repo to `~/github_projects/dotfiles`.    
To keep dotfiles in sync, create the appropriate softlinks:

````
ln -s ~/github_projects/dotfiles/.zshrc ~/.zshrc
ln -s ~/github_projects/dotfiles/.vimrc ~/.vimrc
ln -s ~/github_projects/dotfiles/UltiSnips ~/.vim/UltiSnips
ln -s ~/github_projects/dotfiles/.tmux.conf ~/.tmux.conf
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
