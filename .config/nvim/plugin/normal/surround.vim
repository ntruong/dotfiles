" Name: Surround
" Author: Nicholas Truong

" Pairs of characters we recognize.
let s:pairs = {
  \ '(' : ['(', ')'],
  \ ')' : ['(', ')'],
  \ '[' : ['[', ']'],
  \ ']' : ['[', ']'],
  \ '{' : ['{', '}'],
  \ '}' : ['{', '}'],
  \ '<' : ['<', '>'],
  \ '>' : ['<', '>']
  \ }

" Text to surround with.
function! s:delims(char) abort
  return has_key(s:pairs, a:char) ? s:pairs[a:char] : [a:char, a:char]
endfunction

function! s:surround(type) abort
  " Visually highlight the text to be surrounded while preserving the jumplist
  execute 'normal! g`[vg`]'
  redraw
  " Get a character to surround stuff with
  let l:char = nr2char(getchar())
  " Check to see if user pressed <Esc>; if so, skip surround and reset the view
  if l:char != "\<Esc>"
    " Map the provided character to delimiters
    let l:delims = s:delims(l:char)
    " Save the unnamed register
    let l:reg = @"
    " Surround text
    execute 'normal! c' . l:delims[0] . "\<C-\>\<C-o>P" . l:delims[1] . "\<Esc>"
    " Restore the unnamed register
    let @" = l:reg
  endif
  return
endfunction

nnoremap <silent> <Plug>Surround :set operatorfunc=<SID>surround<CR>g@
