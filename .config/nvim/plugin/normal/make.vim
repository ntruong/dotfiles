" Name: Async makeprg
" Author: Nicholas Truong

" Track the pid of the current job.
let s:makeprg_pid = -1

" on_stdout callback; we store file, makeprg, and errorformat so that we have
" the correct values even if the current buffer changes before this is called.
function! s:OnStdout(file, mp, efm, channel, data, stream) abort
  call reverse(a:data)
  let l:data = reverse(a:data[:match(a:data, '^Running')])
  let what = {
    \ 'efm':   a:efm,
    \ 'lines': l:data,
    \ 'nr'   : '$',
    \ 'title': a:mp,
    \ }
  call setqflist([], ' ', what)
  doautocmd <nomodeline> QuickFixCmdPost a:file
  cwindow
endfunction

" on_exit callback; we store makeprg so that we have the correct value even if
" the current buffer changes before this is called.
function! s:OnExit(mp, job, exitcode, event) abort
  let s:makeprg_pid = -1
  set statusline-=\ [↯]
  echom '`' . a:mp . '`' . ' finished with exit code ' . a:exitcode
endfunction

" Job control options.
function! s:Opts() abort
  return {
    \ 'stdout_buffered' : v:true,
    \ 'on_stdout' : function('s:OnStdout', [bufname(''), &mp, &efm]),
    \ 'on_exit' : function('s:OnExit', [&mp])
    \ }
endfunction

" Asynchronously call the given &makeprg.
function! s:Make() abort
  " Expand any file arguments set in the &makeprg.
  let cmd = join(map(split(&makeprg), { key, val -> expand(val) }))
  let cmd .= " 2>&1"
  " Stop a previous job if necessary.
  if s:makeprg_pid > 0
    call jobstop(s:makeprg_pid)
  endif
  let s:makeprg_pid = jobstart(cmd, s:Opts())
  if s:makeprg_pid > 0
    set statusline+=\ [↯]
  endif
endfunction

command! Make call s:Make()
