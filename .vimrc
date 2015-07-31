" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-commentary'
Plugin 'ReekenX/vim-rename2'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'teranex/jk-jumps.vim'
Plugin 'mattn/emmet-vim'

" Plugin 'SirVer/ultisnips'

Plugin 'kana/vim-textobj-user'
"Plugin 'Julian/vim-textobj-brace'
Plugin 'file:///Users/james/github_projects/vim-textobj-brace'
Plugin 'beloglazov/vim-textobj-quotes'
Plugin 'glts/vim-textobj-comment'

" Run Rspec specs from vim
Plugin 'tpope/vim-dispatch'
Plugin 'thoughtbot/vim-rspec'

Plugin 'tpope/vim-rails'

" Highlight trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'

" compiler plugin to run nodelint.
" Plugin 'bigfish/vim-nodelint'

Plugin 'nanotech/jellybeans.vim'
call vundle#end() " required by vundle
filetype plugin indent on " required by vundle

colorscheme jellybeans

" reduce keymap timeout from default
" of 1000ms to 200ms
set timeoutlen=1000

" Useful aliases for the command line
command! W w
command! Q q
command! Q q
command! Qall qall
command! QA qall
command! E e

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
" allow backspacing over everything in insert mode
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" Use Space to play macros
" :nnoremap <S-Space> @q
:nnoremap <Space> @q

" ignore case when searching with /
:set ignorecase

:set smartcase

" highlight all matches when we perform a search
:set hlsearch

" Highlight next match *while still typing out search pattern*
:set incsearch

" keep 3 lines visible at top and bottom
:set scrolloff=3

" map the vim Leader Key to comma
let mapleader = ","

" :nnoremap <leader>m %
:set showmatch

" Nicer highlighting of matching paranthsis
" http://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta


" Disable  ----------------------------------------------------------- {{{

" Disable VIM backups (.swp files)
" a controversial mapping but I save so often that I don't need them.
" Also when I close terminal without exiting vim,
" it's a real hassle deleting .swp files
set nobackup
set noswapfile

" Don't clutter my dirs up with swp and tmp files
" set backupdir=~/.tmp
" set directory=~/.tmp

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
" nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Turn on invisibles by default
set list!

command! Inv set list!

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

inoremap { {}<esc>i
inoremap ( ()<esc>i
inoremap ) <c-o>:call SmartBrackets()<cr>

function! SmartBrackets()
  let l = line(".")
  let c = col(".")
  let line = getline(".")
  let current = matchstr(line, '\%' . c . 'c.')
  let next = matchstr(line, '\%' . (c+1) . 'c.')
  if (current ==# ')')
    call cursor(l, c+1)
  else
    execute "normal! i)"
    execute "normal! l"
  endif
endfunction


" :inoremap | |<Esc>:execute "normal a["<cr>a

" function! MoveAfterBrackets()
"   let l = line(".")
"   let c = col(".")
"   let line = getline(".")
"   let current = matchstr(line, '\%' . c . 'c.')
"   let prev = matchstr(line, '\%' . (c-1) . 'c.')
"   if (prev ==# '(' && current ==# ')')
"     call cursor(l, c+1)
"   endif
" endfunction

" :autocmd InsertLeave * :call SmartBrackets()
" http://stackoverflow.com/a/23323958/3649209
" function! MoveAfterBrackets()
"   let l = line(".")
"   let c = col(".")
"   let line = getline(".")
"   let current = matchstr(line, '\%' . c . 'c.')
"   let next = matchstr(line, '\%' . (c+1) . 'c.')
"   if (current ==# '(' && next ==# ')')
"     call cursor(l, c+1)
"   endif
" endfunction

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
nnoremap L g_l
vnoremap H ^
vnoremap L $h
vnoremap dH d^

" Make m/M go to the end of the previous word/WORD
nnoremap m ge
nnoremap M gE

" make gi put cursor in center
nnoremap gi gi<Esc>zzi

" go to previous/next cursor locations
nnoremap gb <C-O>
nnoremap gf <C-I>

" repeat a find in visual mode
vnoremap <leader><leader> ;

" better movement when lines are long (line wrapping)
" noremap j gj
" noremap k gk


" }}}


" Splits ----------------------------------------------------------- {{{


" vertical split opens new split area _below_
" (not above, which is the default)
set splitbelow

" horizontal split opens new split area on the _right_
" (not left, which is the default)
set splitright

" nnoremap z<left> <C-W><C-H>
" nnoremap z<down> <C-W><C-J>
" nnoremap z<up> <C-W><C-K>
" nnoremap z<right> <C-W><C-L>

" nnoremap zk :res +5<cr>
" nnoremap zj :res -5<cr>
" nnoremap zh :vertical resize -5<cr>
" nnoremap zl :vertical resize +5<cr>

nnoremap zh <C-W><C-H>
nnoremap zj <C-W><C-J>
nnoremap zk <C-W><C-K>
nnoremap zl <C-W><C-L>

nnoremap z<up> :res +5<cr>
nnoremap z<down> :res -5<cr>
nnoremap z<left> :vertical resize -5<cr>
nnoremap z<right> :vertical resize +5<cr>

nnoremap zs :sp<cr>
nnoremap zv :vsp<cr>
nnoremap zz <C-W><C-W>

nnoremap <leader>fp <c-^>


" nnoremap zx <c-w>q

" nnoremap zx :!

" nnoremap zc zz
" nnoremap sv :source $MYVIMRC<cr>

" depends on UltiSnips
nnoremap <leader>es :vsplit $HOME/.vim/UltiSnips<cr>

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

" }}}
"

" Indentation ----------------------------------------------------------- {{{

:set smartindent
:set expandtab
:set shiftwidth=2
:set autoindent

" Ruby looks nice with width=2
" C,java look nice with width=4
" Javascript looks nice with width=4
" indent with *spaces*, not tabs
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype c setlocal ts=4 sts=4 sw=4
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4
autocmd Filetype java setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

" }}}

" Text objects  ----------------------------------------------------------- {{{

" Insert double brackets (depends on Ultisnips)"
" requires snippet definitions for '(, '{, 'dq, 'sq, '["
" to add (), {}, "", '', [] from within a snippet (see all.snippets)
" :inoremap ( '(<Esc>:execute "normal a["<cr>a
" :inoremap { '{<Esc>:execute "normal a["<cr>a
" :inoremap " 'dq<Esc>:execute "normal a["<cr>a
" :inoremap ' 'sq<Esc>:execute "normal a["<cr>a
" :inoremap ,s '[<Esc>:execute "normal a["<cr>a
" :inoremap ,r <space><space><Esc>i
" :inoremap | |<Esc>:execute "normal a["<cr>a

" Insert double brackets around visual selection
" vnoremap ( xi'(<Esc>:execute "normal a["<cr>a<esc>p
" vnoremap { xi'{<Esc>:execute "normal a["<cr>a<esc>p
" vnoremap " xi'dq<Esc>:execute "normal a["<cr>a<esc>p
" vnoremap ' xi'sq<Esc>:execute "normal a["<cr>a<esc>p
" vnoremap ,s xi'[<Esc>:execute "normal a["<cr>a<esc>p
"
vnoremap q <esc>:call QuickWrap("'")<cr>
vnoremap Q <esc>:call QuickWrap('"')<cr>
vnoremap s <esc>:call StripWrap()<cr>

function! QuickWrap(wrapper)
  let l:w = a:wrapper
  let l:inside_or_around = (&selection == 'exclusive') ? ('i') : ('a')
  normal `>
  execute "normal " . inside_or_around . escape(w, '\')
  normal `<
  execute "normal i" . escape(w, '\')
  normal `<
endfunction

function! StripWrap()
  normal `>x`<x
endfunction


" A hack to allow lowercase user commands
" let g:command_line_substitutes = [
"      \ ['^inv ', 'Inv ']
" \]
" function! CommandLineSubstitute()
"     let cl = getcmdline()
"     if exists('g:command_line_substitutes')
"         for [k, v] in g:command_line_substitutes
"             if match(cl, k) == 0
"                 let cl = substitute(cl, k, v, "")
"                 break
"             endif
"         endfor
"     endif
"     return cl
" endfunction
" cnoremap <cr> <c-\>eCommandLineSubstitute()<cr><cr>
" end hack

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

" go to before/after pasted text
nnoremap gP `[
nnoremap gp `]

" Yank till end of line
:nnoremap Y y$

" Unconditional pasting
" http://vim.wikia.com/wiki/Unconditional_linewise_or_characterwise_paste
" function! PasteJointCharacterwise(regname, pastecmd)
"   let reg_type = getregtype(a:regname)
"   call setreg(a:regname, '', "ac")
"   exe 'normal "'.a:regname . a:pastecmd
"   call setreg(a:regname, '', "a".reg_type)
"   exe 'normal `[v`]J'
" endfunction
" nmap <Leader>p :call PasteJointCharacterwise(v:register, "p")<CR>
" nmap <Leader>P :call PasteJointCharacterwise(v:register, "P")<CR>


" }}}


" Plugins ----------------------------------------------------------- {{{
"
" ctrlp custom maps
nnoremap <leader>p :CtrlP<CR>

let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|tmp|target|dist)|(\.(swp|ico|git|svn))$'

" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 0
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:40,results:40'
" let g:ctrlp_map = ''
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<leader>'],
      \ 'AcceptSelection("v")': ['<V>'],
      \ 'PrtExit()':            ['<X>', '', '<esc>']
      \}
" AcceptSelection("h") = what mapping triggers opening horizontal split
" AcceptSelection("v") = what mapping triggers opening vertical split
" AcceptSelection("v") = what mapping closes ctrlp prompt
"
" let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }
" function! CtrlPMappings()
"   nnoremap <buffer> <silent> ,h :call JamesTest()<cr>
" endfunction
" function! JamesTest()
"   echom "Hello"
"   echo "Hello"
" endfunction

" emmet.vim custom trigger
let g:user_emmet_leader_key='<Leader>e'

" Ultisnips
" let g:UltiSnipsExpandTrigger="\["
" let g:UltiSnipsJumpForwardTrigger="\["
" let g:UltiSnipsJumpBackwardTrigger="\]"

" let g:ycm_key_invoke_completion="<cr>" bad

" thoughtbot/vim-rspec + tpope/dispatch
let g:rspec_command = "Dispatch rspec {spec}"
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>



" Ultisnips + YouCompleteMe
" let g:UltiSnipsExpandTrigger="\[" good
let g:UltiSnipsJumpForwardTrigger="\["
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt
let g:ulti_expand_or_jump_res = 0 "default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
  call UltiSnips#ExpandSnippetOrJump()
  return g:ulti_expand_or_jump_res
endfunction
function! InvokeUlti()
  if Ulti_ExpandOrJump_and_getRes() > 0
    return ""
  else
    return "["
  endif
endfunction
inoremap [ <c-r>=InvokeUlti()<cr>


" jkjumps
let g:jk_jumps_minimum_lines = 2


" YouCompleteMe keybindings
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', ']']
" let g:ycm_key_invoke_completion = '<cr>' bad!


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
