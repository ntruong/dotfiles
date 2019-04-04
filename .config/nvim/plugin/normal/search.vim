" Name: Search
" Author: Nicholas Truong

" Highlight the focused search term differently.
function! s:Search(ch) abort
  call clearmatches()
  let l:search = substitute(@/, '\(\\m\|\\M\|\\V\)', '', 'g')
  call matchadd("IncSearch", '\v%#(' . l:search . ')')
  return a:ch
endfunction
nnoremap <expr> <Plug>searchn <SID>Search("n")
nnoremap <expr> <Plug>searchN <SID>Search("N")
