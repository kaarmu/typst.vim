" FIXME: quick hack for #11
" this will introduce the jobstart/job_start problem with neovim/vim
function! typst#TypstWatch()
    " Prepare command
    let l:cmd = 'typst watch ' . expand('%') . ' --open'
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

