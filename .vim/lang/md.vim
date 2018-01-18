" Name: Markdown configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
""" SETTINGS:
set textwidth=80
function! CompileMd()
  execute "!pandoc ".expand('%:p')." -f markdown -t html -o".
        \substitute(expand('%:p'), "\.md$", "\.html", "").
        \" > /dev/null"
endfunction
nnoremap <buffer> <Leader>cp :call CompileMd()<CR><CR>
function! DisplayHTML()
  let f = substitute(expand('%:p'), "\.md$", "\.html", "")
  execute "!firefox ".f
endfunction
nnoremap <buffer> <Leader>dp :call DisplayHTML()<CR><CR>
