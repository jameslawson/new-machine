# dotfiles

*My dotfiles for vim, tmux, zsh*


## Installation
Suppose you cloned this repo to `<repo> = ~/github_projects/dotfiles`.    
To keep dotfiles in sync, **create the appropriate softlinks**:

```bash
cd <repo>
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.ctags ~/.ctags

# link snippetsemu snippet files
mkdir -p ~/.vim/after
ln -s $PWD/.vim/after/ftplugin ~/.vim/after/ftplugin
```

In your home folder, you can do `l | grep lrw` to see which dot files are symlinks.
