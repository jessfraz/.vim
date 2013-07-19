" Vim color file
" Converted from Textmate theme Clouds using Coloration v0.2.5 (http://github.com/sickill/coloration)

highlight clear
		
if exists("syntax_on")
  syntax reset
endif
let colors_name = "cloudsxterm"

hi Cursor  guifg=#ffffff guibg=#000000 gui=NONE ctermbg=0 cterm=NONE ctermfg=15
hi Visual  guifg=NONE guibg=#bdd5fc gui=NONE ctermbg=153 cterm=NONE ctermfg=NONE
hi CursorLine  guifg=NONE guibg=#cccccc gui=NONE ctermbg=230 cterm=NONE ctermfg=NONE
" hi CursorLine  guifg=NONE guibg=#fffbdd gui=NONE ctermbg=230 cterm=NONE ctermfg=NONE
hi CursorColumn  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi LineNr  guifg=#9c9c9c guibg=#ffffff gui=NONE ctermbg=231 cterm=NONE ctermfg=244
hi VertSplit  guifg=#afafaf guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=244
hi MatchParen  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi StatusLine  guifg=#000000 guibg=#cfcfcf gui=bold ctermbg=252 cterm=bold ctermfg=16
hi StatusLineNC  guifg=#000000 guibg=#cfcfcf gui=NONE ctermbg=252 cterm=NONE ctermfg=16
hi Pmenu  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi PmenuSel  guifg=NONE guibg=#bdd5fc gui=NONE ctermbg=153 cterm=NONE ctermfg=NONE
hi IncSearch  guifg=NONE guibg=#e5dccf gui=NONE ctermbg=253 cterm=NONE ctermfg=NONE
hi Search  guifg=NONE guibg=#e5dccf gui=NONE ctermbg=253 cterm=NONE ctermfg=NONE
hi Directory  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi Folded  guifg=#bcc8ba guibg=#ffffff gui=NONE ctermbg=231 cterm=NONE ctermfg=250
hi FoldColumn guifg=#bcc8ba guibg=#ffffff gui=NONE ctermbg=231 cterm=NONE ctermfg=250

hi Normal  guifg=#555555 guibg=#ffffff gui=NONE ctermbg=231 cterm=NONE ctermfg=237
hi Boolean  guifg=#39946a guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=65
hi Character  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi Comment  guifg=#aaaaaa guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=250
"hi Conditional  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi Conditional  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi Constant  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi Define  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi ErrorMsg  guifg=#ff002a guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=196
hi WarningMsg  guifg=#ff002a guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=196
hi Float  guifg=#46a609 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=70
hi Function  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi Identifier  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi Keyword  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi Label  guifg=#5d90cd guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=68
hi NonText  guifg=#dfdfdf guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=254
" hi NonText  guifg=#ffffff guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=231
hi Number  guifg=#46a609 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=70
hi Operator  guifg=#484848 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=238
hi PreProc  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi Special  guifg=#000000 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=16
hi SpecialKey  guifg=#dfdfdf guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=250
" hi SpecialKey  guifg=#ffffff guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=231
"hi Statement  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi Statement  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=124
hi StorageClass  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi String  guifg=#5d90cd guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=68
hi Tag  guifg=#606060 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=59
hi Title  guifg=#000000 guibg=NONE gui=bold ctermbg=NONE cterm=bold ctermfg=16
hi Todo  guifg=#bcc8ba guibg=NONE gui=inverse,bold ctermbg=NONE cterm=inverse,bold ctermfg=250
hi Type  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline ctermbg=NONE cterm=underline ctermfg=NONE
hi rubyClass  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi rubyFunction  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubySymbol  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyStringDelimiter  guifg=#5d90cd guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=68
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyInclude  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi rubyGlobalVariable  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyRegexp  guifg=#5d90cd guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=68
hi rubyRegexpDelimiter  guifg=#5d90cd guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=68
hi rubyEscape  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyControl  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyOperator  guifg=#484848 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=238
hi rubyException  guifg=#af956f guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=137
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi rubyRailsARAssociationMethod  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi rubyRailsARMethod  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi rubyRailsRenderMethod  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi rubyRailsMethod  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi erubyDelimiter  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi erubyComment  guifg=#bcc8ba guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=250
hi erubyRailsMethod  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi htmlTag  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi htmlLink  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi htmlSpecialChar  guifg=#bf78cc guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=140
hi javaScriptFunction  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi javaScriptRailsFunction  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi yamlKey  guifg=#606060 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=59
hi yamlAnchor  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi yamlAlias  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi yamlDocumentHeader  guifg=#5d90cd guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=68
hi cssURL  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE
hi cssFunctionName  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi cssColor  guifg=#bf78cc guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=140
hi cssPseudoClassId  guifg=#606060 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=59
hi cssClassName  guifg=#c52727 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=160
hi cssValueLength  guifg=#46a609 guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=70
hi cssCommonAttr  guifg=#bf78cc guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=140
hi cssBraces  guifg=NONE guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=NONE

hi javaScriptGlobal  guifg=#bf78cc guibg=NONE gui=NONE ctermbg=NONE cterm=NONE ctermfg=140

hi treePart guifg=#afafaf guibg=NONE ctermbg=NONE ctermfg=250
hi treeOpenable guifg=#afafaf guibg=NONE ctermbg=NONE ctermfg=250
hi treePartFile guifg=#afafaf guibg=NONE ctermbg=NONE ctermfg=250
