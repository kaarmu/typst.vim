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

    let [l:plnum, l:pline] = s:get_prev_nonblank(a:lnum - 1)
    if l:plnum == 0 | return 0 | endif

    let l:line = getline(a:lnum)
    let l:ind = indent(l:plnum)

    let l:synname = synIDattr(synID(a:lnum, 1, 1), "name")

    " Use last indent for block comments
    if l:synname == 'typstCommentBlock'
        return l:ind
    " do not change the indents of bullet lists
    elseif l:synname == 'typstMarkupBulletList'
        return indent(a:lnum)
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

" Gets the previous non-blank line that is not a comment.
function! s:get_prev_nonblank(lnum) abort " {{{1
    let l:lnum = prevnonblank(a:lnum)
    let l:line = getline(l:lnum)

    while l:lnum > 0 && l:line =~ '^\s*//'
        let l:lnum = prevnonblank(l:lnum - 1)
        let l:line = getline(l:lnum)
    endwhile

    return [l:lnum, s:remove_comments(l:line)]
endfunction
" }}}1

" Removes comments from the given line.
function! s:remove_comments(line) abort " {{{1
    return substitute(a:line, '\s*//.*', '', '')
endfunction
" }}}1

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: et sts=2 sw=2 ft=vim
