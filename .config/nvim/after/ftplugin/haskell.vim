" Name: Haskell configuration for Vim
" Author: Nicholas Truong

" Compiler.
compiler stack
" Text-objects.
nnoremap <silent> <buffer> ]] :call search('::', "sW")<CR>
nnoremap <silent> <buffer> [[ :call search('::', "sbW")<CR>
" Text functions.
inoremap ' '
