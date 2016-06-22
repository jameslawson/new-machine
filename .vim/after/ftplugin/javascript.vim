" +---------------------------------------------------------
" | Description: Javascript snippets for vim w/snippetsEmu
" | Author: James Lawson
" | License: MIT
" +---------------------------------------------------------

" ----------------------------------------------------------
" -- DEPENDENCIES
" ----------------------------------------------------------
"  Requires `snippetsEmu` plugin to be added to vim's rtp

" ----------------------------------------------------------
" -- BASICS
" ----------------------------------------------------------

" -- ES5 Strict Mode
Snippet us 'use strict';
Snippet strict 'use strict';

" -- Console Log
Snippet log console.log(<{}>)
Snippet clog console.log(<{}>)

" -- Function declaration
Snippet fn function <{}>() {<cr> <{}> <cr>}
Snippet fun function <{}>() {<cr> <{}> <cr>}


" ----------------------------------------------------------
" -- CONTROL FLOW
" ----------------------------------------------------------

" -- if statement
Snippet if if (<{condition}>) {<cr> <{}> <cr>}

" -- for loop
Snippet for for (var <{i}> = <{}>; <{i}> < <{}> <{i}>++) {<cr> <{}> <cr>}

" ----------------------------------------------------------
" -- DOCUMENTATION
" ----------------------------------------------------------

" -- The `doc` snippet generates a jsdoc.
"    /**
"     * @description Lorem ipsum
"     * @param {String} foo - The name of a foo
"     * @param {Number} bar - The number of foos in a bar
"     */
" -- Follows the 'Google Closure Compiler' variant of jsdoc.
"    - https://developers.google.com/closure/compiler/docs/js-for-compiler
"    - https://code.google.com/p/jsdoc-toolkit/
" -- Try and find a function below current line.
"    If we find a function, find its parameters names
"    via various regex manipulations.
"    For each param name, add a @param line
"    to the generated jdoc snippet
function! ReadParams()
  let lnum = screenrow()
  let params = getline(lnum+1)

  " remove the function keyword
  let params = substitute(params, "^function", "", "")
  " remove the function name (should it exist)
  let params = substitute(params, "^[^\\(]*", "", "")
  " remove the opening parenthesis
  let params = substitute(params, "^(", "", "")
  " remove the closing parenthesis and everything after
  let params = substitute(params, ").*$", "", "")
  " remove any whitespace
  let params = substitute(params, "\\s", "", "g")
  " extract the names and put them into an array
  let names = split(params, ",")

  " build up the documentation
  let doc = "/**" . "\n"
  let doc = join([doc, "@description", " ", "<{}>", "\n"], "")
  for paramname in names
    let doc = join([doc, "@param", " ", "{<{}>}", " ", paramname, " ", "<{}>", "\n"], "")
  endfor
  let doc = doc . "/"
  return doc
endfunction
Snippet doc ``ReadParams()``


" -- The `fdoc` snippet generates a jsdoc _for the file_
function! FileDoc()
  " build up the documentation
  let doc = "/**" . "\n"
  let doc = join([doc, "@file", " ", expand('%:t'), "\n"], "")
  let doc = join([doc, "@description", " ", "<{}>", "\n"], "")
  let doc = join([doc, "@see", " ", "<{}>", "\n"], "")
  let doc = join([doc, "@author", " ", "James Lawson <james.lawson10@imperial.ac.uk>", "\n"], "")
  let doc = doc . "/"
  return doc
endfunction
Snippet fdoc ``FileDoc()``


" ----------------------------------------------------------
" -- BDD
" ----------------------------------------------------------

" -- describe block
Snippet d describe("<{}>", function() {<cr> <{}> <cr>});

" -- it block
Snippet it it("<{}>", function() {<cr> <{}> <cr>});
