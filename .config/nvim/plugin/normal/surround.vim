" Name: Surround
" Author: Nicholas Truong

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
  " Only continue if we are in visual mode.
  if mode() != 'v'
    return
  endif
  " Pairs to surround text with.
  let l:pairs = {
  \ '(' : '()',
  \ '[' : '[]',
  \ '{' : '{}',
  \ '<' : '<>'
  \ }
  " Surround the text.
  let l:txt = has_key(l:pairs, l:cmd) ? l:pairs[l:cmd] : l:cmd . l:cmd
  execute 'normal! c' . l:txt . "\<Esc>P``"
endfunction
function! s:SurroundPrompt(cmd) abort
  " If we are currently in visual mode, toggle visual mode again to prepare to
  " select more text.
  if mode() == 'v'
    execute 'normal! v'
  endif
  " Only select text if we have an appropriate query string.
  if a:cmd =~ '[ia].*'
    execute 'normal! v' . a:cmd[0:1] . 'o'
  endif
  " Update for changes.
  redraw
endfunction
nnoremap <Plug>Surround :call <SID>Surround()<CR>
