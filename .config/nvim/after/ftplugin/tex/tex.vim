" Name: LaTeX configuration for Vim
" Author: Nicholas Truong

" Compiler.
compiler latexmk
filetype indent off
set spell spelllang=en_us
" Text-objects.
nnoremap <silent> <buffer> ]] :call search('^\\begin', "sW")<CR>
nnoremap <silent> <buffer> [[ :call search('^\\begin', "sbW")<CR>
nnoremap <silent> <buffer> ][ :call search('^\\end', "sW")<CR>
nnoremap <silent> <buffer> [] :call search('^\\end', "sbW")<CR>
omap <silent> <buffer> ip <Plug>Paragraph
omap <silent> <buffer> i$ <Plug>MathMode
" Text functions.
inoremap <buffer> ' '
inoremap <buffer> ;bf \textbf{
inoremap <buffer> ;it \textit{
inoremap <buffer> ;ul \underline{
inoremap <buffer> /   \
inoremap <buffer> \   /
" Math stuff.
inoremap <buffer> ;mm \[\]<Esc>T[i<CR><Esc>O
inoremap <buffer> ;mb \mathbb{
inoremap <buffer> ;mc \mathcal{
" Environments.
imap <buffer> ;bg <Plug>Environment

" Automatically run compiler on write.
augroup Tex
  autocmd!
  autocmd BufWritePost *.tex Make
augroup END
