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

# -- homebrew
#    force bash to search Homebrew's /usr/local/sbin before the usual /usr/sbin
export PATH="/usr/local/sbin:$PATH"

# -- enable/disable macbook laptop keyboard
#    (useful for disabling broken keyboards)
alias kboff="sudo kextunload /system/library/extensions/appleusbtopcase.kext/contents/plugins/appleusbtckeyboard.kext/"
alias kbon="sudo kextload /system/library/extensions/appleusbtopcase.kext/contents/plugins/appleusbtckeyboard.kext/"
