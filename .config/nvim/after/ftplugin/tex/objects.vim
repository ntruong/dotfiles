" Name: Objects
" Author: Nicholas Truong

" Create better paragraph text-objects (mainly for formatting). We delimit
" paragraphs by newlines, \begin{...}, \end{...}, \label{...}, \\, etc.
let s:delimiters  = '^(\s*$'
let s:delimiters .= '|\\begin'
let s:delimiters .= '|\\end'
let s:delimiters .= '|\\label'
let s:delimiters .= '|\\part'
let s:delimiters .= '|\\chapter'
let s:delimiters .= '|\\section'
let s:delimiters .= '|\\subsection'
let s:delimiters .= '|\\subsubsection'
let s:delimiters .= '|\\paragraph'
let s:delimiters .= '|\\\\'
let s:delimiters .= '|\\\['
let s:delimiters .= '|\\\]$'
let s:delimiters .= ')'
function! s:Paragraph() abort
  " Save the search register
  let l:search = @/
  " Search backwards for a paragraph delimiter, then go to the line below
  execute '?\v' . s:delimiters . '?+1'
  " Enter linewise visual mode
  normal! V
  " Search forwards for a paragraph delimiter, then go to the line above
  execute '/\v' . s:delimiters . '/-1'
  " Restore the search register
  let @/ = l:search
endfunction

onoremap <Plug>Paragraph :<C-u>call <SID>Paragraph()<CR>
