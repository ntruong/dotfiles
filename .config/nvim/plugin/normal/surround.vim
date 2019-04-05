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
  " Check to see if user pressed <Esc>; if so, skip surround
  if l:char != "\<Esc>"
    " Map the provided character to delimiters
    let l:delims = s:delims(l:char)
    " Save the unnamed register
    let l:reg = @"
    " Surround text
    execute 'normal! c' . l:delims[0] . "\<C-\>\<C-o>P" . l:delims[1]
    " Restore the unnamed register
    let @" = l:reg
  endif
  execute "normal! \<Esc>"
  return
endfunction

function! s:delete(char) abort
  " Check to see if user pressed <Esc>; if so, skip deletion
  if a:char != "\<Esc>"
    " Map the provided character to delimiters
    let l:delims = s:delims(a:char)
    " Get the pair positions
    let l:x = searchpairpos(l:delims[0], '', l:delims[1], "bcnW")
    let l:y = searchpairpos(l:delims[0], '', l:delims[1], "cnW")
    " Save our current position
    let l:pos = getcurpos()
    " Delete the offending delimiters; last first in case char positions change
    call cursor(l:y)
    normal! "_x
    call cursor(l:x)
    normal! "_x
    " Restore our current position
    call setpos('.', l:pos)
  endif
  return
endfunction

nnoremap <silent> <Plug>Surround :set operatorfunc=<SID>surround<CR>g@
nnoremap <silent> <Plug>Delete   :call <SID>delete(nr2char(getchar()))<CR>
