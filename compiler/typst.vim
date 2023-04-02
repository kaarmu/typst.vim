" Vim compiler file
" Compiler: typst

if exists("current_compiler")
    finish
endif
let current_compiler = "typst"

let s:save_cpo = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

let &l:makeprg = current_compiler
    \ . ' ' . shellescape(expand('%*'))
    \ . ' 2>&1 \| sed ' . shellescape('s/\x1B\[\([0-9]\+;\)*[0-9]\+m//g')

CompilerSet errorformat=
    \%E%trror:\ %m,
    \%C%.%#┌─\ %f:%l:%c,
    \%C%.%#│,
    \%C%.%#│%.%#,
    \%C%.%#│\ \ \ \%p^,
    \%Z

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab

