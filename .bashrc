if [ -f /etc/bashrc  ]; then . /etc/bashrc  ;fi
if [ -f /etc/profile ]; then . /etc/profile ;fi

if [ -z $(find /usr/share/terminfo -name 'screen-256color') ]; then
    export TERM='xterm-256color'
fi

# history
export HISTSIZE=3000
export HISTFILESIZE=10000

# ignore dups and space
export HISTCONTROL=ignoreboth
shopt -s histappend

# BASH 4 FEATURES
# **/*.py
shopt -s globstar 2>/dev/null

shopt -s autocd 2>/dev/null
