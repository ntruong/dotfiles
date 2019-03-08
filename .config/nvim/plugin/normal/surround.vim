" Name: Surround
" Author: Nicholas Truong

" Save the position of the user.
let s:pos = [0, 0, 0, 0]

" Regex prefixes to a surround command we recognize.
let s:rtextobj = '^[ia].*'
let s:rregex   = '^r/.\{-}\\\@1<!/'

" Pairs of characters we recognize.
let s:pairs = {
  \ '(' : ['(', ')'],
  \ '[' : ['[', ']'],
  \ '{' : ['{', '}'],
  \ '<' : ['<', '>']
  \ }

" Text to surround with.
let s:stext = ["", ""]
function! s:MakeSText(txt) abort
  if has_key(s:pairs, a:txt)
    let s:stext = s:pairs[a:txt]
  else
    let s:stext = [a:txt, a:txt]
  endif
endfunction

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
  if mode() != 'v' || (l:cmd !~ s:rtextobj && l:cmd !~ s:rregex)
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
    call s:MakeSText(a:cmd[2:])
  " Match regex strings.
  elseif a:cmd =~ '^r/.\{-}\\\@1<!/'
    " Split around the first unescaped forward slash.
    let l:args = split(a:cmd[2:], '\\\@1<!/', 1)
    execute 'normal! v'
    " Search backwards if we're given a string.
    if !empty(l:args[0])
      call search(l:args[0], "bW")
    endif
    execute 'normal! o'
    " Search forwards if we're given a string.
    if !empty(l:args[1])
      call search(l:args[1], "eW")
    endif
    " Fill the surrounding text.
    if len(l:args) == 3
      call s:MakeSText(l:args[2])
    elseif len(l:args) > 3
      let s:stext[0] = l:args[2]
      let s:stext[1] = l:args[3]
    endif
  endif
  " Update for changes.
  redraw
endfunction
nnoremap <Plug>Surround :call <SID>Surround()<CR>
