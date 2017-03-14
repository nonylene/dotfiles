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
au FileType python,java,scala,groovy
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

"pastemode
set pastetoggle=<C-p>

"補完設定
set wildmode=longest,list,full

" keymap
" esc to c-f
inoremap <C-f> <Esc>
" remove highlights
nnoremap <Esc><Esc> <C-u>:noh<CR>

" brackets and quotes
" inoremap { {}<Left>
" inoremap [ []<Left>
" inoremap <SID>parenthese ()<Esc>i
" cnoremap <SID>parenthese (
" inoremap <SID>double_quote ""<Left>
" cnoremap <SID>double_quote "
" inoremap <SID>single_quote ''<Left>
" cnoremap <SID>single_quote '

"1とかの入れ替え
noremap! 1 !
" noremap! <script> 2 <SID>double_quote
imap 2 <Plug>delimitMate"
cnoremap 2 "
noremap! 3 #
noremap! 4 $
noremap! 5 %
noremap! 6 &
" noremap! <script> 7 <SID>single_quote
" noremap! <script> 8 <SID>parenthese
imap 7 <Plug>delimitMate'
imap 8 <Plug>delimitMate(
imap 9 <Plug>delimitMate)
cnoremap 7 '
cnoremap 8 (
cnoremap 9 )
noremap! ! 1
noremap! " 2
noremap! # 3
noremap! $ 4
noremap! % 5
noremap! & 6
noremap! ' 7
noremap! ( 8
noremap! ) 9

" plug
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'Raimondi/delimitMate'
Plug 'croaker/mustang-vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-cursorword'
Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
if has('lua')
  " shoud be running on main machine
  Plug 'Shougo/neocomplete'
  Plug 'Shougo/unite.vim'
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
endif
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

filetype plugin indent on

"neocomplete
if has('lua')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 2
  let g:neocomplcache_min_syntax_length = 3
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  " unite
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable =1
  " unite prefix
  nmap <C-u> [unite]
  nnoremap <silent> [unite]f :<C-u>call UniteFileRec()<CR>
  nnoremap <silent> [unite]g :<C-u>call UniteGrep()<CR>
  nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>

  function UniteFileRec()
    if fugitive#extract_git_dir('.') !=# ''
      Unite file_rec/git
    else
      Unite file_rec/async
    endif
  endfunction

  function UniteGrep()
    if fugitive#extract_git_dir('.') !=# ''
      Unite grep/git
    else
      Unite grep
    endif
  endfunction
endif

"gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_column_always = 1

" lightline
let g:lightline = {
      \ 'component': {
      \   'readonly': '%{&readonly?"ro":""}',
      \   'total_lines': '%L',
      \ },
      \ 'component_function': {
      \   'git_path': 'GitRelativePath',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'git_path' ], [] ],
      \   'right': [ [], [], [ 'fileformat', 'fileencoding', 'filetype', 'total_lines' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [], [ 'git_path' ], [] ],
      \   'right': [ [], [], [ 'fileformat', 'fileencoding', 'filetype', 'total_lines' ] ],
      \ },
      \}

function! GitRelativePath()
  try
    let git_work_tree = fugitive#repo().tree()
    let rel_path = substitute(expand('%:p'), l:git_work_tree.'/', "G:", "")
  catch
    let rel_path = expand('%:~')
  endtry

  let max_len = winwidth(0) - 40
  if strlen(rel_path) > max_len
    return '<'.rel_path[-max_len:]
  else
    return rel_path
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
let g:molokai_original = 1
let g:rehash256 = 1

syntax enable

hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
