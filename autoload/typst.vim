" FIXME: quick hack for #11
" this will introduce the jobstart/job_start problem with neovim/vim
function! typst#TypstWatch(...)
    " Prepare command
    " NOTE: added arguments #23 but they will always be like
    " `typst <args> watch <file> --open` so in the future this might be
    " sensitive to in which order typst options should come.
    let l:cmd = g:typst_cmd
        \ . ' ' . join(a:000)
        \ . ' watch'
        \ . ' ' . expand('%')
        \ . ' --open'
    let l:str = has('win32')
        \ ? 'cmd /s /c "' . l:cmd . '"'
        \ : 'sh -c "' . l:cmd . '"'

    " Execute command and toggle status
    if has('nvim')
        let s:watcher = jobstart(l:str)
    else
        let s:watcher = job_start(l:str)
    endif
endfunction

" Detect context for #51
" Detects the inner most syntax group under the cursor by default.
function! typst#synstack(kwargs = {}) abort 
    let l:pos = get(a:kwargs, 'pos', getcurpos()[1:3])
    let l:only_inner = get(a:kwargs, 'only_inner', v:true)
    if mode() ==# 'i'
        let l:pos[1] -= 1
    endif
    call map(l:pos, 'max([v:val, 1])')

    let l:stack = map(synstack(l:pos[0], l:pos[1]), "synIDattr(v:val, 'name')")
    return l:only_inner ? l:stack[-1:] : l:stack
endfunction

function! typst#in_markup(...) abort
    let l:stack = call('typst#synstack', a:000)
    let l:ret = empty(l:stack)
    for l:name in l:stack
        let l:ret = l:ret 
            \ || l:name =~? '^typstMarkup'
            \ || l:name =~? 'Bracket$'
    endfor
    return l:ret
endfunction

function! typst#in_code(...) abort
    let l:ret = v:false
    for l:name in call('typst#synstack', a:000)
        let l:ret = l:ret 
            \ || l:name =~? '^typstCode'
            \ || l:name =~? 'Brace$'
    endfor 
    return l:ret
endfunction

function! typst#in_math(...) abort
    let l:ret = v:false
    for l:name in call('typst#synstack', a:000)
        let l:ret = l:ret 
            \ || l:name =~? '^typstMath'
            \ || l:name =~? 'Dollar$'
    endfor
    return l:ret
endfunction

function! typst#in_comment(...) abort
    let l:ret = v:false
    for l:name in call('typst#synstack', a:000)
        let l:ret = l:ret 
            \ || l:name =~? '^typstComment'
    endfor
    return l:ret
endfunction
