" Vim syntax file
" Language: Typst
" Maintainer: Kaj Munhoz Arfvidsson
" Latest Revision: 23-03-2023

if exists("b:current_syntax")
  finish
endif

" Clusters
syntax cluster typstNumbers contains=typstNumber,typstFloat,typstFraction,typstAngle,typstLength,typstRatio
syntax cluster typstCommon  contains=typstComment,typstNumber,typstFloat
syntax cluster typstMarkup  contains=@typstCommon,typstHashBrace,typstHashtag,typstDollar,typstLabel,typstReference,@Spell
syntax cluster typstCode    contains=@typstCommon,@typstNumbers,typstParen,typstBrace,typstBracket,typstFuncCall,typstString,typstConstant,typstConditional,typstRepeat,typstKeyword
syntax cluster typstMath    contains=@typstCommon,typstHashtag

" Symbols
syntax region typstParen   contained transparent matchgroup=typstParens   start='(' end=')'
syntax region typstBrace   contained transparent matchgroup=typstBraces   start='{' end='}'                 contains=@typstCode
syntax region typstBracket contained transparent matchgroup=typstBrackets start="\[" end="\]"               contains=@typstMarkup
syntax region typstDollar            transparent matchgroup=typstDollars  start="\$" end="\$"               contains=@typstMath
syntax region typstHashtag           transparent matchgroup=typstHashtags start="\#" end=";\|$"he=e-1       contains=@typstCode
syntax region typstHashBrace         transparent matchgroup=typstHashtags start="\#{" end="}"               contains=@typstCode

syntax match  typstComma    contained ","
syntax match  typstSemiCol  contained ";"
syntax match  typstOperator contained "+-*/=" " TODO: Add the rest

" Comments
syntax keyword typstCommentTodo contained TODO FIXME XXX TBD
syntax match   typstComment     "//.*$" contains=typstCommentTodo,@Spell

" Labels
syntax match typstLabel /<\k\+>/
syntax match typstReference /@\k\+/

" Function calls
syntax match typstFuncCall contained /\v\k+%(-+\k+)*\s*[\(\[]@=/

syntax keyword typstConditional if else contained
syntax keyword typstRepeat while for contained
syntax keyword typstKeyword let set show import include not in and or contained

" Other Keywords
syntax keyword typstConstant contained none auto true false

" Strings
syntax region typstString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=@Spell
syntax region typstString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell

" Decimal constant
syntax match typstNumber /\v<\d+>/
" Floating point constant, with dot
syntax match typstFloat  /\v<\d+\.\d*>/
" Length constant
syntax match typstLength    /\v<\d+(\.\d*)?(pt|mm|cm|in|em)>/
syntax match typstAngle     /\v<\d+(\.\d*)?(deg|rad)>/
syntax match typstRatio     /\v<\d+(\.\d*)?\%>/
syntax match typstFraction  /\v<\d+(\.\d*)?fr>/


" Define the default highlighting.
highlight default link typstParens           Noise
highlight default link typstBraces           Noise
highlight default link typstBrackets         Noise
highlight default link typstDollars          String
highlight default link typstHashtags         Keyword
highlight default link typstComment          Comment
highlight default link typstCommentTodo      Todo
highlight default link typstConditional      Conditional
highlight default link typstRepeat           Repeat
highlight default link typstKeyword          Keyword
highlight default link typstConstant         Constant
highlight default link typstFuncCall         Function
highlight default link typstLabel            Structure
highlight default link typstReference        Structure
highlight default link typstNumber           Number
highlight default link typstFloat            Number
highlight default link typstAngle            Number
highlight default link typstRatio            Number
highlight default link typstFraction         Number
highlight default link typstLength           Number
highlight default link typstOperator         Operator
highlight default link typstSemiCol          Delimiter
highlight default link typstString           String
