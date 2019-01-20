<h1 align="center">new-machine</h1>
<p align="center">
  :computer: Setting up a new macOS machine :computer: <br>
  Most of the work needed to get a developer environment setup on macOS
</p>

Prerequisites:

- Admin rights
- Set up your proxy `$HTTP_PROXY`, `$HTTPS_PROXY` if needed
- Xcode: accept the Xcode Licence Agreement and install
  ```
  sudo xcodebuild -license
  xcode-select --install
  ```
- If necessary, copy `.bash_profile`, `.ssh/`, certificates, any other non-public files to your machine.
  You may need to chmod .ssh files so that they are not [too open](https://stackoverflow.com/a/9270753).
- Change the trackpad direction
- Create dotfiles (.vimrc, .tmux, Brewfile):
  ```
  ./create_dotfiles.sh
  ```
- Increase the [keyboard repeat rate](https://apple.stackexchange.com/a/83923)
  ```
  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 1
  ```
- Setup directories:
  ```
  mkdir -p github/{bbc,jameslawson}
  ```



## 1. CLI

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

## 2. Homebrew
  
- Install [Homebrew](https://brew.sh/).
  ```bash
  $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ```
- Install formulas:
  ```bash
  brew
  ```
  This will use the `Brewfile` to install essentials (`vim`, `git`, ...) 
  languages (`java`, `scala`) and macOS applications (Chrome, KeepingYouAwake, Spectable, ...) via [Cask](http://caskroom.io/).
  

## 3. git


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

$ mkdir -p ~/.git-templates/hooks
$ git config --global core.hooksPath ~/.git-templates/hooks
$ chmod a+x ~/.git-templates/hooks/prepare-commit-msg
```

**Printing Config**: 
- Most config is either "system" or "global" (but there's also local, worktree, file)
  ```
  git config --list --show-origin
  git config --list --system
  git config --list --global
  ```
- See [git-config](https://git-scm.com/docs/git-config) Documentation

**vimdiff**: 
- Config git to use [vimdiff](https://stackoverflow.com/a/3713865/3649209) (bundled with git)
  ```
  $ git config --global diff.tool vimdiff
  $ git config --global difftool.prompt false
  $ git config --global alias.d difftool
  ```
- See [vimdiff cheatsheet](https://gist.github.com/mattratleph/4026987)

**Semantic Commits**: 
- Install Git [semantic commits](https://github.com/fteem/git-semantic-commits):
  ```bash
  git clone https://github.com/fteem/git-semantic-commits ~/.git-semantic-commits
  cd ~/.git-semantic-commits && ./install.sh
  ```

**Print Tracking Branch**: 
- Create a tracking branch on push: `git push -u origin foo`
- Or alternatively, avoid `-u` each time (aka always add upstream tracking on a push):
    ```
    git config --global branch.autosetupmerge always
    ```
- Print out what this branch is tracking on origin:
  ```bash
  tracking() {
    git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null
  }
  ```

## 4. Chrome
- Download Chrome
- Import Bookmarks
- Settings > Show Home Button


## 5. vim

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

## 6. tmux and iTerm

From the `Brewfile`, you should already have `tmux` formula installed.

- Install tmux plugin manager, then install tmux plugins.
  ```
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux
  <prefix> + I   # install plugins
  ```

- **Autostart tmux**: We can automatically start tmux when you create iTerm session.    

  - Go to *Profiles* in iTerm prferences. In *General* tab.    
    In the *Send Text at Start:* field, enter the following:
      ```
      tmux new
      ```
  - By default, colors can become messed up in tmux+iTerm. So we'll need to set color scheme.    
    In the *Window* tab, in *Report Terminal Type* enter: `xterm-256color`. 
    And verify that in `.tmux.conf`, we have the color scheme config:
    ```
    set -g default-terminal "xterm-256color"
    ```

## 7. Node

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

## 8. Python

- Install virtualenv
  ```
  pip install virtualenv
  python   # runs python v2
  python3  # runs python v3
  ```

- Install [jupyter notebook](http://jupyter.org/install.html)
  ```
  python3 -m pip install --upgrade pip
  python3 -m pip install jupyter
  ```


## 9. Java and Scala

The brewfile should have installed these formulas: `java7`, `java8`, `sbt` and `scala`.

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

## 10. Haskell

```
$ brew cask install haskell-platform  # all-in-one haskell environment: ghci, cabal, ...
$ runhaskell foo.hs
$ ghci
```


## 11. Cloud

- Download docker for OSX
- Install [AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- Install [Google Cloud SDK](https://cloud.google.com/sdk/install)


## License

MIT

