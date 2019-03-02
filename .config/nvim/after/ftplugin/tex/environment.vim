" Name: Environment
" Author: Nicholas Truong

" Create a \begin{...} \end{...} environment.
function! s:Environment(env) abort
  let l:env = a:env
  if empty(a:env)
    call inputsave()
    let l:env = input('Begin: ')
    call inputrestore()
  endif
  " Only create the environment if the user supported an environment.
  if empty(l:env)
    return ""
  endif
  let ins = ['\begin{'.l:env.'}', '\end{'.l:env.'}']
  call append('.', ins)
  delete
endfunction
inoremap <Plug>Environment <Esc>:call <SID>Environment("")<CR>
