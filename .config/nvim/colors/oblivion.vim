" File: oblivion.vim
" Author: Nicholas Truong <nt31415@gmail.com>
" Vim color file - Oblivion (true color only)

set background=light

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "oblivion"

" Color palette
let s:black      = "25292e"
let s:red        = "bf454c"
let s:green      = "eafeed"
let s:yellow     = "eedf07"
let s:blue       = "245dbe"
let s:magenta    = "e1597e"
let s:cyan       = "7abdd6"
let s:white      = "ffffff"
" Alternative colors
let s:foreground = "25292e"
let s:background = "ffffff"
let s:offwhite   = "f9f9f9"
let s:line       = "f0f0f0"
let s:palegrey   = "77797b"
let s:palered    = "fceff0"
let s:orange     = "d4692b"
let s:paleblue   = "f2f8fe"
let s:skyblue    = "bad7fb"
let s:deepblue   = "012f5e"
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
call <SID>X("Comment",    s:palegrey, "",           "")
call <SID>X("Constant",   s:blue,     "",           "")
call <SID>X("String",     s:deepblue, "",           "")
call <SID>X("Identifier", s:black,    "",           "")
call <SID>X("Function",   s:violet,   "",           "")
call <SID>X("Statement",  s:red,      "",           "")
call <SID>X("PreProc",    s:red,      "",           "")
call <SID>X("Type",       s:red,      "",           "")
call <SID>X("Special",    s:red,      "",           "")
call <SID>X("Tag",        s:orange,   "",           "")
call <SID>X("Underlined", s:orange,   "",           "underline")
call <SID>X("Ignore",     s:black,    "",           "")
call <SID>X("Error",      s:white,    s:red,        "")
call <SID>X("Todo",       s:magenta,  s:background, "bold")

" Standard highlighting
call <SID>X("ColorColumn",  "",         s:line,       "")
call <SID>X("Conceal",      s:black,    s:background, "")
call <SID>X("Cursor",       "",         "",           "reverse")
call <SID>X("CursorColumn", "",         s:line,       "")
call <SID>X("CursorLine",   "",         s:line,       "")
call <SID>X("Directory",    s:palegrey, "",           "")
call <SID>X("DiffAdd",      "",         s:green,      "")
call <SID>X("DiffChange",   "",         s:paleblue,   "")
call <SID>X("DiffDelete",   s:palered,  s:palered,    "")
call <SID>X("DiffText",     "",         s:skyblue,    "")
call <SID>X("ErrorMsg",     s:white,    s:red,        "")
call <SID>X("VertSplit",    s:line,     s:line,       "")
call <SID>X("Folded",       s:palegrey, "",           "")
call <SID>X("FoldColumn",   s:palegrey, s:line,       "")
call <SID>X("SignColumn",   "",         s:line,       "")
call <SID>X("IncSearch",    s:yellow,   s:black,      "")
call <SID>X("Substitute",   s:yellow,   s:black,      "")
call <SID>X("LineNr",       s:palegrey, "",           "")
call <SID>X("CursorLineNr", s:blue,     "",           "")
call <SID>X("MatchParen",   "",         s:skyblue,    "")
call <SID>X("ModeMsg",      s:blue,     "",           "")
" MoreMsg
call <SID>X("NonText",      s:red,      "",           "")
call <SID>X("Normal",       s:black,    s:background, "")
call <SID>X("NormalNC",     "",         s:offwhite,   "")
call <SID>X("Pmenu",        s:black,    s:line,       "")
call <SID>X("PmenuSel",     s:white,    s:blue,       "")
call <SID>X("PmenuSBar",    s:palegrey, s:palegrey,   "")
" PmenuThumb
call <SID>X("Question",     s:blue,     "",           "")
call <SID>X("QuickFixLine", s:white,    s:red,        "")
call <SID>X("Search",       s:black,    s:skyblue,    "")
call <SID>X("SpecialKey",   s:red,      "",           "")
call <SID>X("SpellBad",     "",         "",           "undercurl")
call <SID>X("SpellCap",     "",         "",           "undercurl")
call <SID>X("SpellLocal",   "",         "",           "undercurl")
call <SID>X("SpellRare",    "",         "",           "undercurl")
call <SID>X("StatusLine",   s:white,    s:blue,       "none")
call <SID>X("StatusLineNC", s:palegrey, s:line,       "none")
call <SID>X("TabLine",      s:palegrey, s:line,       "none")
call <SID>X("TabLineFill",  s:line,     s:line,       "")
call <SID>X("TabLineSel",   s:white,    s:blue,       "bold")
call <SID>X("Title",        s:palegrey, "",           "underline")
call <SID>X("Visual",       "",         s:skyblue,    "")
call <SID>X("Visual",       "",         s:line,       "")
call <SID>X("WarningMsg",   s:black,    s:yellow,     "")
call <SID>X("Whitespace",   s:skyblue,  "",           "")
call <SID>X("WildMenu",     s:blue,     s:line,       "")

" Delete highlight functions
delf <SID>X
