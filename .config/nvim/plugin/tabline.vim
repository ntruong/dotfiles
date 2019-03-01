" Name: Tab Line
" Author: Nicholas Truong

function! Tabline() abort
  let tl = ""
  for i in range(tabpagenr("$"))
    let tabnr   = i + 1
    let winnr   = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr   = buflist[winnr - 1]
    let file    = fnamemodify(bufname(bufnr), ":t")
    let tl .= " "
    let tl .= (tabnr == tabpagenr()) ? "%#TabLineSel#" : "%#TabLine#"
    let tl .= empty(file) ? "scratch" : file
    let tl .= "%* "
  endfor
  let tl .= "%#TabLineFill#"
  return tl
endfunction
set showtabline=2
if exists("+showtabline")
  set tabline=%!Tabline()
endif
