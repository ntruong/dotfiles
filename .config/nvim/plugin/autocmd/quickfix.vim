" Name: Quickfix
" Author: Nicholas Truong

" Automatically open/close the quickfix/location windows.
augroup Quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END
