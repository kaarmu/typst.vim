" Vim syntax file
" Language: Typst
" Maintainer: Kaj Munhoz Arfvidsson

for s:name in g:typst_embedded_languages
    let s:include = ['syntax include'
                \   ,'@typstEmbedded_'..s:name
                \   ,'syntax/'..s:name..'.vim']
    let s:rule = ['syn region'
                \,s:name
                \,'matchgroup=Macro'
                \,'start=/```'..s:name..'\>/ end=/```/' 
                \,'contains=@typstEmbedded_'..s:name 
                \,'keepend']
    if g:typst_conceal
        let s:rule += ['concealends']
    endif 
    execute join(s:include, ' ')
    unlet! b:current_syntax
    execute join(s:rule, ' ')
endfor
