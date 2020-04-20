" Name: Quickfix
" Author: Nicholas Truong

" Automatically open/close the quickfix/location windows.
augroup Quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* copen | cwindow | wincmd p
  autocmd QuickFixCmdPost    l* lopen | lwindow | wincmd p
augroup END
