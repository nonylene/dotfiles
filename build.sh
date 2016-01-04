#!/usr/bin/env bash

cd `dirname $0`

for f in .*;do
    if  [[ $f =~ \.[a-zA-Z0-9]+ ]] && [ -f $f ];then
        ln -s ~/dotfiles/$f ~/$f
    fi
done

if [ ! -e ~/.vim/bundle ];then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    echo "Please :NeoBundleInstall on vim!"
fi

if [ ! -e ~/.zsh ];then
    mkdir ~/.zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
    git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
fi
