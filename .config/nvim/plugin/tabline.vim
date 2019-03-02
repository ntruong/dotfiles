" Name: Tab Line
" Author: Nicholas Truong

function! Tabline() abort
  let tl = ""
  for tabnr in range(1, tabpagenr("$"))
    let winnr   = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr   = buflist[winnr - 1]
    let file    = fnamemodify(bufname(bufnr), ":t")
    let file    = empty(file) ? "[No Name]" : file
    if tabnr == tabpagenr()
      let file = "%#TabLineSel#" . file . "%#TabLine#"
    endif
    let tl .= " " . file . " "
  endfor
  return "%#TabLine#" . trim(tl) . "%#TabLineFill#"
endfunction
set tabline=%!Tabline()
