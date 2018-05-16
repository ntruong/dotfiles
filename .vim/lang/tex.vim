" Name: LaTeX configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
""" SETTINGS:
let b:commentflag = '%'
set textwidth=80
" Text display
inoremap <buffer> ;bf \textbf{}<Space><Esc>T{i
inoremap <buffer> ;it \textit{}<Space><Esc>T{i
inoremap <buffer> ;ul \underline{}<Space><Esc>T{i
inoremap <buffer> ;em \emph{}<Space><Esc>T{i
" Math stuff
inoremap <buffer> ;mm   \[\]<Esc>T[i<CR><Esc>O
" \begin{} ... \end{}
function! BeginEnd(type)
  let t = a:type
  if !(strlen(a:type))
    call inputsave()
    let t = input('Begin: ')
    call inputrestore()
  endif
  let ins = ['\begin{'.t.'}', '\end{'.t.'}']
  call append('.', ins)
  delete
endfunction
inoremap <buffer> ;bg  <Esc>:call BeginEnd("")<CR>
" Tabulated entries
function! Array(type)
  call inputsave()
  let rows = input('Rows: ')
  let cols = input('Cols: ')
  call inputrestore()
  let align = ['l', 'r', 'c'][confirm('Align:', "&left\n&right\n&center", 2)-1]
  confirm
  let matrix = ['\begin{'.a:type.'}{'.repeat(align, cols).'}']
  for r in range(rows)
    let matrix += [join(map(range(cols), '"##".r.";".v:val'), ' & ') . ' \\']
  endfor
  let matrix += ['\end{'.a:type.'}']
  call append('.', matrix)
  delete
  redraw
  for r in range(rows)
    for c in range(cols)
      let id = '##'.r.';'.c
      execute "normal! /".id."\<CR>"
      redraw
      call inputsave()
      let entry = input('Entry: ')
      call inputrestore()
      execute 'normal! cW'.entry
    endfor
  endfor
endfunction
function! Matrix()
  let wrapper = ['\left[', '', '\right]']
  call append('.', wrapper)
  delete
  call cursor(line('.') + 1, 0)
  call Array('array')
endfunction
inoremap <buffer> ;mat <Esc>:call Matrix()<CR>
" Compile and display functions
function! CompileTex()
  execute "!pdflatex ".expand('%:p')." > /dev/null"
endfunction
nnoremap <buffer> <Leader>cp :call CompileTex()<CR><CR>
function! DisplayPdf()
  let f = substitute(expand('%:p'), "\.tex$", "\.pdf", "")
  execute "!open ".f
endfunction
nnoremap <buffer> <Leader>dp :call DisplayPdf()<CR><CR>
"==================================================
