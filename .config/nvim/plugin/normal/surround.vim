" Name: Surround
" Author: Nicholas Truong

" Save the position of the user.
let s:pos = [0, 0, 0, 0]

" Pairs of characters we recognize.
let s:pairs = {
  \ '(' : '()',
  \ '[' : '[]',
  \ '{' : '{}',
  \ '<' : '<>'
  \ }

" Reset the user to the starting state.
function! s:Reset() abort
  if mode() == 'v'
    execute 'normal! v'
  endif
  call cursor(s:pos[1:])
endfunction

function! s:Surround() abort
  " Save the position of the user.
  let s:pos = getpos(".")
  " Listen for updates to the command line.
  augroup Cmdline
    autocmd!
    autocmd CmdlineChanged * call s:SurroundPrompt(getcmdline())
  augroup END
  " Get the selected object and surround character(s).
  let l:cmd = input('surround ↯ ')[2:]
  " Clear the autogroup.
  augroup Cmdline
    autocmd!
  augroup END
  " Quit if we are not in visual mode or if the user canceled.
  if mode() != 'v' || empty(l:cmd)
    call s:Reset()
    return
  endif
  " Save the unnamed register.
  let l:reg = @"
  " Surround the text.
  let l:txt = has_key(s:pairs, l:cmd) ? s:pairs[l:cmd] : l:cmd . l:cmd
  execute 'normal! c' . l:txt . "\<Esc>P"
  " Restore the unnamed register.
  let @" = l:reg
  " Restore the position.
  call s:Reset()
endfunction
function! s:SurroundPrompt(cmd) abort
  " Reset the position.
  call s:Reset()
  " Match text objects.
  if a:cmd =~ '^[ia].*'
    execute 'normal! v' . a:cmd[0:1] . 'o'
  endif
  " Update for changes.
  redraw
endfunction
nnoremap <Plug>Surround :call <SID>Surround()<CR>
