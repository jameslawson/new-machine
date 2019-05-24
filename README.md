<h1 align="center">new-machine</h1>
<p align="center">
  :computer: Setting up a new macOS machine :computer: <br>
  Most of the work needed to get a developer environment setup on macOS
</p>

Prerequisites:
- Admin rights
- Set up your proxy `$HTTP_PROXY`, `$HTTPS_PROXY` if needed


## Essentials

- **Xcode**
  Accept the Xcode Licence Agreement and install Xcode:
  ```
  sudo xcodebuild -license
  xcode-select --install
  ``` 
- **SSH Keys**: If necessary, copy `.bash_profile`, `.ssh/`, certificates, any other non-public files to your machine.
  You may need to chmod .ssh files so that they are not [too open](https://stackoverflow.com/a/9270753). To
  add a private key to the ssh agent, run `ssh-add -K`.
  
- **Mouse and Keyboard**
  - Change the trackpad direction
  - Increase the [keyboard repeat rate](https://apple.stackexchange.com/a/83923)
    ```
    defaults write -g InitialKeyRepeat -int 10
    defaults write -g KeyRepeat -int 1
    ```
- Setup **directories**:
  ```
  mkdir -p github/{work,jameslawson}
  ```
- Create **dotfiles** create symlinks for .vimrc, .tmux, Brewfile, ...:
  ```
  ./create_dotfiles.sh
  ``` 

## 1. Command Prompt

Optional: Add the HTTP Proxy add/remove functions in `./add_remove_proxy.sh` 
to a start-up script (like .bash_profile).

## 2. Homebrew
  
To install [Homebrew](https://brew.sh/) and the Homebrew formulas:

1. Run the following at a command-prompt:
    ```bash
    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```
2. Install Formulas:
    ```bash
    brew bundle ~/Brewfile
    ```
    **Note**: This command reads `~/Brewfile` to install essential tools like vim, git, tree; 
    install languages likes Java, Scala; and install macOS apps like Chrome, KeepingYouAwake, Spectable via [Homebrew Cask](http://caskroom.io/).

3. Optional: Verify the installation has modified your PATH correctly. Output the `$PATH` environment variable:
    ```bash
    $ echo $PATH
    ```

    and confirm the following:
    1. `/usr/local/bin` comes before `/usr/bin` in the output
    2. `/usr/local/sbin/` comes before `/usr/sbin` in the output

    If any of the above are not true, then you'll need to [update your PATH](https://stackoverflow.com/questions/10343834/how-to-modify-path-for-homebrew) by either changing the `$PATH` environment variable in a startup file like `.bash_profile`
    or by changing the order of paths in `/etc/paths`.     
    
     **Note**: `/usr/local/bin` and `/usr/local/sbin` are the default directories where Homebrew places executables upon 
     the installation of Formulas. We must ensure that our [UNIX path search](https://tiswww.case.edu/php/chet/bash/bashref.html#Command-Search-and-Execution-1) is configured
     so that these directories are searched before the standard macOS directories of `/usr/bin` and 
     `/usr/sbin` are searched.

  

## 3. git

**Note:** git was installed via Homebrew in an earlier step. The instructions
below assume you have the `git` formulae installed.

### Verify Installation

Verify that we are using Homebrew git, and not the macOS git:
1. Check the path is correct:

    ```bash
    $ which git
    ```
    The output should be `/usr/local/bin/git`. If the output is `/usr/bin/git` then you are likely using 
    the macOS vim. If this is the case then the Homebrew installation of git is not correct.
    
2. Check the version string:
   ```
   $ git --version
   ```
   if you see `(Apple Git-xxx)` when running `git --version` then you are likely using the macOS vim.
   If this is the case then the Homebrew installation of git is not correct.

### Configure Git

Run the following script to configure git:
```
./configure_git.sh
```

### vimdiff

**Note:** vimdiff is bundled together with git. The configure_git.sh script automatically
configured git to use vimdiff to resolve conflicts. See [vimdiff cheatsheet](https://gist.github.com/mattratleph/4026987)


### Optional: Semantic Commits

For projects using Semantic commits, install git aliases from [semantic commits](https://github.com/fteem/git-semantic-commits): 
  ```bash
  git clone https://github.com/fteem/git-semantic-commits ~/.git-semantic-commits
  cd ~/.git-semantic-commits && ./install.sh
  ```

### Bash Function to Print Tracking Branch

To print out what this branch is tracking on origin, add the following to a startup script (like `.bash_profile`):
```bash
tracking() {
  git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null
}
```

Then writing `$ tracking` and pressing Enter will show the current tracking branch if there is one,
and print an empty line is there is no tracking branch.

**Note:** To create a tracking branch on push: `git push -u origin foo`, or alternatively, to 
avoid writing `-u` each time (and always add upstream tracking on a push), you can use
`git config --global branch.autosetupmerge always`.


## 4. vim

**Note:** vim was installed via Homebrew in an earlier step. The instructions
below assume you have the `vim` formulae installed.

### Verify Installation 

1. Verify that we are using homebrew vim, and not the macOS vim, by running: 
    ```bash
    $ which vim
    ```
    The output should be `/usr/local/bin/vim`.
  
2. To verify that vim was installed with python and system-clipboard support, run in the comand-line prompt:
    ```
    $ vim --version | grep python
    $ vim --version | grep clipboard
    ```
    and verify that the output contains `+python3` and `+clipboard`. If you see `-python3` or `-clipboard`
    then the installation of vim is not correct.

### Install vim Plugins 

To install [vundle](https://github.com/VundleVim/Vundle.vim), a plugin manager for vim and vim plugins:
1. Run in the command-line:
    ```
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ```
2. Open vim and from inside vim, install plugins by running the vim user command: **:PluginInstall** 

## 4X. Neovim (Experimental)

**Note:** Neovim was installed via Homebrew in an earlier step. The instructions
below assume you have the `neovim` formula installed.

### vim-plug

To install plugins for Neovim:

1. Download [vim-plug](https://github.com/junegunn/vim-plug/wiki/tutorial) (for Neovim on UNIX):
    ```
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
2. Open Neovim (by running the `nvim` command) and execute the Neovim user command **:PlugInstall** in Normal Mode.

## 5. tmux and iTerm

**Note:** tmux and iTerm were installed via Homebrew in an earlier step. The instructions
below assume you have the `tmux` formulae installed and `iterm2` cask installed.

### Verify Installation 

1. Check the version of tmux:
   ```
   tmux -V
   ```
   and verify the version is 2.9a or above.
2. Check the installation path:
   ```
   which tmux
   ```
   and verify the path is `/usr/local/bin/tmux`. 

### tmux plugins

To install the tmux plugin manager (tpm) and tmux plugins:
1. Run in the command-line:
  ```
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```
2. Open tmux install plugins by running **`<prefix> + I`** 


### Automatially start tmux in iTerm

To automatically start tmux when an iTerm session is created:    

1. In iTerm Preferences, view **Profiles > General**
2. In the **Send Text at Start:** field, enter the following:
    ```
    tmux new
    ```
    
    
### Using `xterm-256color` in iTerm

1. In iTerm Preferences, view **Profiles > Terminal**
2. In the **Report Terminal Type** enter: `xterm-256color`. 
3. In `.tmux.conf`, verify that this line exists: 
    ```
    set -g default-terminal "screen-256color"
    ```
  


## 6. Node

**Note:** Homebrew installed Node Version Manager (nvm) in an earlier step. The instructions
below assumes the use of Node Version Manager (nvm) to 
handle all system-wide and project-specific installations of node.

### Install Node

1. Install desired versions of node:
    ```
    nvm ls-remote
    nvm install v0.12.15
    nvm install v4.5.0
    nvm install v5.12.0
    ```
3. Optional: Pick a version to be the default:
    ```
    nvm use v5.12.0
    nvm alias default v5.12.0
    ```

4. Optional: Remove nvm automatic loading in `.bash_profile`.
   By default, nvm automatically loads itself on each tty session startup by running a bash script in
   .bash_profile. This uses over 1 second to load itself, significantly slowing down
   the overall tty session startup time. For terminal multiplexers (like tmux), this 
   can hinder a developer's workflow where tty sessions are created and destroyed frequently.
   A workarund is to instead, _manually_ load nvm by wrapping
   the nvm loader shell script in a bash function.

   ```diff
   - export NVM_DIR="$HOME/.nvm"
   - [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
   - [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
   + nvm() {
   +   export NVM_DIR="$HOME/.nvm"
   +   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
   +   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
   +  }
   ```
   Then the first time `nvm` is run in the tty session will cause nvm to load into the bash path. 
   All subsequent times we run `nvm`, the actual `nvm` executable will run because it has since been loaded into the path.
   ```
   nvm              <- run this nvm function, this loads nvm to path
   nvm ls           <- now we can use the real nvm executable
   ```

### Node Package Manager (npm)

Run the following script to configure npm:
```
./configure_npm.sh
```

## 7. Python

**Note:** Python was installed via Homebrew in an earlier step. The instructions
below assume the `python` and `python3` formulae were installed.

### Verify Installation of Homebrew Python

| Executable  | Command              | Expected Output |
| ---------   | -------------------- | --------------- |
| `python3`   | `python3 --version`  | `Python 3.x.x`  |
| `python2`   | `python2 --version`  | `Python 2.x.x`  |
| `python`    | `python2 --version`  | `Python 2.x.x`  |
| `pip3`      | `pip3 --version`     | `pip A.B.C from /usr/local/lib/python3.x/site-packages/pip (python 3.x)`  |
| `pip2`      | `pip2 --version`     | `pip A.B.C from /usr/local/lib/python2.x/site-packages/pip (python 2.x)`  |
| `pip`       | `pip --version`      | `pip A.B.C from /usr/local/lib/python2.x/site-packages/pip (python 2.x)`  |


| Executable  | Command              | Expected Output |
| ---------   | -------------------- | --------------- |
| `python3`   | `which python3`      | `/usr/local/bin/python3`  | 
| `python2`   | `which python2`      | `/usr/local/bin/python2`  |
| `python`    | `which python`       | `/usr/local/bin/python`   |
| `pip3`      | `which pip3`         | `/usr/local/bin/pip3`     |
| `pip2`      | `which pip2`         | `/usr/local/bin/pip2`     |
| `pip`       | `which pip`          | `/usr/local/bin/pip`     |


You can additionally verify that `python` and `python2` binary files in `/usr/local`
are both symbolic links that link to the same executable:

```bash
$ readlink /usr/local/bin/python
../Cellar/python@2/2.7.16/bin/python
$ readlink /usr/local/bin/python2
../Cellar/python@2/2.7.16/bin/python
```

### anaconda

**Note:** Anaconda was installed via Homebrew in an earlier step. The instructions below assume
the `anaconda` cask is installed.

### jupyter notebook

**Note:** Jupyter notebook was installed via anaconda distribution in an earlier step.

Add alias:
```
alias pynb="jupyter notebook"  
```

## 8. Java and Scala

**Note:** Java was installed via Homebrew in an earlier step. The instructions
below assume the `java7`, `java8`, `sbt`, `scala` formulae were installed.

Optional: Bash functions for changing the JDK version by adding the functions
in `set_jdk.sh` to a startup script (like .bash_profile).


## 9. Haskell

```
$ brew cask install haskell-platform  # all-in-one haskell environment: ghci, cabal, ...
$ runhaskell foo.hs
$ ghci
```

## 10. Rust

- Installing [rustup](https://www.rust-lang.org/tools/install)

```
curl https://sh.rustup.rs -sSf | sh
```

## 11. Cloud and Containerization

- Download docker for OSX
- Install [AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- Install [Google Cloud SDK](https://cloud.google.com/sdk/install)


## 12. Chrome
- Sign into developer Google Account and sync bookmarks and extensions.
- Or:
  - Import Bookmarks
  - Settings > Show Home Button
  - Install extensions


## License

MIT

