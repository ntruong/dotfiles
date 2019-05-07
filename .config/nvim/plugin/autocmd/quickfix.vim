" Name: Quickfix
" Author: Nicholas Truong

" Automatically open/close the quickfix/location windows.
augroup Quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow | wincmd p
  autocmd QuickFixCmdPost l* lwindow | wincmd p
augroup END
