"Plugin
"プラグインを読み込む場合はここに記述する。

"Encode
"下記の指定は環境によって文字化けする可能性があるので適宜変更する
set encoding=utf-8 "文字コードをUTF-8にする
set termencoding=utf-8 "文字コードをUTF-8にする
"set fileencodings=iso-2022-jp,utf-8,euc-jp,sjis
set fileencodings=ucs-bom,utf-8,sjis,euc-jp,iso-2022-jp

"File
set hidden    "ファイル変更中でも他のファイルを開けるようにする
set autoread    "ファイル内容が変更されると自動読み込みする

"Backup
set backupdir=$HOME/.vim/backup    "バックアップディレクトリを指定する
set browsedir=buffer    "ファイル保存ダイアログの初期ディレクトリをバッファファ>イル位置に設定
set directory=$HOME/.vim/backup    "スワップファイルディレクトリを指定する
set history=1000    "履歴保存数
set undodir=$HOME/.vim/backup

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
set number

"font
"set guifont=MS_Gothic:h10
"set guifontwide=MS_Gothic:h10

"" 挿入モード中に'Ctr-*'でコマンドモードでの移動を可能にする
"カーソルを右へ（foward）
inoremap <c-f> <right>
"カーソルを左へ（backward）
inoremap <c-b> <left>

scriptencoding utf-8 "これ入れないと下記が反映されない
let s:use_dein = 1

"dein
if &compatible
  set nocompatible
endif

"dein.vimディレクトリをruntimepathに追加する
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

"以下定型文
if dein#load_state("~/.vim/dein")
  call dein#begin("~/.vim/dein")
    call dein#add("~/.vim/dein/repos/github.com/Shougo/dein.vim")
    
      "好きなプラグインを dein#add() 追加していく
      call dein#add('vim-airline/vim-airline')
      call dein#add('vim-scripts/gtags.vim')

    call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

