#!/usr/bin/env bash

cd `dirname $0`

# include dot files in glob ("*")
# .. and . is not included with "*"
shopt -s dotglob

# link file or dig new dir
function link_file_or_recur() {
  file=$1
  if [[ $file != .git ]] && [[ $file != *.swp ]]; then
    if [[ -f $file && ! -L ~/$file ]]; then
      ln -s ~/dotfiles/$file ~/$file
    fi
    if [ -d $file ]; then
       if [ ! -d ~/$file ]; then mkdir -m 700 ~/$file; fi
       for ff in $file/*; do
         link_file_or_recur $ff
       done
    fi
  fi
}

# dot files or directory only
for f in .[!.]*; do
  link_file_or_recur $f
done

# local configs
function touch_unless_exists() {
  if [ ! -f ~/$1 ];then
      touch ~/$1
  fi
}

function cp_copied_unless_exists() {
  if [ ! -f ~/$1 ];then
    cp copied/$1 ~/$1
  fi
}

function remove_if_exists() {
  if [[ -L "$HOME/$1" ]];then
    echo -e "\033[1;33mRemoving ~/$1\033[0m"
    rm -rf "$HOME/$1"
  fi
}

function warn_if_exists() {
  if [ -e "$HOME/$1" ];then
    echo -e "\033[1;31m~/$1 is moved. Please migrate.\033[0m"
  fi
}


cp_copied_unless_exists '.zshrc_local'
cp_copied_unless_exists '.config/git/config_local'
cp_copied_unless_exists '.tmux.conf_local'

touch_unless_exists '.bashrc_local'

remove_if_exists '.gitconfig'
remove_if_exists '.gitignore'
remove_if_exists '.githooks/post-commit'
remove_if_exists '.githooks/pre-commit'
remove_if_exists '.tigrc'
remove_if_exists '.config/pypoetry'

warn_if_exists '.gitconfig_local'
warn_if_exists '.githooks'

# Local bin dir
mkdir -m 700 ~/local/bin -p

# vim
plug_file="$HOME/.vim/autoload/plug.vim"
if [ ! -f $plug_file ];then
  curl -Lo $plug_file --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# zsh
if [ ! -e ~/.zsh ];then
    mkdir -m 700 ~/.zsh/site-functions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
    git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
    git clone https://github.com/jimhester/per-directory-history.git ~/.zsh/per-directory-history
fi
