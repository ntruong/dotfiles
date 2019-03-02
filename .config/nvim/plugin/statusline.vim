" Name: Status Line
" Author: Nicholas Truong

set statusline=
set statusline+=%y        " File type
set statusline+=\ %.40f   " File path
set statusline+=%=        " Right side
set statusline+=\ %3(%m%) " Flags
set statusline+=\ [%3l,   " Line number
set statusline+=%-3.3c]   " Column number
