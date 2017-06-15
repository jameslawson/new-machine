# oh-my-zsh
# -----------------------

# Required for zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
SEGMENT_SEPARATOR=''

# zsh plugins
plugins=(git rails ruby rvm virtualenv)

# Required for zsh
source $ZSH/oh-my-zsh.sh

source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# https://github.com/robbyrussell/oh-my-zsh/issues/449
# unsetopt nomatch

# PATH
# -----------------------
# export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/texbin:/Library/Frameworks/Python.framework/Versions/2.6/bin"



# Homebrew
# -----------------------
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

# Java
# --------------------
export JUNIT_HOME="$HOME/java"
export PATH="$PATH:$JUNIT_HOME"
export CLASSPATH="$CLASSPATH:$JUNIT_HOME/junit-4.11.jar:$JUNIT_HOME/hamcrest-core-1.3.jar"
export JAVA_HOME=$(/usr/libexec/java_home)

# Haskell
# --------------------
export PATH="$PATH:$HOME/Library/Haskell/bin"
# http://stackoverflow.com/a/19736802
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Vim
# --------------------
export EDITOR='vim'

# Latex
# ------
LIBGS=/usr/local/Cellar/ghostscript/9.16/lib/libgs.9.16.dylib


# Vim for command line editing
# usr/local/bin/vim has +clipboard
# http://vimcasts.org/blog/2013/11/getting-vim-with-clipboard-support/
# alias vim='/usr/local/bin/vim'
# also we need -ixon to get ctrl+enter to work in vim
# http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt
stty -ixon -ixoff

alias vim="stty stop '' -ixon ; /usr/local/bin/vim"
ttyctl -f

# bash vi editing mode
# ---------------------------------
set -o vi
bindkey -v
bindkey -M viins ';;' vi-cmd-mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey ',,' history-incremental-search-backward

# Ruby + Ruby on Rails
# ---------------------------------

# adding rmv to path! should this be here??!
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# export GUARD_GEM_SILENCE_DEPRECATIONS='1'

# added by travis gem
[ -f /Users/james/.travis/travis.sh ] && source /Users/james/.travis/travis.sh

# from https://github.com/jferris/dotfiles/blob/master/aliases.local
alias migrate="rake db:migrate db:test:prepare"
alias remigrate="rake db:migrate && rake db:rollback && rake db:migrate && rake db:test:prepare"

export NVM_DIR="/Users/james/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
