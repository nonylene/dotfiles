#!/usr/bin/env bash

cd `dirname $0`

# include dot files in glob ("*")
# .. and . is not included with "*"
shopt -s dotglob

# link file or dig new dir
function link_file_or_recur() {
    for f in $1/*; do
        if [[ $f != *.swp ]]; then
            if [[ -f $f && ! -f ~/$f ]]; then
              ln -s ~/dotfiles/$f ~/$f
            fi
            if [ -d $f ]; then
              if [ ! -d ~/$f ]; then mkdir ~/$f; fi
              link_file_or_recur $f
            fi
        fi
    done
}

# dot files or directory only
for f in .[!.]*; do
    if [[ $f != .git ]] && [[ $f != *.swp  ]]; then
        if [[ -f $f && ! -L ~/$f ]]; then
          ln -s ~/dotfiles/$f ~/$f
        fi
        if [ -d $f ]; then
          if [ ! -d ~/$f ]; then mkdir ~/$f; fi
          link_file_or_recur $f
        fi
    fi
done

# local configs
function touch_unless_exists() {
  if [ ! -f ~/$1 ];then
      touch ~/$1
  fi
}

function cp_local_unless_exists() {
  if [ ! -f ~/$1 ];then
    cp locals/$1 ~/$1
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


cp_local_unless_exists '.zshrc_local'
cp_local_unless_exists '.config/git/config_local'
cp_local_unless_exists '.tmux.conf_local'

touch_unless_exists '.bashrc_local'

remove_if_exists '.xvimrc'
remove_if_exists '.gitconfig'
remove_if_exists '.gitignore'
remove_if_exists '.githooks/post-commit'
remove_if_exists '.githooks/pre-commit'
remove_if_exists '.config/redshift.conf'
remove_if_exists '.tigrc'

warn_if_exists '.gitconfig_local'
warn_if_exists '.githooks'

# vim
plug_file="$HOME/.vim/autoload/plug.vim"
if [ ! -f $plug_file ];then
  curl -Lo $plug_file --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# zsh
if [ ! -e ~/.zsh ];then
    mkdir ~/.zsh/site-functions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
    git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
    git clone https://github.com/jimhester/per-directory-history.git ~/.zsh/per-directory-history
fi
