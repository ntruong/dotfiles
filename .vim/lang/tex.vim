" Name: LaTeX configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
""" SETTINGS:
let b:commentflag = '%'
let b:gotoflag = '(<>)'
set textwidth=80
inoremap <buffer> ;; <Esc>:call search(b:gotoflag)<CR>c4l
" Text display
inoremap <buffer> ;bf \textbf{}<Space>(<>)<Esc>T{i
inoremap <buffer> ;it \textit{}<Space>(<>)<Esc>T{i
inoremap <buffer> ;ul \underline{}<Space>(<>)<Esc>T{i
inoremap <buffer> ;em \emph{}<Space>(<>)<Esc>T{i
" Math stuff
inoremap <buffer> ;mm   \[\]<Left><Left>
" Sectionings
inoremap <buffer> ;sc   \section{}<CR>(<>)<Esc><Up>f}i
inoremap <buffer> ;ssc  \subsection{}<CR>(<>)<Esc><Up>f}i
inoremap <buffer> ;sssc \subsubsection{}<CR>(<>)<Esc><Up>f}i
" \begin{} ... \end{
function! BeginEnd(type)
  let t = a:type
  if !(strlen(a:type))
    call inputsave()
    let t = input('Begin: ')
    call inputrestore()
  endif
  let ins = ["\\begin{".t."}", "\\end{".t."}"]
  call append('.', ins)
  delete
endfunction
inoremap <buffer> ;bg  <Esc>:call BeginEnd("")<CR>
inoremap <buffer> ;ls  <Esc>:call BeginEnd("itemize")<CR>
inoremap <buffer> ;en  <Esc>:call BeginEnd("enumerate")<CR>
inoremap <buffer> ;*   \item<Space>
" Misc
inoremap <buffer> ;pkg \usepackage{}<Left>
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
