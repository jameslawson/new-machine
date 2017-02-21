# dotfiles

*My dotfiles for vim, tmux, zsh*


## Installation
Suppose you cloned this repo to `<repo> = ~/github_projects/dotfiles`.    
To keep dotfiles in sync, **create the appropriate softlinks**:

```bash
cd <repo>
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

In your home folder, you can do `l | grep lrw` to see which dot files are symlinks.

#### Proxy Configuration

```bash
git config --global http.proxy $HTTP_PROXY
git config --global https.proxy $HTTPS_PROXY
```

```bash
npm config set proxy $HTTP_PROXY
npm config set http_proxy $HTTP_PROXY
npm config set https-proxy $HTTP_PROXY
```
