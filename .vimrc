filetype off
filetype plugin indent off
execute pathogen#infect()
filetype off
syntax on
filetype plugin indent on

" https://github.com/nelstrom/vim-textobj-rubyblock
runtime macros/matchit.vim
set nocompatible
if has("autocmd")
  filetype indent plugin on
endif

" reduce keymap timeout from default
" of 1000ms to 200ms
set timeoutlen=1000

" Disable VIM backups (.swp files)
" a controversial mapping but I save so often 
" and I close terminal, it's a hassle deleting .swp files 
set nobackup
set noswapfile

" Make :W an alias for :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Enable syntax highlighting
:syntax enable

" Relative line numbering
:set relativenumber
:autocmd InsertEnter * :set number
:autocmd InsertLeave * :set relativenumber
:au FocusLost * :set number
:au FocusGained * :set relativenumber

" Powerline
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2 " Always show status bar

" Fix backspace
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start


" vertical split opens new split area below 
" (not above, which is the default)
set splitbelow

" horizontal split opens new split area on the right 
" (not left, which is the default)
set splitright

" Use Space to play macros
" :nnoremap <S-Space> @q
:nnoremap <Space> @q

:set ignorecase " ignore case when searching with /
:set smartcase 
" highlight all matches when
" we perform a search
:set hlsearch
" Highlight next match *while
" still typing out search pattern*
:set incsearch
:set scrolloff=3 "keep 3 lines visible at top and bottom

" map the vim Leader Key to comma
let mapleader = ","

:nnoremap <leader>m %
:set showmatch

" Nicer highlighting of matching paranthsis
" http://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta


" Bad Habits ----------------------------------------------------------- {{{

" Avoiding bad habits, map arrow keys to no-ops 
:map <up> <nop>
:map <down> <nop>
:map <left> <nop>
:map <right> <nop>

" Disable Ex mode
map Q <nop>

" Disable K
:nnoremap K <nop>

" Disable U
" emacs style undo-ing...no thanks
:nnoremap U <nop>

" }}}

" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

" Invisibles  -------------------------------------------------------- {{{

" http://vimcasts.org/episodes/show-invisibles/

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Turn on invisibles by default
set list!

" }}}

" Editing  ----------------------------------------------------------- {{{

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" J joins a line, so why not have S split a line "
nnoremap S i<CR><Esc><right>

" ENTER AND SHIFT-ENTER add new lines in normal mode
" note: <S-CR> depends on a mapping defined later
" (see the 'iTerm escape code trick')
" hence the use of nmap and not nnoremap
:nmap <S-CR> O<Esc>j
:nmap <CR> o<Esc>k

" some sneaky shortcuts for inserting symbols
:inoremap <Leader>h #
:inoremap <Leader>a @
:inoremap <Leader>t @
:inoremap <Leader>b `
:inoremap <Leader>; ;
:inoremap <Leader>c ,
:inoremap <Leader>[ [


" add semicolon at the end of the line
:inoremap <Leader><Leader> <Esc>$a;<Esc>

" add a comma at the end of the line
:inoremap << <Esc>$a,<Esc>

" Exit insert mode quickly
" Exit visual mode quickly
" write and close file quickly
:inoremap ;; <Esc>
:vnoremap ;; <Esc>;
:nnoremap <Leader>x :q<cr>

" Go to normal mode for one command
:inoremap <Leader>z <C-o>

" }}}


" Movement ----------------------------------------------------------- {{{

" Make H,L a 'stronger' version of h,l
" H goes to front of current line
" L goes to end of current line
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L $h
vnoremap dH d^

" make gi put cursor in center
nnoremap gi gi<Esc>zzi

" go to before/after pasted text
nnoremap gP `[
nnoremap gp `]

" go to previous/next cursor locations
nnoremap gb <C-O>
nnoremap gf <C-I>

" }}}


" Search/Replace -------------------------------------------------------- {{{


" if you don't like typing :%s to search+replace
nnoremap <leader>s :%s//<left>

" Search using text visually selected
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" Search and replace using visually selected ttext
" http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Center screen when moving between between search terms
nnoremap n nzzzv
nnoremap N Nzzzv

" open quickfiz with search results
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:open<CR>

" }}}

" adding comments in insert mode with commentary.vim
" use leader-x instead of ctrl-x with commentary.vim
:inoremap <Leader>x <C-X>

" shortcut to turn off search highlighting
nnoremap <leader>nh :noh

" Indentation ----------------------------------------------------------- {{{

:set smartindent
:set expandtab
:set shiftwidth=2
:set autoindent

" Ruby looks nice with width=2
" C,java look nice with width=4
" Javascript looks nice with width=4
" indent with spaces (spaces ftw!)
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype c setlocal ts=4 sts=4 sw=4
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4
autocmd Filetype java setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" }}}

" Text objects  ----------------------------------------------------------- {{{

" call textobj#user#plugin('datetime', {
" \   'date': {
" \     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
" \     'select': ['ad', 'id'],
" \   },
" \   'time': {
" \     'pattern': '\<\d\d:\d\d:\d\d\>',
" \     'select': ['at', 'it'],
" \   },
" \ })

" call textobj#user#plugin('line', {
" \   '-': {
" \     'select-a-function': 'CurrentLineA',
" \     'select-a': 'al',
" \     'select-i-function': 'CurrentLineI',
" \     'select-i': 'il',
" \   },
" \ })

function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
  \ non_blank_char_exists_p
  \ ? ['v', head_pos, tail_pos]
  \ : 0
endfunction

" Insert double brackets (depends on Ultisnips)"
" requires snippet definitions for '(, '{, 'dq, 'sq, '["
" to add (), {}, "", '', [] from within a snippet (see all.snippets)
:inoremap ( '(<Esc>:execute "normal a["<cr>a
:inoremap { '{<Esc>:execute "normal a["<cr>a
:inoremap " 'dq<Esc>:execute "normal a["<cr>a
:inoremap ' 'sq<Esc>:execute "normal a["<cr>a
:inoremap ,s '[<Esc>:execute "normal a["<cr>a
:inoremap ,r <space><space><Esc>i
" :inoremap | |<Esc>:execute "normal a["<cr>a

" Insert double brackets around visual selection
vnoremap ( xi'(<Esc>:execute "normal a["<cr>a<esc>p
vnoremap { xi'{<Esc>:execute "normal a["<cr>a<esc>p
vnoremap " xi'dq<Esc>:execute "normal a["<cr>a<esc>p
vnoremap ' xi'sq<Esc>:execute "normal a["<cr>a<esc>p
vnoremap ,s xi'[<Esc>:execute "normal a["<cr>a<esc>p

" Square brackets motion with d
" onoremap id i[
" vnoremap id i[
" onoremap ad a[
" vnoremap ad a[

" Go to next/prev text objects
" dinb = delete inside next brackets
" onoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
" xnoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
" onoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>
" xnoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>

" onoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
" xnoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
" onoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>
" xnoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>

" by Steve Losh
" https://bitbucket.org/sjl/dotfiles/src/c8b7d567fbc1b2d25c5f719cb78d33cfaa161ba0/vim/vimrc?at=default#cl-1857

" by Steve Losh
" https://bitbucket.org/sjl/dotfiles/src/c8b7d567fbc1b2d25c5f719cb78d33cfaa161ba0/vim/vimrc?at=default#cl-1959

" }}}

" Copy and paste ----------------------------------------------------------- {{{

" Prevent cursor move after yank
" http://stackoverflow.com/questions/3806629/yank-a-region-in-vim-without-the-cursor-moving-to-the-top-of-the-block
:vmap y ygv<Esc>

" with vim comipiled with clipboard+, 
" we can make vim and system clipboard work together
set clipboard=unnamed

" Visually select text just pasted with <leader>V
" go to just before/after pasted text with gp and gP
nnoremap <leader>v `[v`]

" Yank till end of line
:nnoremap Y y$

" Unconditional pasting
" http://vim.wikia.com/wiki/Unconditional_linewise_or_characterwise_paste
function! PasteJointCharacterwise(regname, pastecmd)
  let reg_type = getregtype(a:regname)
  call setreg(a:regname, '', "ac")
  exe 'normal "'.a:regname . a:pastecmd
  call setreg(a:regname, '', "a".reg_type)
  exe 'normal `[v`]J'
endfunction
nmap <Leader>p :call PasteJointCharacterwise(v:register, "p")<CR>
nmap <Leader>P :call PasteJointCharacterwise(v:register, "P")<CR>


" }}}


" Plugins ----------------------------------------------------------- {{{
"
" ctrlp custom maps
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<S-CR>'],
      \ 'AcceptSelection("v")': ['<C-CR>'],
      \ 'PrtExit()':            ['<C-X>']
      \}

nnoremap <leader>f :CtrlP<CR>

" emmet.vim custom trigger
let g:user_emmet_leader_key='<Leader>e'

" Ultisnips
let g:UltiSnipsExpandTrigger="\["
let g:UltiSnipsJumpForwardTrigger="\["
let g:UltiSnipsJumpBackwardTrigger="\]"

" jkjumps
let g:jk_jumps_minimum_lines = 2


" }}}

" Environments ----------------------------------------------------------- {{{

" Getting CTRL+ENTER to work
" --------------------------
" (1) http://superuser.com/questions/705147/is-it-safe-to-map-a-key-to-a-custom-escape-sequence-in-iterm
" use some unused function key codes to
" make special key combos work in terminal
" (2) for tmux we need to use an ifelse
" tmux will send different style escape codes compared to the ones we find outside tmux
" http://unix.stackexchange.com/questions/154501/can-i-get-my-iterm-key-combos-working-in-tmux
" Note that we must have 'set-option -g xterm-keys on' in .tmux.conf for this to work
if &term =~ "screen"
  set  <F13>=[1;2P
  set  <F14>=[1;2Q
  set  <F15>=[1;2R
  set  <F16>=[1;2S
  set  <F17>=[1;5P
  set  <F18>=[1;5Q
  set  <F19>=[1;5R
  set  <F20>=[1;5A
  set  <F21>=[1;5B
elseif &term =~ "xterm"
  set  <F13>=^O2P
  set  <F14>=^O2Q
  set  <F15>=^O2R
  set  <F16>=^O2S
  set  <F17>=^O5P
  set  <F18>=^O5Q
  set  <F19>=^O5R
  set  <F20>=[1;5A
  set  <F21>=[1;5B
endif
:map  <F13> <C-CR>
:map! <F13> <C-CR>
:map  <F14> <S-CR>
:map! <F14> <S-CR>
:map  <F15> <C-Space>
:map! <F15> <C-Space>
:map  <F16> <S-Space>
:map! <F16> <S-Space>

" }}}

" Maximise the current split 
" A bit like tmux zoom
:nnoremap <leader>z :call MaximizeToggle()<CR>
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction


" Editing files ----------------------------------------------------------- {{{

" Editing and sourcing .vimrc with leader+ev, leader+sv
" (where ev = edit vimrc, sv = source vimrc)
" Editing Ultisnips files with leader+es (es = edit snips)
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" :nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>es :vsplit $HOME/.vim/UltiSnips<cr>

" Edit another file in the same directory as current file
:nnoremap <leader>dd :e <C-R>=expand("%:p:h") . '/'<CR><CR>
:nnoremap <leader>ds :split <C-R>=expand("%:p:h") . '/'<CR><CR>
:nnoremap <leader>dv :vnew <C-R>=expand("%:p:h") . '/'<CR><CR>

" }}}

" Syntax checking (syntastic) ---------------------------------------------- {{{

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" }}}
"
"
