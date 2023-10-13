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
        \ . ' ' . g:typst_pdf_viewer

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

" Below are adapted from preservim/vim-markdown
" They have their own MIT License at https://github.com/preservim/vim-markdown#license
let s:headersRegexp = '^='

" For each level, contains the regexp that matches at that level only.
"
let s:levelRegexpDict = {
    \ 1: '^=[^=]',
    \ 2: '^==[^=]',
    \ 3: '^===[^=]',
    \ 4: '^====[^=]',
    \ 5: '^=====[^=]',
    \ 6: '^======[^=]'
\ }


" Returns the level of the header at the given line.
"
" If there is no header at the given line, returns `0`.
"
function! s:GetLevelOfHeaderAtLine(linenum)
    let l:lines = join(getline(a:linenum, a:linenum + 1), "\n")
    for l:key in keys(s:levelRegexpDict)
        if l:lines =~ get(s:levelRegexpDict, l:key)
            return l:key
        endif
    endfor
    return 0
endfunction

function! s:GetHeaderLineNum(...)
    if a:0 == 0
        let l:l = line('.')
    else
        let l:l = a:1
    endif
    while(l:l > 0)
        if join(getline(l:l, l:l + 1), "\n") =~ s:headersRegexp
            return l:l
        endif
        let l:l -= 1
    endwhile
    return 0
endfunction

function! s:GetHeaderLevel(...)
    if a:0 == 0
        let l:line = line('.')
    else
        let l:line = a:1
    endif
    let l:linenum = s:GetHeaderLineNum(l:line)
    if l:linenum !=# 0
        return s:GetLevelOfHeaderAtLine(l:linenum)
    else
        return 0
    endif
endfunction

function! s:GetHeaderList()
    let l:bufnr = bufnr('%')
    let l:fenced_block = 0
    let l:front_matter = 0
    let l:header_list = []
    let l:vim_markdown_frontmatter = get(g:, 'vim_markdown_frontmatter', 0)
    for i in range(1, line('$'))
        let l:lineraw = getline(i)
        let l:l1 = getline(i+1)
        let l:line = substitute(l:lineraw, '#', "\\\#", 'g')
        if join(getline(i, i + 1), "\n") =~# s:headersRegexp && l:line =~# '^\S'
            let l:is_header = 1
        else
            let l:is_header = 0
        endif
        if l:is_header ==# 1 && l:fenced_block ==# 0 && l:front_matter ==# 0
            if match(l:line, '^#') > -1
                let l:line = substitute(l:line, '\v^#*[ ]*', '', '')
                let l:line = substitute(l:line, '\v[ ]*#*$', '', '')
            endif
            let l:level = s:GetHeaderLevel(i)
            let l:item = {'level': l:level, 'text': l:line, 'lnum': i, 'bufnr': bufnr}
            let l:header_list = l:header_list + [l:item]
        endif
    endfor
    return l:header_list
endfunction

function! typst#Toc(...)
    if a:0 > 0
        let l:window_type = a:1
    else
        let l:window_type = 'vertical'
    endif

    let l:cursor_line = line('.')
    let l:cursor_header = 0
    let l:header_list = s:GetHeaderList()
    let l:indented_header_list = []
    if len(l:header_list) == 0
        echom 'Toc: No headers.'
        return
    endif
    let l:header_max_len = 0
    let l:vim_markdown_toc_autofit = get(g:, 'vim_markdown_toc_autofit', 0)
    for h in l:header_list
        if l:cursor_header == 0
            let l:header_line = h.lnum
            if l:header_line == l:cursor_line
                let l:cursor_header = index(l:header_list, h) + 1
            elseif l:header_line > l:cursor_line
                let l:cursor_header = index(l:header_list, h)
            endif
        endif
        let l:text = repeat('  ', h.level-1) . h.text
        let l:total_len = strdisplaywidth(l:text)
        if l:total_len > l:header_max_len
            let l:header_max_len = l:total_len
        endif
        let l:item = {'lnum': h.lnum, 'text': l:text, 'valid': 1, 'bufnr': h.bufnr, 'col': 1}
        let l:indented_header_list = l:indented_header_list + [l:item]
    endfor

    " Open the TOC buffer in a new window
    let l:orig_winid = win_getid()
    let l:toc_bufnr = bufnr('TOC', 1)
    " execute 'sbuffer ' . l:toc_bufnr
    if a:0 > 0
        if a:1 == 'vertical'
            execute 'vsplit +buffer' . l:toc_bufnr
            if (&columns/2) > l:header_max_len && l:vim_markdown_toc_autofit == 1
                execute 'vertical resize ' . (l:header_max_len + 1 + 3)
            else
                execute 'vertical resize ' . (&columns/2)
            endif
        elseif a:1 == 'tab'
            execute 'tabnew | buffer' . l:toc_bufnr
        else
            execute 'sbuffer ' . l:toc_bufnr
        endif
    else
        execute 'sbuffer ' . l:toc_bufnr
    endif

    setlocal buftype=nofile
    setlocal bufhidden=delete
    call setbufline(l:toc_bufnr, 1, map(copy(l:indented_header_list), 'v:val.text'))
    let b:indented_header_list = l:indented_header_list
    let b:orig_winid = l:orig_winid

    " Define a mapping to jump to the corresponding line in the original file when a line is clicked
    nnoremap <buffer> <silent> <Enter> :call <SID>JumpToHeader()<CR>

    " Move the cursor to the current header in the TOC
    execute 'normal! ' . l:cursor_header . 'G'

endfunction

function! s:JumpToHeader()
    let l:lnum = line('.')
    let l:header_info = b:indented_header_list[l:lnum - 1]
    let l:orig_winid = b:orig_winid
    call win_execute(l:orig_winid, 'buffer ' . l:header_info.bufnr)
    call win_execute(l:orig_winid, 'normal! ' . l:header_info.lnum . 'G')
    if g:typst_auto_close_toc
        bwipeout!
    endif
    call win_gotoid(l:orig_winid)
endfunction
