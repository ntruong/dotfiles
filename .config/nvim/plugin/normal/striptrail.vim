" Name: StripTrail
" Author: Nicholas Truong

function! s:StripTrail() abort
  let search=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=search
  call cursor(l, c)
endfunction
nnoremap <Plug>StripTrail :call <SID>StripTrail()<CR>
