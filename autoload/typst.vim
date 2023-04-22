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

