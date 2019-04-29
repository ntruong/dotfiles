" Name: Comment
" Author: Nicholas Truong

" Aligns a visual selection using column and sed.
function! s:align()
  '<,'>!column -t | sed 's/\( *\) /\1/g'
endfunction

vnoremap <Plug>Align :<C-u>call <SID>align()<CR>
