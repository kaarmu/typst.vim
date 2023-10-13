" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

if !exists('g:typst_cmd')
    let g:typst_cmd = "typst"
endif


if !exists('g:typst_pdf_viewer')
    let g:typst_pdf_viewer =  ""
endif

if !exists('g:typst_auto_close_toc')
    let g:typst_auto_close_toc =  0
endif

let b:did_ftplugin = 1

let s:cpo_orig = &cpo
set cpo&vim

compiler typst
"Workaround for https://github.com/typst/typst/issues/1937
set errorformat^=\/%f:%l:%c:%m

setlocal expandtab
setlocal tabstop=8
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal commentstring=//%s
setlocal comments=s1:/*,mb:*,ex:*/,://

setlocal formatoptions+=croq

setlocal suffixesadd=.typ

command! -nargs=* -buffer TypstWatch call typst#TypstWatch(<f-args>)

command! -buffer Toc call typst#Toc('vertical')
command! -buffer Toch call typst#Toc('horizontal')
command! -buffer Tocv call typst#Toc('vertical')
command! -buffer Toct call typst#Toc('tab')

let &cpo = s:cpo_orig
unlet s:cpo_orig
" vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab
