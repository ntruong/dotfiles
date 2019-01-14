" File: transcendence.vim
" Author: Nicholas Truong <nt31415@gmail.com>
" Vim color file - Transcendence (true color only)

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "transcendence"

" Color palette
let s:black      = "77797b"
let s:red        = "bf454c"
let s:green      = "45bf7b"
let s:yellow     = "eedf07"
let s:blue       = "245dbe"
let s:magenta    = "e1597e"
let s:cyan       = "7abdd6"
let s:white      = "ffffff"
" Alternative colors
let s:foreground = "ffffff"
let s:background = "25292e"
let s:line       = "35393e"
let s:orange     = "e17859"
let s:skyblue    = "bad7fb"
let s:violet     = "876dc8"

" Highlight a group
fun <SID>X(group, fg, bg, attr)
  let l:fg   = (a:fg != "")   ? a:fg   : "none"
  let l:bg   = (a:bg != "")   ? a:bg   : "none"
  let l:attr = (a:attr != "") ? a:attr : "none"
  exec "highlight " . a:group . " guifg=#" . l:fg
  exec "highlight " . a:group . " guibg=#" . l:bg
  exec "highlight " . a:group . " gui="    . l:attr
endfun

" Preferred groups
call <SID>X("Comment",      s:black,      "",           "")
call <SID>X("Constant",     s:orange,     "",           "")
call <SID>X("String",       s:cyan,       "",           "")
call <SID>X("Identifier",   s:white,      "",           "")
call <SID>X("Function",     s:violet,     "",           "")
call <SID>X("Statement",    s:red,        "",           "bold")
call <SID>X("PreProc",      s:red,        "",           "")
call <SID>X("Type",         s:red,        "",           "bold")
call <SID>X("Special",      s:red,        "",           "")
call <SID>X("Tag",          s:orange,     "",           "underline")
call <SID>X("Underlined",   s:orange,     "",           "underline")
call <SID>X("Ignore",       s:background, "",           "")
call <SID>X("Error",        s:white,      s:red,        "")
call <SID>X("Todo",         s:magenta,    s:background, "bold")

" Standard highlighting
call <SID>X("ColorColumn",  "",           s:line,       "")
call <SID>X("Conceal",      s:foreground, s:background, "")
call <SID>X("Cursor",       "",           "",           "reverse")
call <SID>X("CursorColumn", "",           s:line,       "")
call <SID>X("CursorLine",   "",           s:line,       "")
call <SID>X("Directory",    s:black,      "",           "")
call <SID>X("DiffAdd",      s:white,      s:green,      "")
call <SID>X("DiffChange",   "",           s:background, "")
call <SID>X("DiffDelete",   s:red,        s:red,        "")
call <SID>X("DiffText",     s:black,      s:skyblue,    "")
call <SID>X("ErrorMsg",     s:white,      s:red,        "")
call <SID>X("VertSplit",    s:background, s:background, "")
call <SID>X("Folded",       s:black,      s:line,       "")
call <SID>X("FoldColumn",   s:black,      s:background, "")
call <SID>X("SignColumn",   "",           s:background, "")
call <SID>X("IncSearch",    s:background, s:yellow,     "")
call <SID>X("Substitute",   s:background, s:yellow,     "")
call <SID>X("LineNr",       s:black,      "",           "")
call <SID>X("CursorLineNr", s:cyan,       "",           "")
call <SID>X("MatchParen",   "",           s:black,      "")
call <SID>X("ModeMsg",      s:cyan,       "",           "")
" MoreMsg
call <SID>X("NonText",      s:red,        "",           "")
call <SID>X("Normal",       s:foreground, s:background, "")
call <SID>X("NormalNC",     "",           "",           "")
call <SID>X("Pmenu",        s:black,      s:line,       "")
call <SID>X("PmenuSel",     s:cyan,       s:black,      "")
call <SID>X("PmenuSBar",    s:black,      s:black,      "")
" PmenuThumb
call <SID>X("Question",     s:blue,       "",           "")
call <SID>X("QuickFixLine", s:white,      s:red,        "")
call <SID>X("Search",       s:background, s:skyblue,    "")
call <SID>X("SpecialKey",   s:red,        "",           "")
call <SID>X("SpellBad",     "",           "",           "undercurl")
call <SID>X("SpellCap",     "",           "",           "undercurl")
call <SID>X("SpellLocal",   "",           "",           "undercurl")
call <SID>X("SpellRare",    "",           "",           "undercurl")
call <SID>X("StatusLine",   s:cyan,       s:background, "")
call <SID>X("StatusLineNC", s:black,      "",           "")
call <SID>X("TabLine",      s:black,      s:background, "")
call <SID>X("TabLineFill",  "",           "",           "")
call <SID>X("TabLineSel",   s:cyan,       "",           "")
call <SID>X("Title",        s:black,      "",           "underline")
call <SID>X("Visual",       "",           s:line,       "")
call <SID>X("WarningMsg",   s:background, s:yellow,     "")
call <SID>X("Whitespace",   s:cyan,       "",           "")
call <SID>X("WildMenu",     s:cyan,       s:line,       "")

" Delete highlight functions
delf <SID>X
