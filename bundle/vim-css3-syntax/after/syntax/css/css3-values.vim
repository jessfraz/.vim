syn match cssValueLength contained "[-+]\=\d\+\(\.\d*\)\=\(ch\|rem\|vw\|vh\|vmin\|vmax\)"
syn match cssValueAngle contained "[-+]\=\d\+\(\.\d*\)\=turn"
" TODO: create cssValueResolution group
syn match cssValueNumber contained "[-+]\=\d\+\(\.\d*\)\=dp\(i\|cm\|px\)"
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(calc\|toggle\)\s*(" end=")" oneline keepend
syn keyword cssCommonAttr contained initial
