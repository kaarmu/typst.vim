" Vim compiler file
" Compiler: typst

if exists("current_compiler")
    finish
endif
let current_compiler = g:typst_cmd

let s:save_cpo = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

let s:filter_step = ['sed',
                    \shellescape('s/\\x1B\\[\\([0-9]\\+;\\)*[0-9]\\+m//g')]

if has('patch-7.4.191')
    let s:compile_step = [current_compiler, 'compile', '%:S']
else
    let s:compile_step = [current_compiler, 'compile', '%']
endif

let s:makeprg = s:compile_step
    \ + ['2>&1', '\\\|']
    \ + s:filter_step

" This style of `CompilerSet makeprg` is non-typical.
" The reason is that I want to avoid a long string of
" escaped spaces and we can very succinctly build makeprg
" with variables now. You cannot write something like this
" `CompilerSet makeprg=s:makeprg`.
execute 'CompilerSet makeprg=' . join(s:makeprg, '\ ')

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

