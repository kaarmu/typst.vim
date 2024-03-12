if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

setlocal autoindent
setlocal indentexpr=TypstIndent(v:lnum)
" setlocal indentkeys=... " We use the default

function! TypstIndent(lnum) abort " {{{1
    let s:sw = shiftwidth()
    
    let l:plnum = prevnonblank(a:lnum - 1)
    if l:plnum == 0
	    return 0
    endif

    let l:line = getline(a:lnum)
    let l:pline = getline(l:plnum)
    let l:ind = indent(l:plnum)

    if l:pline =~ '\v[{[(]\s*$'
      let l:ind = l:ind + s:sw
    endif

    if l:line =~ '\v^\s*[}\])],*$'
      let l:ind = l:ind - s:sw
    endif

    return l:ind
endfunction
" }}}1

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: et sts=2 sw=2 ft=vim
