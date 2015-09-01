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
