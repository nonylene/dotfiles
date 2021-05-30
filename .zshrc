# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Disable ctrl-s to pause
stty -ixon

# suppress overlapping
typeset -gU PATH path
typeset -gU fpath
typeset -gU LD_LIBRARY_PATH

emulate sh -c 'source /etc/profile'

terminfo_dirs=("/usr/share/terminfo" "/lib/terminfo" "/etc/terminfo")

for d in $terminfo_dirs; do
  if [[ -d $d && -z $(find $d -name 'screen-256color') ]]; then
    export TERM='xterm-256color'
  fi
done

autoload -Uz zmv
alias mmv='noglob zmv -W'

export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
# i : ignore case
# M : long prompt
# R : colorize
# X : do not clear screen
# F : quit if text is less than one screen
export LESS='-iMRXF'
export PAGER=less
alias 'v'='vim'
alias py='python3'
alias ipy='ipython3'
alias ll='ls -lh'
alias la='ls -A'
alias lla='ll -A'
alias g='git'
alias gdiff='git diff --no-index'
alias c='cat'
alias l='less'
alias b='bundle'
alias ta='tmux attach'

setopt PRINT_EXIT_VALUE

export PIPENV_VENV_IN_PROJECT=1

# history
export HISTFILE=${HOME}/.zsh_hist
export HISTSIZE=4000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt inc_append_history
setopt EXTENDED_HISTORY
setopt hist_reduce_blanks

# long command
export REPORTTIME=1

# ENGLISH
export LANG=en_US.UTF-8
export LC_ALL=${LANG}
export LC_CTYPE=ja_JP.UTF-8
export LC_COLLATE=ja_JP.UTF-8

# grep color
alias grep='grep --color=auto'

function gr {
  grep -rI --exclude-dir={.git,vendor,.venv} "$@" ./
}

function fin {
  find ./  -name "*$@*" | grep "$@"
}

function dotfiles {
  (cd ~/dotfiles; git pull origin master; ./deploy.sh)
  source ~/.zshrc
}

export PATH="$HOME/local/bin:$HOME/.local/bin::$PATH"

# gopath
export GOPATH="${HOME}/go"
export PATH="$GOPATH/bin:$PATH"

# include path etc
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# completion
autoload -U compinit; compinit

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:processes' menu yes select=1
zstyle ':completion:*' use-cache true

# ls color
alias ls='ls --color=auto'
eval `dircolors ~/.zsh/dircolors-solarized/dircolors.256dark`

# .. ...
alias ...='cd ../..'
alias ....='cd ../../..'

# vcs_info
autoload -Uz vcs_info
setopt prompt_subst

tput_normal=$(tput sgr0)
tput_yellow=$(tput setaf 3)
tput_red=$(tput setaf 1)
tput_cyan=$(tput setaf 6)

zstyle ':vcs_info:*' enable git hg #svn bzr
zstyle ':vcs_info:(git):*' formats "[${tput_yellow}%r: %b${tput_normal}]"
zstyle ':vcs_info:(git):*' actionformats "[${tput_yellow}%r: %b${tput_normal} (${tput_red}%a${tput_normal})]"
zstyle ':vcs_info:*' formats "[%s:${tput_yellow}%r: %b${tput_normal}]"
zstyle ':vcs_info:*' actionformats "[%s:${tput_yellow}%r: %b${tput_normal} (${tput_red}%a${tput_normal})]"
zstyle ':vcs_info:*+set-message:*' hooks vcs_info_hook
zstyle ':vcs_info:*+no-vcs:*' hooks no_vcs_hook

novcs_color_len=$((${#tput_cyan} + ${#tput_normal}))
noaction_color_len=$((${novcs_color_len} + ${#tput_yellow} + ${#tput_normal}))
action_color_len=$((${noaction_color_len} + ${#tput_red} + ${#tput_normal}))

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

function generate_promopt_header() {
  prompt_header=$(printf "\n%s%*s" "$prompt_left" \
    "$((${COLUMNS}-${#prompt_left}+${prompt_color_len}-1))" \
    "${vcs_info_msg_0_}")
}

precmd() {
  vcs_info
  prompt_left="${tput_cyan}${USER}@${HOST}${tput_normal}"
  generate_promopt_header
}

TRAPWINCH() {
  generate_promopt_header
  zle reset-prompt
}

# prompt
PROMPT='${prompt_header}
%~ %(!. !root! #.>) '

bindkey -M emacs "^F" forward-word
bindkey -M emacs "^B" backward-word
bindkey -e

fpath=($HOME/.zsh/site-functions $fpath)

# use []^ etc.
setopt no_nomatch

# cd if command not found
setopt auto_cd

# extended glob (pattern match)
setopt extended_glob

# when command in history, delete old history
setopt hist_ignore_all_dups

# start with space, not save in history
setopt hist_ignore_space

# ctrl-w -> delete until '/'
# treat these words as normal chalacters
WORDCHARS='*?_-[]~&;!#$%^(){}<>'

if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# tmux
# You can set $launch_tmux to false
if [[ -z $launch_tmux ]]; then
  case "$OSTYPE" in
    darwin*)
      # do not launch tmux without iTerm2
      [ "$TERM_PROGRAM" = 'iTerm.app' ] && launch_tmux=true
      ;;
    linux*)
      # do not launch tmux without iTerm2
      [ "$TERM_PROGRAM" != 'vscode' ] && launch_tmux=true
      ;;
    *)
      # without mac!
      launch_tmux=true
      ;;
  esac
fi

if [[ $launch_tmux == true && -z $TMUX ]]; then
  if $(tmux has-session); then
    tmux new-session
  else
    tmux
  fi
fi

# command color
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# use per directory history!
export PER_DIRECTORY_HISTORY_TOGGLE='^H'
source ~/.zsh/per-directory-history/per-directory-history.zsh

# ghq-cd
## https://github.com/motemen/ghq/issues/268#issuecomment-573403493
function ghq-cd {
    if [ -n "$1" ]; then
        dir="$(ghq list --full-path --exact "$1")"
        if [ -z "$dir" ]; then
            echo "No directroies found for '$1'"
            return 1
        fi
        cd "$dir"
        return
    fi

    echo 'Usage: ghq-cd {repo}'
    return 1
}

## https://github.com/motemen/ghq/blob/3981090302a12b29c0c96736fc0aafe5a83a109d/misc/zsh/_ghq#L63-L67
function _ghq-cd {
  local -a _repos
  _repos=( ${(@f)"$(_call_program repositories ghq list --unique)"} )
  _describe -t repositories Repositories _repos
}

compdef _ghq-cd ghq-cd

# mv with directory_history
function gmv {
  path1=`realpath $1`
  path2=`realpath $2`
  mv $path1 $path2
  mv $HOME/.directory_history/$path1 $HOME/.directory_history/$path2
}
