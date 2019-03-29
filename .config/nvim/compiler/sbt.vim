" Vim compiler file
" Compiler:   sbt
" Maintainer: Nicholas Truong <me@n-truong.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "sbt"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=sbt\ -no-colors\ compile

CompilerSet errorformat=
  \%E\ %#[error]\ %f:%l:%c:\ %m,
  \%C\ %#[error]\ %p^,%-C%.%#,%Z,
  \%W\ %#[warn]\ %f:%l:%c:\ %m,
  \%C\ %#[warn]\ %p^,%-C%.%#,%Z,
  \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
