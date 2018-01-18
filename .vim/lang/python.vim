" Name: Python configuration for Vim
" Author: Nicholas Truong
"==================================================

"==================================================
""" SETTINGS:
let b:commentflag = '#'
inoremap <buffer> #imp #import
""" CUSTOM SYNTAX:
syn match pythonFunction "\v\.(\w+)\("hs=s+1,he=e-1
"==================================================
