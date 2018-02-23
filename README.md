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

In your home folder, you can do `ls -lah | grep lrw` to see which dot files are symlinks.

<h1 align="center">new-machine</h1>
<p align="center">
  :computer: Setting up a new OSX machine :computer: <br>
  Most of the work needed to get a developer environment setup on OSX
</p>

Prerequisites:

- Admin rights
- Set up your proxy `$HTTP_PROXY`, `$HTTPS_PROXY` if needed
- Download/update Xcode and accept the Xcode Licence Agreement.

License: MIT

## 1. Dotfiles
Download [dotfiles](https://github.com/jameslawson/dotfiles#installation
), following the installation instructions from that repo.

## 2. Homebrew
  
Install Homebrew.
```bash
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Install [Cask](http://caskroom.io/).
```
$ brew install caskroom/cask/brew-cask
```
Install Chrome and then [KeepingYouAwake](https://github.com/newmarcel/KeepingYouAwake), a Caffeine clone
```
$ brew cask install iterm
$ brew cask install google-chrome
$ brew cask install keepingyouawake
$ brew install pidof
$ brew install wget
$ brew install tree
...
```

## 3. git
```bash
$ brew install git
$ git config --global user.name "James Lawson"
$ git config --global user.email "jameslawson@users.noreply.github.com"
$ git config --global alias.co checkout
$ git config --global alias.fb "!sh -c \"git checkout feature/foo-$1\" -"
$ git config --global alias.st status
$ git config --global alias.ci commit -v
$ git config --global alias.lg log --oneline --decorate --all --graph¬
$ git config --system http.proxy $HTTP_PROXY
$ git config --system https.proxy $HTTPS_PROXY
```

## 4. vim

Install vim with `clipboard+` and `python+` support.

```bash
$ brew install vim --override-system-vi
$ vim --version | grep python 
python+
$ vim --version | grep clipboard
clipboard+
$ whereis vim --version | grep clipboard
/usr/bin/vim
```

Install vundle (instructions taken from [here](https://github.com/VundleVim/Vundle.vim)):
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
:PluginInstall # run this command inside of vim
```

## 5. tmux and iTerm

Install tmux.

```
brew install tmux
brew install reattach-to-user-namespace  # some tmux plugins might need this
```

Install tmux plugin manager, then install tmux plugins.
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux
<prefix> + I   # install plugins
```

Download iTerm from the [website](https://www.iterm2.com/).
Open iTerm Preferences.  Go to *Profiles* on bar of icons.

- We can automatically start tmux when you create iTerm session.     
  In *General* tab. In the *Send text at start:* field, enter the following:
    ```
    tmux new
    ```
- By default, colors can become messed up in tmux+iTerm. So we'll need to set color scheme.    
  In the *Window* tab, in *Report Terminal Type* enter: `xterm-256color`. In `.tmux.conf`, you should have the color scheme config:
    ```
    set -g default-terminal "xterm-256color"
    ```
 - Scrolling in tmux's copy mode is painful. We can use vim style shortcuts to make scrolling in copy mode easier.
   In the *keys* tab, add the following the iTerm Profile Keys:    
   ```
   CTRL+U = Send Page Up
   CTRL+D = Send Page Down
   ```
 - Configure iTerm to start up a new tmux session by default.    
   In the *Profiles* tab, add the following to *Send Text at Start*:
   ```
   tmux new
   ```

## 6. Node

#### Setup nvm
Run the [install script](https://github.com/creationix/nvm#install-script).
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash
nvm ls-remote
nvm install v0.12.15
nvm install v4.5.0
nvm install v5.12.0
nvm ls
nvm use v5.12.0
nvm alias default v5.12.0
```

#### Configure npm
```
npm config set init.author.name $name  
npm config set init.author.email $email
npm config set proxy $HTTP_PROXY
npm config set http_proxy $HTTP_PROXY
npm config set https-proxy $HTTP_PROXY
```


## 7. Python


```
pip install virtualenv
python   # runs python v2
python3  # runs python v3
```



## 8. Ruby
**Setup rbenv**    
```
$ brew install rbenv ruby-build
$ echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
$ source ~/.bash_profile
```

**Install Ruby**    
Find the latest version number, `<version>`, of Ruby.    
At the time of writing, `<version> = 2.2.3`.
Install this version via `rbenv install`.
```
$ rbenv install <version>
```
Then point global ruby to be this version:
```
$ rbenv global
system
$ rbenv global <version>
$ rbenv global
2.3.3
$ ruby -v
ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-darwin14]
```

**Setup Bundler**    
```
$ ruby -r bundler -e "puts RUBY_VERSION"
(an error complaining about bundler being missing)
$ gem install bundler
$ ruby -r bundler -e "puts RUBY_VERSION"
2.2.3
$ brew install rbenv-bundler
$ rbenv bundler on
```

**Local Ruby Project**     
Suppose you have written a Gemfile for a project. To install the gems:
```
$ rbenv local <version>
$ gem install bundler
$ bundle install
```
where `<version>` is the desired version of Ruby. 

## 9. Haskell

```
$ brew cask install haskell-platform  # all-in-one haskell environment: ghci, cabal, ...
$ runhaskell foo.hs
$ ghci
```

## 10. Scala

```
brew install sbt
brew install scala --with-docs
```

## 11. Mongo, Redis, Postgresql

```
brew install mongodb
sudo mkdir -p /data/db

brew install redis
brew install postgresql
```


## License

MIT

