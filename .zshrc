# -- use sed to delete all the lines in git branch's output that dont start with a asterix (*)
#    then take result and regex capture the text after the *, and then only print this text
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# -- change prompt
#    source: https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
#    expansion symbols: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
#    term-256 colors: https://robotmoon.com/256-colors/
PROMPT='%F{240}[%f %F{126}%*%f %F{240}]%f %B%F{70}%1~%f%b '

alias internal="cd /Users/james/github/jameslawson/internal"

chmod u+x /Users/james/github/jameslawson/internal/packages/principal-ideal-tool/build/index.js
alias pit="/Users/james/github/jameslawson/internal/packages/principal-ideal-tool/build/index.js"

chmod u+x /Users/james/github/jameslawson/internal/packages/principal-ideal-tool/build/pitx.js
alias pitx="/Users/james/github/jameslawson/internal/packages/principal-ideal-tool/build/pitx.js"


alias l="ls -lahGFh"
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export PATH="/usr/local/sbin:$PATH"

# alias vi="nvim"
# alias vim="nvim"
alias vi='/usr/local/bin/nvim'
alias vim='/usr/local/bin/nvim'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/python@3.10/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/james/code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/james/code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/james/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/james/code/google-cloud-sdk/completion.zsh.inc'; fi
