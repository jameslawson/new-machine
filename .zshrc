export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="lukerandall"
plugins=(git)
zstyle ':omz:update' frequency 30

# ; -- Begin Manual Config
source ~/.zsh/.zsh-user.sh
# ; -- End Manual Config

# ; -- All config below this line has been added by tools
# ;    running installation scripts. These changes should not be
# ;    committed to GitHub

$FZF_DEFAULT_COMMAND="rg --files --follow --hidden"
