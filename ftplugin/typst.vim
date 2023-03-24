" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let s:cpo_orig = &cpo
set cpo&vim

compiler typst

setlocal suffixesadd=.typ

let &cpo = s:cpo_orig
unlet s:cpo_orig
" vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab
