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

CompilerSet makeprg=typst\ compile\ \$*\ \%:S
" TODO: errorformat

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab

