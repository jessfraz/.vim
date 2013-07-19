" TODO: create cssMulticolProp group and cssMulticolAttr group
syn keyword cssFontProp contained columns
syn match cssFontProp contained "\<column-\(count\|fill\|gap\|rule\(-\(color\|style\|width\)\)\=\|span\|width\)\>"
syn keyword cssFontAttr contained page column balance
syn match cssFontAttr contained "\<avoid-\(page\|column\)\>"
