export EDITOR=vim
alias py='python3'
alias glog='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias g='git'

# history
export HISTFILE=${HOME}/.zsh_hist
export HISTSIZE=500
export SAVEHIST=3000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# ENGLISH
export LANG=en_US.UTF-8

# prompt
PROMPT='%d > '
RPROMPT='[%n@%m]'

# vim-oriented
bindkey -v

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

# ctrl-w -> delete until '/'
# treat these words as normal chalacters
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ls color
alias ls='ls --color=auto'
eval `dircolors ~/.zsh/dircolors-solarized/dircolors.256dark`
if [ -n "$LS_COLORS" ]; then
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# command color
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# tmux
if [ -z $TMUX ]; then
    if $(tmux has-session); then
       tmux new-session
    else
       tmux
    fi
fi

# include path etc
[ -f ~/.zshrc_server ] && source ~/.zshrc_server
