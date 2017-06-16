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

" -- [VUNDLE]: vundle plugin
"    that manages Vundle. Essential, don't remove
"    depends on [1]
Plugin 'gmarik/Vundle.vim'

" ----------------------------------------------------------

" -- [ASYNC]: Add vim-async
Plugin 'skywind3000/asyncrun.vim', { 'rev': '66af612eadb59e94c895ee57bca82b36d4aea732' }

" -- [CTRLP]: ctrlp (control-p) - vim fuzzy file finder
"    (written in vimscript and has no dependencies)
Plugin 'kien/ctrlp.vim'

" -- [AG]: make it easier to grep files inside vim
"    Adds `The Silver Searcher` to vim
"    depends on [6]
Plugin 'rking/ag.vim'

" ----------------------------------------------------------

" -- [SLEUTH]: vim-sleuth - auto-detect indentation
Plugin 'https://github.com/tpope/vim-sleuth'

" -- [SNIPEMU]: SnippetsEmu
Plugin 'https://github.com/vim-scripts/snippetsEmu'

" -- [COMMENT]: tim Pope's commenting plugin
"    use gcc to comment a line
Plugin 'tpope/vim-commentary'

" -- [RENAME]: adds :Rename user function
"    so that you can rename a file from inside vim
Plugin 'ReekenX/vim-rename2'

" " -- [TMUX]: seamless navigation between tmux panes and vim splits
" Plugin 'christoomey/vim-tmux-navigator'

" -- [JKJUMP]: cursor can jumping back through previous positions
Plugin 'teranex/jk-jumps.vim'

" " -- [EMMET]: shortcuts for quickly writing HTML
Plugin 'mattn/emmet-vim'

" -- [WHITESP]: highlight trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'

" -- [JELLY]: Jellybeans theme
Plugin 'nanotech/jellybeans.vim'

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

" -- [DISPATCH]: Add vim-dispatch
"    used to run unit tests in background
" Plugin 'tpope/vim-dispatch'

Plugin 'jameslawson/sandwich.vim'

" ----------------------------------------------------------

" -- [YASL]: yet another javascript syntax
Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'
Plugin 'derekwyatt/vim-scala'
Plugin 'rust-lang/rust.vim'
Plugin 'leafgarland/typescript-vim'
" -- Other Languages
" Plugin 'tpope/vim-dispatch'
" Plugin 'thoughtbot/vim-rspec'
" Plugin 'tpope/vim-rails'
" Plugin 'lukerandall/haskellmode-vim'
" Plugin 'ElmCast/elm-vim'

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
set relativenumber
set number
autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set relativenumber

" -- Put vim in the background (use `fg` to restore vim)
noremap zx <c-z>

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

" --  enable status bar
set laststatus=2

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

" -- yank till end of line
nnoremap Y y$

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
nnoremap S i<cr><esc><right>

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

" -- remove redundant whitespace quickly with KK
nnoremap KK :%s/\s\+$//e<CR>"

" -- quickly open vim autocomplete
inoremap <leader>a <c-p>

" -- supress newlines that are sometimes added by autocomplete
"    http://superuser.com/a/941082
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" ----------------------------------------------------------
" -- TDD
" ----------------------------------------------------------

" -- Run tests via `npm run t`
nnoremap <leader>rt :!npm run t<cr>

" ----------------------------------------------------------
" -- VISUAL SANDWICH
" ----------------------------------------------------------

" -- Surround a visual selection with
"    a given input (form a sandwich with the input).
" function! Sandwich()
"   let bread = input('Surround with: ', '')
"   if len(bread) > 0
"     " add the top slice
"     normal `<
"     exe 'normal i' . bread

"     " add the bottom slice
"     let command = (&selection == 'exclusive') ? 'i' : 'a'
"     normal `>
"     exe 'normal ' . command . bread
"   endif
" endfunction
" vnoremap <leader>s <esc>:call Sandwich()<cr>

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
" -- MOVEMENT
" ----------------------------------------------------------

" -- make H,L a 'stronger' version of h,l
"    H goes to front of current line
"    L goes to end of current line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $h

" -- dH deletes from here to beginning of line
nnoremap dH d^

" -- go to matching parenthesis
nnoremap <leader>m %

" -- go to previous/next cursor locations
"    gb is 'go back'
"    depends on jk jumps plugin [JKJUMP]
nnoremap gb <c-o>


" ----------------------------------------------------------
" -- READING
" ----------------------------------------------------------

" -- use :dir to print the directory the current file is in
"    which is not the same as :pwd which shows the directory
"    in which vim was exec'ed from
function Dir()
  echo expand('%:p:h')
endfunction
command! Dir call Dir()

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
autocmd Filetype python setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype c setlocal ts=4 sts=4 sw=4
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4
autocmd Filetype java setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
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

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

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

" -- [GITGUTTER]
" Toggle with :GitGutterToggle
" let g:gitgutter_map_keys = 0

" --
" https://github.com/ggreer/the_silver_searcher/blob/master/doc/ag.1.md

" -- Grep functions
"    These are built upon [AG] plugin
function! GrepSass(arg)
  let command = ['Ag']               " call the :Ag command that [AG] exposes
  let command += ["'" . a:arg. "'"]  " and search for our query string
  let command += ['--ignore-dir=node_modules/']
  let command += ['--ignore-dir=.git/']
  execute join(command, " ")
endfunction
command -nargs=1 GrepSass call GrepSass('<args>')

function! GrepJs(arg)
  let command = ['Ag']               " call the :Ag command that [AG] exposes
  let command += ["'" . a:arg. "'"]  " and search for our query string
  " echom &filetype
  " if &filetype =~ 'javascript'
  let command += ['-G .js']           " only search for .js files
  let command += ['--ignore-case']    " case-insensitive
  let command += ['--ignore-dir=node_modules/']
  let command += ['--ignore-dir=.git/']
  execute join(command, " ")
endfunction
command -nargs=1 GrepJs call GrepJs('<args>')

function! Ctags()
  let command = ['find . -type f ']        " find every file
  let command += ['-iregex ".*\.js$" ']    " that is a javascript file
  let command += ['-not -path "./node_modules/*" '] " ignore node_modules
  let command += ['-not -path "bower_components/*" '] " ignore bower_components
  let command += ['-exec jsctags {} -f \; '] " ignore node_modules
  let command += ['| sed /^$/d ']            " remove newlines
  let command += ['| sort ']                 " sort by name
  let command += ['> tags']                  " write to file called `tags`
endfunction


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

" -- depends on [8]
function! s:Jq()
  %!jq .
  set filetype=json
endfunction
command! PrettyJSON :call <sid>Jq()

" ============================

function! Open()
  let l:dir = expand("%:p:h")
  silent exe "!open " . l:dir
endfunction
command! -nargs=0 O :call Open()
command! -nargs=0 Open :call Open()

" -- Autocompletes :e to prepare to
"    open a file **in the current file's folder**
"    http://stackoverflow.com/a/1708936/3649209
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" ============================

function NoOp()
endfunction

function! Tdd_refresh()
  fun! OnAsyncRunExit()
    let g:tdd_running = 0
    if g:asyncrun_status == 'success'
      let g:tdd_status = "Passing"
      call airline#parts#define('tdd', { 'function': 'Tdd_check', 'accent': 'green' })
      let g:airline_section_b = airline#section#create(['tdd'])
    elseif g:asyncrun_status == 'failure'
      let g:tdd_status = "Failing"
      call airline#parts#define('tdd', { 'function': 'Tdd_check', 'accent': 'red' })
      let g:airline_section_b = airline#section#create(['tdd'])
    endif

    echom ''
    exe ':AirlineRefresh'
  endf
  let g:asyncrun_exit = "silent! call OnAsyncRunExit()"

  " let l:spec_location = @% " read the contents of the % regsiter
  " let l:tdd_command = substitute(g:tdd_spec_command, "{spec}", l:spec_location, "g")
  " let l:async_tdd_command = substitute("AsyncRun! {command}", "{command}", l:async_tdd_command, "g")
  " execute l:async_tdd_command
  if (g:tdd_running == 0)
    let g:tdd_running = 1
    execute "AsyncRun! npm run test"
    exe ':AirlineRefresh'
  endif
  " TODO: change exe to execute?
endfunction

" function! s:InSpecFile()
"   return match(expand("%"), ".spec.js$") != -1
" endfunction

let g:tdd_status = ""
let g:tdd_running = 0
function! Tdd_check()
  return g:tdd_status
endfunction

function! Tdd_disabled()
  return '-'
endfunction

" Tdd plugin is activated iff there exists some
" regex in tdd_path_whitelist that matches the
" current buffer's absolute path
" Regexes can be deactived (not included in the above check)
" by changing 1 to 0
let g:tdd_path_whitelist = {
    \ '/Users/lawsoj03/github_projects/tipo': 'BABEL_ENV=test ./node_modules/.bin/mocha {spec} --reporter spec --recursive --require ./test/util/spec.helper.js --compilers js:babel-core/register,scss:./test/util/mocha.scss.compiler.js',
    \ }
function! MyPlugin(...)
  let l:file = expand("%:p")  " the filename including extension

  " Determine if current buffer's path matches
  " some regex in `file_in_whitelist`
  let l:file_in_whitelist = 0
  for regex in keys(g:tdd_path_whitelist)
     if (match(l:file, regex) > -1)
       let l:file_in_whitelist = 1
       " let g:tdd_spec_command = tdd_path_whitelist[regex]
     endif
  endfor

  " echom (&filetype =~ 'javascript')

  if (&filetype =~ 'javascript' && l:file_in_whitelist)
    " Enabled
    " Whenever we save the file, call Tdd_refresh
    call airline#parts#define('tdd', { 'function': 'Tdd_check' })

    augroup RefreshTddStatus
      autocmd!
      autocmd BufWritePost * call Tdd_refresh()
    augroup END

  else
    " Disabled
    call airline#parts#define('tdd', { 'function': 'Tdd_disabled', 'accent': 'yellow' })
    let g:airline_section_b = airline#section#create(['tdd'])
  endif
endfunction

call airline#add_statusline_func('MyPlugin')

" ============================

" function! Spec()
"   let l:file = expand("%:p")  " the filename including extension
"   let l:dir = expand("%:p:h") " the directory containing the file
"   " replace src/ with test/
"   let l:testdir = substitute(l:dir, "src\/", "test\/", "g") " ???
"   " replace .js with .spec.js

" endfunction
" command! -nargs=0 Open :call Open()

" -- [AG]
let g:ag_highlight=1
