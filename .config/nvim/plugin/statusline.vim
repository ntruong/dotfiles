" Name: Status Line
" Author: Nicholas Truong

" Buffer flags.
function! Modifiers() abort
  let l:flags = ""
  let l:flags .= (&modified ? " [+] " : "")  " Modified flag
  let l:flags .= (&readonly ? " [-] " : "")  " Readonly flag
  let l:flags .= (&pvw ? " [preview] " : "") " Preview flag
  return l:flags
endfunction

set statusline=
set statusline+=\ %y\                    " File type
set statusline+=\ %.40f\                 " File path
set statusline+=%{Modifiers()}           " Flags
set statusline+=%=                       " Right side
set statusline+=\ [%3l                   " Current line
set statusline+=/%-3L]:                  " Total lines
set statusline+=[%2v]\                   " Virtual column number
set statusline+=\ %{&fileformat}         " File format
set statusline+=/%{&fileencoding?&fileencoding:&encoding}\  " File encoding
