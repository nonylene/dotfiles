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

# vscode
case `uname` in
  'Darwin')
    VSCODE_DIR="$HOME/Library/Application Support/Code/User"
    ;;
  'Linux')
    VSCODE_DIR="$HOME/.config/Code/User"
    ;;
esac

if [[ -n $VSCODE_DIR ]]; then
  for f in 'keybindings.json' 'settings.json'; do
    file="$VSCODE_DIR/$f"
    if [[ ! -L "$file" ]]; then
      ln -s ~/dotfiles/vscode/$f "$file"
    fi
  done
fi

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

cp_local_unless_exists '.zshrc_local'
cp_local_unless_exists '.gitconfig_local'
cp_local_unless_exists '.tmux.conf_local'

touch_unless_exists '.bashrc_local'

if [ -L "$HOME/.xvimrc" ];then
  echo -e "\033[1;31mRemoving ~/.xvimrc\033[0m"
  rm -rf "$HOME/.xvimrc"
fi


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
