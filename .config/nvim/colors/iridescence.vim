" File: iridescence.vim
" Author: Nicholas Truong <nt31415@gmail.com>
" Vim color file - Iridescence

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "iridescence"

" Highlight a group
fun <SID>X(group, fg, bg, attr)
  let l:fg   = (a:fg != "")   ? a:fg   : "none"
  let l:bg   = (a:bg != "")   ? a:bg   : "none"
  let l:attr = (a:attr != "") ? a:attr : "none"
  exec "highlight " . a:group . " ctermfg=" . l:fg
  exec "highlight " . a:group . " ctermbg=" . l:bg
  exec "highlight " . a:group . " cterm="   . l:attr
endfun

" Preferred groups
call <SID>X("Comment",      8,  "", "")
call <SID>X("Constant",     5,  "", "")
call <SID>X("String",       6,  "", "")
call <SID>X("Identifier",   7, "", "bold")
call <SID>X("Function",     5,  "", "")
call <SID>X("Statement",    9,  "", "bold")
call <SID>X("PreProc",      9,  "", "")
call <SID>X("Type",         9,  "", "bold")
call <SID>X("Special",      9,  "", "")
call <SID>X("Tag",          11, "", "underline")
call <SID>X("Underlined",   11, "", "underline")
call <SID>X("Ignore",       "", "", "")
call <SID>X("Error",        7,  9,  "")
call <SID>X("Todo",         5,  "", "bold")

" Standard highlighting
call <SID>X("ColorColumn",  "", 8,  "")
call <SID>X("Conceal",      "", "", "")
call <SID>X("Cursor",       "", "", "reverse")
call <SID>X("CursorColumn", "", 8,  "")
call <SID>X("CursorLine",   "", 8,  "")
call <SID>X("Directory",    8,  "", "")
call <SID>X("DiffAdd",      7,  2,  "")
call <SID>X("DiffChange",   "", "", "")
call <SID>X("DiffDelete",   "", 9,  "")
call <SID>X("DiffText",     4,  "", "reverse")
call <SID>X("ErrorMsg",     7,  9,  "")
call <SID>X("VertSplit",    "", "", "")
call <SID>X("Folded",       8,  "", "")
call <SID>X("FoldColumn",   8,  "", "")
call <SID>X("SignColumn",   "", "", "")
call <SID>X("IncSearch",    12, "", "reverse")
call <SID>X("Substitute",   3,  "", "reverse")
call <SID>X("LineNr",       8,  "", "")
call <SID>X("CursorLineNr", 6,  "", "")
call <SID>X("MatchParen",   "", 8,  "")
call <SID>X("ModeMsg",      6,  "", "")
" MoreMsg
call <SID>X("NonText",      9,  "", "")
call <SID>X("Normal",       7,  "", "")
call <SID>X("NormalNC",     "", "", "")
call <SID>X("Pmenu",        8,  "", "")
call <SID>X("PmenuSel",     6,  "", "")
call <SID>X("PmenuSBar",    7,  8,  "")
" PmenuThumb
call <SID>X("Question",     4,  "", "")
call <SID>X("QuickFixLine", 7,  9,  "")
call <SID>X("Search",       4,  "", "reverse")
call <SID>X("SpecialKey",   9,  "", "")
call <SID>X("SpellBad",     "", "", "undercurl")
call <SID>X("SpellCap",     "", "", "undercurl")
call <SID>X("SpellLocal",   "", "", "undercurl")
call <SID>X("SpellRare",    "", "", "undercurl")
call <SID>X("StatusLine",   0,  "", "bold")
call <SID>X("StatusLineNC", 8,  "", "bold")
call <SID>X("TabLine",      8,  "", "")
call <SID>X("TabLineFill",  "", "", "")
call <SID>X("TabLineSel",   0,  "", "")
call <SID>X("Title",        8,  "", "underline")
call <SID>X("Visual",       "", 8,  "")
call <SID>X("WarningMsg",   3,  "", "reverse")
call <SID>X("Whitespace",   6,  "", "")
call <SID>X("WildMenu",     6,  "", "underline")

" Delete highlight functions
delf <SID>X
