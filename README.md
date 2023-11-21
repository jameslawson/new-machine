<h1 align="center">new-machine</h1>
<p align="center">
  :computer: Setting up a new macOS machine :computer: <br>
  Most of the work needed to get a developer environment setup on macOS
</p>

Prerequisites:
- macOS 10.14.6+ with Admin User
- Set up your proxy `$HTTP_PROXY`, `$HTTPS_PROXY` if needed


## 1. Essentials

- **Xcode**
  Accept the Xcode Licence Agreement and install Xcode:
  ```
  sudo xcodebuild -license
  xcode-select --install
  ``` 
- **SSH Keys**: For updating existing machines copy `.bash_profile`, `.ssh/`, certificates, any other non-public files from
  the filesystem to the new filesystem.
  For new machines, [create a new SSH Key](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh). This should include your **GitHub SSH key**.
  ```
  ssh-keygen -t rsa -b 4096 -C "mail@jameslawson.io"
  chmod 400 ~/.ssh/id_rsa
  ssh-add -K
  ```
  The above chmod .ssh makes sure the keys are not [too open](https://stackoverflow.com/a/9270753).
  The ssh-add adds the private key to the ssh agent, so it doesn't keep asking for the private key over again.    
  Also add the following to `~/.ssh/config` to [automatically load keys](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent) to the agent.
  ```
  Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_rsa
  ```
  Then add the [public key](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account) to your account.
  
- **Mouse and Keyboard**
  - Change the trackpad direction
  - Increase the [keyboard repeat rate](https://apple.stackexchange.com/a/83923)
    ```
    defaults write -g InitialKeyRepeat -int 10
    defaults write -g KeyRepeat -int 1
    ```
- Setup **directories**:
  ```
  mkdir -p github/jameslawson
  ```
- **Clone the dotfiles repo**:
  ```
  cd ~/github
  git clone git@github.com:jameslawson/dotfiles.git
  ```
  
- Create **dotfiles** create symlinks for .vimrc, .tmux, Brewfile, ...:
  ```
  cd ~/github/dotfiles
  ./create-softlinks.sh
  ```
  
  
To install [Homebrew](https://brew.sh/) and the Homebrew formulas:

- **Homebrew**: Run the following at a command-prompt:
    ```bash
    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```
    
    Optional: Verify the installation has modified your PATH correctly. Output the `$PATH` environment variable:
    ```bash
    $ echo $PATH
    ```
    and confirm the following:
    1. `/usr/local/bin` comes before `/usr/bin` in the output
    2. `/usr/local/sbin/` comes before `/usr/sbin` in the output
    If any of the above are not true, then you'll need to [update your PATH](https://stackoverflow.com/questions/10343834/how-to-modify-path-for-homebrew) by either changing the `$PATH` environment variable in a startup file like `.bash_profile`
    or by changing the order of paths in `/etc/paths`.     
    
     **Note**: `/usr/local/bin` is the default directories where Homebrew places executables upon 
     the installation of Formulas. We must ensure that our [UNIX path search](https://tiswww.case.edu/php/chet/bash/bashref.html#Command-Search-and-Execution-1) is configured
     so that these directories are searched before the standard macOS directories of `/usr/bin` and 
     `/usr/sbin` are searched.

    
    

## 2. git

Install git:
`brew install git`

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
   You can try [running](https://apple.stackexchange.com/a/272220) `brew link --overwrite git`.


## 3. Homebrew Formulas

Install Formulas:
```bash
brew bundle --file ~/Brewfile
```
**Note**: This command reads `~/Brewfile` to install essential tools like vim, git, tree; 
install languages likes Java, Scala; and install macOS apps like Chrome, KeepingYouAwake, Spectable via [Homebrew Cask](http://caskroom.io/).


## 4. Vim (Neovim)

```
brew install neovim
```

### Verify Installation 

1. Check the version of neovim:
   ```
   nvim -version
   ```
   and verify the version is v0.4.3 or above


### Neovim Plugins

To install plugins for Neovim:

1. Download [vim-plug](https://github.com/junegunn/vim-plug/wiki/tutorial) (for Neovim on UNIX):
    ```
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
2. Open Neovim (by running the `nvim` command) and execute the Neovim user command **:PlugInstall** in Normal Mode.
3. Optional: Check Neovim's startup time is below 100ms using: `nvim --startuptime /dev/stdout +qall` 

### Deoplete Dependencies (Autocompletion)

For the `Shougo/deoplete.nvim` plugin (`[DEOP]`), you need to install Python 3 for neovim.

1. Use pip to install the neovim python 3 plugin support:
    ```
    pip3 install --user pynvim
    ```
    **Note:** This step assumes the steps in "7. Python" are complete.
2. Open Neovim (by running the `nvim` command) and execute the Neovim user command **:UpdateRemotePlugins** in Normal Mode.


### FZF Dependencies (Filename fuzzy search, Project-wide Code Search)

For `junegunn/fzf` plugin, you need to install FZF 


You can optionally keep fzf output but override the internal search algorithm to something faster,
and most crucially, something that is smart enough to [respect gitignore](https://github.com/junegunn/fzf#respecting-gitignore), after all, we don't node_module files ultimately appearing in our vim fzf searches.
(popular overrides are [ag ("silver surfer")](https://github.com/ggreer/the_silver_searcher) or [ripgrep](https://github.com/BurntSushi/ripgrep)). Let's use ripgrep.

```
brew install ripgrep
```

Then when running either (:Files for Filename fuzzy search, or :Rg for big-grep search), `junegunn/fzf` will run the
command defined by `$FZF_DEFAULT_COMMAND` environment variable and pipe it into fzf which in turn produces a list inside vim. Add the following to .bash_profile:
  
```
$FZF_DEFAULT_COMMAND=`rg --files --follow --hidden`
```


### bash_profile alias (optional)
 
Add the following alias to `.bash_profile` to redirect vim and vi commands to nvim

```
alias vim="nvim"
alias vi="nvim"
```


## 5. tmux and iTerm

**Note:** tmux and iTerm were installed via Homebrew in an earlier step. The instructions
below assume you have the `tmux` formulae installed and `iterm2` cask installed.

### Verify Installation 

1. Check the version of tmux:
   ```
   tmux -V
   ```
   and verify the version is 3.1b or above.
2. Check the installation path:
   ```
   which tmux
   ```
   and verify the path is `/usr/local/bin/tmux`. 
   
### copy mode
In tmux copy-mode, to copy to macOS clipboard we need to use [reattach-to-user-namespace](https://thoughtbot.com/blog/tmux-copy-paste-on-os-x-a-better-future) or else copying will silently fail. 
```
brew install reattach-to-user-namespace
```

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

### Install nvm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
```
Reopen your terminal after installing nvm (either via above command or via Brewfile).

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

```
brew install pyenv
brew install openssl readline sqlite3 xz zlib
pyenv install 2.7.18
pyenv install 3.8.5
pyenv local 3.8.5
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

