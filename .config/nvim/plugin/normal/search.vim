" Name: Search
" Author: Nicholas Truong

" Highlight the focused search term differently.
function! s:Search(ch)
  call clearmatches()
  call matchadd("IncSearch", '\%#' . @/)
  return a:ch
endfunction
nnoremap <expr> <Plug>searchn <SID>Search("n")
nnoremap <expr> <Plug>searchN <SID>Search("N")
