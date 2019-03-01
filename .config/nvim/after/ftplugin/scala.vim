" Name: Scala configuration for Vim
" Author: Nicholas Truong

setlocal makeprg=sbt\ -no-colors\ compile
setlocal errorformat=;;;
setlocal errorformat+=[error]\ %f:%l:%c:\ %m
setlocal errorformat+=%-G%.%#
