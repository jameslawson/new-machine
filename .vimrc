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
" [8] jq
"     $ brew install jq

" ----------------------------------------------------------
" -- SETUP VUNDLE
" ----------------------------------------------------------

set nocompatible              " required by vundle
filetype off                  " required by vundle

" -- set the runtime path to include Vundle
"    initialize vundle then import  [1]
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ----------------------------------------------------------
" -- IMPORT VIM PLUGINS (VIA VUNDLE)
" ----------------------------------------------------------

" -- [VUNDLE]: vundle plugin
"    that manages Vundle. Essential, don't remove
"    depends on [1]
Plugin 'gmarik/Vundle.vim'

" ----------------------------------------------------------

" -- [CTRLP]: ctrlp (control-p) - vim fuzzy file finder
"    (written in vimscript and has no dependencies)
Plugin 'kien/ctrlp.vim'

" -- [AG]: - make it easier to grep files inside vim
"    Adds `The Silver Searcher` to vim
"    depends on [6]
Plugin 'rking/ag.vim'

" ----------------------------------------------------------

" -- [SNIPEMU]: SnippetsEmu
Plugin 'https://github.com/vim-scripts/snippetsEmu'

" ----------------------------------------------------------

" -- [COMMENT]: tim Pope's commenting plugin
"    use gcc to comment a line
Plugin 'tpope/vim-commentary'

" -- [RENAME]: adds :Rename user function
"    so that you can rename a file from inside vim
Plugin 'ReekenX/vim-rename2'

" -- [TMUX]: seamless navigation between tmux panes and vim splits
Plugin 'christoomey/vim-tmux-navigator'

" -- [JKJUMP]: cursor can jumping back through previous positions
Plugin 'teranex/jk-jumps.vim'

" -- [EMMET]: shortcuts for quickly writing HTML
Plugin 'mattn/emmet-vim'

" -- [WHITESP]: highlight trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'

" ----------------------------------------------------------

" -- [JELLY] Jellybeans theme
Plugin 'nanotech/jellybeans.vim'

" ----------------------------------------------------------

" -- [YASL]: yet another javascript syntax
Plugin 'othree/yajs.vim'

" -- Other Languages
" Plugin 'tpope/vim-dispatch'
" Plugin 'thoughtbot/vim-rspec'
" Plugin 'tpope/vim-rails'
" Plugin 'lukerandall/haskellmode-vim'
" Plugin 'ElmCast/elm-vim'
Plugin 'derekwyatt/vim-scala'

" ----------------------------------------------------------
"
" -- [GITDIFF]: show lines added/modified/deleted next to line numbers
Plugin 'airblade/vim-gitgutter'

" -- [EXPAND]: expand selection gradually
Plugin 'terryma/vim-expand-region'

" -- [TXTOBJ]: custom text objects
Plugin 'kana/vim-textobj-user'

" -- [TXTOBJ-QUOTE]: treat quotes as a text object
" depends on [TXTOBJ]
Plugin 'beloglazov/vim-textobj-quotes'

" -- [AIRLINE]: Add airline
" -- depends on [7]
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" ----------------------------------------------------------
" -- END VIM PLUGINS
" ----------------------------------------------------------

call vundle#end()          " requied for vundle
filetype plugin indent on  " required for vundle

" ----------------------------------------------------------

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
set relativenumber
set number
autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set relativenumber

" -- make sure vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" ----------------------------------------------------------
" -- ESSENTIAL APPEARANCE
" ----------------------------------------------------------

" -- enable highlighting of current line
set cul
hi CursorLine term=none cterm=none ctermbg=3

" -- use jellybeans theme
"    depends on [JELLY]
colorscheme jellybeans

" -- enable syntax highlighting
syntax enable

" -- change colour of the line numbers
highlight LineNr ctermfg=DarkGrey

" -- always keep 3 lines visible at top and bottom
"    when cursor hits top/bottom and you scroll
set scrolloff=3

" -- show matching parentheses
"    :help showmatch
" -- change color of highlighting of matching paranthsis
"    http://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
set showmatch
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" -- turn on invisibles by default
"    and use the same symbols as TextMate for tabstops and EOLs
set list!
set listchars=tab:▸\ ,eol:¬

set laststatus=2

" ----------------------------------------------------------
" -- TEMPORARY FILES
" ----------------------------------------------------------

" persistent undo
set undofile
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" backup to ~/.tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" ----------------------------------------------------------
" -- FORGIVING
" ----------------------------------------------------------

" -- make :W an alias for :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" -- fix backspace
"    http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" -- useful aliases
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

" -- yank till end of line
nnoremap Y y$

" ----------------------------------------------------------
" -- EDITING
" ----------------------------------------------------------

" -- add a comma at the end of the line
inoremap << <Esc>$a,<Esc>

" -- add a new line in normal mode
nmap <CR> o<Esc>k

" -- keep the cursor in place while joining lines
nnoremap J mzJ`z

" -- given J joins a line, why not have S split a line "
"    make S break a line into two lines
nnoremap S i<CR><Esc><right>

" -- some sneaky shortcuts for inserting symbols
inoremap <Leader>h #
inoremap <Leader>b `
inoremap <Leader>; ;
inoremap <Leader>c ,
inoremap <Leader>[ [

" -- add semicolon at the end of the line
"    quickly by using ,,
inoremap <Leader><Leader> <Esc>$a;<Esc>

" -- exit insert mode quickly with ;;
" -- exit visual mode quickly with ;;
inoremap ;; <Esc>
vnoremap ;; <Esc>

" ----------------------------------------------------------
" -- TDD
" ----------------------------------------------------------

" Run tests via `npm run t`
nnoremap <leader>rt :!npm run t<cr>

" ----------------------------------------------------------
" -- SANDWICH
" ----------------------------------------------------------

" -- Surround a visual selection with
"    a given input (form a sandwich with the input).
function! Sandwich()
  let bread = input('Surround with: ', '')
  if len(bread) > 0
    " add the top slice
    normal `<
    exe 'normal i' . bread

    " add the bottom slice
    let command = (&selection == 'exclusive') ? 'i' : 'a'
    normal `>
    exe 'normal ' . command . bread
  endif
endfunction
vnoremap <leader>s <esc>:call Sandwich()<cr>

" ----------------------------------------------------------
" -- SMART BRACKETS
" ----------------------------------------------------------

" -- CLOSING BRACKETS:
" -- move cursor when:
"    - cursor sitting on a character that is )
" -- add right bracket when:
"    - cursor sitting on <CR> (ie the empty space at end of line)
"    - cursor sitting on a character that is not )
function! SmartClose(closebracket)
  let col = col(".")
  let sitting = getline(".")[col-1]
  if (sitting ==# a:closebracket)
    " -- move the cursor right
    call cursor(line("."), col+1)
    return ''
  else
    " -- add the closing bracket
    return a:closebracket
  endif
  return ''
endfunction

inoremap { {}<esc>i
inoremap ( ()<esc>i
inoremap ) <c-r>=SmartClose(')')<cr>
inoremap } <c-r>=SmartClose('}')<cr>

" ----------------------------------------------------------
" -- SMART QUOTES
" ----------------------------------------------------------

function! SmartQuotes(thequote)
  let col = col(".")
  let sitting = getline(".")[col-1]
  if (sitting ==# a:thequote)
    " -- move the cursor right
    call cursor(line("."), col+1)
  else
    " -- add the closing bracket
    "    then position cursor over right quote
    execute "normal! i" . a:thequote . a:thequote
  endif
  return ''
endfunction

inoremap ' <c-r>=SmartQuotes("'")<cr>
inoremap " <c-r>=SmartQuotes('"')<cr>

" ----------------------------------------------------------
" -- MOVEMENT
" ----------------------------------------------------------

" -- make H,L a 'stronger' version of h,l
"    H goes to front of current line
"    L goes to end of current line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $h
vnoremap dH d^

" -- go to matching parenthesis
:nnoremap <leader>m %

" -- go to previous/next cursor locations
"    gb is 'go back'
"    depends on jk jumps plugin [JKJUMP]
nnoremap gb <C-O>

" ----------------------------------------------------------
" -- SEARCH AND REPLACE
" ----------------------------------------------------------

" -- see: :help ignorecase, :help smartcase,
"         :help hlsearch, :help incsearch
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

" -- see: :help smartindent, :help expandtab,
"         :help shiftwidth, :help autoindent
set smartindent
set expandtab
set shiftwidth=2
set autoindent

" -- indent with *spaces*, not tabs
"    use either 2 or 4 spaces, depending on the language
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype c setlocal ts=4 sts=4 sw=4
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4
autocmd Filetype java setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
" autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=4 sts=4 sw=4
autocmd Filetype scss setlocal ts=4 sts=4 sw=4

" ----------------------------------------------------------
" -- MACROS
" ----------------------------------------------------------

" -- replay macros with space
nnoremap <Space> @q

" ----------------------------------------------------------
" -- PLUGINS
" ----------------------------------------------------------

" -- [AIRLINE]
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
" disable airline 'vim-gitdiff' extension (aka 'hunks' extension)
let g:airline#extensions#hunks#enabled = 0

" -- [SNIPEMU]
let g:snippetsEmu_key = "["

" -- [CTRLP]
nnoremap <leader>p :CtrlP<CR>
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|tmp|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 0
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<leader>'],
      \ 'AcceptSelection("v")': ['<V>'],
      \ 'PrtExit()':            ['<X>', '', '<esc>']
      \}

" -- [EMMET]
let g:user_emmet_leader_key='<Leader>e'

" -- [ULTI]
let g:UltiSnipsJumpForwardTrigger="\["
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" -- [JKJUMP]
let g:jk_jumps_minimum_lines = 2

" -- [AG]
let g:ag_highlight = 1

" -- [GITGUTTER]
" Toggle with :GitGutterToggle
" let g:gitgutter_map_keys = 0

" --
" https://github.com/ggreer/the_silver_searcher/blob/master/doc/ag.1.md

" -- Grep functions
"    These are built upon [AG] plugin
function! GrepSass(arg)
  let command = ['Ag', a:arg] " call the :Ag command that [AG] exposes
  let command += ['-G .scss'] " only search for .scss files
  let command += ['--ignore-dir=node_modules/']
  let command += ['--ignore-dir=.git/']
  execute join(command, " ")
endfunction
command -nargs=* GrepSass call GrepSass('<args>')

function! GrepJs(arg)
  let command = ['Ag', a:arg] " call the :Ag command that [AG] exposes
  let command += ['-G .js']   " only search for .js files
  let command += ['--ignore-case'] " case-insensitive
  let command += ['--ignore-dir=node_modules/']
  let command += ['--ignore-dir=.git/']
  execute join(command, " ")
endfunction
command -nargs=* GrepJs call GrepJs('<args>')


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

" -- depends on [8]
function! s:PrettyJSON()
  %!jq .
  set filetype=json
endfunction
command! PrettyJSON :call <sid>PrettyJSON()

" -- [AG]
let g:ag_highlight=1
