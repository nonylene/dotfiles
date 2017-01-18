set nocompatible
set encoding=utf-8
set nobackup
set number
set title
"backspace
set backspace=start,eol,indent
" indent when wrap
"set breakindent
"mouse
set mouse=a
"no preview
set completeopt=menuone

"選択行を強調する
set cursorline

"括弧の対応
set showmatch

"--------tab--------
"tabをspaceにするなど
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"tab空白表示
set list
set listchars=tab:>-,trail:_

"自動インデント
set autoindent
set cindent

"file分け
au BufNewFile,BufRead *.css set expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.php set expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.html set expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.md set expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.js set expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.yml set expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.rb set expandtab tabstop=2 shiftwidth=2 softtabstop=2

"-------Search--------
"インクリメンタルサーチを有効にする
set incsearch
"大文字小文字を区別しない
set ignorecase
"大文字で検索されたら対象を大文字限定にする
set smartcase
"行末まで検索したら行頭に戻る
set wrapscan
"検索をハイライト
set hlsearch

"scrollを快適にする-これを使うと長押しがうまく見れなくなる
"set lazyredraw

"検索やコマンドの履歴
set history=50

"pastemode
set pastetoggle=<C-p>

"補完設定
set wildmode=longest,list,full

" keymap
" esc to c-f
inoremap <C-f> <Esc>
" remove highlights
nnoremap <Esc> :noh<CR>

" brackets
inoremap { {}<Left>
" inoremap <SID>Bracket {}<Left>
inoremap <SID>Parenthese ()<Left>
cnoremap <SID>Parenthese (

"1とかの入れ替え
noremap! 1 !
noremap! 2 "
noremap! 3 #
noremap! 4 $
noremap! 5 %
noremap! 6 &
noremap! 7 '
noremap! <script> 8 <SID>Parenthese
noremap! 9 )
noremap! ! 1
noremap! " 2
noremap! # 3
noremap! $ 4
noremap! % 5
noremap! & 6
noremap! ' 7
noremap! ( 8
noremap! ) 9

"tenkeyの設定
noremap <Esc>Oq 1
noremap <Esc>Or 2
noremap <Esc>Os 3
noremap <Esc>Ot 4
noremap <Esc>Ou 5
noremap <Esc>Ov 6
noremap <Esc>Ow 7
noremap <Esc>Ox 8
noremap <Esc>Oy 9
noremap <Esc>Op 0
noremap <Esc>On .
noremap <Esc>OQ /
noremap <Esc>OR *
noremap <Esc>Ol +
noremap <Esc>OS -
noremap <Esc>OM <Enter>
noremap! <Esc>Oq 1
noremap! <Esc>Or 2
noremap! <Esc>Os 3
noremap! <Esc>Ot 4
noremap! <Esc>Ou 5
noremap! <Esc>Ov 6
noremap! <Esc>Ow 7
noremap! <Esc>Ox 8
noremap! <Esc>Oy 9
noremap! <Esc>Op 0
noremap! <Esc>On .
noremap! <Esc>OQ /
noremap! <Esc>OR *
noremap! <Esc>Ol +
noremap! <Esc>OS -
noremap! <Esc>OM <Enter>

"カッコやクオートなどを入力した際に左に自動で移動
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>
"inoremap "" ""<Left>
"inoremap '' ''<Left>
"inoremap <> <><Left>

" dein
let dein_base_dir = $HOME."/.vim/dein"
let dein_repo_dir = dein_base_dir."/repos/github.com/Shougo/dein.vim"

" append dein_repo_dir
" use exe to evaluate variable
exe "set runtimepath+=".dein_repo_dir

"filetype off called automatically
call dein#begin(dein_base_dir)

call dein#add(dein_base_dir)
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/unite.vim')
call dein#add('tomasr/molokai')
call dein#add('croaker/mustang-vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('itchyny/vim-cursorword')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-fugitive')

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

unlet dein_repo_dir

"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 2
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_column_always = 1

"colorscheme
colorscheme molokai
if &term =~ "xterm-256color" || "screen-256color"
    set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dm
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif
let g:molokai_original = 1
let g:rehash256 = 1

syntax enable

hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
