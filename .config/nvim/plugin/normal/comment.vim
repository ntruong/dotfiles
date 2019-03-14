" Name: Comment
" Author: Nicholas Truong

function! s:Comment() abort
  " Get filetype comments.
  let l:comments = split(&comments, ",")
  let l:commentpairs = map(l:comments, { k, v -> split(v, ":") })
  let l:comment = filter(l:commentpairs, { k, v, -> len(v) == 1 })
  if len(l:comment) < 1
    return
  endif
  let l:comment = l:comment[0][0]
  let l:line  = getline(".")
  let l:begin = strpart(l:line, match(l:line, '\S'), strlen(l:comment))
  let l:c     = col(".")
  let l:cmd   = ""
  if l:begin == l:comment
    let l:c -= strlen(l:comment) + 1
    let l:c = (l:c > 0) ? l:c : 0
    normal! _dW
  else
    let l:c += strlen(l:comment) + 1
    execute "normal! I" . l:comment . " "
  endif
  call cursor(".", l:c)
endfunction
nnoremap <Plug>Comment :call <SID>Comment()<CR>
