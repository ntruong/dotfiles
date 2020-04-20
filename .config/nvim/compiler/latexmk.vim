" Vim compiler file
" Compiler:   Latexmk
" Maintainer: Nicholas Truong <me@n-truong.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "latexmk"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=latexmk\ -interaction=nonstopmode\ -file-line-error\ -pdf\ %<

CompilerSet errorformat=%f:%l:%m,%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
