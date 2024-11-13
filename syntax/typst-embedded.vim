" Vim syntax file
" Language: Typst
" Maintainer: Kaj Munhoz Arfvidsson
" Upstream: https://github.com/kaarmu/typst.vim

for s:name in g:typst_embedded_languages
    let s:langname = substitute(s:name, '  *-> .*$', '', '')
    let s:langfile = substitute(s:name, '^.* ->  *', '', '')
    let s:include = ['syntax include'
                \   ,'@typstEmbedded_'..s:langname
                \   ,'syntax/'..s:langfile..'.vim']
    let s:rule = ['syn region'
                \,s:langname
                \,'matchgroup=Macro'
                \,'start=/```'..s:langname..'\>/ end=/```/'
                \,'contains=@typstEmbedded_'..s:langname
                \,'keepend']
    if g:typst_conceal
        let s:rule += ['concealends']
    endif
    execute 'silent! ' .. join(s:include, ' ')
    unlet! b:current_syntax
    execute join(s:rule, ' ')
endfor

" vim: sw=4 sts=4 et fdm=marker fdl=0
