" Name: Whitespace
" Author: Nicholas Truong

" Hide whitespace in insert mode.
augroup au_display
  autocmd!
  autocmd InsertEnter * setlocal nolist
  autocmd InsertLeave * setlocal list
augroup END
