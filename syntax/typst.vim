" Vim syntax file
" Language: Typst
" Maintainer: Kaj Munhoz Arfvidsson
" Latest Revision: Apr 2023

if exists("b:current_syntax")
  finish
endif

syntax sync fromstart
syntax spell toplevel

" Common {{{1
syntax cluster typstCommon
    \ contains=@typstComment

" Common > Comment {{{2
syntax cluster typstComment
    \ contains=typstCommentBlock,typstCommentLine
syntax match typstCommentBlock
    \ #/\*\%(\_.\{-}\)\*/#
    \ contains=typstCommentTodo,@Spell
syntax match typstCommentLine
    \ #//.*#
    \ contains=typstCommentTodo,@Spell
syntax keyword typstCommentTodo
    \ contained
    \ TODO FIXME XXX TBD


" Code {{{1
syntax cluster typstCode
    \ contains=@typstCommon
            \ ,@typstCodeKeywords
            \ ,@typstCodeConstants
            \ ,@typstCodeIdentifiers
            \ ,@typstCodeFunctions
            \ ,@typstCodeParens

" Code > Keywords {{{2
syntax cluster typstCodeKeywords
    \ contains=typstCodeConditional
            \ ,typstCodeRepeat
            \ ,typstCodeKeyword
            \ ,typstCodeStatement
syntax keyword typstCodeConditional
    \ contained
    \ if else
syntax keyword typstCodeRepeat
    \ contained
    \ while for
syntax keyword typstCodeKeyword
    \ contained
    \ not in and or return
syntax region typstCodeStatement
    \ contained
    \ matchgroup=typstCodeStatementWord start=/\v(let|set|show|import|include)>-@!/ end=/\v%(;|$)/
    \ contains=@typstCode

" Code > Identifiers- {{{2
syntax cluster typstCodeIdentifiers
    \ contains=typstCodeIdentifier
            \ ,typstCodeFieldAccess
syntax match typstCodeIdentifier
    \ contained
    \ /\v\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include))@<![\.\[\(]@!/
syntax match typstCodeFieldAccess
    \ contained
    \ /\v\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include))@<!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunction

" Code > Functions {{{2
syntax cluster typstCodeFunctions
    \ contains=typstCodeFunction
syntax match typstCodeFunction
    \ contained
    \ /\v\K\k*%(-+\k+)*[\(\[]@=/
    \ nextgroup=typstCodeFunctionArgument
syntax match typstCodeFunctionArgument
    \ contained
    \ /\v%(%(\(.{-}\)|\[.{-}\]|\{.{-}\}))*/ transparent
    \ contains=@typstCode

" Code > Constants {{{2
syntax cluster typstCodeConstants
    \ contains=typstCodeConstant
            \ ,typstCodeNumberInteger
            \ ,typstCodeNumberFloat
            \ ,typstCodeNumberLength
            \ ,typstCodeNumberAngle
            \ ,typstCodeNumberRatio
            \ ,typstCodeNumberFraction
            \ ,typstCodeString
syntax match typstCodeConstant
    \ contained
    \ /\v<%(none|auto|true|false)-@!>/ 
syntax match typstCodeNumberInteger
    \ contained
    \ /\v<\d+>/

syntax match typstCodeNumberFloat
    \ contained
    \ /\v<\d+\.\d*>/
syntax match typstCodeNumberLength
    \ contained
    \ /\v<\d+(\.\d*)?(pt|mm|cm|in|em)>/
syntax match typstCodeNumberAngle
    \ contained
    \ /\v<\d+(\.\d*)?(deg|rad)>/
syntax match typstCodeNumberRatio
    \ contained
    \ /\v<\d+(\.\d*)?\%/
syntax match typstCodeNumberFraction
    \ contained
    \ /\v<\d+(\.\d*)?fr>/
syntax region typstCodeString
    \ contained
    \ start=/"/ skip=/\v\\\\|\\"/ end=/"/
    \ contains=@Spell

" Code > Parens {{{2
syntax cluster typstCodeParens
    \ contains=typstCodeParen
            \ ,typstCodeBrace
            \ ,typstCodeBracket
            \ ,typstCodeDollar
            \ ,typstMarkupRawInline
            \ ,typstMarkupRawBlock
syntax region typstCodeParen
    \ contained
    \ matchgroup=Noise start=/(/ end=/)/
    \ contains=@typstCode
syntax region typstCodeBrace
    \ contained
    \ matchgroup=Noise start=/{/ end=/}/
    \ contains=@typstCode
syntax region typstCodeBracket
    \ contained
    \ matchgroup=Noise start=/\[/ end=/\]/
    \ contains=@typstMarkup
syntax region typstCodeDollar
    \ contained
    \ matchgroup=Number start=/\$/ end=/\$/
    \ contains=@typstMath


" Hashtag {{{1
syntax cluster typstHashtag
    \ contains=@typstHashtagKeywords
            \ ,@typstHashtagConstants
            \ ,@typstHashtagIdentifiers
            \ ,@typstHashtagFunctions
            \ ,@typstHashtagParens

" Hashtag > Keywords {{{2
syntax cluster typstHashtagKeywords
    \ contains=typstHashtagConditional
            \ ,typstHashtagRepeat
            \ ,typstHashtagKeywords
            \ ,typstHashtagStatement

" syntax match typstHashtagControlFlowError
"     \ /\v#%(if|while|for)>-@!.{-}$\_.{-}%(\{|\[|\()/
syntax match typstHashtagControlFlow
    \ /\v#%(if|while|for)>-@!.{-}\ze%(\{|\[|\()/
    \ contains=typstHashtagConditional,typstHashtagRepeat 
    \ nextgroup=@typstCode
syntax region typstHashtagConditional
    \ contained
    \ start=/\v#if>-@!/ end=/\v\ze(\{|\[)/
    \ contains=@typstCode
syntax region typstHashtagRepeat
    \ contained
    \ start=/\v#(while|for)>-@!/ end=/\v\ze(\{|\[)/
    \ contains=@typstCode
syntax match typstHashtagKeyword
    \ /\v#(return)>-@!/
    \ skipwhite nextgroup=@typstCode
syntax region typstHashtagStatement
    \ matchgroup=typstHashtagStatementWord start=/\v#(let|set|show|import|include)>-@!/ end=/\v%(;|$)/
    \ contains=@typstCode

" Hashtag > Constants {{{2
syntax cluster typstHashtagConstants
    \ contains=typstHashtagConstant
syntax match typstHashtagConstant
    \ /\v#(none|auto|true|false)>-@!/

" Hashtag > Identifiers {{{2
syntax cluster typstHashtagIdentifiers
    \ contains=typstHashtagIdentifier
            \ ,typstHashtagFieldAccess
syntax match typstHashtagIdentifier
    \ /\v#\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include|if|while|for|return))@<![\.\[\(]@!/
syntax match typstHashtagFieldAccess
    \ /\v#\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include|if|while|for|return))@<!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunction

" Hashtag > Functions {{{2
syntax cluster typstHashtagFunctions
    \ contains=typstHashtagFunction
syntax match typstHashtagFunction
    \ /\v#\K\k*%(-+\k+)*[\(\[]@=/
    \ nextgroup=typstCodeFunctionArgument

" Hashtag > Parens {{{2
syntax cluster typstHashtagParens
    \ contains=typstHashtagParen
            \ ,typstHashtagBrace
            \ ,typstHashtagBracket
            \ ,typstHashtagDollar
syntax region typstHashtagParen
    \ matchgroup=Noise start=/#(/ end=/)/
    \ contains=@typstCode
syntax region typstHashtagBrace
    \ matchgroup=Noise start=/#{/ end=/}/
    \ contains=@typstCode
syntax region typstHashtagBracket
    \ matchgroup=Noise start=/#\[/ end=/\]/
    \ contains=@typstMarkup
syntax region typstHashtagDollar
    \ matchgroup=Noise start=/#\$/ end=/\$/
    \ contains=@typstMath


" Markup {{{1
syntax cluster typstMarkup
    \ contains=@typstCommon
            \ ,@Spell
            \ ,@typstHashtag
            \ ,@typstMarkupText
            \ ,@typstMarkupParens

" Markup > Text {{{2
syntax cluster typstMarkupText
    \ contains=typstMarkupRawInline
            \ ,typstMarkupRawBlock
            \ ,typstMarkupLabel
            \ ,typstMarkupReference
            \ ,typstMarkupUrl
            \ ,typstMarkupHeading
            \ ,typstMarkupBulletList
            \ ,typstMarkupEnumList
            \ ,typstMarkupBold
            \ ,typstMarkupItalic
            \ ,typstMarkupLinebreak
            \ ,typstMarkupNonbreakingSpace
            \ ,typstMarkupShy
            \ ,typstMarkupDash
            \ ,typstMarkupEllipsis
            \ ,typstMarkupTermList

syntax match typstMarkupRawInline
    \ /`.\{-}`/

syntax region typstMarkupRawBlock 
    \ matchgroup=Macro start=/```\w*/ 
    \ matchgroup=Macro end=/```/ keepend
syntax region typstCodeBlock
    \ matchgroup=Macro start=/```typst/
    \ matchgroup=Macro end=/```/ contains=@typstCode keepend
syntax include @C syntax/c.vim
syntax region typstMarkupCCodeBlock
    \ matchgroup=Macro start=/```c\>/
    \ matchgroup=Macro end=/```/ contains=@C keepend
syntax include @CPP syntax/cpp.vim
syntax region typstMarkupCPPCodeBlock 
    \ matchgroup=Macro start=/```cpp/
    \ matchgroup=Macro end=/```/ contains=@CPP keepend
syntax include @Python syntax/python.vim
syntax region typstMarkupPythonCodeBlock 
    \ matchgroup=Macro start=/```python/
    \ matchgroup=Macro end=/```/ contains=@Python keepend

syntax match typstMarkupLabel
    \ /\v\<\K%(\k*-*)*\>/
syntax match typstMarkupReference
    \ /\v\@\K%(\k*-*)*/
syntax match typstMarkupUrl
    \ #\v\w+://\S*#
syntax match typstMarkupHeading
    \ /^\s*\zs=\{1,6}\s.*$/
    \ contains=typstMarkupLabel,@Spell
syntax match typstMarkupBulletList
    \ /\v^\s*-\s+/
syntax match typstMarkupEnumList
    \ /\v^\s*(\+|\d+\.)\s+/
" syntax match typstMarkupItalicError
"     \ /\v(\w|\\)@<!_\S@=.*|.*\S@<=\\@<!_/
syntax match typstMarkupItalic
    \ /\v(\w|\\)@1<!_\S@=.{-}(\n.{-1,})*\S@1<=\\@1<!_/
    \ contains=typstMarkupItalicRegion
syntax region typstMarkupItalicRegion
    \ contained
    \ matchgroup=typstMarkupItalicDelimiter 
    \ start=/\(^\|[^0-9a-zA-Z]\)\@<=_/ end=/_\($\|[^0-9a-zA-Z]\)\@=/
    \ concealends contains=typstMarkupLabel,typstMarkupBold,@Spell
" syntax match typstMarkupBoldError
"     \ /\v(\w|\\)@<!\*\S@=.*|.*\S@<=\\@<!\*/
syntax match typstMarkupBold
    \ /\v(\w|\\)@1<!\*\S@=.{-}(\n.{-1,})*\S@1<=\\@1<!\*/
    \ contains=typstMarkupBoldRegion
syntax region typstMarkupBoldRegion
    \ contained
    \ matchgroup=typstMarkupBoldDelimiter 
    \ start=/\(^\|[^0-9a-zA-Z]\)\@<=\*/ end=/\*\($\|[^0-9a-zA-Z]\)\@=/
    \ concealends contains=typstMarkupLabel,typstMarkupBold,@Spell
syntax match typstMarkupLinebreak
    \ /\\\\/
syntax match typstMarkupNonbreakingSpace
    \ /\~/
syntax match typstMarkupShy
    \ /-?/
syntax match typstMarkupDash
    \ /-\{2,3}/
syntax match typstMarkupEllipsis
    \ /\.\.\./
syntax match typstMarkupTermList
    \ #\v^\s*\/\s+[^:]*:#

" Markup > Parens {{{2
syntax cluster typstMarkupParens
    \ contains=typstMarkupBracket
            \ ,typstMarkupDollar
syntax region typstMarkupBracket
    \ matchgroup=Noise start=/\[/ end=/\]/
    \ contains=@typstMarkup
syntax region typstMarkupDollar
    \ matchgroup=Special start=/\$/ skip=/\\\$/ end=/\$/
    \ contains=@typstMath


" Math {{{1
syntax cluster typstMath
    \ contains=@typstCommon
            \ ,@typstHashtag
            \ ,typstMathFunction
            \ ,typstMathNumber
            \ ,typstMathSymbol
            \ ,typstMathBold
            \ ,typstMathScripts
            \ ,typstMathQuote

syntax match typstMathFunction
    \ /\<\v\zs\a\w+\ze\(/
    \ contained
syntax match typstMathNumber
    \ /\<\d\+\>/
    \ contained
syntax region typstMathQuote
    \ matchgroup=String start=/"/ skip=/\\"/ end=/"/
    \ contained

if g:typst_conceal_math
    runtime! syntax/typst-symbols.vim
endif


" Math > Linked groups {{{2
highlight default link typstMathFunction            Statement
highlight default link typstMathNumber              Number
highlight default link typstMathSymbol              Statement

" Highlighting {{{1

" Highlighting > Linked groups {{{2
highlight default link typstCommentBlock            Comment
highlight default link typstCommentLine             Comment
highlight default link typstCommentTodo             Todo
highlight default link typstCodeConditional         Conditional
highlight default link typstCodeRepeat              Repeat
highlight default link typstCodeKeyword             Keyword
highlight default link typstCodeConstant            Constant
highlight default link typstCodeNumberInteger       Number
highlight default link typstCodeNumberFloat         Number
highlight default link typstCodeNumberLength        Number
highlight default link typstCodeNumberAngle         Number
highlight default link typstCodeNumberRatio         Number
highlight default link typstCodeNumberFraction      Number
highlight default link typstCodeString              String
highlight default link typstCodeStatementWord       Statement
highlight default link typstCodeIdentifier          Identifier
highlight default link typstCodeFieldAccess         Identifier
highlight default link typstCodeFunction            Function
highlight default link typstCodeParen               Noise
highlight default link typstCodeBrace               Noise
highlight default link typstCodeBracket             Noise
highlight default link typstCodeDollar              Noise
" highlight default link typstHashtagControlFlowError Error
highlight default link typstHashtagConditional      Conditional
highlight default link typstHashtagRepeat           Repeat
highlight default link typstHashtagKeyword          Keyword
highlight default link typstHashtagConstant         Constant
highlight default link typstHashtagStatementWord    Statement
highlight default link typstHashtagIdentifier       Identifier
highlight default link typstHashtagFieldAccess      Identifier
highlight default link typstHashtagFunction         Function
highlight default link typstHashtagParen            Noise
highlight default link typstHashtagBrace            Noise
highlight default link typstHashtagBracket          Noise
highlight default link typstHashtagDollar           Noise
highlight default link typstMarkupRawInline         Macro
highlight default link typstMarkupRawBlock          Macro
highlight default link typstMarkupLabel             Structure
highlight default link typstMarkupReference         Structure
highlight default link typstMarkupBulletList        Structure
" highlight default link typstMarkupItalicError       Error
" highlight default link typstMarkupBoldError         Error
highlight default link typstMarkupEnumList          Structure
highlight default link typstMarkupLinebreak         Structure
highlight default link typstMarkupNonbreakingSpace  Structure
highlight default link typstMarkupShy               Structure
highlight default link typstMarkupDash              Structure
highlight default link typstMarkupEllipsis          Structure
highlight default link typstMarkupTermList          Structure
highlight default link typstMarkupDollar            Noise

" Highlighting > Custom Styling {{{2
highlight! Conceal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

highlight default typstMarkupHeading                    term=underline,bold     cterm=underline,bold    gui=underline,bold
highlight default typstMarkupUrl                        term=underline          cterm=underline         gui=underline
highlight default typstMarkupBoldRegion                 term=bold               cterm=bold              gui=bold
highlight default typstMarkupItalicRegion               term=italic             cterm=italic            gui=italic

highlight default link typstMarkupBoldDelimiter         typstMarkupBold
highlight default link typstMarkupItalicDelimiter       typstMarkupItalic

" }}}1

let b:current_syntax = "typst"

" vim: foldlevel=0 tabstop=8 shiftwidth=4 softtabstop=4 expandtab
