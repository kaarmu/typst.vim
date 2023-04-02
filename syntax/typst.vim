" Vim syntax file
" Language: Typst
" Maintainer: Kaj Munhoz Arfvidsson
" Latest Revision: 23-03-2023

if exists("b:current_syntax")
  finish
endif

" Clusters
syntax cluster typstCommon
    \ contains=typstComment

" Comment
syntax cluster typstComment
    \ contains=typstCommentBlock,typstCommentLine
syntax match typstCommentBlock
    \ /\*.*\*/
    \ contains=typstCommentTodo,@Spell
syntax match typstCommentLine
    \ #//.*$#
    \ contains=typstCommentTodo,@Spell
syntax keyword typstCommentTodo
    \ contained
    \ TODO FIXME XXX TBD

" Symbols
syntax match typstSymbolComma       contained /,/
syntax match typstSymbolSemiColon   contained /;/
syntax match typstSymbolColon       contained /:/

" Code
syntax cluster typstCode contains=@typstCommon
syntax match typstCodeIdentifier
    \ contained containedin=typstCode
    \ /\v\k+%(-+\k+)*>-@![\.\[\(]@!/
syntax match typstCodeFieldAccess
    \ contained containedin=typstCode
    \ /\v\k+%(-+\k+)*>-@!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunctionCall
syntax match typstCodeFunctionCall
    \ contained containedin=typstCode
    \ /\v\k+%(-+\k+)*[\(\[]@=/
    " TODO Add nextgroup=typstCodeArgumentList or typstCodeDictionary
syntax keyword typstCodeConditional
    \ contained containedin=typstCode
    \ if else
syntax keyword typstCodeRepeat
    \ contained containedin=typstCode
    \ while for
syntax keyword typstCodeKeyword
    \ contained containedin=typstCode
    \ set show import include not in and or return
syntax keyword typstCodeConstant
    \ contained containedin=typstCode
    \ none auto true false
syntax region typstCodeString
    \ contained containedin=typstCode
    \ start=/"/ skip=/\v\\\\|\\"/ end=/"/
    \ contains=@Spell

" Hashtag
syntax cluster typstHashtag contains=@typstCommon
syntax match typstHashtagIdentifier
    \ containedin=typstHashtag
    \ /\v#\k+%(-+\k+)*>-@![\.\[\(]@!/
syntax match typstHashtagFieldAccess
    \ containedin=typstHashtag
    \ /\v#\k+%(-+\k+)*>-@!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunctionCall
syntax match typstHashtagFunction
    \ containedin=typstHashtag
    \ /\v#\k+%(-+\k+)*[\(\[]@=/
    \ nextgroup=@typstCode
    " TODO Add nextgroup=typstHashtagArgumentList or typstHashtagDictionary
syntax match typstHashtagConditional
    \ containedin=typstHashtag
    \ /\v#if>-@!/
    \ skipwhite nextgroup=@typstCode
syntax match typstHashtagRepeat
    \ containedin=typstHashtag
    \ /\v#(while|for)>-@!/
    \ skipwhite nextgroup=@typstCode
syntax match typstHashtagKeyword
    \ containedin=typstHashtag
    \ /\v#(set|show|import|include|return)>-@!/
    \ skipwhite nextgroup=@typstCode
syntax match typstHashtagConstant
    \ containedin=typstHashtag
    \ /\v#(none|auto|true|false)>-@!/

" Numbers
syntax cluster typstNumber
    \ contains=typstNumberInteger,typstNumberFloat,typstNumberLength,typstNumberAngle,typstNumberRatio,typstNumberFraction
syntax match typstNumberInteger
    \ /\v<\d+>/
syntax match typstNumberFloat
    \ /\v<\d+\.\d*>/
syntax match typstNumberLength
    \ /\v<\d+(\.\d*)?(pt|mm|cm|in|em)>/
syntax match typstNumberAngle
    \ /\v<\d+(\.\d*)?(deg|rad)>/
syntax match typstNumberRatio
    \ /\v<\d+(\.\d*)?\%>/
syntax match typstNumberFraction
    \ /\v<\d+(\.\d*)?fr>/

" Markup
syntax cluster typstMarkup
    \ contains=@typstCommon,@typstHashtag
syntax match typstMarkupRaw
    \ containedin=typstMarkup
    \ /`.*`/
syntax region typstMarkupRaw
    \ containedin=typstMarkup
    \ start=/```/ end=/```/
syntax match typstMarkupLabel
    \ containedin=typstMarkup
    \ /<\S\+>/
syntax match typstMarkupReference
    \ containedin=typstMarkup
    \ /@\S\+\s/
syntax match typstMarkupHeading
    \ containedin=typstMarkup
    \ /^=\{1,6}\s.*$/
syntax match typstMarkupBulletList
    \ containedin=typstMarkup
    \ /\v^\s*-\s+/
syntax match typstMarkupEnumList
    \ containedin=typstMarkup
    \ /\v^\s*(\+|\d+\.)\s+/

" Math
syntax cluster typstMath
    \ contains=@typstCommon,@typstHashtag

" Stmt
syntax keyword typstCodeLet
    \ contained containedin=typstCode
    \ let
    \ skipwhite nextgroup=typstCodeStmtAssignment,typstCodeStmtFunctionDefinition
syntax match typstHashtagLet
    \ containedin=typstHashtag
    \ /\v#let>-@!/
    \ skipwhite nextgroup=typstCodeStmtAssignment,typstCodeStmtFunctionDefinition
syntax match typstCodeStmtAssignment
    \ contained
    \ /\v\k+%(-+\k+)*>-@![\.\[\(]@!\s*\=/ transparent
    \ contains=typstCodeIdentifier
    \ skipwhite nextgroup=@typstCode
syntax region typstCodeStmtFunctionDefinition
    \ contained
    \ start=/\v\k+%(-+\k+)*[\(\[]@=/ end=/\v\s*\=/
    \ contains=typstCodeParen
    \ skipwhite nextgroup=@typstCode

" Paren variants
syntax region typstCodeParen
    \ contained containedin=typstCode
    \ start=/(/ end=/)/ transparent
    \ contains=@typstCode
syntax region typstCodeBrace
    \ contained containedin=typstCode
    \ start=/{/ end=/}/ transparent
    \ contains=@typstCode
syntax region typstCodeBracket
    \ contained containedin=typstCode
    \ start=/\[/ end=/\]/ transparent
    \ contains=@typstMarkup
syntax region typstCodeDollar
    \ contained containedin=typstCode
    \ start=/\$/ end=/\$/ transparent matchgroup=Number
    \ contains=@typstMath
syntax region typstMarkupDollar
    \ containedin=typstMarkup
    \ start=/\$/ end=/\$/ transparent matchgroup=Number
    \ contains=@typstMath
syntax region typstHashtagParen
    \ containedin=typstHashtag
    \ start=/#(/ end=/)/ transparent
    \ contains=@typstCode
syntax region typstHashtagBrace
    \ containedin=typstHashtag
    \ start=/#{/ end=/}/ transparent
    \ contains=@typstCode
syntax region typstHashtagBracket
    \ containedin=typstHashtag
    \ start=/#\[/ end=/\]/ transparent
    \ contains=@typstMarkup
syntax region typstHashtagDollar
    \ containedin=typstHashtag
    \ start=/#\$/ end=/\$/ transparent matchgroup=Number
    \ contains=@typstMath

" Define the default highlighting.
highlight default link typstCommentBlock        Comment
highlight default link typstCommentLine         Comment
highlight default link typstCommentTodo         Todo
highlight default link typstSymbolComma         Noise
highlight default link typstSymbolSemiColon     Noise
highlight default link typstSymbolColon         Noise
highlight default link typstCodeIdentifier      Identifier
highlight default link typstCodeFieldAccess     Identifier
highlight default link typstCodeFunctionCall    Function
highlight default link typstCodeConditional     Conditional
highlight default link typstCodeRepeat          Repeat
highlight default link typstCodeKeyword         Keyword
highlight default link typstCodeLet             Keyword
highlight default link typstHashtagLet          Keyword
highlight default link typstCodeConstant        Constant
highlight default link typstCodeString          String
highlight default link typstNumberInteger       Number
highlight default link typstNumberFloat         Number
highlight default link typstNumberLength        Number
highlight default link typstNumberAngle         Number
highlight default link typstNumberRatio         Number
highlight default link typstNumberFraction      Number
highlight default link typstMarkupRaw           Macro
highlight default link typstMarkupRaw           Macro
highlight default link typstMarkupLabel         Structure
highlight default link typstMarkupReference     Structure
highlight default link typstMarkupHeading       Statement
highlight default link typstMarkupBulletList    Statement
highlight default link typstMarkupEnumList      Statement
highlight default link typstHashtagIdentifier   Identifier
highlight default link typstHashtagFieldAccess  Identifier
highlight default link typstHashtagFunction     Function
highlight default link typstHashtagConditional  Conditional
highlight default link typstHashtagRepeat       Repeat
highlight default link typstHashtagKeyword      Keyword
highlight default link typstHashtagConstant     Constant
