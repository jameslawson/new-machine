" +----------------------------------------------------------------
" | Author: James Lawson
" | License: MIT
" | Description: Neovim Config (github.com/jameslawson/dotfiles)
" +----------------------------------------------------------------

" ----------------------------------------------------------
" -- 1. CORE APPEARANCE
" ----------------------------------------------------------

" -- always syntax highlight; highlight current line
"    and always use line numbers
syntax enable
set cursorline
set number

" -- always keep 3 lines visible at top and bottom
"    when cursor hits top/bottom as you scroll
set scrolloff=3

" ----------------------------------------------------------
" -- 2. CORE BEHAVIOUR
" ----------------------------------------------------------
let mapleader = ","
set timeoutlen=400
inoremap ;; <Esc>
vnoremap ;; <Esc>

" -- add semicolon at the end of the line and exit insert mode by
"    using <leader><leader> if vim autocomplete window is open, pick the
"    highlighted suggestion, close the window, add a semicolon
"    at the end of the line and then exit insert mode
inoremap <expr> <leader><leader> pumvisible() ?  "\<C-Y><Esc>$a;<Esc>" : "\<Esc>$a;<Esc>"

" -- supress newlines that are sometimes added by vim autocomplete
"    http://superuser.com/a/941082
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" ----------------------------------------------------------
" -- 3. CORE EDITING
" ----------------------------------------------------------

" -- fix backspace (http://vim.wikia.com/wiki/Backspace_and_delete_problems)
set backspace=indent,eol,start

" -- pressing enter in normal mode adds a new line
"    (instead of moving the cursor to the new line)
nmap <cr> o<esc>k

" -- keep the cursor in place when using J to join lines
nnoremap J mzJ`z

" -- given J joins a line, why not have S split a line
"    make S break (split) a line into two lines
"    placing the second line in a new line belong
nnoremap S i<cr><esc>:%s/\s\+$//e<cr>

" -- some sneaky shortcuts for inserting symbols
inoremap <leader>h #
inoremap <leader>b `
inoremap <leader>c ,

" ----------------------------------------------------------
" -- 4. CORE MOVEMENT
" ----------------------------------------------------------

" -- make H,L a 'stronger' version of h,l
"    H and L goes to start/end of current line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $h

" ----------------------------------------------------------
" -- 5. COPY AND PASTE
" ----------------------------------------------------------

" -- prevent cursor move after yank
vmap y ygv<Esc>

" -- nvim access macOS system clipboard
set clipboard=unnamed

" -- visually select text just pasted with <leader>V
"    go to just before/after pasted text with gp and gP
nnoremap <leader>v `[v`]

" ----------------------------------------------------------
" -- 6. SEARCH AND REPLACE
" ----------------------------------------------------------

set ignorecase
set smartcase
set hlsearch
set incsearch

" -- center screen when moving between between search terms
nnoremap n nzzzv
nnoremap N Nzzzv

" ----------------------------------------------------------
" -- 7. INDENTATION
" ----------------------------------------------------------

set smartindent
set expandtab
set shiftwidth=2
set autoindent

" ----------------------------------------------------------
" -- 8. MACROS
" ----------------------------------------------------------

" -- replay macros with space
nnoremap <Space> @q

" ----------------------------------------------------------
" -- 9. FORGIVING
" ----------------------------------------------------------

" -- make :W an alias for :w
"    similarly make :Q an alias for :q and make :Wq an alias for :wq
command! Wq wq
command! W w
command! Q q

" ----------------------------------------------------------
" -- 10. DISABLE
" ----------------------------------------------------------

" -- map arrow keys to no-ops
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" -- disable Q (Ex Mode), K and U (emacs-style undo)
map Q <nop>
nnoremap K <nop>
nnoremap U <nop>

" ----------------------------------------------------------
" -- 11. PLUGINS
" ----------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

" -- EDITING
Plug 'tpope/vim-commentary'           " [COMMENT]
Plug 'kana/vim-textobj-user'          " [TOBJ]
Plug 'beloglazov/vim-textobj-quotes'  " [TOBJQ], depends on [TOBJ]
Plug 'mattn/emmet-vim'                " [EMMET]

" -- BEHAVIOUR
Plug 'milkypostman/vim-togglelist'    " [TOGLIST]

" -- APPEARANCE
Plug 'nanotech/jellybeans.vim'         " [JELLY]
Plug 'vim-airline/vim-airline'         " [AIRLINE]
Plug 'ntpeters/vim-better-whitespace'  " [WSPACE]

" -- SYNTAX HIGHLIGHTING
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'gutenye/json5.vim'

" -- BACKGROUND PROCESSES (CODE COMPLETION, SEARCH, ERROR CHECKING)
Plug 'dense-analysis/ale'                                         " [ALE]
Plug 'embear/vim-localvimrc'
Plug 'neomake/neomake'                                            " [NEOMAKE]
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }     " [DEOPLETE]
Plug 'SirVer/ultisnips'                                           " [ULTISNIPS]
Plug 'junegunn/fzf', { 'do': './install --bin' }                  " [FZF]
Plug 'junegunn/fzf.vim'                                           " [FZF]

call plug#end()

" ----------------------------------------------------------
" -- 12. PLUGIN CONFIG
" ----------------------------------------------------------

" -- depends on [JELLY]
colorscheme jellybeans

" -- depends on [NEOMAKE]
call neomake#configure#automake('rw', 500)
let g:neomake_virtualtext_current_error = 0
let g:neomake_python_enabled_makers = ['pylama']
let g:neomake_error_sign={'text': '*', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign={'text': '*', 'texthl': 'NeomakeWarningSign'}
let g:neomake_info_sign = {'text': '*', 'texthl': 'NeomakeInfoSign' }
let g:neomake_message_sign = {'text': '*', 'texthl': 'NeomakeMessageSign' }
:highlight NeomakeErrorMsg ctermfg=227 ctermbg=237
:highlight NeomakeWarningSign ctermfg=130 ctermbg=237

" -- depends on [DEOPLETE]
" let g:deoplete#enable_at_startup = 1

" " -- depends on [ALE]
" let g:ale_fixers = {'javascript': ['eslint'], 'typescript': ['eslint'], 'typescriptreact': ['eslint']}
let g:localvimrc_whitelist='/Users/james/github/jameslawson/*'


" -- depends on [FZF], brew install ripgrep
nnoremap <leader>p :Files<CR>

" -- change default from CTRL+Y-comma to comma-e-comma
" let g:user_emmet_leader_key='<leader>e'

" -- [ULTI] change snippet insert from TAB to [
" let g:UltiSnipsExpandTrigger="[" this doesnt work because of SirVer/ultisnips/issues/376
let g:UltiSnipsExpandTrigger = "<nop>"
inoremap <expr> [ pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\["
