for f in .*;do
    if  [[ $f =~ \.[a-zA-Z0-9]+ ]] && [ -f $f ];then
        ln -s ~/dotfiles/$f ~/$f
    fi
done
