" Vim color file
" Converted from Textmate theme Espresso Soda using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=light
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Espresso Soda"

hi Cursor  guifg=NONE guibg=#000000 gui=NONE
hi Visual  guifg=NONE guibg=#c2e8ff gui=NONE
hi CursorLine  guifg=NONE guibg=#f2f2f2 gui=NONE
hi CursorColumn  guifg=NONE guibg=#f2f2f2 gui=NONE
hi LineNr  guifg=#808080 guibg=#ffffff gui=NONE
hi VertSplit  guifg=#cfcfcf guibg=#cfcfcf gui=NONE
hi MatchParen  guifg=#61862f guibg=NONE gui=NONE
hi StatusLine  guifg=#000000 guibg=#cfcfcf gui=bold
hi StatusLineNC  guifg=#000000 guibg=#cfcfcf gui=NONE
hi Pmenu  guifg=#61862f guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#c2e8ff gui=NONE
hi IncSearch  guifg=NONE guibg=#c4daed gui=NONE
hi Search  guifg=NONE guibg=#c4daed gui=NONE
hi Directory  guifg=NONE guibg=#e8ffd5 gui=bold
hi Folded  guifg=#adadad guibg=#ffffff gui=NONE

hi Normal  guifg=#000000 guibg=#ffffff gui=NONE
hi Boolean  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi Character  guifg=#bc670f guibg=#fffdf7 gui=NONE
hi Comment  guifg=#adadad guibg=NONE gui=NONE
hi Conditional  guifg=#61862f guibg=NONE gui=NONE
hi Constant  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi Define  guifg=#61862f guibg=NONE gui=NONE
hi ErrorMsg  guifg=NONE guibg=NONE gui=NONE
hi WarningMsg  guifg=NONE guibg=NONE gui=NONE
hi Float  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi Function  guifg=#61862f guibg=NONE gui=NONE
hi Identifier  guifg=#6700b9 guibg=NONE gui=NONE
hi Keyword  guifg=#61862f guibg=NONE gui=NONE
hi Label  guifg=#bc670f guibg=#fffdf7 gui=NONE
hi NonText  guifg=#e0e0e0 guibg=#f2f2f2 gui=NONE
hi Number  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi Operator  guifg=#626fc9 guibg=NONE gui=NONE
hi PreProc  guifg=#61862f guibg=NONE gui=NONE
hi Special  guifg=#000000 guibg=NONE gui=NONE
hi SpecialKey  guifg=#e0e0e0 guibg=#f2f2f2 gui=NONE
hi Statement  guifg=#61862f guibg=NONE gui=NONE
hi StorageClass  guifg=#6700b9 guibg=NONE gui=NONE
hi String  guifg=#bc670f guibg=#fffdf7 gui=NONE
hi Tag  guifg=#2f6f9f guibg=#f4faff gui=NONE
hi Title  guifg=#000000 guibg=NONE gui=bold
hi Todo  guifg=#adadad guibg=NONE gui=inverse,bold
hi Type  guifg=#3a1d72 guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#61862f guibg=NONE gui=NONE
hi rubyFunction  guifg=#61862f guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=NONE guibg=#e8ffd5 gui=bold
hi rubyConstant  guifg=#3a1d72 guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#bc670f guibg=#fffdf7 gui=NONE
hi rubyBlockParameter  guifg=#4c8fc7 guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi rubyInclude  guifg=#61862f guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#4c8fc7 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#699d36 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#699d36 guibg=NONE gui=NONE
hi rubyEscape  guifg=NONE guibg=#fcedbd gui=bold
hi rubyControl  guifg=#61862f guibg=NONE gui=NONE
hi rubyClassVariable  guifg=#4c8fc7 guibg=NONE gui=NONE
hi rubyOperator  guifg=#626fc9 guibg=NONE gui=NONE
hi rubyException  guifg=#61862f guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi rubyRailsUserClass  guifg=#3a1d72 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#61862f guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#61862f guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#61862f guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#61862f guibg=NONE gui=NONE
hi erubyDelimiter  guifg=#000000 guibg=NONE gui=NONE
hi erubyComment  guifg=#adadad guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#61862f guibg=NONE gui=NONE
hi htmlTag  guifg=#61862f guibg=NONE gui=NONE
hi htmlEndTag  guifg=#61862f guibg=NONE gui=NONE
hi htmlTagName  guifg=#61862f guibg=NONE gui=NONE
hi htmlArg  guifg=#61862f guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#000000 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#6700b9 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#61862f guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#2f6f9f guibg=#f4faff gui=NONE
hi yamlAnchor  guifg=#4c8fc7 guibg=NONE gui=NONE
hi yamlAlias  guifg=#4c8fc7 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#bc670f guibg=#fffdf7 gui=NONE
hi cssURL  guifg=#4c8fc7 guibg=NONE gui=NONE
hi cssFunctionName  guifg=#61862f guibg=NONE gui=NONE
hi cssColor  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi cssPseudoClassId  guifg=#4f9fcf guibg=NONE gui=NONE
hi cssClassName  guifg=#4f9fcf guibg=NONE gui=NONE
hi cssValueLength  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi cssCommonAttr  guifg=#7653c1 guibg=#f3f2ff gui=NONE
hi cssBraces  guifg=#000000 guibg=NONE gui=NONE
