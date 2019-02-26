" Name: Haskell configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
setlocal makeprg=stack\ build
setlocal errorformat=;;;
setlocal errorformat+=%f:%l:%c:\ error:\ %m
setlocal errorformat+=%f:%l:%c:\ warning:\ %m
setlocal errorformat+=%E%f:%l:%c:\ error:
setlocal errorformat+=%W%f:%l:%c:\ warning:
setlocal errorformat+=%Z\ %\\+%m
setlocal errorformat+=%-G%.%#
inoremap ' '
"==================================================
