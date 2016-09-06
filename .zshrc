emulate sh -c 'source /etc/profile'

export EDITOR=vim
alias 'v'='vim'
alias 'vi'='vim'
alias py='python3'
alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
alias ll='ls -lh'
alias la='ll -a'
alias lla='ll -a'
alias g='git'
alias e='exit'
alias c='cd'
alias ta='tmux attach'

# grep color
alias grep='grep --color=auto'

function gr {
    grep -rI --exclude-dir={.git,"*vendor/bundle*"} "$@" ./
}

function fin {
    find ./  -name "*$@*" | grep "$@"
}

setopt PRINT_EXIT_VALUE

# history
export HISTFILE=${HOME}/.zsh_hist
export HISTSIZE=2000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# ENGLISH
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# long command
export REPORTTIME=1

# gopath
export GOPATH="${HOME}/.go"
export PATH="$GOPATH/bin:$PATH"

# include path etc
[ -f ~/.zshrc_server ] && source ~/.zshrc_server

# tmux
if [ -z $TMUX ]; then
    if $(tmux has-session); then
       tmux new-session
    else
       tmux
    fi
fi

# vcs_info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git hg #svn bzr
zstyle ':vcs_info:(git):*' formats '
[%F{yellow}%r: %b%f]
'
zstyle ':vcs_info:(git):*' actionformats '
[%F{yellow}%r: %b%f (%F{red}%a%f)]
'
zstyle ':vcs_info:*' formats '
[%s:%F{yellow}%r: %b%f]
'
zstyle ':vcs_info:*' actionformats '
[%s:%F{yellow}%r: %b%f (%F{red}%a%f)]
'

precmd() {vcs_info}

# prompt
PROMPT='${vcs_info_msg_0_}%~ %(!.#.>) '
RPROMPT='[%n@%18>..>%m%>>]'

bindkey -e
# vim-oriented
#bindkey -v
#bindkey '^?' backward-delete-char

# completion commands
autoload -U compinit; compinit

# cd if command not found
setopt auto_cd

# .. ...
alias ...='cd ../..'
alias ....='cd ../../..'

# cd + tab -> directory history
setopt auto_pushd
setopt pushd_ignore_dups

# extended glob (pattern match)
setopt extended_glob

# when command in history, delete old history
setopt hist_ignore_all_dups

# start with space, not save in history
setopt hist_ignore_space

# completion files
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ctrl-w -> delete until '/'
# treat these words as normal chalacters
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## suppress overlapping
typeset -U PATH

# ls color
alias ls='ls --color=auto'
eval `dircolors ~/.zsh/dircolors-solarized/dircolors.256dark`
if [ -n "$LS_COLORS" ]; then
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# command color
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
