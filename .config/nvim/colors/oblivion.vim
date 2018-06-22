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
let s:green      = "047c04"
let s:yellow     = "eedf07"
let s:blue       = "245dbe"
let s:magenta    = "e1597e"
let s:cyan       = "7abdd6"
let s:white      = "ffffff"
" Alternative colors
let s:foreground = "25292e"
let s:background = "ffffff"
let s:palegrey   = "77797b"
let s:grey       = "6c7339"
let s:orange     = "d4692b"
let s:skyblue    = "bad7fb"
let s:deepblue   = "012f5e"
let s:violet     = "6848ba"
let s:line       = "f0f0f0"

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
call <SID>X("Comment",    s:grey,     "",     "")
call <SID>X("Constant",   s:blue,     "",     "")
call <SID>X("String",     s:deepblue, "",     "")
call <SID>X("Identifier", s:black,    "",     "")
call <SID>X("Function",   s:violet,   "",     "")
call <SID>X("Statement",  s:red,      "",     "")
call <SID>X("PreProc",    s:red,      "",     "")
call <SID>X("Type",       s:red,      "",     "")
call <SID>X("Special",    s:red,      "",     "")
call <SID>X("Tag",        s:orange,   "",     "")
call <SID>X("Underlined", s:orange,   "",     "underline")
call <SID>X("Ignore",     s:black,    "",     "")
call <SID>X("Error",      s:white,    s:red,  "")
call <SID>X("Todo",       s:magenta,  "",     "bold")

" Standard highlighting
call <SID>X("ColorColumn",  "",         s:line,       "")
" Conceal
call <SID>X("Cursor",       "",         "",           "reverse")
call <SID>X("CursorColumn", "",         s:line,       "")
call <SID>X("CursorLine",   "",         s:line,       "")
call <SID>X("Directory",    s:skyblue,  "",           "")
call <SID>X("DiffAdd",      "",         s:green,      "")
call <SID>X("DiffChange",   "",         s:blue,       "")
call <SID>X("DiffDelete",   "",         s:red,        "")
call <SID>X("DiffText",     "",         s:skyblue,    "")
call <SID>X("ErrorMsg",     s:white,    s:red,        "")
call <SID>X("VertSplit",    s:line,     s:line,       "")
call <SID>X("Folded",       s:palegrey, "",           "")
call <SID>X("FoldColumn",   s:palegrey, s:palegrey,   "")
call <SID>X("SignColumn",   "",         s:palegrey,   "")
call <SID>X("IncSearch",    s:yellow,   s:black,      "")
call <SID>X("Substitute",   s:yellow,   s:black,      "")
call <SID>X("LineNr",       s:palegrey, "",           "")
call <SID>X("CursorLineNr", s:blue,     "",           "")
call <SID>X("MatchParen",   "",         s:skyblue,    "")
call <SID>X("ModeMsg",      s:blue,     "",           "")
" MoreMsg
call <SID>X("NonText",      s:red,      "",           "")
call <SID>X("Normal",       s:black,    s:background, "")
call <SID>X("NormalNC",     "",         "",           "")
call <SID>X("Pmenu",        s:black,    s:line,       "")
call <SID>X("PmenuSel",     s:white,    s:blue,       "")
call <SID>X("PmenuSBar",    s:grey,     s:palegrey,   "")
" PmenuThumb
call <SID>X("Question",     s:blue,     "",           "")
call <SID>X("QuickFixLine", "",         s:blue,       "")
call <SID>X("Search",       s:black,    s:skyblue,    "")
call <SID>X("SpecialKey",   s:red,      "",           "")
call <SID>X("SpellBad",     "",         "",           "undercurl")
call <SID>X("SpellCap",     "",         "",           "undercurl")
call <SID>X("SpellLocal",   "",         "",           "undercurl")
call <SID>X("SpellRare",    "",         "",           "undercurl")
call <SID>X("StatusLine",   s:blue,     s:white,      "")
call <SID>X("StatusLineNC", s:line,     s:palegrey,   "")
call <SID>X("TabLine",      s:palegrey, s:line,       "none")
call <SID>X("TabLineFill",  s:line,     s:line,       "")
call <SID>X("TabLineSel",   s:white,    s:blue,       "bold")
call <SID>X("Title",        s:grey,     "",           "underline")
call <SID>X("Visual",       "",         s:skyblue,    "")
call <SID>X("Visual",       "",         s:palegrey,   "")
call <SID>X("WarningMsg",   s:black,    s:yellow,     "")
call <SID>X("Whitespace",   s:skyblue,  "",           "")
call <SID>X("WildMenu",     s:blue,     s:line,       "")

" Delete highlight functions
delf <SID>X
