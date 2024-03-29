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

" 上下3行
set scrolloff=3

" always show status bar
set laststatus=2
" remove vim mode information
set noshowmode

"括弧の対応
set showmatch

"--------tab--------
"tabをspaceにするなど
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
"tab空白表示
set list
set listchars=tab:>-,trail:_

"自動インデント
set autoindent
set cindent

" Change tabwidth by file type
" kotlin is not included (not supported by default)
au FileType java,scala,groovy
  \ setlocal tabstop=4 shiftwidth=4 softtabstop=4

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

"補完設定
set wildmode=longest,list,full

set pastetoggle=<C-k>

" keymap
" emacs / bash
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <C-RIGHT>
inoremap <C-b> <C-LEFT>
" remove highlights
nnoremap <Esc><Esc> <C-u>:noh<CR>


if has('patch-7.4-786')
  augroup local
    au!
    au OptionSet paste call lightline#update()
  augroup END
endif

map <C-k> <Plug>KeyMapRotate
map! <C-k> <Plug>KeyMapRotate

" Disable increment / decrement
map <C-a> <Nop>
map <C-x> <Nop>

" plug
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-cursorword'
Plug 'tomtom/tcomment_vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'nonylene/vim-keymaps'
if v:version > 702
  Plug 'itchyny/lightline.vim'
endif
if has('lua')
  " shoud be running on main machine
  Plug 'Shougo/neocomplete'
endif
call plug#end()


" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 2
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

filetype plugin indent on

"gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" keymaps
let g:keymaps =  [
      \  {
      \    'name': 'JP',
      \    'keymap': {
      \      'noremap!': {
      \        '1': '!',
      \        '3': '#',
      \        '4': '$',
      \        '5': '%',
      \        '6': '&',
      \        '!': '1',
      \        '"': '2',
      \        '#': '3',
      \        '$': '4',
      \        '%': '5',
      \        '&': '6',
      \        "'": '7',
      \        '(': '8',
      \        ')': '9',
      \      },
      \      'imap': {
      \        '2': '<Plug>delimitMate"',
      \        '7': "<Plug>delimitMate'",
      \        '8': '<Plug>delimitMate(',
      \        '9': '<Plug>delimitMate)',
      \      },
      \      'cnoremap': {
      \        '2': '"',
      \        '7': "'",
      \        '8': '(',
      \        '9': ')',
      \      },
      \    },
      \  },
      \  {
      \    'name': 'PASTE',
      \    'paste': 1
      \  },
      \]

 " lightline
let g:lightline = {
      \ 'component': {
      \   'total_lines': '%L',
      \ },
      \ 'component_function': {
      \   'git_path': 'GitRelativePath',
      \   'keymap': 'keymaps#get_current_keymap_name',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'keymap' ], [ 'git_path' ], [] ],
      \   'right': [ [], [], [ 'fileformat', 'fileencoding', 'filetype', 'total_lines' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [], [ 'git_path' ], [] ],
      \   'right': [ [], [], [ 'fileformat', 'fileencoding', 'filetype', 'total_lines' ] ],
      \ },
      \}

function! GitRelativePath()
  let head = &modified ? '* ' : (&modifiable && !&readonly)? '' : '- '

  try
    " TODO
    let git_work_tree = fugitive#repo().tree()
    let rel_path = substitute(expand('%:p'), l:git_work_tree.'/', "G:", "")
  catch
    let rel_path = expand('%:~')
  endtry


  let max_len = winwidth(0) - 45 - strlen(head)
  if strlen(rel_path) > max_len
    return head.'<'.rel_path[-max_len:]
  else
    return head.rel_path
  endif
endfunction

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
let g:rehash256 = 1

syntax enable

hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
