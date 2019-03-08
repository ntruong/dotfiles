" Name: Surround
" Author: Nicholas Truong

" Pairs of characters we recognize.
let s:pairs = {
  \ '(' : '()',
  \ '[' : '[]',
  \ '{' : '{}',
  \ '<' : '<>'
  \ }

" If we are currently in visual mode, toggle it off.
function! s:VisualOff() abort
  if mode() == 'v'
    execute 'normal! v'
  endif
endfunction

function! s:Surround() abort
  " Listen for updates to the command line.
  augroup Cmdline
    autocmd!
    autocmd CmdlineChanged * call s:SurroundPrompt(getcmdline())
  augroup END
  " Mark the current location.
  execute 'normal! m`'
  " Get the selected object and surround character(s).
  let l:cmd = input('surround ↯ ')[2:]
  " Clear the autogroup.
  augroup Cmdline
    autocmd!
  augroup END
  " Quit if we are not in visual mode or if the user canceled.
  if mode() != 'v' || empty(l:cmd)
    call s:VisualOff()
    execute 'normal! ``'
    return
  endif
  " Save the unnamed register.
  let l:reg = @"
  " Surround the text.
  let l:txt = has_key(s:pairs, l:cmd) ? s:pairs[l:cmd] : l:cmd . l:cmd
  execute 'normal! c' . l:txt . "\<Esc>P``"
  " Restore the unnamed register.
  let @" = l:reg
endfunction
function! s:SurroundPrompt(cmd) abort
  " If we are currently in visual mode, toggle visual mode again to prepare to
  " select more text.
  call s:VisualOff()
  " Only select text if we have an appropriate query string.
  if a:cmd =~ '[ia].*'
    execute 'normal! v' . a:cmd[0:1] . 'o'
  endif
  " Update for changes.
  redraw
endfunction
nnoremap <Plug>Surround :call <SID>Surround()<CR>
