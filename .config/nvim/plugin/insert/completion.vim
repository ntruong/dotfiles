" Name: Completion
" Author: Nicholas Truong

" Start completion in insert mode.
function! s:Completion(type) abort
  if col(".") > 1 && strpart(getline("."), col(".") - 2, 3) =~ '^\w'
    return a:type
  else
    return "\<Tab>"
  endif
endfunction
inoremap <expr> <Plug>Completion     <SID>Completion('<C-n>')
inoremap <expr> <Plug>PrevCompletion <SID>Completion('<C-p>')
