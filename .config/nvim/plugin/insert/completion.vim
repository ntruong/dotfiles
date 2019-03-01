" Name: Completion
" Author: Nicholas Truong

function! s:Completion() abort
  if col(".") > 1 && strpart(getline("."), col(".") - 2, 3) =~ '^\w'
    return "\<C-n>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <expr> <Plug>Completion <SID>Completion()
