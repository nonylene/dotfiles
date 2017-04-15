#!/usr/bin/env bash

cd `dirname $0`

# include dot files in glob ("*")
# .. and . is not included with "*"
shopt -s dotglob

function link_file_or_reccur() {
    for f in $1/*; do
        if [[ $f != *.swp ]]; then
            if [[ -f $f && ! -f ~/$f ]]; then
              ln -s ~/dotfiles/$f ~/$f
            fi
            if [ -d $f ]; then
              if [ ! -d ~/$f ]; then mkdir ~/$f; fi
              link_file_or_reccur $f
            fi
        fi
    done
}

# dot files or directory only
for f in .[!.]*; do
    if [[ $f != .git ]] && [[ $f != *.swp  ]]; then
        if [[ -f $f && ! -f ~/$f ]]; then
          ln -s ~/dotfiles/$f ~/$f
        fi
        if [ -d $f ]; then
          if [ ! -d ~/$f ]; then mkdir ~/$f; fi
          link_file_or_reccur $f
        fi
    fi
done

if [ ! -f ~/.zshrc_local ];then
  echo -e "# vim: filetype=zsh\n" > ~/.zshrc_local
  if [ -f ~/.zshrc_server ]; then
    cat ~/.zshrc_server >> ~/.zshrc_local
    echo "please remove ~/.zshrc_server"
  fi
fi

function touch_unless_exists() {
  if [ ! -f ~/$1 ];then
      touch ~/$1
  fi
}

touch_unless_exists '.zshrc_local'
touch_unless_exists '.bashrc_local'
touch_unless_exists '.tmux-server.conf'

plug_file="$HOME/.vim/autoload/plug.vim"
if [ ! -f $plug_file ];then
  curl -Lo $plug_file --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -e ~/.zsh ];then
    mkdir ~/.zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
    git clone https://github.com/seebi/dircolors-solarized ~/.zsh/dircolors-solarized
    git clone https://github.com/jimhester/per-directory-history.git ~/.zsh/per-directory-history
fi
