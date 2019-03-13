" Name: Async makeprg
" Author: Nicholas Truong

" Track the pid of the current job.
let s:makeprg_pid = -1

" on_stdout callback.
function! s:OnStdout(channel, data, stream) abort
  cgetexpr a:data
endfunction

" on_exit callback.
function! s:OnExit(job, exitcode, event) abort
  let s:makeprg_pid = -1
  set statusline-=\ [↯]
  echom &makeprg . " finished with exit code " . a:exitcode
endfunction

" Job control options.
let s:opts = {
  \ 'stdout_buffered' : v:true,
  \ 'on_stdout' : function('s:OnStdout'),
  \ 'on_exit'   : function('s:OnExit')
  \ }

" Asynchronously call the given &makeprg.
function! s:Make() abort
  " Expand any file arguments set in the &makeprg.
  let cmd = join(map(split(&makeprg), { key, val -> expand(val) }))
  let cmd .= " 2>&1"
  " Stop a previous job if necessary.
  if s:makeprg_pid > 0
    call jobstop(s:makeprg_pid)
  endif
  let s:makeprg_pid = jobstart(cmd, s:opts)
  if s:makeprg_pid > 0
    set statusline+=\ [↯]
  endif
endfunction

command! Make call s:Make()
