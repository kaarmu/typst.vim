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
" Works the same as in vimtex
function! typst#synstack(...) abort 
    let l:pos = a:0 > 0 ? [a:1, a:2] : [line('.'), col('.')]
    if mode() ==# 'i'
        let l:pos[1] -= 1
    endif
    call map(l:pos, 'max([v:val, 1])')

    return map(synstack(l:pos[0], l:pos[1]), "synIDattr(v:val, 'name')")
endfunction

function! typst#in_mode(name, ...) abort
    let l:name = 'typst' . toupper(a:name[0]) . a:name[1:]
    return match(call('typst#synstack', a:000), '^' . l:name) >= 0
endfunction
