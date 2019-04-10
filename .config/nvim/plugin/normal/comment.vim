" Name: Comment
" Author: Nicholas Truong

function! s:Comment() abort
  let l:comment = split(&commentstring, "%s")[0]
  let l:line  = getline(".")
  let l:begin = strpart(l:line, match(l:line, '\S'), strlen(l:comment))
  let l:c     = col(".")
  let l:cmd   = ""
  if l:begin == l:comment
    let l:c -= strlen(l:comment) + 1
    let l:c = (l:c > 0) ? l:c : 0
    normal! _"_dW
  else
    let l:c += strlen(l:comment) + 1
    execute "normal! I" . l:comment . " "
  endif
  call cursor(".", l:c)
endfunction
nnoremap <Plug>Comment :call <SID>Comment()<CR>
