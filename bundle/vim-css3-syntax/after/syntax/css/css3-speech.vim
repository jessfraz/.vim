syn match cssAuralProp contained "\<voice-\(volume\|balance\|rate\|pitch\|range\|stress\|duration\)\>"
syn match cssAuralProp contained "\<rest\(-\(before\|after\)\)\=\>"
syn keyword cssAuralAttr contained young old neutral preserve moderate reduced
syn match cssAuralAttr contained "\<\(literal\|no\)-punctuation\>"
syn match cssAuralAttr contained "\<\(x-\)\=\(weak\|strong\)\>"
syn match cssValueNumber contained "[-+]\=\d\+\(dB\|st\)"
