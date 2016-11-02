" +---------------------------------------------------------
" | Description: C snippets for vim w/snippetsEmu
" | Author: James Lawson
" | License: MIT
" +---------------------------------------------------------

" ----------------------------------------------------------
" -- DEPENDENCIES
" ----------------------------------------------------------
"  Requires `snippetsEmu` plugin to be added to vim's rtp
"

" -- #include
Snippet inc #include <<{}>>
Snippet include #include <<{}>>

" -- main function
Snippet main int main(int argc, char *argv[]) {<cr> <{}> <cr>}
