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

alias vim="nvim"
alias vi="nvim"
alias l="ls -lahGFh"
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
