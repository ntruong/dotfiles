" Name: Surround
" Author: Nicholas Truong

" Save the position of the user.
let s:pos = [0, 0, 0, 0]

" Regex prefixes to a surround command we recognize.
let s:rtextobj = '^[ia].*'

" Text to surround with.
let s:stext = ["", ""]

" Pairs of characters we recognize.
let s:pairs = {
  \ '(' : ['(', ')'],
  \ '[' : ['[', ']'],
  \ '{' : ['{', '}'],
  \ '<' : ['<', '>']
  \ }

" Reset the user to the starting state.
function! s:Reset() abort
  if mode() == 'v'
    execute 'normal! v'
  endif
  call cursor(s:pos[1:])
  let s:stext = ["", ""]
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
  let l:cmd = input('surround ↯ ')
  " Clear the autogroup.
  augroup Cmdline
    autocmd!
  augroup END
  " Quit if we are not in visual mode or if the command was invalid.
  if mode() != 'v' || l:cmd !~ s:rtextobj
    call s:Reset()
    return
  endif
  " Save the unnamed register.
  let l:reg = @"
  " Surround the text.
  execute 'normal! c' . s:stext[0] . "\<C-o>P" . s:stext[1] . "\<Esc>"
  " Restore the unnamed register.
  let @" = l:reg
  " Restore the position.
  call s:Reset()
endfunction
function! s:SurroundPrompt(cmd) abort
  " Reset the position.
  call s:Reset()
  " Match text objects.
  if a:cmd =~ s:rtextobj
    execute 'normal! v' . a:cmd[0:1] . 'o'
    let l:txt = a:cmd[2:]
    let s:stext = has_key(s:pairs, l:txt) ? s:pairs[l:txt] : [l:txt, l:txt]
  endif
  " Update for changes.
  redraw
endfunction
nnoremap <Plug>Surround :call <SID>Surround()<CR>
