" Name: LaTeX configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
let &l:makeprg="latexmk -interaction=nonstopmode -pdf %<" .
             \ " && latexmk -c"
" Async make.
function! Make()
  call MakeStop()
  let cmd  = "latexmk "
  let cmd .= "-interaction=nonstopmode "
  let cmd .= "-pvc "
  let cmd .= "-pdf "
  let cmd .= expand("%:t")
  let b:latexmk_pid = jobstart(cmd)
endfunction
function! MakeStop()
  if exists("b:latexmk_pid") && b:latexmk_pid > 0
    call jobstop(b:latexmk_pid)
    let b:latexmk_pid = -1
  endif
endfunction
command! Make :call Make()
command! MakeStop :call MakeStop()
" Text display
setlocal textwidth=80
filetype indent off
" Text-objects.
nnoremap <silent> [[ :call search('^\\begin', "sbW")<CR>
nnoremap <silent> ]] :call search('^\\end', "sW")<CR>
" Text functions
inoremap <buffer> ;bf \textbf{}<Left>
inoremap <buffer> ;it \textit{}<Left>
inoremap <buffer> ;ul \underline{}<Left>
inoremap <buffer> ;em \emph{}<Left>
inoremap <buffer> /   \
inoremap <buffer> \   /
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
