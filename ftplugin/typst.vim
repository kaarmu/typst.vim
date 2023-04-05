" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
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

" FIXME: quick hack for #11
function! TypstWatch() abort
    " Prepare command
    let l:cmd = 'typst watch % --open'
    let l:str = has('win32')
          \ ? 'cmd /s /c "' . l:cmd . '"'
          \ : ['sh', '-c', l:cmd]

    " Execute command and toggle status
    call job_start(expand(l:str))
endfunction
command! -buffer TypstWatch call TypstWatch()

let &cpo = s:cpo_orig
unlet s:cpo_orig
" vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab
