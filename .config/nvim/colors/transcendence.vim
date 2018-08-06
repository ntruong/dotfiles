" File: transcendence.vim
" Author: Nicholas Truong <nt31415@gmail.com>
" Vim color file - Transcendence (true color only)

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "transcendence"

" Color palette
let s:black      = "25292e"
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
let s:palegrey   = "77797b"
let s:orange     = "e17859"
let s:skyblue    = "bad7fb"
let s:violet     = "6848ba"

" Highlight a group
fun <SID>X(group, fg, bg, attr)
  if a:fg != ""
    exec "highlight " . a:group . " guifg=#" . a:fg
  endif
  if a:bg != ""
    exec "highlight " . a:group . " guibg=#" . a:bg
  endif
  if a:attr != ""
    exec "highlight " . a:group . " gui=" . a:attr
  endif
endfun

" Preferred groups
call <SID>X("Comment",    s:palegrey,     "",           "")
call <SID>X("Constant",   s:orange,       "",           "")
call <SID>X("String",     s:cyan,         "",           "")
call <SID>X("Identifier", s:white,        "",           "")
call <SID>X("Function",   s:violet,       "",           "")
call <SID>X("Statement",  s:red,          "",           "")
call <SID>X("PreProc",    s:red,          "",           "")
call <SID>X("Type",       s:red,          "",           "")
call <SID>X("Special",    s:red,          "",           "")
call <SID>X("Tag",        s:orange,       "",           "")
call <SID>X("Underlined", s:orange,       "",           "underline")
call <SID>X("Ignore",     s:black,        "",           "")
call <SID>X("Error",      s:white,        s:red,        "")
call <SID>X("Todo",       s:magenta,      s:background, "bold")

" Standard highlighting
call <SID>X("ColorColumn",  "",           s:line,       "")
call <SID>X("Conceal",      s:foreground, s:background, "")
call <SID>X("Cursor",       "",           "",           "reverse")
call <SID>X("CursorColumn", "",           s:line,       "")
call <SID>X("CursorLine",   "",           s:line,       "")
call <SID>X("Directory",    s:palegrey,   "",           "")
call <SID>X("DiffAdd",      s:white,      s:green,      "")
call <SID>X("DiffChange",   "",           s:background, "")
call <SID>X("DiffDelete",   s:red,        s:red,        "")
call <SID>X("DiffText",     s:palegrey,   s:skyblue,    "")
call <SID>X("ErrorMsg",     s:white,      s:red,        "")
call <SID>X("VertSplit",    s:background, s:background, "")
call <SID>X("Folded",       s:palegrey,   s:line,       "")
call <SID>X("FoldColumn",   s:palegrey,   s:line,       "")
call <SID>X("SignColumn",   "",           s:line,       "")
call <SID>X("IncSearch",    s:black,      s:yellow,     "none")
call <SID>X("Substitute",   s:black,      s:yellow,     "none")
call <SID>X("LineNr",       s:palegrey,   "",           "")
call <SID>X("CursorLineNr", s:cyan,       "",           "")
call <SID>X("MatchParen",   "",           s:skyblue,    "")
call <SID>X("ModeMsg",      s:cyan,       "",           "")
" MoreMsg
call <SID>X("NonText",      s:red,        "",           "")
call <SID>X("Normal",       s:foreground, s:background, "")
call <SID>X("NormalNC",     "",           "",           "")
call <SID>X("Pmenu",        s:palegrey,   s:line,       "")
call <SID>X("PmenuSel",     s:cyan,       s:palegrey,   "")
call <SID>X("PmenuSBar",    s:palegrey,   s:palegrey,   "")
" PmenuThumb
call <SID>X("Question",     s:blue,       "",           "")
call <SID>X("QuickFixLine", s:white,      s:red,        "")
call <SID>X("Search",       s:black,      s:skyblue,    "")
call <SID>X("SpecialKey",   s:red,        "",           "")
call <SID>X("SpellBad",     "",           "",           "undercurl")
call <SID>X("SpellCap",     "",           "",           "undercurl")
call <SID>X("SpellLocal",   "",           "",           "undercurl")
call <SID>X("SpellRare",    "",           "",           "undercurl")
call <SID>X("StatusLine",   s:cyan,       s:background, "none")
call <SID>X("StatusLineNC", s:palegrey,   "",           "none")
call <SID>X("TabLine",      s:palegrey,   s:background, "none")
call <SID>X("TabLineFill",  "",           "",           "none")
call <SID>X("TabLineSel",   s:cyan,       "",           "none")
call <SID>X("Title",        s:palegrey,   "",           "underline")
call <SID>X("Visual",       "",           s:line,       "")
call <SID>X("WarningMsg",   s:black,      s:yellow,     "")
call <SID>X("Whitespace",   s:cyan,       "",           "")
call <SID>X("WildMenu",     s:cyan,       s:line,       "")

" Delete highlight functions
delf <SID>X
