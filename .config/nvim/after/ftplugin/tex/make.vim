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
  if exists("b:latexmk_pid") && b:latexmk_pid > 0
    call jobstop(b:latexmk_pid)
    let b:latexmk_pid = -1
  endif
endfunction
command! -buffer Make call s:Make()
command! -buffer MakeStop call s:MakeStop()
