"Plugin
"プラグインを読み込む場合はここに記述する。
  
  
"Encode
"下記の指定は環境によって文字化けする可能性があるので適宜変更する
set encoding=utf-8 "文字コードをUTF-8にする
"set fileencoding=utf-8 "文字コードをUTF-8にする
set termencoding=utf-8 "文字コードをUTF-8にする
set fileencodings=iso-2022-jp,utf-8,euc-jp,sjis
  
  
"File
set hidden    "ファイル変更中でも他のファイルを開けるようにする
set autoread    "ファイル内容が変更されると自動読み込みする
  
  
"Backup
set backupdir=$HOME/_vim/backup    "バックアップディレクトリを指定する
set browsedir=buffer    "ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set directory=$HOME/_vim/backup,c:\temp    "スワップファイルディレクトリを指定する
set history=1000    "履歴保存数
set undodir=$HOME/_vim/backup 
  
"Search
set noincsearch   "インクリメンタルサーチを行う
set hlsearch    "検索結果をハイライトする
set noignorecase    "検索時に文字の大小を区別しない
set smartcase    "検索時に大文字を含んでいたら大小を区別する
"set wrapscan    "検索をファイルの先頭へループする
set foldmethod=manual
set foldlevel=100 "not fold
  
  
"Input
set noautoindent
"set cindent "C言語のインデントに従って自動インデントを行う
set shiftwidth=4    "行頭での<Tab>の幅
set tabstop=4   "行頭以外での<Tab>の幅
set expandtab   "<Tab>の代わりに<Space>を挿入する
set softtabstop=4   "expandtabで<Tab>が対応する<Space>の数
set backspace=indent,eol,start
"set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末で止まらないようにする"
set clipboard=unnamed "クリップボードを利用する

"font
set guifont=MS_Gothic:h10
set guifontwide=MS_Gothic:h10
  
"" Dvorak用にhtで左右移動するようRemap
"noremap  t     l
  
"" 挿入モード中に'Ctr-*'でコマンドモードでの移動を可能にする
"カーソルを右へ（foward）
inoremap <c-f> <right>
"カーソルを左へ（backward）
inoremap <c-b> <left>
  
"" 空白文字を表示
"set list    "タブ、行末等の不可視文字を表示する
"set listchars=tab:>-,trail:-,eol:$
scriptencoding utf-8 "これ入れないと下記が反映されない
"augroup highlightZenkakuSpace "全角スペースを赤色にする
"  autocmd!
"  autocmd VimEnter,ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
"  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"augroup END
" Flags {{{
let s:use_dein = 1
" }}}

" Prepare .vim dir {{{
let s:vimdir = $HOME . '/.vim'
if has('vim_starting')
  if ! isdirectory(s:vimdir)
    call system('mkdir ' . s:vimdir)
  endif
endif
" }}}

" dein {{{
let s:dein_enabled  = 0
if s:use_dein && v:version >= 704
  let s:dein_enabled = 1

  " Set dein paths
  let s:dein_dir = s:vimdir . '/dein'
  let s:dein_github = s:dein_dir . '/repos/github.com'
  let s:dein_repo_name = 'Shougo/dein.vim'
  let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

  " Check dein has been installed or not.
  if !isdirectory(s:dein_repo_dir)
    echo 'dein is not installed, install now '
    let s:dein_repo = 'https://github.com/' . s:dein_repo_name
    echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
    call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
  endif
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir

  " Begin plugin part {{{

  " Check cache
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " dein
    call dein#add('Shougo/dein.vim')

    " Basic tools {{{
    " Asynchronous execution library: need for vimshell, Gmail, unite, etc...
    call dein#add('Shougo/vimproc', {'build': 'make'})

    " Support repeat for surround, speedating, easymotion, etc...
    call dein#add('tpope/vim-repeat')

    " Sub mode
    call dein#add('kana/vim-submode')

    " webapi
    call dein#add('mattn/webapi-vim')
    " }}}

    " Unite {{{
    " Search and display information from arbitrary sources
    call dein#add('Shougo/unite.vim', {
          \ 'depends': ['vimproc'],
          \ 'on_cmd': ['Unite'],
          \ 'lazy': 1})

    " Source for unite: mru
    call dein#add('Shougo/neomru.vim', {'depdens': ['unite.vim']})

    " Source for unite: mark
    call dein#add('tacroe/unite-mark', {'depdens': ['unite.vim']})

    " Source for unite: help
    call dein#add('tsukkee/unite-help', {'depdens': ['unite.vim']})

    " Source for unite: history/command, history/search
    call dein#add('thinca/vim-unite-history', {'depdens': ['unite.vim']})

    " Source for unite: history/yank
    call dein#add('Shougo/neoyank.vim', {'depdens': ['unite.vim']})

    " Source for unite: tag
    call dein#add('tsukkee/unite-tag', {'depdens': ['unite.vim']})

    " Source for unite: outline
    call dein#add('Shougo/unite-outline', {'depdens': ['unite.vim']})
    " }}}

    " Completion {{{
    if has('lua')
      call dein#add('Shougo/neocomplete.vim', {
            \ 'on_i': 1,
            \ 'lazy': 1})
      call dein#add('ujihisa/neco-look', {
            \ 'depends': ['neocomplete.vim']})
    endif
    " }}}

    " Snippet {{{
    call dein#add('Shougo/neosnippet')
    "      \ 'on_map': ['<Plug>(neosnippet_expand_or_jump)',
    "      \            '<Plug>(neosnippet_expand_target)'],
    "      \ 'lazy': 1})
    call dein#add('Shougo/neosnippet-snippets', {'depdens': ['neosnippet']})
    call dein#add('honza/vim-snippets', {'depdens': ['neosnippet']})
    call dein#add('rcmdnk/vim-octopress-snippets', {'depdens': ['neosnippet']})
    " }}}

    " Code syntax, tools for each language {{{

    " Applescript
    call dein#add('vim-scripts/applescript.vim')

    " Automatic LaTeX Plugins
    "call dein#add('coot/atp_vim')

    " CSS3 (Sass)
    call dein#add('hail2u/vim-css3-syntax.git')

    " c++ {{{
    " syntax with c++11 support
    call dein#add('vim-jp/cpp-vim')
    " c++ completion
    call dein#add('osyo-manga/vim-marching')
    " c++ formatting
    call dein#add('rhysd/vim-clang-format')
    " }}}

    " Go
    " Extra plugins for Go
    call dein#add('vim-jp/vim-go-extra')

    " Java
    call dein#add('koron/java-helper-vim')

    " Markdown {{{
    call dein#add('junegunn/vader.vim')
    call dein#add('godlygeek/tabular')
    call dein#add('joker1007/vim-markdown-quote-syntax')
    call dein#add('rcmdnk/vim-markdown')
    " }}}

    " Python {{{
    " indent
    call dein#add('hynek/vim-python-pep8-indent')
    " Folding method for python, but makes completion too slow...?
    call dein#add('vim-scripts/python_fold')
    " }}}

    " Powershell
    call dein#add('PProvost/vim-ps1')

    " Homebrew
    call dein#add('xu-cheng/brew.vim')

    " LaTex
    call dein#add('lervag/vimtex')

    " Vim Syntax
    call dein#add('dbakker/vim-lint')

    " Syntax checking
    "call dein#add('vim-syntastic/syntastic')
    call dein#add('neomake/neomake')
    call dein#add('benjie/neomake-local-eslint.vim')
    " }}}

    " View {{{
    " Status line
    call dein#add('itchyny/lightline.vim')

    " Visual indent guides: make moving slow?
    call dein#add('nathanaelkane/vim-indent-guides')

    " Konfekt/FastFold
    call dein#add('Konfekt/FastFold')

    " replacement of matchparen (require OptionSet sutocommand event)
    if (v:version == 704 && has('patch786')) || v:version >= 705
      call dein#add('itchyny/vim-parenmatch')
    endif

    " Diff {{{
    " linediff
    call dein#add('AndrewRadev/linediff.vim', {
          \ 'on_cmd': ['Linediff'],
          \ 'lazy': 1})

    " Character base diff
    "call dein#add('rickhowe/diffchar.vim')

    " diff enhanced
    "if v:version >= 800
    "  call dein#add('chrisbra/vim-diff-enhanced')
    "endif
    " }}} Diff

    " IDE like {{{
    " The NERD Tree: File Explorer
    call dein#add('scrooloose/nerdtree', {
          \ 'on_cmd': ['NERDTreeToggle'],
          \ 'lazy': 1})

    " Source Explorer
    call dein#add('wesleyche/SrcExpl', {
          \ 'on_cmd': ['SrcExplToggle'],
          \ 'lazy': 1})

    " For Tags
    call dein#add('majutsushi/tagbar', {
          \ 'on_cmd': ['TagbarToggle'],
          \ 'lazy': 1})
    " }}} IDE like
    " }}} View

    " Version Control System {{{
    " Git
    call dein#add('tpope/vim-fugitive')
    call dein#add('gregsexton/gitv', {
          \ 'depdens': ['tpope/vim-fugitive'],
          \ 'on_cmd': ['Gitv'],
          \ 'lazy': 1})

    " Version control (especially for VCSVimDiff (<Leader>cv)
    call dein#add('vim-scripts/vcscommand.vim', {
          \ 'on_cmd': ['VCSVimDiff'],
          \ 'lazy': 1})

    " Gist
    call dein#add('mattn/gist-vim', {
          \ 'depdens': ['mattn/webapi-vim'],
          \ 'on_cmd': ['Gist'],
          \ 'lazy': 1})
    " }}} Version Control System

    " Selection {{{
    " wildfire
    "call dein#add('gcmt/wildfire.vim')

    " Highlight on the fly
    call dein#add('t9md/vim-quickhl')
    " }}} Selection

    " Search {{{
    " Count searching objects
    call dein#add('osyo-manga/vim-anzu')

    " Improved incremental searching (default incsearch shows only the next one.)
    call dein#add('haya14busa/incsearch.vim')
    " }}} Search

    " Edit {{{
    " textobj {{{
    call dein#add('kana/vim-textobj-user')
    " line: al, il
    call dein#add('kana/vim-textobj-line', {'depends': ['vim-textobj-user']})
    " line: ai, ii
    call dein#add('kana/vim-textobj-indent', {'depends': ['vim-textobj-user']})
    " function: af, if
    call dein#add('kana/vim-textobj-function', {'depends': ['vim-textobj-user']})
    " comment: ac, ic
    call dein#add('thinca/vim-textobj-comment', {'depends': ['vim-textobj-user']})
    " }}}

    " Operator {{{
    call dein#add('kana/vim-operator-user')
    call dein#add('kana/vim-operator-replace', {'depdens': ['vim-operator-user']})
    " }}}

    " Gundo
    call dein#add('sjl/gundo.vim', {
          \ 'on_cmd': ['GundoToggle'],
          \ 'lazy': 1})

    " Align
    call dein#add('h1mesuke/vim-alignta', {
          \ 'on_cmd': ['Alignta'],
          \ 'lazy': 1})

    " yank
    call dein#add('LeafCage/yankround.vim')

    " over
    call dein#add('osyo-manga/vim-over', {
          \ 'on_cmd': ['OverCommandLine'],
          \ 'lazy': 1})

    " vim-multiple-cursors, like Sublime Text's multiple selection
    "call dein#add('terryma/vim-multiple-cursors')

    " Easy to change surround
    call dein#add('tpope/vim-surround')

    " }}} Edit

    " Move {{{
    " Easymotion
    call dein#add('easymotion/vim-easymotion', {
          \ 'on_map': ['<Plug>(easymotion-sn)', '<Plug>(easymotion-bd-W)',
          \            '<Plug>(easymotion-bd-w)'],
          \ 'lazy': 1})

    " }}} Move

    " Check language, web source {{{
    " vim-ref
    call dein#add('thinca/vim-ref', {
          \ 'on_cmd': ['Ref'],
          \ 'lazy': 1})

    " Grammer check with LanguageTool
    call dein#add('rhysd/vim-grammarous', {
          \ 'on_cmd': ['GrammarousCheck'],
          \ 'lazy': 1})

    " Google Translate
    call dein#add('daisuzu/translategoogle.vim', {
          \ 'on_cmd': ['TranslateGoogle', 'TranslateGoogleCmd'],
          \ 'lazy': 1})
    " }}}

    " Other tools {{{
    " Make benchmark result of vimrc
    call dein#add('mattn/benchvimrc-vim', {
          \ 'on_cmd': ['BenchVimrc'],
          \ 'lazy': 1})

    " Open browser
    call dein#add('tyru/open-browser.vim', {
          \ 'on_map': ['<Plug>(openbrowser-smart-search)'],
          \ 'lazy': 1})

    " Database access
    call dein#add('vim-scripts/dbext.vim')

    " Like spacemacs, but for vim
    call dein#add('SpaceVim/SpaceVim')
    " }}}

    " Fun {{{dotfiles
    " }}}

    call dein#end()

    call dein#save_state()
  endif

  " }}} dein end

  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif
" }}} dein
