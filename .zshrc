# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# suppress overlapping
typeset -U PATH

emulate sh -c 'source /etc/profile'

export EDITOR=vim
# i : ignore case
# M : long prompt
# R : colorize
# X : do not clear screen
# F : quit if text is less than one screen
export LESS='-iMRXF'
export PAGER=less
alias 'v'='vim'
alias 'vi'='vim'
alias py='python3'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ll -a'
alias g='git'
alias e='exit'
alias c='cat'
alias b='bundle'
alias ta='tmux attach'

setopt PRINT_EXIT_VALUE

# history
export HISTFILE=${HOME}/.zsh_hist
export HISTSIZE=3000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt inc_append_history
setopt EXTENDED_HISTORY

# long command
export REPORTTIME=1

# ENGLISH
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# grep color
alias grep='grep --color=auto'

function gr {
    grep -rI --exclude-dir={.git,vendor} "$@" ./
}

function fin {
    find ./  -name "*$@*" | grep "$@"
}

export PATH="$HOME/local/bin:$PATH"

# gopath
export GOPATH="${HOME}/.go"
export PATH="$GOPATH/bin:$PATH"

# ls color
alias ls='ls --color=auto'
eval `dircolors ~/.zsh/dircolors-solarized/dircolors.256dark`

# .. ...
alias ...='cd ../..'
alias ....='cd ../../..'

# vcs_info
autoload -Uz vcs_info
setopt prompt_subst

local tput_normal=$(tput sgr0)
local tput_yellow=$(tput setaf 3)
local tput_red=$(tput setaf 1)
local tput_cyan=$(tput setaf 6)

zstyle ':vcs_info:*' enable git hg #svn bzr
zstyle ':vcs_info:(git):*' formats "[${tput_yellow}%r: %b${tput_normal}]"
zstyle ':vcs_info:(git):*' actionformats "[${tput_yellow}%r: %b${tput_normal} (${tput_red}%a${tput_normal})]"
zstyle ':vcs_info:*' formats "[%s:${tput_yellow}%r: %b${tput_normal}]"
zstyle ':vcs_info:*' actionformats "[%s:${tput_yellow}%r: %b${tput_normal} (${tput_red}%a${tput_normal})]"
zstyle ':vcs_info:*+set-message:*' hooks vcs_info_hook
zstyle ':vcs_info:*+no-vcs:*' hooks no_vcs_hook

local noaction_color_len=$((${#tput_yellow} + ${#tput_cyan} + 2 * ${#tput_normal}))
local action_color_len=$((${#tput_yellow} + ${#tput_cyan} + 2 * ${#tput_normal}))
local novcs_color_len=$((${#tput_cyan} + ${#tput_normal}))

function +vi-vcs_info_hook() {
  if [ -z ${hook_com[action]} ]; then
    # no action
    prompt_color_len=$noaction_color_len
  else
    prompt_color_len=$action_color_len
  fi
}

function +vi-no_vcs_hook() {
  prompt_color_len=$novcs_color_len
}

precmd() {
  vcs_info
  prompt_left="${tput_cyan}${USER}@${HOST}${tput_normal}"
  printf "\n%b%*b\n" "$prompt_left" "$((${COLUMNS}-${#prompt_left}+${prompt_color_len}))" "${vcs_info_msg_0_}"
}

# prompt
PROMPT='%~ %(!. !root! #.>) '

bindkey -e

# completion commands
autoload -U compinit; compinit

# cd if command not found
setopt auto_cd

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

if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# tmux
if [ -z $TMUX ]; then
    if $(tmux has-session); then
       tmux new-session
    else
       tmux
    fi
fi

# command color
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# include path etc
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
