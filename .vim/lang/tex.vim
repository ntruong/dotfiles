" Name: LaTeX configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
""" SETTINGS:
let b:commentflag = '%'
let b:gotoflag = '(<>)'
set textwidth=80
inoremap <buffer> ;; <Esc>:call search(b:gotoflag)<CR>c4l
nnoremap <buffer> ;; :call search(b:gotoflag)<CR>c4l
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
  let ins = ["\\begin{".t."}",
            \b:gotoflag,
            \"\\end{".t."}",
            \b:gotoflag]
  call append('.', ins)
  delete
endfunction
inoremap <buffer> ;bg  <Esc>:call BeginEnd("")<CR>i
inoremap <buffer> ;doc <Esc>:call BeginEnd("document")<CR>i
inoremap <buffer> ;ls  <Esc>:call BeginEnd("itemize")<CR>i
inoremap <buffer> ;en  <Esc>:call BeginEnd("enumerate")<CR>i
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
" Symbols
inoremap //a \alpha
inoremap //b \beta
inoremap //g \gamma
inoremap //d \delta
inoremap //e \epsilon
inoremap //z \zeta
inoremap //t \theta
inoremap //k \kappa
inoremap //l \lambda
inoremap //m \mu
inoremap //n \nu
inoremap //p \pi
inoremap //s \sigma
inoremap //c \chi
"==================================================
