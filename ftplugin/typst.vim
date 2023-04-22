" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

if !exists('g:typst_cmd')
    let g:typst_cmd = "typst"
endif

let b:did_ftplugin = 1

let s:cpo_orig = &cpo
set cpo&vim

compiler typst

setlocal expandtab
setlocal tabstop=8
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal formatoptions+=croq

setlocal suffixesadd=.typ

command! -nargs=* -buffer TypstWatch call typst#TypstWatch(<f-args>)

let &cpo = s:cpo_orig
unlet s:cpo_orig
" vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab
