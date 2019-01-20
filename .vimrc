" +---------------------------------------------------------
" | Author: James Lawson
" | License: MIT
" +---------------------------------------------------------

" ----------------------------------------------------------
" -- INSTALLATION
" ----------------------------------------------------------
" 1. Install the dependencies listed below.
" 2. Open vim. Ignore any errors.
" 3. In normal mode, execute :PluginInstall
"    you should see all the plugins install successfully.
" 4. Restart vim.

" ----------------------------------------------------------
" -- DEPENDENCIES
" ----------------------------------------------------------
" [1] vundle
"     $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"     Essential Vundle commands ...
"     -  :PluginInstall,
"     -  :PluginClean
"     -  :PluginList,
" [2] Powerline
"     pip install powerline-status
"     https://powerline.readthedocs.org/en/latest/installation.html
" [3] clipboard+
"     vim needs to be compiled with clipboard+
"     $ vim --version | grep clipboard
" [4] CMake and YCM python installation script
"     $ brew install cmake
"     $ cd ~/.vim/bundle/YouCompleteMe
"     $ ./install.py
" [5] python+
"     vim needs to be compiled with python+ or python3+
"     $ vim --version | grep python
" [6] The Silver Searcher (https://github.com/ggreer/the_silver_searcher)
"     $ brew install the_silver_searcher
" [7] The powerline fonts (https://github.com/powerline/powerline)
"     $ git clone git@github.com:powerline/fonts.git
"     $ ./install.sh
"     Then go to iTerm2 and change the font to one of the newly installed
"     fonts that end with "for powerline"

" ----------------------------------------------------------
" -- SETUP VUNDLE
" ----------------------------------------------------------

set nocompatible              " required by [VUNDLE]
filetype off                  " required by [VUNDLE]

" -- set the runtime path to include vundle
"    initialize vundle then import
"    required by [VUNDLE]
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ----------------------------------------------------------
" -- IMPORT VIM PLUGINS (VIA VUNDLE)
" ----------------------------------------------------------

Plugin 'gmarik/Vundle.vim'              " -- [VUNDLE], depends on [1]
Plugin 'kien/ctrlp.vim'                 " -- [CTRLP]
Plugin 'rking/ag.vim'                   " -- [AG], depends on [6]
Plugin 'vim-scripts/snippetsEmu'        " -- [SNIPEMU]
Plugin 'tpope/vim-commentary'           " -- [COMMENT]
Plugin 'ReekenX/vim-rename2'            " -- [RENAME]
Plugin 'teranex/jk-jumps.vim'           " -- [JKJUMP]
Plugin 'mattn/emmet-vim'                " -- [EMMET]
Plugin 'ntpeters/vim-better-whitespace' " -- [WHITESP]
Plugin 'nanotech/jellybeans.vim'        " -- [JELLY]
Plugin 'airblade/vim-gitgutter'         " -- [GITDIFF]
Plugin 'vim-airline/vim-airline'        " -- [AIRLINE] depends on [7]
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jameslawson/sandwich.vim'       " -- [SANDWICH]
Plugin 'jameslawson/grepx.vim'          " -- [GREPX]
Plugin 'scrooloose/nerdtree'            " -- [NERD]
Plugin 'terryma/vim-multiple-cursors'

" -- Text Objects
Plugin 'kana/vim-textobj-user'          " -- [TEXTOBJ]
Plugin 'beloglazov/vim-textobj-quotes'  " -- [TEXTOBJ-QUOTE], depends on [TEXTOBJ]
Plugin 'terryma/vim-expand-region'      " -- [EXPAND]

" -- Javascript
Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'                    " -- [JSJSX]

" -- Scala
Plugin 'derekwyatt/vim-scala'           " -- scala

" -- Other Languages
Plugin 'editorconfig/editorconfig-vim'   " -- editorconfig
Plugin 'johnlim/vim-groovy'              " -- groovy
Plugin 'chr4/nginx.vim'                  " -- nginx config files
Plugin 'bfontaine/Brewfile.vim'          " -- brewfile syntax
" Plugin 'digitaltoad/vim-pug.git'       " -- pug
" Plugin 'rust-lang/rust.vim'            " -- rust
" Plugin 'leafgarland/typescript-vim'    " -- typescript
" Plugin 'tpope/vim-rails'               " -- ruby on rails
" Plugin 'lukerandall/haskellmode-vim'   " -- haskell
" Plugin 'ElmCast/elm-vim'               " -- elm
" Plugin 'purescript-contrib/purescript-vim'

" ----------------------------------------------------------
" -- END VIM PLUGINS
" ----------------------------------------------------------

"  finish initializing vundle
"  required by [VUNDLE]
call vundle#end()
filetype plugin indent on

" ----------------------------------------------------------
" -- ESSENTIAL BEHAVIOUR
" ----------------------------------------------------------

" -- map the vim Leader Key to comma
let mapleader = ","

" -- reduce keymap timeout from default of 1000ms to 500ms
set timeoutlen=500

" -- use relative line numbering
"    relative number is used in visual mode
"    but becomes absolute number in insert mode
" set relativenumber
set number
" autocmd InsertEnter * :set number norelativenumber
" autocmd InsertLeave * :set relativenumber

" -- make sure vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" -- check if the file has been modified before we go into
"    insert mode (or when the cursor hasn't moved for a while)
"    this tries to prevent the "this file has already been modified" problem
"    https://stackoverflow.com/a/927634/3649209
autocmd CursorHold * checktime
autocmd InsertEnter * checktime


" -- By default vim will only look for the tags file in the cwd of current buffer.
"    We want vim to search up the directory hierarchy until it finds the tags file
" set tags=tags;/
set tags=./.tags,.tags,./tags,tags

" ----------------------------------------------------------
" -- ESSENTIAL APPEARANCE
" ----------------------------------------------------------

" -- enable highlighting of current line
set cursorline

" -- use jellybeans theme
"    depends on [JELLY]
colorscheme jellybeans

" -- enable syntax highlighting
syntax enable

" -- change fg and bg colours of the line numbers
"    and the cursor line
highlight LineNr ctermfg=235
highlight CursorLine ctermbg=234
highlight CursorLineNr ctermbg=234 ctermfg=250

" -- always keep 3 lines visible at top and bottom
"    when cursor hits top/bottom and you scroll
set scrolloff=3

" -- change color of highlighting of matching paranthsis
"    http://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
highlight MatchParen cterm=bold ctermbg=none ctermfg=magenta

" -- turn on invisibles by default
"    and use the same symbols as TextMate for tabstops and EOLs
set list!
set listchars=tab:▸\ ,eol:¬

" --  enable status bar
set laststatus=2

" -- show when lines exceeds the maximum line length
"    highlight firstthe character that goes over the limit
"    https://superuser.com/a/771555
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 105)

" ----------------------------------------------------------
" -- SWAPFILES
" ----------------------------------------------------------

" -- disable .swp files
set nobackup
set noswapfile

" ----------------------------------------------------------
" -- FORGIVING
" ----------------------------------------------------------

" -- make :W an alias for :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" -- fix backspace
"    http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" -- useful aliases
command! Wq wq
command! W w
command! Q q
command! Q q
command! Qall qall
command! QA qall
command! E e

" ----------------------------------------------------------
" -- DISABLE
" ----------------------------------------------------------

" -- map arrow keys to no-ops
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" -- disable Ex mode
map Q <nop>

" -- disable K
nnoremap K <nop>

" -- disable U
"    emacs style undo-ing...no thanks ;)
nnoremap U <nop>

" ----------------------------------------------------------
" -- COPY AND PASTE
" ----------------------------------------------------------

" -- prevent cursor move after yank
vmap y ygv<Esc>

" -- with vim comipiled with clipboard+, [3]
"    we can make vim and system clipboard work together
set clipboard=unnamed

" -- visually select text just pasted with <leader>V
"    go to just before/after pasted text with gp and gP
nnoremap <leader>v `[v`]

" ----------------------------------------------------------
" -- EDITING
" ----------------------------------------------------------

" -- add a comma at the end of the line
" inoremap << <Esc>$a,<Esc>

" -- add a new line in normal mode
nmap <cr> o<esc>k

" -- keep the cursor in place while joining lines
nnoremap J mzJ`z

" -- given J joins a line, why not have S split a line "
"    make S break a line into two lines
nnoremap S i<cr><esc>:%s/\s\+$//e<cr>

" -- some sneaky shortcuts for inserting symbols
inoremap <leader>h #
inoremap <leader>b `
inoremap <leader>; ;
inoremap <leader>c ,

" -- add semicolon at the end of the line and exit insert mode by
"    using <leader><leader> if the autocomplete window is open, pick the
"    highlighted suggestion, close the window, add a semicolon
"    at the end of the line and then exit insert mode
inoremap <expr> <leader><leader> pumvisible() ?  "\<C-Y><Esc>$a;<Esc>" : "\<Esc>$a;<Esc>"

" -- exit insert mode quickly with ;;
" -- exit visual mode quickly with ;;
inoremap ;; <Esc>
vnoremap ;; <Esc>

" -- supress newlines that are sometimes added by autocomplete
"    http://superuser.com/a/941082
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" ----------------------------------------------------------
" -- MOVEMENT
" ----------------------------------------------------------

" -- make H,L a 'stronger' version of h,l
"    H goes to front of current line
"    L goes to end of current line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $h

" -- go to previous/next cursor locations (via vims jumplist)
"    gb is 'go back', gf is 'go foward'
"    depends on jk jumps plugin [JKJUMP]
nnoremap gb <c-o>
nnoremap gf <c-i>

" ----------------------------------------------------------
" -- SEARCH AND REPLACE
" ----------------------------------------------------------

set ignorecase
set smartcase
set hlsearch
set incsearch

" -- center screen when moving between between search terms
nnoremap n nzzzv
nnoremap N Nzzzv

" -- shortcut to turn off search highlighting
nnoremap <leader>nh :noh

" ----------------------------------------------------------
" -- INDENTATION
" ----------------------------------------------------------

set smartindent
set expandtab
set shiftwidth=2
set autoindent

" -- indent with *spaces*, not tabs
"    use either 2 or 4 spaces, depending on the language
"    these will change according to [SLEUTH]
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype c setlocal ts=4 sts=4 sw=4
autocmd Filetype cpp setlocal ts=2 sts=2 sw=2
autocmd Filetype java setlocal ts=4 sts=4 sw=4
" autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

" ----------------------------------------------------------
" -- MACROS
" ----------------------------------------------------------

" -- replay macros with space
nnoremap <Space> @q

" ----------------------------------------------------------
" -- PLUGINS
" ----------------------------------------------------------

" -- [NERD]
" -- make CTRL+n open nerdtree
map <leader>t :NERDTreeFind %<cr>
:let g:NERDTreeWinSize=60


" " -- Check if NERDTree is open or active
" function! IsNERDTreeOpen()
"   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction

" " -- Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" "    file, and we're not in vimdiff
" function! SyncTree()
"   if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"     NERDTreeFind
"     wincmd p
"   endif
" endfunction

" " -- Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()

" -- [AG]
let g:ag_highlight = 1

" -- [JSJSX]
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" ----------------------------------------------------
" -- [AIRLINE]
" ----------------------------------------------------
function! AirlineInit()
  " let g:airline_section_a = airline#section#create([' ', ' ', 'branch'])
  let g:airline_section_a = airline#section#create([''])
  let g:airline_section_b = airline#section#create([''])
  let g:airline_section_c = airline#section#create([''])
  let g:airline_section_x = airline#section#create(['%f (', 'filetype', ')'])
  let g:airline_section_y = airline#section#create([''])
  let g:airline_section_z = airline#section#create([''])
  " let g:airline_section_z = airline#section#create_right(['%l', '%c'])
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
endfunction
autocmd VimEnter * call AirlineInit()
call AirlineInit()

" let g:airline_theme='minimalist'
" let g:airline_powerline_fonts = 0
" let g:airline_left_sep = ' '
" let g:airline_left_alt_sep = '|'
" let g:airline_right_sep = ' '
" let g:airline_right_alt_sep = '|'
" " disable airline 'vim-gitdiff' extension (aka 'hunks' extension)
" let g:airline#extensions#hunks#enabled = 0

" -- [SNIPEMU]
let g:snippetsEmu_key = "["

" -- [CTRLP]
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>r :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|tmp|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 0
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<leader>'],
      \ 'AcceptSelection("v")': ['<V>'],
      \ 'PrtExit()':            ['<X>', '', '<esc>']
      \ }

" -- [EMMET]
let g:user_emmet_leader_key='<Leader>e'

" -- [ULTI]
let g:UltiSnipsJumpForwardTrigger="\["
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" -- [JKJUMP]
let g:jk_jumps_minimum_lines = 2

" -- [AG]
let g:ag_highlight = 1

vnoremap q <esc>:call QuickWrap("'")<cr>
vnoremap Q <esc>:call QuickWrap('"')<cr>

function! QuickWrap(wrapper)
  let l:w = a:wrapper
  let l:inside_or_around = (&selection == 'exclusive') ? ('i') : ('a')
  normal `>
  execute "normal! " . inside_or_around . escape(w, '\')
  normal `<
  execute "normal! i" . escape(w, '\')
  normal `<
endfunction

" http://vim.wikia.com/wiki/Making_a_list_of_numbers#Incrementing_selected_numbers
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <leader>a :call Incr()<CR>
