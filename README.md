<h1 align="center">dotfiles</h1>
<p align="center">
  :wrench: A repo for my dotfiles :wrench: <br>
  Configuration for vim, tmux, git, zsh, ...
</p>

## Installation
Suppose you cloned this repo to `/dotfiles`.    
To keep dotfiles in sync, **create the appropriate softlinks**:

```bash
#
#    ~/.some_dotfile   === soft link ===>   dotfiles/.some_dotfile
#

cd dotfiles
ln -s $PWD/.gitignore_global ~/.gitignore_global
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.ctags ~/.ctags
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf

# link snippetsemu snippet files
mkdir -p ~/.vim/after
ln -s $PWD/.vim/after/ftplugin ~/.vim/after/ftplugin
```

In your home folder, you can do `ls | grep lrw` to see which dot files are symlinks.

## License

MIT
