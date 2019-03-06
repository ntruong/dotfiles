" Name: LaTeX configuration for Vim
" Author: Nicholas Truong

" Asynchronously call latexmk on the current file.
function! s:Make() abort
  call s:MakeStop()
  let cmd  = "latexmk "
  let cmd .= "-interaction=nonstopmode "
  let cmd .= "-pvc "
  let cmd .= "-pdf "
  let cmd .= expand("%:t")
  let b:latexmk_pid = jobstart(cmd)
endfunction
" Cancel the current async latexmk job.
function! s:MakeStop() abort
  if b:latexmk_pid > 0
    call jobstop(b:latexmk_pid)
  endif
  let b:latexmk_pid = -1
endfunction
let b:latexmk_pid = -1
command! -buffer Make call s:Make()
command! -buffer MakeStop call s:MakeStop()
" Put a notice for make in the statusline.
setlocal statusline+=\ [%{b:latexmk_pid\ >\ 0\ ?\ \"↯\"\ :\ \"\ \"}]
