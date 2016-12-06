#!/usr/bin/env bash

cd `dirname $0`

# include dot files in glob ("*")
# .. and . is not included with "*"
shopt -s dotglob

function link_file_or_reccur() {
    for f in $1/*; do
        if [[ $f != *.swp ]]; then
            if [ -f $f ]; then ln -s ~/dotfiles/$f ~/$f; fi
            if [ -d $f ]; then mkdir ~/$f; link_file_or_reccur $f; fi
        fi
    done
}

# dot files or directory only
for f in .[!.]*; do
    if [[ $f != .git ]] && [[ $f != *.swp  ]]; then
        if [ -f $f ]; then ln -s ~/dotfiles/$f ~/$f; fi
        if [ -d $f ]; then mkdir ~/$f; link_file_or_reccur $f; fi
    fi
done

if [ ! -f ~/.zshrc_server ];then
    touch ~/.zshrc_server
fi

if [ ! -f ~/.tmux-server.conf ];then
    touch ~/.tmux-server.conf
fi

dein_dir="$HOME/.vim/dein/repos/github.com/Shougo/dein.vim"
if [ ! -e $dein_dir ];then
    mkdir -p $dein_dir
    git clone https://github.com/Shougo/dein.vim $dein_dir
fi

if [ ! -e ~/.zsh ];then
    mkdir ~/.zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
    git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
fi
