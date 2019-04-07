" Name: LaTeX configuration for Vim
" Author: Nicholas Truong

" Compiler.
compiler latexmk
filetype indent off
" Text-objects.
nnoremap <silent> <buffer> ]] :call search('^\\begin', "sW")<CR>
nnoremap <silent> <buffer> [[ :call search('^\\begin', "sbW")<CR>
nnoremap <silent> <buffer> ][ :call search('^\\end', "sW")<CR>
nnoremap <silent> <buffer> [] :call search('^\\end', "sbW")<CR>
omap <silent> <buffer> ip <Plug>Paragraph
" Text functions.
inoremap <buffer> ' '
inoremap <buffer> ;bf \textbf{}<C-g>U<Left>
inoremap <buffer> ;it \textit{}<C-g>U<Left>
inoremap <buffer> ;ul \underline{}<C-g>U<Left>
inoremap <buffer> /   \
inoremap <buffer> \   /
" Math stuff.
inoremap <buffer> ;mm \[\]<Esc>T[i<CR><Esc>O
inoremap <buffer> ;mb \mathbb{}<C-g>U<Left>
inoremap <buffer> ;mc \mathcal{}<C-g>U<Left>
" Environments.
imap <buffer> ;bg <Plug>Environment

" Automatically run compiler on write.
augroup Tex
  autocmd!
  autocmd BufWritePost *.tex Make
augroup END
