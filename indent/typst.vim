if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

setlocal autoindent
setlocal indentexpr=TypstIndentExpr()
" setlocal indentkeys=... " We use the default

" This wrapper function is used to enhance performance.
function! TypstIndentExpr() abort
    return TypstIndent(v:lnum)
endfunction

function! TypstIndent(lnum) abort " {{{1
    let s:sw = shiftwidth()

    let l:plnum = prevnonblank(a:lnum - 1)
    if l:plnum == 0 
        return 0 
    endif

    let l:pline = getline(l:plnum)

    " Skip comment lines
    while l:pline =~ '\v//.*$'
        let l:plnum = prevnonblank(l:plnum - 1)
        if l:plnum == 0 
            return 0 
        endif

        let l:pline = getline(l:plnum)
    endwhile

    let l:line = getline(a:lnum)
    let l:ind = indent(l:plnum)

    let l:stack = [''] + map(synstack(v:lnum , 1), "synIDattr(v:val, 'name')")

    " Use last indent for block comments
    if l:stack[-1] == 'typstCommentBlock'
        return l:ind
    endif

    if l:pline =~ '\v[{[(]\s*$'
        let l:ind += s:sw
    endif

    if l:line =~ '\v^\s*[}\])]'
        let l:ind -= s:sw
    endif

    return l:ind
endfunction
" }}}1

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: et sts=2 sw=2 ft=vim
