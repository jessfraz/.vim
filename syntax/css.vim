" Better CSS Syntax for Vim
" Language: Cascading Style Sheets
" Maintainer:   Chris Yip <chrisyipw@gmail.com>, twitter: @chrisyipw
" URL:  http://www.vim.org/scripts/script.php?script_id=3220
" GIT:  http://github.com/ChrisYis/Better-CSS-Syntax-for-Vim
" Last Update:  2012/5/29
" Full CSS2, most of HTML5 & CSS3 properties (include prefix like -moz-) supported

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
set iskeyword+=-

syn region cssAtkeyword start=/@\(media\|font-face\|page\|keyframes\)/ end=/\ze{/ contains=cssAtType, cssAtkey, cssPseudo, cssValFn, cssValBlock
syn region cssAtkeyword start=/@\(import\|charset\|namespace\)/ end=/\ze;/ contains=cssAtType, cssAtkey, cssPseudo, cssValFn, cssValBlock

syn keyword cssAtType media import charset font-face page keyframes namespace contained
syn keyword cssAtkey all braille embossed handheld print projection screen speech tty tv contained

syn region cssValBlock start=/(/ end=/)/ contained contains=cssAtProps

syn match cssAtProps /[^()]*/ contained contains=cssMediaProp,cssAtValBlock
syn keyword cssMediaProp grid monochrome orientation scan contained
syn match cssMediaProp /color\(-index\)\=\ze\s*[:)]/ contained
syn match cssMediaProp /\(\(device\)-\)\=aspect-ratio\ze\s*[:)]/ contained
syn match cssMediaProp /\(\(max\|min\)-\)\=device-\(height\|width\)\ze\s*[:)]/ contained
syn match cssMediaProp /\(\(max\|min\)-\)\=\(height\|width\)\ze\s*[:)]/ contained

syn region cssAtValBlock start=/:\zs/ end=/\ze[)]/ contained contains=cssAttr,cssColor,cssImportant,cssNumber,cssUnits,cssQuote,cssFunction

syn region cssValFn start=/\<url\s*(/ end=/)\ze/ contained contains=cssPathFn

syn match cssTagName /\*/
syn keyword cssTagName a abbr acronym address applet area article aside audio b base basefont bdo big blockquote body br button canvas caption center cite code col colgroup command datalist dd del details dfn dir div dl dt em embed fieldset font form figcaption figure footer frame frameset h1 h2 h3 h4 h5 h6 head header hgroup hr html img i iframe img input ins isindex kbd keygen label legend li link map mark menu meta meter nav noframes noscript object ol optgroup option output p param pre progress q rp rt ruby s samp script section select small span strike strong style sub summary sup table tbody td textarea tfoot th thead time title tr tt ul u var variant video xmp

syn match cssClass "\.[A-Za-z][A-Za-z0-9_-]\{0,\}"

syn match cssIdentifier "#[A-Za-z_@][A-Za-z0-9_@-]*"

syn match cssPrefix /\(-\(webkit\|moz\|o\|ms\)-\)\|filter/

syn match cssNumber /\(-\)\=\(\.\d\+\|\d\+\(\.\d\+\)\{0,\}\)/ contained

syn match cssPseudo /\:\(child\|link\|visited\|active\|hover\|focus\|left\|right\|root\|empty\|target\|enabled\|disabled\|checked\|indeterminate\|valid\|invalid\|required\|optional\|default\)\>/
syn match cssPseudo /\:first\-\(child\)\>/
syn match cssPseudo /\:\{1,2\}first\-\(letter\|line\)\>/
syn match cssPseudo /\:\(last\|only\)-child\>/
syn match cssPseudo /\:\(first\|last\|only\)-of-type\>/
syn match cssPseudo /\:nth\(-last\)\{0,1\}-child([0-9]*[n]*)/
syn match cssPseudo /\:nth\(-last\)\{0,1\}-of-type([0-9]*[n]*)/
syn match cssPseudo /\:not([#\.]\{0,\}\S\+)/
syn match cssPseudo /\:lang([a-zA-Z]\{2\}\(-[a-zA-Z]\{2\}\)\{0,1\})\>/
syn match cssPseudo /\:read\-\(only\|write\)\>/
syn match cssPseudo /\:\{1,2\}\(after\|before\)\>/
syn match cssPseudo /\:\{2\}selection\>/
syn match cssPseudo /\:\{2\}value\>/
syn match cssPseudo /\:\{2\}progress-bar\>/

syn region cssFuncRegion start=/{/ end=/}/ contains=cssPropRegion

syn match cssPropRegion /[^{}]*/ contained contains=cssProp,cssAttrBlock,cssPrefix,cssComment transparent

syn region cssAttrBlock start=/:\zs/ end=/\ze[;}]\{1\}/ contained contains=cssAttr,cssColor,cssImportant,cssNumber,cssUnits,cssQuote,cssFunction

syn keyword cssAttr above absolute accent adjacent after alias all alphabetic alternate always auto avoid balance baseline back before behind below blink block bold bolder border both bottom capitalize caption cell center central circle clear clone code collapse compact copy crop cross crosshair current dashed default digits disc discard dot dotted double embed end fast faster fill first fixed forward front hanging help here hidden hide high higher horizontal icon ideographic inherit inhibit initial invert italic justify kashida landscape last left level lighter linear loud low lower ltr mathematical manual medium meet menu middle modal move multiple moderate narrower new none normal nowrap oblique overline parent perceptual pointer portrait progress reduced relative reverse ridge right root rtl same saturation scroll separate show silent single slice slide slow slower solid soft square start static stretch strong sub super suppress tab text thick thin tibetan top underline unrestricted vertical visible wait wider window contained

syn match cssAttr /\<transparent\>/ contained

syn match cssAttr /\<\(absolute\|relative\)-colorimetric\>/ contained
syn match cssAttr /<\(pause\|rest\)-\(after\|before\)\>/ contained
syn match cssAttr /\<\(x-\)\=\(weak\|strong\|low\|high\)\>/ contained
syn match cssAttr /\(in\|out\)\(set\|side\)/ contained
syn match cssAttr /\<\(block\|inline\)-axis\>/ contained
syn match cssAttr /\<\(border\|content\)-box\>/ contained
syn match cssAttr /\<x-\(loud\|soft\|slow\|fast\|low\|high\)\>/ contained
syn match cssAttr /\<context-menu\|not-allowed\|vertical-text\|all-scroll\|from-image\|spell-out\|line-through\|bidi-override\|keep-all\>/ contained
syn match cssAttr /\<inline\(-\(block\|table\)\)\{0,1\}\>/ contained
syn match cssAttr /\<table\(-\(caption\|cell\|column\|row\)\)\{0,1\}\>/ contained
syn match cssAttr /\<table\(-\(column\|footer\|header\|row\)-group\)\>/ contained
syn match cssAttr /\<ruby\(-\(base\|text\)\(-group\)\{0,1\}\)\{0,1\}\>/ contained
syn match cssAttr /\<\(exclude\|include\)-ruby\>/ contained
syn match cssAttr /\<\(consider\|disregard\)-shifts\>/ contained
syn match cssAttr /\<list-item\|run-in\>/ contained
syn match cssAttr /\<\(\(\(block\|inline\)-line\)\|max\|grid\)-height\>/ contained
syn match cssAttr /\<\(far\|left\|right\)-side\>/ contained
syn match cssAttr /\<\(left\|right\)wards\>/ contained
syn match cssAttr /\<\(center\|far\)-\(left\|right\)\>/ contained
syn match cssAttr /\<\(\(text-\)\=\(before\|after\)-\(edge\|central\|ideographic\|alphabetic\|hanging\|mathematical\|use-script\)\)\>/ contained
syn match cssAttr /\<\([nwse]\{1,4\}\|col\|row\)-resize\>/ contained
syn match cssAttr /\<use-scriot\|reset-size\|caps-height\|status-bar\|message-box\>/ contained
syn match cssAttr /\<small-\(caps\|caption\)\>/ contained
syn match cssAttr /\<\(\(ultra\|extra\|semi\)-\)\=\(condensed\|expanded\)\>/ contained
syn match cssAttr /\<no-\(change\|content\|display\|drop\|limit\|repeat\)\>/ contained
syn match cssAttr /\<repeat\(-\(x\|y\)\)\=\>/ contained
syn match cssAttr /\<\(end\|line\)-edge\>/ contained
syn match cssAttr /\<break-\(all\|word\|strict\)\>/ contained
syn match cssAttr /\<\(upper\|lower\)case\>/ contained
syn match cssAttr /\<distribute\(-\(letter\|space\)\)\=\>/ contained
syn match cssAttr /\<\(literal\|no\)-punctuation\>/ contained
syn match cssAttr /\<inter-\(word\|ideograph\|cluster\)\>/ contained
syn match cssAttr /\<\(font\|text\|max\)-size\>/ contained
syn match cssAttr /\<ease\(-\(in\|out\|in-out\)\)\=\>/ contained
syn match cssAttr /\<text-\(top\|bottom\)\>/ contained
syn match cssAttr /\<pre\(-\(wrap\|line\)\)\=\>/ contained
syn match cssAttr /\<preserve\(-\(breaks\)\)\=\>/ contained

syn match cssProp /\(appearance\|backface-visibility\|binding\|bottom\|clear\|clip\|color\|columns\|content\|crop\|cursor\|direction\|elevation\|empty-cells\|hanging-punctuation\|height\|hyphens\|icon\|inline-box-align\|left\|letter-spacing\|move-to\|nbsp-mode\|opacity\|orphans\|phonemes\|position\|play-during\|presentation-level\|punctuation-trim\|quotes\|rendering-intent\|resize\|richness\|right\|size\|speech-rate\|src\|stress\|string-set\|tab-size\|table-layout\|top\|unicode-bidi\|vertical-align\|visibility\|volume\|widows\|width\|z-index\|zimuth\)\ze\s*:/ contained

syn match cssProp /\(\<\|\)alignment-\(adjust\|baseline\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)animation\(-\(delay\|direction\|duration\|iteration-count\|name\|play-state\|timing-function\)\)\{0,1\}\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)background\(-\(attachment\|break\|clip\|color\|image\|origin\|position\|repeat\|size\)\)\{0,1\}\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)baseline-shift\|caption-side\|color-profile\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)bookmark-\(label\|level\|target\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)border\(-\(bottom\|collapse\|color\|image\|left\|length\|radius\|right\|spacing\|style\|top\|width\)\)\{0,1\}\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)border\(-\(bottom\|left\|right\|top\)\(-\(color\|style\|wdith\)\)\{0,1\}\)\{0,1\}\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)border-\(bottom\|top\)-\(left\|right\)-radius\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)box-\(align\|decoration-break\|direction\|flex\|\(flex\|ordinal\)-group\|lines\|orient\|pack\|shadow\|sizing\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)column\(-\(\break-\(after\|before\)\|count\|fill\|gap\|rule\(-\(color\|style\|width\)\)\{0,1\}\)\|span\|width\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)counter-\(increment\|reset\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)cue\(-\(after\|before\)\)\{0,1\}\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)display\(-\(model\|role\)\)\{0,1\}\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)dominant-baseline\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)drop-initial-\(\(\(after\|before\)-\(adjust\|align\)\)\|size\|value\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)fit\(-position\)\{0,1\}\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)float\>\(-offset\)\{0,1\}\ze\s*:/ contained
syn match cssProp /\(\<\|\)font\(-\(family\|size\(-adjust\)\=\|stretch\|style\|variant\|weight\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)grid-\(columns\|rows\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)hyphenate-\(after\|before\|character\|lines\|resource\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)image-\(orientation\|resolution\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)line-\(height\|stacking\(-\(ruby\|shift\|strategy\)\)\=\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)list-style\(-\(image\|position\|type\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)\(margin\|padding\)\(-\(bottom\|left\|right\|start\|top\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)mark\(s\|-\(after\|before\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)\(max\|min\)-\(height\|width\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)nav-\(down\|index\|left\|right\|up\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)outline\(-\(color\|offset\|style\|width\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)overflow\(-\(style\|x\|y\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)page\(-\(break-\(after\|before\|inside\)\|policy\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)pause\(-\(after\|before\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)pitch\(-range\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)rest\(-\(after\|before\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)rotation\(-point\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)ruby-\(align\|overhang\|position\|span\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)speak\(-\(header\|numeral\|punctuation\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)target\(-\(name\|new\|position\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)text-\(align\(-last\)\=\|decoration\|emphasis\|height\|indent\|justify\|outline\|replace\|shadow\|transform\|wrap\|overflow\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)transition\(-\(delay\|duration\|property\|timing-function\)\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)voice-\(balance\|duration\|family\|pitch\(-range\)\=\|rate\|stress\|volume\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)white-space\(-collapse\)\=\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)word-\(break\|spacing\|wrap\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)user-\(drag\|modify\|select\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)marquee\(-\(direction\|play-count\|loop\|increment\|repetition\|speed\|style\)\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)mask\(-\(attachment\|box-image\|clip\|composite\|image\|position\|position-x\|position-y\|size\|repeat\|origin\)\)\>\ze\s*:/ contained
syn match cssProp /\(\<\|\)transform\(-\(origin\|origin-x\|origin-y\|origin-z\|style\)\)\>\ze\s*:/ contained

syn match cssSelector /\[[#\.]\{0,1\}\c[-a-z0-9]\+\([*^$]\{0,1\}=\c[-a-z0-9_'"]\+\)*\]/

syn match cssUnits /\d\@<=\(%\|cm\|deg\|dpi\|dpcm\|em\|ex\|\in\|mm\|pc\|pt\|px\|s\)\ze\s*[,;)}]\=/ contained

syn match cssColor /#\(\x\{6\}\|\x\{3\}\)/ contained

syn match cssImportant /!important\>/ contained

syn region cssComment start=/\/\*/ end=/\*\// contains=@Spell

syn region cssFunction start=/\c[-a-z0-9@]*(/ end=/)/ contained contains=cssPathFn,cssAttValFn

syn region cssPathFn start=/\<\(url\|format\)\s*(\zs/ end=/\ze)/ contained

syn region cssAttValFn start=/\<\(rotate\|rgba\|rgb\|hsl\|hsla\)\s*(\zs/ end=/\ze)/ contained contains=cssNumber,cssUnits

syn match cssBraket /[{}]/ contained

syn match cssQuote /\('.*'\|".*"\)/ contained

" Define the default highlighting.
command -nargs=+ HLink hi def link <args>

HLink cssAtkeyword Constant
HLink cssAtType Identifier
HLink cssAtkey Special
HLink cssMediaProp Type
HLink cssAtProps Function

HLink cssAttr SpecialKey

HLink cssAttValFn Function

HLink cssValBlock Function
HLink cssValFn Function

HLink cssAttrBlock Normal

HLink cssBraket Function

HLink cssClass Function

HLink cssColor Constant

HLink cssComment Comment

HLink cssError ErrorMsg

HLink cssPathFn Directory

HLink cssFunction Function
HLink cssFnValBlock Function

HLink cssFuncRegion Function

HLink cssIdentifier Identifier

HLink cssImportant PreProc

HLink cssUnits Special

HLink cssNumber Number

HLink cssPrefix Special

HLink cssProp Type

HLink cssPropRegion Normal

HLink cssPseudo Structure

HLink cssQuote String

HLink cssSelector Structure

HLink cssString String

HLink cssTagName Statement

HLink cssURL String

delcommand HLink

let b:current_syntax = "css"
syn sync minlines=10
