" +---------------------------------------------------------
" | Description: Python snippets for vim w/snippetsEmu
" | Author: James Lawson
" | License: MIT
" +---------------------------------------------------------

" ----------------------------------------------------------
" -- DEPENDENCIES
" ----------------------------------------------------------
"  Requires `snippetsEmu` plugin to be added to vim's rtp
"
Snippet sys from sys import stdin<{}>
Snippet stdin from sys import stdin<{}>
Snippet rl stdin.readline()<{}>
Snippet rls for line in stdin.readlines():<cr>   <{}>
Snippet rx x = int(stdin.readline())<{}>
Snippet rxs xs = map(int, stdin.readline().split())<{}>

Snippet main if __name__ == '__main__':<cr><{}>
Snippet forn for _ in range(n):<cr><{}>
