" Name: LaTeX configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
setlocal makeprg=pdflatex\ -interaction\ nonstopmode\ %<
" Text display
setlocal textwidth=80
" Text functions
inoremap <buffer> ;bf \textbf{}<Left>
inoremap <buffer> ;it \textit{}<Left>
inoremap <buffer> ;ul \underline{}<Left>
inoremap <buffer> ;em \emph{}<Left>
inoremap <buffer> /   \
" Math stuff
inoremap <buffer> ;mm \[\]<Esc>T[i<CR><Esc>O
inoremap <buffer> ;mb \mathbb{}<Esc>T{i
inoremap <buffer> ;mc \mathcal{}<Esc>T{i
" \begin{} ... \end{}
function! BeginEnd(type)
  let l:t = a:type
  if empty(a:type)
    call inputsave()
    let l:t = input('Begin: ')
    call inputrestore()
  endif
  let ins = ['\begin{'.l:t.'}', '\end{'.l:t.'}']
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
"==================================================
