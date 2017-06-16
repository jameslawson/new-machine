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

" -- #include directive
Snippet inc #include <<{}>>
Snippet include #include <<{}>>

" -- #define directive
Snippet def #define <{}>
Snippet define #define <{}>

" -- main function
Snippet main int main(int argc, char *argv[]) {<cr> <{}> <cr>}

" -- printf, printf with newline
Snippet pf printf("<{}>")
Snippet pfn printf("<{}>\n")
