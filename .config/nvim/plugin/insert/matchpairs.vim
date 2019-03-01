" Name: Match Pairs
" Author: Nicholas Truong

" Step over closing delimeters if they have pairs.
function! s:Close(open, close) abort
  let l:str = getline(".")
  let l:value = a:close
  if strpart(l:str, col(".") - 1, 1) == a:close
    let i = 0
    let len = strlen(str)
    let matches = 0
    while i < len
      let c = strpart(str, i, 1)
      if c == a:open
        let matches += 1
      elseif c == a:close
        let matches -= 1
      endif
      let i += 1
    endwhile
    if matches == 0
      let value = "\<C-g>U\<Right>"
    endif
  endif
  return value
endfunction
inoremap <expr> <Plug>Match} <SID>Close("{", "}")
inoremap <expr> <Plug>Match) <SID>Close("(", ")")
inoremap <expr> <Plug>Match] <SID>Close("[", "]")

" Step over closing quotes if they have pairs.
function! s:Quote(ch) abort
  let line = getline(".")
  let value = ""
  let i = 0
  let len = strlen(line)
  let chcount = 0
  while i < len
    let c = strpart(line, i, 1)
    if c == a:ch
      let chcount += 1
    endif
    let i += 1
  endwhile
  if (chcount % 2 == 0)
    if strpart(line, col(".") - 1, 1) == a:ch
      let value = "\<C-g>U\<Right>"
    else
      let value = a:ch.a:ch."\<C-g>U\<Left>"
    endif
  else
    let value = a:ch
  endif
  return value
endfunction
inoremap <expr> <Plug>Match" <SID>Quote("\"")
inoremap <expr> <Plug>Match' <SID>Quote("\'")

" Remove pairs of delimiters if they are adjacent.
function! s:Remove() abort
  let pair_dict = {"{": "}", "(": ")", "[": "]", "\"": "\"", "\'": "\'"}
  let fst = strpart(getline("."), col(".") - 2, 1)
  let snd = strpart(getline("."), col(".") - 1, 1)
  if has_key(pair_dict, fst) && (pair_dict[fst] == strpart(getline("."), col(".") - 1, 1))
    return "\<Right>\<BS>\<BS>"
  endif
  return "\<BS>"
endfunction
inoremap <expr> <Plug>RemoveMatch <SID>Remove()

" Automatically expand {}.
function! s:BraceOpener() abort
  let fst = strpart(getline("."), col(".") - 2, 1)
  if (strpart(getline("."), col(".") - 2, 1) == "{") && (strpart(getline("."), col(".") - 1, 1) == "}")
    return "\<CR>\<CR>\<Up>\<Tab>"
  endif
  return "\<CR>"
endfunction
inoremap <expr> <Plug>Expand{} <SID>BraceOpener()
