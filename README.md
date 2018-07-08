<h1 align="center">dotfiles</h1>
<p align="center">
  :wrench: A repo for my dotfiles :wrench: <br>
  Configuration for vim, tmux, git, zsh, ...
</p>

License: MIT

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
- Download/update Xcode and accept the Xcode Licence Agreement
- If necessary, copy `.bash_profile`, `.ssh/`, certificates, any other non-public files to your machine.
  You may need to chmod .ssh files so that they are not [too open](https://stackoverflow.com/a/9270753).
- Change the trackpad direction
- Increase the [keyboard repeat rate](https://apple.stackexchange.com/a/83923)
  ```
  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 1
  ```
- Setup directories:
  ```
  mkdir -p github/{bbc,jameslawson}
  ```
- Bash Aliases:
  ```bash
  alias l="ls -lah"
  alias pynb="jupyter notebook"  
  ```
- Bash Custom PS1:
  ```bash
  # -- use sed to delete all the lines in git branch's output that dont start with a asterix (*)
  #    then take result and regex capture the text after the *, and then only print this text
  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
  }
  
  # -- xterm 256-colours
  #    https://unix.stackexchange.com/a/124409
  export G="\[\033[38;5;040m\]"  # green
  export P="\[\033[38;5;162m\]"  # purple
  export R="\[\033[00m\]"        # red
  export D1="\[\033[38;5;244m\]" # dark
  export D2="\[\033[38;5;239m\]" # darker

  export PS1="$D1[$D2 \t $D1] $G\w$P\$(parse_git_branch) $D1$R$ "
  ```
- Bash Cycle tab completion
  ```bash
  # -- Cycle bash completion
  #    https://superuser.com/a/289022
  bind 'TAB:menu-complete'
  ```


## 1. Homebrew
  
Install [Homebrew](https://brew.sh/).
```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Install [Cask](http://caskroom.io/).
```
$ brew tap caskroom/cask
```
Install Chrome and then [KeepingYouAwake](https://github.com/newmarcel/KeepingYouAwake), a Caffeine clone
```
$ brew cask install iterm2
$ brew cask install google-chrome
$ brew cask install keepingyouawake
$ brew cask install spectacle
$ brew cask install sip
$ brew install pidof
$ brew install wget
$ brew install tree
...
```

## 2. git
```bash
$ brew install git
$ git config --global user.name "James Lawson"
$ git config --global user.email "jameslawson@users.noreply.github.com"
$ git config --global alias.co checkout
$ git config --global alias.st status
$ git config --global alias.ci commit -v
$ git config --global alias.lg log --graph --oneline --decorate --all
$ git config --system http.proxy $HTTP_PROXY
$ git config --system https.proxy $HTTPS_PROXY
$ git config --global url.ssh://git@github.com/.insteadOf https://github.com/
$ git config --global core.excludesfile ~/.gitignore_global
```

Git [semantic commits](https://github.com/fteem/git-semantic-commits):
```bash
git clone https://github.com/fteem/git-semantic-commits ~/.git-semantic-commits
cd ~/.git-semantic-commits && ./install.sh
```

Print tracking branch
```bash
tracking() {
  git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null
}
```

## 2. Chrome
- Download Chrome
- Import Bookmarks
- Settings > Show Home Button

## 3. Dotfiles
Open terminal. following the installation above for installing dotfiles
```
git clone git@github.com:jameslawson/dotfiles.git ~/github/jameslawson/dotfiles
cd  ~/github/jameslawson/dotfiles
# ... see instructions for dotfiles to create softlinks
```

## 4. vim

Install vim with `clipboard+` and `python+` support.

```bash
$ brew install vim --override-system-vi --with-python3 --with-custom-python
$ vim --version | grep python
+python3
$ vim --version | grep clipboard
+clipboard
$ whereis vim
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

Go to *Profiles* in iTerm prferences.

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

Turn off nvm by default
```bash
nvm() {
  # -- nvm.sh is really is slow ... so wrap it in a function
  #    USAGE:
  #    $ nvm              <- run this nvm function, this loads nvm to path
  #    $ nvm ls           <- now we can use the real nvm executable
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
```


## 7. Python


```
pip install virtualenv
python   # runs python v2
python3  # runs python v3
```

Install [jupyter notebook](http://jupyter.org/install.html)
```
python3 -m pip install --upgrade pip
python3 -m pip install jupyter
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

## 10. Java, Scala

```
brew cask install java
brew cask install java8
brew install sbt
brew install scala --with-docs
```

Setting a jdk
```bash
# -- http://www.jayway.com/2014/01/15/how-to-switch-jdk-version-on-mac-os-x-maverick/
#    Example use: setjdk 1.7 - selects the latest installed JDK version of the 1.7 branch
#    Example use: setjdk 1.7.0_51 - select a specific version
#    Run /usr/libexec/java_home -h to get more details on how to choose versions
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}
function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}
setjdk 1.8
```

## 11. Mongo, Redis, PostgreSQL

```
brew install mongodb
sudo mkdir -p /data/db

brew install redis
brew install postgresql
brew cask install psequel
```

## 12. Docker and Cloud

- Download docker for OSX
- Install [AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)


## License

MIT

