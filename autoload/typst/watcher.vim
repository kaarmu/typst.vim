" typst.vim - Vim plugin for Typst
"
" TypstWatch is for interactive editing of a document. The command opens
" a PDF reader and runs `typst watch` in the background so that you can
" write almost like a WYSIWYG! 
"
" Authors:
" - kaarmu (Kaj Munhoz Arfvidsson)
"

function! typst#watcher#init()
    command! -nargs=* -buffer TypstWatch call typst#watcher#TypstWatch(<f-args>)
endfunction

function! typst#watcher#TypstWatch(...)
    " Prepare command
    " NOTE: added arguments #23 but they will always be like
    " `typst <args> watch <file> --open` so in the future this might be
    " sensitive to in which order typst options should come.
    let l:cmd = g:typst_cmd
        \ . ' ' . join(a:000)
        \ . ' watch'
        \ . ' --diagnostic-format short'
        \ . ' ' . expand('%')

    if !empty(g:typst_pdf_viewer)
        let l:cmd = l:cmd . ' --open ' . g:typst_pdf_viewer 
    else
        let l:cmd = l:cmd . ' --open'
    endif

    " Write message
    echom 'Starting: ' . l:cmd

    let l:str = has('win32')
              \ ? 'cmd /s /c "' . l:cmd . '"'
              \ : 'sh -c "' . l:cmd . '"'

    " Execute command and toggle status
    if has('nvim')
        " let s:watcher = jobstart(l:str, {'on_stderr': 'typst#TypstWatcherCb'})
        let s:watcher = jobstart(l:str)
    else
        if exists('s:watcher') && job_status(s:watcher) == 'run'
            echoerr 'TypstWatch is already running.'
        endif
	let l:Callback = function('s:TypstWatcherCb')
        let s:watcher = job_start(l:str, {'err_mode': 'raw',
                                         \'err_cb': l:Callback})
    endif
endfunction

" Callback function for job exit
function! s:TypstWatcherCb(channel, str)
    let l:errors = []
    for l:line in split(a:str, "\n")
        " Probably this match can be done using errorformat.
	" Maybe do something like vim-dispatch.
        let l:match = matchlist(l:line, '\v^([^:]+):(\d+):(\d+):\s*(.+)$')
        if 0 < len(l:match)
            let l:error = {'filename': l:match[1],
                          \'lnum': l:match[2],
                          \'col': l:match[3],
                          \'text': l:match[4]}
            call add(l:errors, l:error)
        endif
    endfor
    call setqflist(l:errors)
    execute empty(l:errors) ? 'cclose' : 'copen'
endfunction
